#!/bin/bash

cat << __EOF__ > /var/tmp/create-database.sql
USE master;
GO
CREATE DATABASE ${MSSQL_DATABASE};
GO
__EOF__

cat << __EOF__ > /var/tmp/create-user.sql
USE master;
GO
CREATE LOGIN ${MSSQL_USER} WITH PASSWORD = '${MSSQL_PASSWORD}';
GO
USE ${MSSQL_DATABASE};
GO
CREATE USER ${MSSQL_USER} FOR LOGIN ${MSSQL_USER};
GO
ALTER ROLE db_owner ADD MEMBER ${MSSQL_USER};
GO
__EOF__

function log() {
  echo "$(date '+%F %T.00') init.sh     ${1}" >&2
}

function sqlcmd() {
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} ${@}
}

function sqlcmd_ping() {
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -Q 'SELECT 1' -t 1 > /dev/null
}

function initdb() {
  local timeout=60
  local i=0
  until sqlcmd_ping; do
    log "Waiting for Microsoft SQL Server is ready...($i sec)"
    [ $i -ge $timeout ] && return 1
    let i++
    sleep 1
  done
  if [ -n "${MSSQL_DATABASE}" ]; then
    sqlcmd -i /var/tmp/create-database.sql
    log "Successfully created database: '${MSSQL_DATABASE}'"
    if [ -n "${MSSQL_USER}" ] && [ -n "${MSSQL_PASSWORD}" ]; then
      sqlcmd -i /var/tmp/create-user.sql
      log "Successfully created user: '${MSSQL_USER}'"
    fi
  fi
}

(initdb >/dev/null &)

${@}
