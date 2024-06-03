#!/bin/bash

# Set default policies
ufw default deny incoming
ufw default allow outgoing

# Allow specific services (e.g., SSH, HTTP)
ufw allow 4242/tcp
ufw allow http/tcp

# Enable UFW
ufw --force enable

# sed -i 's/^ENABLED=0/ENABLED=1/' /etc/ufw/ufw.conf
# sed -i '/^### RULES ###/a\\n### tuple ### allow tcp 4242 0.0.0.0/0 any 0.0.0.0/0 in\n-A ufw-user-input -p tcp --dport 4242 -j ACCEPT\n\n### END RULES ###\n' /etc/ufw/user.rules
# sed -i '/^### RULES ###/a\\n### tuple ### allow tcp 4242 ::/0 any ::/0 in\n-A ufw6-user-input -p tcp --dport 4242 -j ACCEPT\n\n### END RULES ###\n' /etc/ufw/user6.rules
# systemctl enable ufw
# systemctl start ufw
# ufw reload

