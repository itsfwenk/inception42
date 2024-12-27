#!/bin/bash

sleep 10

if [ -f "/var/www/html/wp-config.php" ]; then
	echo "Skipping wp-config file set up."
else
	if [ ! -d "/var/www/html/wp-content" ]; then
		wp core download --allow-root || { echo "Wordpress download failure"; exit 1; }
	else
		echo "WordPress files already present, skipping download."
	fi
	echo "Setting wp-config.php file"
	wp core config --allow-root \
					--dbname="${SQL_DATABASE}" \
					--dbuser="${SQL_USER}" \
					--dbpass="${SQL_PASSWORD}" \
					--dbhost=mariadb:3306 \
					--path='/var/www/html' || { echo "Wordpress core config failure"; exit 1; }

	echo "Installing WordPress"
	wp core install --url="${WORDPRESS_URL}" \
					--title="${WORDPRESS_TITLE}" \
					--admin_user="${WORDPRESS_ADMIN_USER}" \
					--admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
					--admin_email="${WORDPRESS_ADMIN_EMAIL}" \
					--allow-root || { echo "Wordpress core install failed"; exit 1; }

	echo "Creating user..."
	wp user create "${USER_USERNAME}" "${USER_EMAIL}" \
		--role=subscriber \
		--user_pass="${USER_PASSWORD}" \
		--allow-root || { echo "Wordpress user create failed"; exit 1; }
fi

wp config set WP_REDIS_HOST "${WP_REDIS_HOST}" --allow-root

wp config set WP_REDIS_PORT "${WP_REDIS_PORT}" --allow-root

wp plugin install redis-cache --activate --allow-root

wp redis enable --allow-root

wp redis status --allow-root

exec php-fpm7.4 -F -R


