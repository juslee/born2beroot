#!/bin/bash

# Variables
DB_NAME="wordpress_db"
DB_USER="admin"
DB_PASSWORD="mypassword"
WP_URL="http://localhost"
WP_TITLE="My WordPress Site"
WP_ADMIN_USER="admin"
WP_ADMIN_PASSWORD="mypassword"
WP_ADMIN_EMAIL="admin@example.com"
WP_PATH="/var/www/html"

# Download WordPress
wget https://wordpress.org/latest.tar.gz -P /tmp
tar -xzf /tmp/latest.tar.gz -C /tmp
mv /tmp/wordpress/* $WP_PATH

# Set Permissions
sudo chown -R www-data:www-data $WP_PATH
sudo chmod -R 755 $WP_PATH

# Create wp-config.php
cp $WP_PATH/wp-config-sample.php $WP_PATH/wp-config.php
sed -i "s/database_name_here/$DB_NAME/" $WP_PATH/wp-config.php
sed -i "s/username_here/$DB_USER/" $WP_PATH/wp-config.php
sed -i "s/password_here/$DB_PASSWORD/" $WP_PATH/wp-config.php

# Generate Authentication Keys and Salts
wget -qO- https://api.wordpress.org/secret-key/1.1/salt/ > /tmp/wp.keys
sed -i '/AUTH_KEY/d' $WP_PATH/wp-config.php
sed -i '/SECURE_AUTH_KEY/d' $WP_PATH/wp-config.php
sed -i '/LOGGED_IN_KEY/d' $WP_PATH/wp-config.php
sed -i '/NONCE_KEY/d' $WP_PATH/wp-config.php
sed -i '/AUTH_SALT/d' $WP_PATH/wp-config.php
sed -i '/SECURE_AUTH_SALT/d' $WP_PATH/wp-config.php
sed -i '/LOGGED_IN_SALT/d' $WP_PATH/wp-config.php
sed -i '/NONCE_SALT/d' $WP_PATH/wp-config.php
cat /tmp/wp.keys >> $WP_PATH/wp-config.php

# Install WP-CLI
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Install WordPress
sudo -u www-data wp core install --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL

echo "WordPress installation completed successfully!"
