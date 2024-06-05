#!/bin/bash
# Variables
DB_NAME="wordpress_db"
DB_USER="admin"
DB_PASSWORD="mypassword"
DB_ROOT_PASSWORD="mypassword"
# WP_URL="http://192.168.67.4"
# WP_TITLE="My WordPress Site"
# WP_ADMIN_USER="juslee"
# WP_ADMIN_PASSWORD="mypassword"
# WP_ADMIN_EMAIL="triplez@justinlee.sg"
WP_PATH="/var/www/html"

# Start MariaDB service
#systemctl start mariadb

# Secure MariaDB Installation
mysql -e "UPDATE mysql.global_priv SET priv=json_set(priv, '$.plugin', 'mysql_native_password', '$.authentication_string', PASSWORD('$DB_ROOT_PASSWORD')) WHERE User='root';"
mysql -e "DELETE FROM mysql.global_priv WHERE User='';"
mysql -e "DELETE FROM mysql.global_priv WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
mysql -e "FLUSH PRIVILEGES;"

# Drop WordPress database if it exists
mysql -u root -p$DB_ROOT_PASSWORD -e "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u root -p$DB_ROOT_PASSWORD -e "DROP USER IF EXISTS '$DB_USER'@'localhost';"

# Create WordPress database and user
mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE DATABASE $DB_NAME;"
mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root -p$DB_ROOT_PASSWORD -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;"
mysql -u root -p$DB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# Enable and restart MariaDB service
#systemctl enable mariadb
#systemctl restart mariadb

# Wait for MariaDB to restart
echo "Waiting for MariaDB to restart..."
sleep 60

# Download WordPress
wget https://wordpress.org/latest.tar.gz -P /tmp
tar -xzf /tmp/latest.tar.gz -C /tmp
cp -R /tmp/wordpress/* $WP_PATH

# Set Permissions
chown -R www-data:www-data $WP_PATH
chmod -R 755 $WP_PATH

# Create wp-config.php
cp $WP_PATH/wp-config-sample.php $WP_PATH/wp-config.php
sed -i "s/database_name_here/$DB_NAME/" $WP_PATH/wp-config.php
sed -i "s/username_here/$DB_USER/" $WP_PATH/wp-config.php
sed -i "s/password_here/$DB_PASSWORD/" $WP_PATH/wp-config.php

# Generate Authentication Keys and Salts
# wget -qO- https://api.wordpress.org/secret-key/1.1/salt/ > /tmp/wp.keys
# sed -i '/AUTH_KEY/d' $WP_PATH/wp-config.php
# sed -i '/SECURE_AUTH_KEY/d' $WP_PATH/wp-config.php
# sed -i '/LOGGED_IN_KEY/d' $WP_PATH/wp-config.php
# sed -i '/NONCE_KEY/d' $WP_PATH/wp-config.php
# sed -i '/AUTH_SALT/d' $WP_PATH/wp-config.php
# sed -i '/SECURE_AUTH_SALT/d' $WP_PATH/wp-config.php
# sed -i '/LOGGED_IN_SALT/d' $WP_PATH/wp-config.php
# sed -i '/NONCE_SALT/d' $WP_PATH/wp-config.php
# cat /tmp/wp.keys >> $WP_PATH/wp-config.php

# # Install WP-CLI
# wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# chmod +x wp-cli.phar
# mv wp-cli.phar /usr/local/bin/wp

# # Install WordPress
# runuser -u www-data -- wp core install --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --path=$WP_PATH

echo "Disabling and removing firstboot service"
systemctl disable firstboot.service
#rm /etc/systemd/system/firstboot.service

echo "WordPress installation completed successfully!"
