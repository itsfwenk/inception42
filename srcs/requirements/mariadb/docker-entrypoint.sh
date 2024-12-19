#!/bin/bash

# if [ -f .env ]; then
#     source .env
# else
#     echo ".env file not found! $PWD"
#     exit 1
# fi

# chmod -R 755 /var/lib/mysql

set -e

chown -R mysql:mysql /var/lib/mysql

mkdir -p /run/mysqld

chown -R mysql:mysql /run/mysqld

# service mysql start;

echo "Not HERE"

if ! mysqladmin ping --silent; then
  mysqld --user=mysql &
  sleep 10
fi

echo "Here !!!"
# until mariadb -e "SELECT 1;" >/dev/null 2>&1; do
#     echo "Waiting for MariaDB to start..."
#     sleep 2
# done

# until mysqladmin ping --silent --socket=/run/mysqld/mysqld.sock; do
#     echo "Waiting for MariaDB to start..."
#     sleep 2
# done

# mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# mysql -u "${SQL_USER}" -p"${SQL_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# mysql -e "CREATE USER '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# mysql -u "${SQL_USER}" -p"${SQL_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# mysql -e "FLUSH PRIVILEGES;"

# mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

mysqld_safe --datadir=/var/lib/mysql &

until mysqladmin ping -uroot -p"${SQL_ROOT_PASSWORD}" --silent; do
  echo "Waiting DB to be ready"
  sleep 5
done

mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

mysql -u root -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

mysql -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%' WITH GRANT OPTION;"

mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

mysql -u root -e "FLUSH PRIVILEGES;"

exec mysqld --user=mysql
# wait
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
# exec mysqld_safe

# mysqld
