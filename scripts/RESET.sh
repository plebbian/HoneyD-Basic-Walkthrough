#!/bin/bash
# For a complete reset

echo "[🧼🫧🧺🧽🧹]CLEANING EVERYTHING..."

docker rm -f honeyd 2>/dev/null || true
docker rmi honeyd-18 2>/dev/null || true

echo "[✅] DONE"