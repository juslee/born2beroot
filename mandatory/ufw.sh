#!/bin/bash
sed -i 's/^ENABLED=0/ENABLED=1/' /etc/ufw/ufw.conf
sed -i '/### RULES ###/a\\n### tuple ### allow tcp 4242 0.0.0.0/0 any 0.0.0.0/0 in\n-A ufw-user-input -p tcp --dport 4242 -j ACCEPT\n\n### END RULES ###\n' /etc/ufw/user.rules
sed -i '/### RULES ###/a\\n### tuple ### allow tcp 4242 ::/0 any ::/0 in\n-A ufw6-user-input -p tcp --dport 4242 -j ACCEPT\n\n### END RULES ###\n' /etc/ufw/user6.rules
ufw enable
