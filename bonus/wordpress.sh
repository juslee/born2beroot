#!/bin/bash
wget -O /tmp/latest.tar.gz http://wordpress.org/latest.tar.gz
tar -xzvf /tmp/latest.tar.gz -C /tmp
mv /tmp/wordpress/* /var/www/html
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i 's/database_name_here/wordpress_db/' /var/www/html/wp-config.php
sed -i 's/username_here/admin/' /var/www/html/wp-config.php
sed -i 's/password_here/mypassword/' /var/www/html/wp-config.php
sed -i 's/localhost/localhost/' /var/www/html/wp-config.php
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/
