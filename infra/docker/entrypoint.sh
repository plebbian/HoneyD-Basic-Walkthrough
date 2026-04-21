#!/bin/bash
set -e

INTERFACE="${HONEYD_INTERFACE:-lo}"
CONFIG="${HONEYD_CONFIG:-/opt/honeyd/honeyd.conf}"
HONEYD_NET="${HONEYD_NET:-192.168.0.0/24}"
HONEYD_GW="${HONEYD_GW:-127.0.0.1}"
HONEYD_BIN="${HONEYD_BIN:-/usr/bin/honeyd}"

echo "[*] USING HONEYD BINARY: ${HONEYD_BIN}"
echo "[*] USING INTERFACE: ${INTERFACE}"
echo "[*] USING CONFIG: ${CONFIG}"
echo "[*] USING HONEYD NETWORK: ${HONEYD_NET}"

if [ ! -x "${HONEYD_BIN}" ]; then
    echo "[!] HONEYD BINARY NOT FOUND OR NOT EXECUTABLE: ${HONEYD_BIN}"
    exit 1
fi

if [ ! -f "${CONFIG}" ]; then
    echo "[!] HONEYD CONFIG NOT FOUND: ${CONFIG}"
    exit 1
fi

echo "[*] STARTING SSH BACKEND ON PORT 2222..."
mkdir -p /var/run/sshd
/usr/sbin/sshd

echo "[*] STARTING WEB BACKEND ON PORT 8080..."
cd /opt/honeyd
nohup python3 -m http.server 8080 >/tmp/web.log 2>&1 &
sleep 2

if ! ss -tulpn | grep -q ':8080'; then
    echo "[!] WEB BACKEND FAILED TO START"
    cat /tmp/web.log 2>/dev/null || true
    exit 1
fi

echo "[*] ADDING ROUTE: ${HONEYD_NET} via ${HONEYD_GW}"
ip route add "${HONEYD_NET}" via "${HONEYD_GW}" 2>/dev/null || true

echo "[*] STARTING HONEYD..."
exec "${HONEYD_BIN}" -d -f "${CONFIG}" -i "${INTERFACE}"