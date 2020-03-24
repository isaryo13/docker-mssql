FROM mcr.microsoft.com/mssql/server:2019-latest

ENV MSSQL_DATABASE ""
ENV MSSQL_USER ""
ENV MSSQL_PASSWORD ""

USER root
COPY init.sh /
RUN chmod +x /init.sh
USER mssql

EXPOSE 1433

ENTRYPOINT [ "/init.sh" ]
CMD [ "/opt/mssql/bin/sqlservr" ]
