#!/bin/bash
sed -i '/### RULES ###/a\\n### tuple ### allow tcp 80 0.0.0.0/0 any 0.0.0.0/0 in\n-A ufw-user-input -p tcp --dport 80 -j ACCEPT\n\n### END RULES ###\n' /etc/ufw/user.rules
sed -i '/### RULES ###/a\\n### tuple ### allow tcp 80 ::/0 any ::/0 in\n-A ufw6-user-input -p tcp --dport 80 -j ACCEPT\n\n### END RULES ###\n' /etc/ufw/user6.rules
