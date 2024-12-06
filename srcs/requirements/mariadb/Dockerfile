FROM debian:bullseye

RUN apt update -y && \
    apt upgrade -y && \
    apt-get install mariadb-server -y && \
    systemctl enable mariadb && \
    systemctl start mariadb

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf