FROM mcr.microsoft.com/mssql/server:2017-latest

ENV MSSQL_DATABASE ""
ENV MSSQL_USER ""
ENV MSSQL_PASSWORD ""

COPY init.sh /
RUN chmod +x /init.sh

EXPOSE 1433

ENTRYPOINT [ "/init.sh" ]
CMD [ "/opt/mssql/bin/sqlservr" ]
