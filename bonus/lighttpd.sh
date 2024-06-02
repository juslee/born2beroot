#!/bin/bash
apt purge -y apache2
systemctl enable lighttpd
sed -i 's/^### RULES ###/a\\n### tuple ### allow tcp 80 0.0.0.0/0 any 0.0.0.0/0 in\n-A ufw-user-input -p tcp --dport 80 -j ACCEPT\n\n### END RULES ###\n/' /etc/ufw/user.rules
sed -i 's/^### RULES ###/a\\n### tuple ### allow tcp 80 ::/0 any ::/0 in\n-A ufw6-user-input -p tcp --dport 80 -j ACCEPT\n\n### END RULES ###\n/' /etc/ufw/user6.rules
sed -i 's/"bin-path" => "\/usr\/bin\/php-cgi",/"host" => "127.0.0.1",/' /etc/lighttpd/conf-available/15-fastcgi-php.conf
sed -i 's/"socket" => "\/var\/run\/php\/php8.2-fpm.sock",/"port" => "80",/' /etc/lighttpd/conf-available/15-fastcgi-php.conf
lighty-enable-mod fastcgi
lighty-enable-mod fastcgi-php
