FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y nginx openssl && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

CMD [ "/setup.sh" ]