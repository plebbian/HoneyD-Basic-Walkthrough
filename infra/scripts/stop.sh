#!/bin/bash

cd "$(dirname "$0")/../compose" || exit

echo "[*] Stopping Honeyd..."
docker compose down