#!/bin/bash

PORT=80
LOG_FILE="honeypot_audit.log"

echo "Stealth Honeypot active on port $PORT..."

while true; do
    REQUEST=$(nc -lp $PORT -v 2> >(grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' > last_ip.txt) | head -n 1)
    IP=$(cat last_ip.txt)
    
    PATH_REQ=$(echo "$REQUEST" | awk '{print $2}')
    
    echo "[$(date)] Connection from $IP - Request: $REQUEST" >> "$LOG_FILE"

    case "$PATH_REQ" in
        "/")
            RESPONSE="HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<html><body><h1>Apache2 Ubuntu Default Page</h1><p>This is the default welcome page.</p></body></html>"
            ;;
        "/admin"|"/login")
            RESPONSE="HTTP/1.1 401 Unauthorized\r\nWWW-Authenticate: Basic realm=\"Restricted Admin Area\"\r\nContent-Type: text/html\r\n\r\n<html><body><h1>401 Unauthorized</h1></body></html>"
            echo "!! ALERT: $IP attempted to access ADMIN area !!" >> "$LOG_FILE"
            ;;
        "/config.php"|"/wp-admin")
            RESPONSE="HTTP/1.1 403 Forbidden\r\nContent-Type: text/html\r\n\r\n<html><body><h1>Access Denied</h1><p>Permissions for config.php are restricted to local loopback.</p></body></html>"
            ;;
        *.php|*.sql|*.env)
            RESPONSE="HTTP/1.1 404 Not Found\r\nContent-Type: text/html\r\n\r\n<html><body><h1>File Not Found</h1><p>The requested resource is missing.</p></body></html>"
            ;;
        *)
            RESPONSE="HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<html><body><h1>It works!</h1></body></html>"
            ;;
    esac

    echo -e "$RESPONSE" | nc -lp $PORT > /dev/null 2>&1
done
