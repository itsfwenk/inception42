#!/bin/bash

if [ -f .env ]; then
    source .env
else
    echo ".env file not found!"
    exit 1
fi

service mysql start;

mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"