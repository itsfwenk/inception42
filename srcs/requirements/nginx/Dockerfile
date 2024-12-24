FROM debian:bullseye

RUN apt update -y && apt upgrade -y &&\
    apt install -y vim curl nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=fli.42.fr/UID=fli"

RUN mkdir -p /var/run/nginx

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

COPY conf/nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]