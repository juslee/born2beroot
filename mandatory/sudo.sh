#!/bin/bash
mkdir -p /etc/sudoers.d
echo 'welee ALL=(ALL) ALL' > /etc/sudoers.d/welee
echo 'Defaults        passwd_tries=3' > /etc/sudoers.d/passwd_tries
echo 'Defaults        badpass_message="Authentication failed. Please try again."' > /etc/sudoers.d/badpass_message
echo 'Defaults        logfile="/var/log/sudo/sudo.log"' > /etc/sudoers.d/logfile
echo 'Defaults        log_input,log_output' > /etc/sudoers.d/log_input
echo 'Defaults        iolog_dir="/var/log/sudo"' > /etc/sudoers.d/iolog_dir
echo 'Defaults        requiretty' > /etc/sudoers.d/requiretty
echo 'Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"' > /etc/sudoers.d/secure_path

mkdir -p /var/log/sudo
chmod 0750 /var/log/sudo
chown root:root /var/log/sudo
chmod 440 /etc/sudoers.d/welee
chmod 440 /etc/sudoers.d/passwd_tries
chmod 440 /etc/sudoers.d/badpass_message
chmod 440 /etc/sudoers.d/logfile
chmod 440 /etc/sudoers.d/log_input
chmod 440 /etc/sudoers.d/iolog_dir
chmod 440 /etc/sudoers.d/requiretty
chmod 440 /etc/sudoers.d/secure_path
chmod 750 /etc/sudoers.d
