#!/bin/bash
sed -i 's/^PASS_MAX_DAYS\t99999/PASS_MAX_DAYS\t30/' /etc/login.defs
sed -i 's/^PASS_MIN_DAYS\t0/PASS_MAX_DAYS\t2/' /etc/login.defs
sed -i 's/^PASS_WARN_AGE\t7/PASS_WARN_AGE\t7/' /etc/login.defs
sed -i 's/^# difok = 1/difok = 7/' /etc/security/pwquality.conf
sed -i 's/^# minlen = 8/minlen = 10/' /etc/security/pwquality.conf
sed -i 's/^# dcredit = 0/dcredit = -1/' /etc/security/pwquality.conf
sed -i 's/^# ucredit = 0/ucredit = -1/' /etc/security/pwquality.conf
sed -i 's/^# lcredit = 0/lcredit = -1/' /etc/security/pwquality.conf
sed -i 's/^# maxrepeat = 0/maxrepeat = 3/' /etc/security/pwquality.conf
sed -i 's/^# usercheck = 1/usercheck = 1/' /etc/security/pwquality.conf
sed -i 's/^# retry = 3/retry = 3/' /etc/security/pwquality.conf
sed -i 's/^# enforce_for_root/enforce_for_root/' /etc/security/pwquality.conf
sed -i 's/^# enforcing = 1/enforcing = 1/' /etc/security/pwquality.conf

chage --maxdays 30 root
chage --mindays 2 root
chage --warndays 7 root

chage --maxdays 30 welee
chage --mindays 2 welee
chage --warndays 7 welee
