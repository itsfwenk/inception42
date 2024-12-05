FROM debian:bullseye

RUN apt update \
    apt install vim -y \
    apt install curl -y \
    apt install nginx -y \
    apt install OpenSSL -y

RUN mkdir -p /etc/nginx/ssl \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

RUN mkdir -p /var/run/nginx

RUN docker run -it nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
# COPY

# EXPOSE

# ENTRYPOINT 