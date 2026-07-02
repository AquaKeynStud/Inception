#!/bin/bash

echo "Creating directory for the SSL certificate"
mkdir -p /etc/nginx/ssl

echo "Creating SSL certificate"
openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-keyout /etc/nginx/ssl/inception.key \
	-out /etc/nginx/ssl/inception.crt \
	-subj "/C=FR/ST=IDF/L=Lyon/O=42/OU=42/CN=arocca.42.fr"

echo "Launching NGINX..."
exec nginx -g "daemon off;"