#!/bin/bash

PORT=2222 
LOG_FILE="ssh_honeypot.log"

echo "SSH Honeypot started on port $PORT..."

while true; do
    
    ATTACKER_INFO=$(timeout 5s nc -lp $PORT -v <<EOF
SSH-2.0-OpenSSH_7.4p1 Debian-10+deb9u7
EOF
)
    echo "[$(date)] Connection detected!" >> "$LOG_FILE"
    echo "Raw Data: $ATTACKER_INFO" >> "$LOG_FILE"
    echo "------------------------------------" >> "$LOG_FILE"
done
