#!/bin/bash

# Output file
output_file="sysinfo.txt"

# Function to collect system metrics
collect_system_metrics() {
    # CPU usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

    # Memory usage
    mem_usage=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2}')

    # Disk space
    disk_space=$(df -h | awk '$NF=="/"{printf "%s/%s (%.2f%%)", $3,$2,$5}')

    # Network statistics
    network_stats=$(cat /proc/net/dev | awk '/eth0/{print "Received: " $2 " bytes, Transmitted: " $10 " bytes"}')

    # Output to standard output
    echo "System Metrics"
    echo "--------------"
    echo "CPU Usage: $cpu_usage"
    echo "Memory Usage: $mem_usage"
    echo "Disk Space: $disk_space"
    echo "Network Statistics: $network_stats"
    echo

    # Output to file
    echo "System Metrics" > "$output_file"
    echo "--------------" >> "$output_file"
    echo "CPU Usage: $cpu_usage" >> "$output_file"
    echo "Memory Usage: $mem_usage" >> "$output_file"
    echo "Disk Space: $disk_space" >> "$output_file"
    echo "Network Statistics: $network_stats" >> "$output_file"
    echo >> "$output_file"
}

# Call function to collect system metrics
collect_system_metrics

echo "System metrics have been saved to $output_file"

