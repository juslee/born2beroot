#!/bin/bash
systemctl enable mariadb
systemctl start mariadb

MYSQL_ROOT_PASSWORD="mypassword"
MYSQL_USER_PASSWORD="mypassword"

mysql -e "
UPDATE mysql.global_priv SET priv=json_set(priv, '$.plugin', 'mysql_native_password', '$.authentication_string', PASSWORD('$MYSQL_ROOT_PASSWORD')) WHERE User='root';
DELETE FROM mysql.global_priv WHERE User='';
DELETE FROM mysql.global_priv WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
"

mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "
CREATE DATABASE wordpress_db;
CREATE USER 'admin'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'admin'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
"
