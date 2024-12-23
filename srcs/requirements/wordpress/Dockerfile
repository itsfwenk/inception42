FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt-get -y install wget

RUN apt-get install -y php7.4\
						php-fpm\
						php-mysql\
						mariadb-client

RUN sed -i 's/^clear_env.*/clear_env = no/' "/etc/php/7.4/fpm/pool.d/www.conf"

RUN sed -i 's|^listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

RUN	mkdir -p /var/www/html && chmod -R 777 /var/www/html

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN	chmod +x wp-cli.phar

RUN	mv wp-cli.phar /usr/local/bin/wp

RUN	chown -R www-data:www-data /var/www/html

COPY	./wp_script.sh /usr/local/bin/wp_script.sh

RUN	chmod +x /usr/local/bin/wp_script.sh && mkdir -p /run/php

WORKDIR	/var/www/html

EXPOSE	9000

CMD	exec /usr/local/bin/wp_script.sh
