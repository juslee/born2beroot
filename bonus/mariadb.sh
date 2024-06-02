#!/bin/bash
systemctl enable mariadb
systemctl start mariadb

apt install -y expect

MYSQL_ROOT_PASSWORD="mypassword"
MYSQL_USER_PASSWORD="mypassword"

expect -f - <<-EOF
set timeout 2
spawn mysql_secure_installation
expect "Enter current password for root (enter for none):"
send "\r"
expect "Switch to unix_socket authentication \[Y/n\]"
send "n\r"
expect "Change the root password? \[Y/n\]"
send "Y\r"
expect "New password:"
send "${MYSQL_ROOT_PASSWORD}\r"
expect "Re-enter new password:"
send "${MYSQL_ROOT_PASSWORD}\r"
expect "Remove anonymous users?  \[Y/n\]"
send "Y\r"
expect "Disallow root login remotely? \[Y/n\]"
send "Y\r"
expect "Remove test database and access to it? \[Y/n\]"
send "Y\r"
expect "Reload privilege tables now? \[Y/n\]"
send "Y\r"
expect eof
EOF

mysql -u root -p${MYSQL_ROOT_PASSWORD} "
CREATE DATABASE wordpress;
CREATE USER 'admin'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
"
