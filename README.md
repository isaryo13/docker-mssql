# docker-mssql

## Supported tags

- `2017-latest`
- `2019-latest`

## How to use this image

The basic usage is the same as the base image [`mcr.microsoft.com/mssql/server`](https://hub.docker.com/_/microsoft-mssql-server), but some extended environment variables are available (see the Environment variables section for details).

Example usage:

Start an instance:
```sh
docker run -d \
  -e 'ACCEPT_EULA=Y' \
  -e 'SA_PASSWORD=yourStrong(!)Password' \
  -e 'MSSQL_DATABASE=mydb' \
  -e 'MSSQL_USER=myuser' \
  -e 'MSSQL_PASSWORD=Password123' \
  -p 1433:1433 \
  isaryo13/mssql:2017-latest
```

Connect to Microsoft SQL Server:
```sh
docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd \
  -S localhost \
  -U myuser \
  -P Password123 \
  -d mydb
```

## Environment Variables

### `ACCEPT_EULA`

See [mcr.microsoft.com/mssql/server](https://hub.docker.com/_/microsoft-mssql-server).

### `SA_PASSWORD`

See [mcr.microsoft.com/mssql/server](https://hub.docker.com/_/microsoft-mssql-server).

### `MSSQL_PID`

See [mcr.microsoft.com/mssql/server](https://hub.docker.com/_/microsoft-mssql-server).

### `MSSQL_DATABASE`

This variable is optional and allows you to specify the name of a database to be created on image startup. If a user/password was supplied (see below) then that user will be granted `db_owner` access to this database.

### `MSSQL_USER`, `MSSQL_PASSWORD`

These variables are optional, used in conjunction to create a new user and to set that user's password. This user will be granted `db_owner` permissions (see above) for the database specified by the `MSSQL_DATABASE` variable. Both variables are required for a user to be created.
