FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN mkdir -p /var/www/html/static

COPY ./website-files /website

WORKDIR /var/www/html/static

