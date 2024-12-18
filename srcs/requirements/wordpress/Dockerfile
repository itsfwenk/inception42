FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt-get -y install wget

RUN apt-get install -y php7.4\
						php-fpm\
						php-mysql\
						mariadb-client

# RUN wget https://fr.wordpress.org/wordpress-6.7.1-fr_FR.tar.gz -P /var/www

# RUN cd /var/www && tar -xzf wordpress-6.7.1-fr_FR.tar.gz && rm wordpress-6.7.1-fr_FR.tar.gz

# RUN chown -R root:root /var/www/wordpress

# RUN chown -R www-data:www-data /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

# RUN chmod +x ./wp_script.sh

COPY ./wp_script.sh /usr/local/bin/wp_script.sh

CMD ["/usr/local/bin/wp_script.sh"]
