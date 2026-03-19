#!/bin/bash
set -e

INTERFACE="${HONEYD_INTERFACE:-lo}"
CONFIG="${HONEYD_CONFIG:-/opt/honeyd/honeyd.conf}"
HONEYD_NET="${HONEYD_NET:-192.168.0.0}"
HONEYD_MASK="${HONEYD_MASK:-255.255.255.0}"
HONEYD_GW="${HONEYD_GW:-127.0.0.1}"
HONEYD_BIN="${HONEYD_BIN:-/usr/local/bin/honeyd-host}"

echo "[*] Using Honeyd binary: ${HONEYD_BIN}"
echo "[*] Using interface: ${INTERFACE}"
echo "[*] Using config: ${CONFIG}"

if [ ! -x "${HONEYD_BIN}" ]; then
    echo "[!] Honeyd binary not found or not executable: ${HONEYD_BIN}"
    exit 1
fi

if [ ! -f "${CONFIG}" ]; then
    echo "[!] Honeyd config not found: ${CONFIG}"
    exit 1
fi

echo "[*] Adding route: ${HONEYD_NET}/${HONEYD_MASK} via ${HONEYD_GW}"
route add -net "${HONEYD_NET}" netmask "${HONEYD_MASK}" gw "${HONEYD_GW}" 2>/dev/null || true

echo "[*] Starting Honeyd..."
exec "${HONEYD_BIN}" -d -f "${CONFIG}" -i "${INTERFACE}"