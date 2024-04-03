#!/bin/bash

# Creating sys-info table

set -o errexit

echo "You are about to view key system info"
sleep 3

sysFile="sysinfo.txt"

echo "copy of the system details will be saved in $sysFile."

# checking for cpu_usage
echo checking cpu usage...
sleep 3
cpu_usage="S[100-$(vmstat 1 2 | tail -1 | awk '{print $15}')]%"
echo checking cpu usage done
echo

# checking for mem_usage
echo checking memory usage...
sleep 3
mem_usage="S(free -m | grep ^Mem | awk '{print $3 "MB"}')"
echo  checking memory usage done
echo

# checking disk space
echo checking disk space...
sleep 3
disk_space="$(df -h | grep /$ | awk '{print $4}')"
echo checking disk space done
echo

# checking network stats
echo checking network stats...
sleep 3
packets_received="$(netstat -s | grep "total packets" | awk '{print $1}')"
requests_sent="$(netstat -s | grep "requests sent" | awk '{print $1}')"
echo checking network stats done
echo
sleep 3

echo -e "CPU Usage\tMemory Usage\tUnused Disk Space\tPackets rec. /Request sent" > "$sysFile"
if [ $? -eq 0 ]; then
	echo -e "$cpu_usage\t\t$mem_usage\t\t$disk_space\t\t\t$packets_received/$requests_sent" >> "$sysFile"
	cat "$sysFile"
	sleep 3
	echo
       	echo "System metrics saved to $sysFile"
else
	echo "Error: Failed to extract necessary system metric to $sysFile"
	exit 1
fi


