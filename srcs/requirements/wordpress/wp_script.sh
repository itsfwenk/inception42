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

echo "Configuration changes applied successfully!"