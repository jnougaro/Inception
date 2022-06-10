# Declare the basic image
FROM debian:buster

RUN apt-get update && \
    apt-get -y install mariadb-server mariadb-client

# To change a file's owner: use commande chown
# Create directory which will have wordpress's files
RUN mkdir -p /var/run/mysqld

RUN chown -R mysql:root /run/mysqld && chown -R mysql:mysql /var/lib/mysql

# To copy ./conf/50-server.cnf in the container
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/script.sh .

EXPOSE 3306

# The mysqld_safe startup script starts mysqld with some extra safety features
CMD bash script.sh

# https://docs.docker.com/engine/reference/builder/#arg
