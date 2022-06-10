# Image
FROM debian:buster

# Install php-fpm
# Wordpress needs php modules to work

RUN apt-get update && \
    apt-get -y install php7.3-fpm php7.3-common php7.3-mysql curl mariadb-client

RUN mkdir -p /var/run/ && mkdir -p /run/php/

# Install Wordpress with wp cli
# wp-cli is a set of command line tools to manage WordPress set up
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
# To type wp instead of php wp-cli.phar, we need to make the file executable and move it to somewhere in our PATH

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

COPY ./conf/script.sh /etc/

CMD ["bash", "/etc/script.sh"]