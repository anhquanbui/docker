#!/bin/bash
# ✅ SAFE MODE: This script removes containers and images only.
# Volumes and databases are kept safe, no data will be lost.

echo "🛑 Stopping all containers..."
docker stop $(docker ps -aq) 2>/dev/null

echo "🗑️  Removing all containers..."
docker rm -f $(docker ps -aq) 2>/dev/null

echo "🗑️  Removing all images..."
docker rmi -f $(docker images -aq) 2>/dev/null

echo "✅ All containers and images removed. Volumes and data are preserved."
