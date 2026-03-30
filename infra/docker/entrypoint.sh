#!/bin/bash
set -e

INTERFACE="${HONEYD_INTERFACE:-lo}"
CONFIG="${HONEYD_CONFIG:-/opt/honeyd/honeyd.conf}"
HONEYD_NET="${HONEYD_NET:-192.168.0.0/24}"
ROUTE_NET="${ROUTE_NET:-192.168.0.0}"
ROUTE_MASK="${ROUTE_MASK:-255.255.255.0}"
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

echo "[*] ADDING ROUTE: ${ROUTE_NET}/${ROUTE_MASK} via ${HONEYD_GW}"
ip route add "${HONEYD_NET}" via "${HONEYD_GW}" 2>/dev/null || true

echo "[*] STARTING HONEYD..."
exec "${HONEYD_BIN}" -d -f "${CONFIG}" -i "${INTERFACE}"