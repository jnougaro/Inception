#!/bin/sh

if [ ! -f /var/www/html/wp-config.php ]; then
    until mysqladmin -hmariadb -u${MYSQL_USER} -p${MYSQL_USER_PASSWORD} ping; do
        sleep 2
        # sleep until we're connected to mariadb
        # WordPress won't try to configure itself until the database is created
    done
        cd /var/www/html/ && wp core download --allow-root # downdload WordPress
        wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_USER_PASSWORD} --dbhost=${WP_DB_HOST} --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root # generate a config file and set up the database
        wp core install --url=jnougaro.42.fr --title=${WP_TITLE} --admin_user=${MYSQL_ADMIN} --admin_password=${MYSQL_ADMIN_PASSWORD} --admin_email=${MYSQL_ADMIN_MAIL} --skip-email --allow-root # install WordPress and configure site and admin
        wp user create ${MYSQL_USER} ${MYSQL_USER_MAIL} --role=author --user_pass=${MYSQL_USER_PASSWORD} --allow-root # configure user
    #    wp theme install ${WP_THEME} --activate --allow-root # theme installation
fi

php-fpm7.3 -F -R # launch site
