#!/bin/bash
systemctl enable mariadb
systemctl start mariadb

MYSQL_ROOT_PASSWORD="mypassword"
MYSQL_USER_PASSWORD="mypassword"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "DELETE FROM mysql.user WHERE User='';"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
mysql -e "FLUSH PRIVILEGES;"

mysql -e "CREATE DATABASE wordpress;"
mysql -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"
