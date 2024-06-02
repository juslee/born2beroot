#!/bin/bash
wget -O /tmp/latest.tar.gz http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz -C /var/www/html/
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
