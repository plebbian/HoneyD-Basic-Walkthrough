#!/bin/bash
set -e

echo "[🔨] BUILDING HONEYD IMAGE..."
docker build -t honeyd-18 -f infra/docker/Dockerfile .

echo "[✅] BUILD COMPLETE"

echo "[🗑] REMOVING EXISTING CONTAINER (if it exists)..."
docker rm -f honeyd 2>/dev/null || true

echo "[🏁] STARTING HONEYD CONTAINER..."

docker run -it \
  --name honeyd \
  --network host \
  --cap-add=NET_ADMIN \
  --cap-add=NET_RAW \
  --privileged \
  honeyd-18