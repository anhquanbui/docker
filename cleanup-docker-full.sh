#!/bin/bash
# 🚨 WARNING: This script will remove ALL Docker data including volumes (databases).
# Use only if you want to completely reset Docker to a clean state.

echo "🛑 Stopping all containers..."
docker stop $(docker ps -aq) 2>/dev/null

echo "🗑️  Removing all containers..."
docker rm -f $(docker ps -aq) 2>/dev/null

echo "🗑️  Removing all images..."
docker rmi -f $(docker images -aq) 2>/dev/null

echo "🗑️  Removing all volumes..."
docker volume rm $(docker volume ls -q) 2>/dev/null

echo "🗑️  Removing all non-default networks..."
docker network rm $(docker network ls -q) 2>/dev/null

echo "🧹 Pruning system (containers, images, networks, volumes)..."
docker system prune -a -f --volumes

echo "✅ Docker has been completely cleaned."
