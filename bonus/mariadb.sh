#!/bin/bash

# Variables
DB_NAME="wordpress_db"
DB_USER="admin"
DB_PASSWORD="mypassword"
DB_ROOT_PASSWORD="mypassword"

# Install MariaDB
echo "mariadb-server mariadb-server/root_password password $DB_ROOT_PASSWORD" | debconf-set-selections
echo "mariadb-server mariadb-server/root_password_again password $DB_ROOT_PASSWORD" | debconf-set-selections

# apt-get update
# apt-get install -y mariadb-server

systemctl enable mariadb
systemctl start mariadb

# Secure MariaDB Installation
# mysql -e "UPDATE mysql.global_priv SET priv=json_set(priv, '$.plugin', 'mysql_native_password', '$.authentication_string', PASSWORD('$DB_ROOT_PASSWORD')) WHERE User='root';"
mysql -e "DELETE FROM mysql.global_priv WHERE User='';"
mysql -e "DELETE FROM mysql.global_priv WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
mysql -e "FLUSH PRIVILEGES;"

# Install MySQL Database and Create WordPress Database
mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE DATABASE $DB_NAME;"
mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root -p$DB_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
mysql -u root -p$DB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
