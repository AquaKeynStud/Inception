#!/bin/bash
set -e

: "${MYSQL_DATABASE:?Need MYSQL_DATABASE}"

unset MYSQL_HOST
unset MYSQL_TCP_PORT

INIT_FILE="/var/lib/mysql/.inception_initialized"
MYSQL_USER="$(cat /run/secrets/db_user)"
MYSQL_PASSWORD="$(cat /run/secrets/db_password)"
MYSQL_ROOT_PASSWORD="$(cat /run/secrets/db_root_password)"

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB system tables..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

if [ ! -f "$INIT_FILE" ]; then
    echo "Running Inception MariaDB setup..."

    mysqld_safe --skip-networking &
    echo "Waiting for MariaDB..."

    until mysqladmin --protocol=socket ping --silent; do
        sleep 1
    done

    echo "MariaDB is ready"

    mysql --protocol=socket << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    touch "$INIT_FILE"

    mysqladmin --protocol=socket -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

exec mysqld_safe