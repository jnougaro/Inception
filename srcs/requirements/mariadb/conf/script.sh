#!/bin/sh

# If this directory already exists, does not create it
if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; then
    mysqld& # &: to run a service in the background
    until mysqladmin ping; do # ping: will send a signal when mysql is ready
        sleep 2
    done

    cd /root/
# until mysqld is fully functionnal, it will not execute the following
# from the mysql command, it is possible to issue commands to the database server
# connection to MySQL with root user
    mysql -e "CREATE DATABASE ${MYSQL_DATABASE};"
# creation of a MySQL user dedicated to the database
    mysql -e "CREATE USER '${MYSQL_ADMIN}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN}'@'%';"
    mysql -e "FLUSH PRIVILEGES;"

    mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';"
# give him the rights on this database
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -e "FLUSH PRIVILEGES;"

    mysql -e "DELETE FROM mysql.user WHERE user=''"
    mysql -e "DELETE FROM mysql.user WHERE user='root'" # delete root because we need a user with a password
    mysql -e "FLUSH PRIVILEGES;" # purge privileges to ensure they are saved and available in the session
    killall mysqld # stop the server

fi
mysqld # to launch the MariaDB service, use command mysqld

# https://www.techotopia.com/index.php/The_mysql_Command-Line_Tool
# https://medium.com/@mandeepkaur1/a-list-of-mysql-commands-c4d0d244aa5c
