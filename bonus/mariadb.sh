#!/bin/bash
systemctl enable mariadb
systemctl start mariadb

MYSQL_ROOT_PASSWORD="mypassword"
MYSQL_USER_PASSWORD="mypassword"

mysql -u root -e "
UPDATE mysql.user SET plugin = 'unix_socket' WHERE User = 'root';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User = '';
UPDATE mysql.user SET Host='localhost' WHERE User='root' AND Host='%';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
"
systemctl restart mariadb
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "
CREATE DATABASE wordpress;
CREATE USER 'admin'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
"
