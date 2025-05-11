#!/bin/bash

echo "===== System Usage Report ====="
echo "Generated on: $(date)"
echo ""

# CPU Usage
echo "----- Total CPU Usage -----"
mpstat 1 1 | awk '/Average/ && $NF ~ /[0-9.]+/ {printf "CPU Usage: %.2f%%\n", 100 - $NF}'
echo ""

# Memory Usage
echo "----- Memory Usage -----"
free -m | awk '/Mem:/ {
  total=$2; used=$3; free=$4;
  printf "Total: %d MB\nUsed: %d MB\nFree: %d MB\nUsage: %.2f%%\n", total, used, free, used/total*100
}'
echo ""

# Disk Usage
echo "----- Disk Usage (Root Partition) -----"
df -h / | awk 'NR==2 {
  printf "Total: %s\nUsed: %s\nAvailable: %s\nUsage: %s\n", $2, $3, $4, $5
}'
echo ""

# Top 5 Processes by CPU Usage
echo "----- Top 5 Processes by CPU Usage -----"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

# Top 5 Processes by Memory Usage
echo "----- Top 5 Processes by Memory Usage -----"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""
