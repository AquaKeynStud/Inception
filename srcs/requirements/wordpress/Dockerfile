FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
	php7.4 \
    php7.4-fpm \
    php7.4-mysql \
	curl \
	mariadb-client \
    && apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html

RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 9000

CMD ["/setup.sh"]
