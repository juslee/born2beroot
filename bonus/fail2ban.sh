#!/bin/bash
echo "SyslogFacility AUTH" > /etc/ssh/sshd_config.d/syslog.conf
echo "LogLevel INFO" > /etc/ssh/sshd_config.d/log.conf
echo "auth,authpriv.*                 /var/log/auth.log" > /etc/rsyslog.d/50-default.conf

apt install -y fail2ban
rm /etc/fail2ban/jail.d/defaults-debian.conf
{
	echo "[sshd]"
	echo "enabled = true"
	echo "port = 4242"
	echo "findtime = 600"
	echo "bantime = 600"
	echo "filter = sshd"
	echo "maxretry = 3"
	echo "logpath = /var/log/auth.log"
} >> /etc/fail2ban/jail.d/sshd.conf
