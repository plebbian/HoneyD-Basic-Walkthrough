#!/bin/bash

cd "$(dirname "$0")/../compose" || exit

echo "[*] Resetting Honeyd..."
docker compose down -v
docker compose up --build