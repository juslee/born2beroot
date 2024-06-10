#!/bin/bash
ARCH=$(uname --all)
PCPU=$(grep 'physical id' /proc/cpuinfo | uniq | wc -l)
VCPU=$(grep processor /proc/cpuinfo | uniq | wc -l)
RAM_TOTAL=$(free --mega --human | grep 'Mem' | awk '{print $2}')
RAM_USED=$(free --mega | grep 'Mem' | awk '{print $3}')
RAM_PERC=$(free --mega | grep 'Mem' | awk '{printf("%.2f%%"), $3 / $2 * 100}')
DISK_TOTAL=$(df --human-readable --total | grep 'total' | awk '{print $2}')
DISK_USED=$(df --human-readable -B1M --total | grep 'total' | awk '{print $3}')
DISK_PERC=$(df --human-readable --total | grep 'total' | awk '{print $5}')
CPU_LOAD=$(top --batch-mode --iterations 2 | grep '^%Cpu' | tail -1 | xargs | awk '{printf("%.1f%%"), $2 + $4 + $6}')
LAST_BOOT=$(who --boot | awk '{print($3 " " $4)}')
LVM=$(if [ "$(lsblk | grep --count lvm)" -eq 0 ]; then echo no; else echo yes; fi)
TCP=$(grep TCP /proc/net/sockstat | awk '{print $3}')
USER_LOG=$(who | wc -l)
IP_ADDR=$(hostname -I | awk '{print $1}')
MAC_ADDR=$(ip address | grep link/ether | awk '{print $2}')
CMDS=$(journalctl _COMM=sudo | grep --count COMMAND)

wall "    #Architecture: $ARCH
    #CPU physical: $PCPU
    #vCPU: $VCPU
    #Memory Usage: $RAM_USED/$RAM_TOTAL ($RAM_PERC)
    #Disk Usage: $DISK_USED/$DISK_TOTAL ($DISK_PERC)
    #CPU Load: $CPU_LOAD
    #Last Boot: $LAST_BOOT
    #LVM use: $LVM
    #Connections TCP: $TCP established
    #Users log: $USER_LOG
    #Network: IP $IP_ADDR ($MAC_ADDR)
    #Sudo: $CMDS cmd"
