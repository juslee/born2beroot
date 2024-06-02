#!/bin/bash
wget -O /usr/local/bin/monitoring.sh http://c2r1s14.42singapore.sg:8000/mandatory/monitoring.sh
chmod +x /usr/local/bin/monitoring.sh
echo '*/10 * * * * /usr/local/bin/monitoring.sh' | crontab -u welee -
