FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt-get -y install wget

RUN apt-get install -y php7.3\
						php-fpm\
						php-mysql\
						mariadb-client