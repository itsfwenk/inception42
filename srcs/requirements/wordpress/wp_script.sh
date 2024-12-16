#!/bin/bash

POOL_CONF="/etc/php/7.4/fpm/pool.d/www.conf"

if grep -q "^clear_env" "$POOL_CONF"; then
    echo "Updating 'clear_env' directive..."
    sed -i 's/^clear_env.*/clear_env = no/' "$POOL_CONF"
else
    echo "Adding 'clear_env = no' directive..."
    echo "clear_env = no" >> "$POOL_CONF"
fi

if grep -q "^listen" "$POOL_CONF"; then
    echo "Updating 'listen' directive..."
    sed -i 's/^listen.*/listen = wordpress:9000/' "$POOL_CONF"
else
    echo "Adding 'listen = wordpress:9000' directive..."
    echo "listen = wordpress:9000" >> "$POOL_CONF"
fi

echo "Restarting PHP-FPM service..."
systemctl restart php7.4-fpm

echo "PHP configuration changes applied successfully!"

until mysql -h db -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1" &> /dev/null; do
    echo "Waiting for the database to be ready..."
    sleep 3
done

# if [ ! -f /var/www/wordpress/wp-config.php ]; then
#     cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
#     sed -i "s/database_name_here/wordpress/" /var/www/wordpress/wp-config.php
#     sed -i "s/username_here/fli/" /var/www/wordpress/wp-config.php
#     sed -i "s/password_here/wordpress_password/" /var/www/wordpress/wp-config.php
#     sed -i "s/localhost/db/" /var/www/wordpress/wp-config.php
# fi

wp config create	--allow-root \
					--dbname=$SQL_DATABASE \
					--dbuser=$SQL_USER \
					--dbpass=$SQL_PASSWORD \
					--dbhost=mariadb:3306 --path='/var/www/wordpress'

sudo -u www-data wp core install --url='fli.42.fr' \
								--title='Inception' \
								--admin_user=$WP_ADMINUSER \
								--admin_password=$WP_ADMINPW \
								--admin_email='fli@student.42.fr'

wp user create fliuser fli@user.fr

php-fpm
