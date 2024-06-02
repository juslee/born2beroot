#!/bin/bash
sed -i 's/^cgi.fix_pathinfo=0/cgi.fix_pathinfo=1/' /etc/php/8.2/fpm/php.ini
sed -i 's/^listen = \/run\/php\/php8.2-fpm.sock/listen = 127.0.0.1:80' /etc/php/8.2/fpm/pool.d/www.conf
systemctl enable php8.2-fpm
