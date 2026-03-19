#!/bin/bash

# Go to compose directory no matter where script is run from
cd "$(dirname "$0")/../compose" || exit

echo "[*] Starting Honeyd..."
docker compose up --build