#!/bin/bash

VERSION=$1
if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version>"
  exit 0
fi

# Build a single init SQL script from multiple DDLs.
/bin/rm -f init.sql
touch init.sql
cat ../../wherehows-data-model/DDL/postgres/ETL_DDL/*.sql >> init.sql
cat ../../wherehows-data-model/DDL/postgres/WEB_DDL/*.sql >> init.sql

docker build --force-rm -t wherehows-postgres:$VERSION .
docker build --force-rm -t wherehows-postgres:latest .
