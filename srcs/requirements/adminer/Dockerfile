FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt install curl php php-fpm php-mysql -y

RUN php-fpm7.4 -t

RUN sed -i 's|^listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:8080|' /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /var/www/adminer

RUN chmod -R 777 /var/www/adminer

RUN chown -R www-data:www-data /var/www/adminer

COPY adminer-script.sh /adminer-script.sh

RUN chmod 755 /adminer-script.sh

RUN mkdir -p /run/php/

WORKDIR /var/www/adminer

EXPOSE 8080

CMD [ "/adminer-script.sh" ]