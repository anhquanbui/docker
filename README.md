# 🚀 Docker Setup & Commands for VPS

This guide helps you **install Docker on VPS (Ubuntu/Debian)** and provides a **cheat sheet of essential Docker commands**.

---

## 🔧 System Check
```bash
cat /etc/os-release
```

---

## 📥 Install Docker

### Ubuntu
```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

# Add GPG key & repo
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Turn on service & test
sudo systemctl enable --now docker
sudo docker run --rm hello-world
```

---

### Debian
```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker
sudo docker run --rm hello-world
```

---

## ✅ Re-check Installation
```bash
systemctl status docker
sudo docker --version
docker run hello-world
```

---

## ⚡ Enable Docker (if inactive)
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

---

# 📚 Docker Command Cheat Sheet

👉 If you’re just starting out, remember these **Top 5 Commands**:
```bash
docker ps -a
docker run ...
docker stop ...
docker rm ...
docker exec -it ...
```

---

## 1. Basic Container Operations
```bash
docker ps                       # List running containers
docker ps -a                    # List all containers (including stopped ones)
docker run -it <image> <cmd>    # Run container (foreground)
docker run -d <image>           # Run container (background / detached)
docker run -it --name myapp <image>   # Run with custom name
docker run -p 8080:80 <image>   # Map host:container ports
docker run -v $(pwd):/app <image>     # Mount host folder
```

---

## 2. Managing Containers
```bash
docker stop <id|name>           # Stop a container
docker start <id|name>          # Start a stopped container
docker restart <id|name>        # Restart container
docker rm <id|name>             # Remove stopped container
docker container prune          # Remove all stopped containers
```

---

## 3. Managing Images
```bash
docker images                   # List local images
docker pull <image>:<tag>       # Pull image from Docker Hub
docker rmi <id|name>            # Remove image
docker image prune -a           # Remove unused images
```

---

## 4. Inspecting & Accessing Containers
```bash
docker exec -it <id|name> bash  # Open shell inside container
docker logs <id|name>           # Show logs
docker logs -f <id|name>        # Follow logs in real time
```

---

## 5. Building Images
```bash
docker build -t myapp:latest .
docker build -t myapp:latest --build-arg ENV=prod .
```

---

## 6. System Management
```bash
docker info                     # Show system info
docker system prune -a          # Clean up unused data
docker system df                # Show disk usage
```

---

## 7. Networks & Volumes
```bash
docker network ls               # List networks
docker network create mynet     # Create network
docker run -d --network=mynet --name=web nginx   # Run container in network
docker volume ls                # List volumes
docker volume prune             # Remove unused volumes
```

---

## 8. Bonus: Docker Compose
```bash
docker compose up -d            # Start services
docker compose down             # Stop & remove services
docker compose up -d --build    # Rebuild & restart services
```

---

## 🧹 Cleanup Scripts (you can downoa

Sometimes you want to remove containers and images (to refresh environment) or completely reset Docker.  
Below are two ready-to-use scripts (already uploaded to Git).

### 1. Light Cleanup (Safe)
Removes **containers + images** only. Keeps **volumes and databases** safe.

```bash
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
```

Save as `cleanup-docker-light.sh` and run:
```bash
chmod +x cleanup-docker-light.sh
./cleanup-docker-light.sh
```

---

### 2. Full Cleanup (Dangerous)
Removes **everything**: containers, images, volumes, and networks.  
⚠️ **All data (including databases) will be deleted**.

```bash
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
```

Save as `cleanup-docker-full.sh` and run:
```bash
chmod +x cleanup-docker-full.sh
./cleanup-docker-full.sh
```

---

✨ With this guide, you can quickly set up Docker on your VPS, manage containers like a pro, and clean up safely when needed.
