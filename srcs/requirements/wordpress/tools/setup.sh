#!/bin/bash
set -e

: "${MYSQL_HOST:?Need MYSQL_HOST}"
: "${MYSQL_DATABASE:?Need MYSQL_DATABASE}"

: "${WP_USER_EMAIL:?Need WP_USER_EMAIL}"
: "${WP_ADMIN_EMAIL:?Need WP_ADMIN_EMAIL}"
: "${WP_URL:?Need WP_URL}"
: "${WP_TITLE:?Need WP_TITLE}"

mkdir -p /var/www/html
mkdir -p /run/php
cd /var/www/html || exit 1

MYSQL_USER="$(cat /run/secrets/db_user)"
MYSQL_PASSWORD="$(cat /run/secrets/db_password)"

WP_USER="$(grep user /run/secrets/credentials | cut -d '=' -f2)"
WP_ADMIN_USER="$(grep admin /run/secrets/credentials | cut -d '=' -f2)"
WP_USER_PASSWORD="$(grep user_pswd /run/secrets/credentials | cut -d '=' -f2)"
WP_ADMIN_PASSWORD="$(grep admin_pswd /run/secrets/credentials | cut -d '=' -f2)"

echo "Trying to connect to MariaDB at $MYSQL_HOST with user $MYSQL_USER..."

until mysqladmin ping -h"$MYSQL_HOST" --silent >/dev/null 2>&1; do
    echo "Waiting for MariaDB server..."
    sleep 1
done

echo "MariaDB server is reachable"

until mysql -h "$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "Waiting for valid WordPress DB credentials..."
    sleep 1
done

echo "MariaDB is ready"

if [ ! -f /var/www/html/wp-settings.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
fi

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="${MYSQL_HOST}" \
        --allow-root
fi

if ! wp core is-installed --allow-root >/dev/null 2>&1; then
    echo "Installing WordPress..."
    wp core install \
        --url="https://${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root
fi

if wp user get "${WP_USER}" --allow-root >/dev/null 2>&1; then
    echo "WordPress user ${WP_USER} already exists, skipping."
elif wp user list --field=user_email --allow-root | grep -Fx "${WP_USER_EMAIL}" >/dev/null 2>&1; then
    echo "Email ${WP_USER_EMAIL} already exists, skipping user creation."
else
    echo "Creating WordPress user..."
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root
fi

chown -R www-data:www-data /var/www/html

exec php-fpm7.4 -F