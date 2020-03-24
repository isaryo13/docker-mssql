# Makefile

.PHONY: $(shell egrep -o '^[a-zA-Z_-]+:' $(MAKEFILE_LIST) | sed 's/://')

build:
	@docker build -f 2017/Dockerfile -t mssql:2017-latest .
	@docker build -f 2019/Dockerfile -t mssql:2019-latest .

clean:
	@docker rmi mssql:2017-latest
	@docker rmi mssql:2019-latest
