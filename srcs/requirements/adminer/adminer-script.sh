#!/bin/bash

if [ ! -d "/var/www/adminer/index.php" ]; then
	curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o index.php
fi

exec php-fpm7.4 -F -R