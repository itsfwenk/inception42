FROM debian:bullseye

RUN apt update -y && \
    apt upgrade -y && \
    apt-get install mariadb-server -y
    # systemctl enable mariadb && \
    # systemctl start mariadb

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY docker-entrypoint.sh /usr/local/bin/

# COPY ../../.env /var/lib/mysql

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["mysqld"]

# # Use a base Linux image
# FROM debian:bullseye

# # Set environment variables for MariaDB installation
# ENV MYSQL_ROOT_PASSWORD=root_password \
#     MYSQL_DATABASE=example_db \
#     MYSQL_USER=user_name \
#     MYSQL_PASSWORD=user_password

# # Install MariaDB
# RUN apt-get update && apt-get install -y \
#     mariadb-server \
#     && apt-get clean

# # Copy custom configuration (optional)
# # COPY my-custom.cnf /etc/mysql/conf.d/

# # Expose MariaDB port
# EXPOSE 3306

# # Add initialization scripts (optional)
# COPY init-db.sql /docker-entrypoint-initdb.d/

# # Start MariaDB
# CMD ["mysqld"]
