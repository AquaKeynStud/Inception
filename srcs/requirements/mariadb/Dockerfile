FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y mariadb-server && apt-get clean && rm -rf /var/lib/apt/lists/*


RUN sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf \
 && sed -i 's/^#\?port.*/port = 3306/' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

CMD [ "/setup.sh" ]