#!/bin/bash
mkdir -p /etc/ssh/sshd_config.d
echo "Port 4242" > /etc/ssh/sshd_config.d/port.conf
echo "PermitRootLogin no" > /etc/ssh/sshd_config.d/root.conf
