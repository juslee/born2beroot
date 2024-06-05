#!/bin/bash
apt install -y lighttpd

# Enable firewall rules for HTTP
sed -i '/^### RULES ###/a \
### tuple ### allow tcp 80 0.0.0.0/0 any 0.0.0.0/0 in\n-A ufw-user-input -p tcp --dport 80 -j ACCEPT\n' /etc/ufw/user.rules
sed -i '/^### RULES ###/a \
### tuple ### allow tcp 80 ::/0 any ::/0 in\n-A ufw6-user-input -p tcp --dport 80 -j ACCEPT\n' /etc/ufw/user6.rules

# Enable lighttpd modules
lighty-enable-mod fastcgi
lighty-enable-mod fastcgi-php
service lighttpd force-reload
