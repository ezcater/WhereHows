FROM postgres:9.4

RUN apt-get update

EXPOSE 5432
ADD init.sql /docker-entrypoint-initdb.d
