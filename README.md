# 🚀 Docker Setup & Commands for VPS

This guide helps you **install Docker on VPS (Ubuntu/Debian)** and provides a **cheat sheet of essential Docker commands**.

---

## 🔧 System Check
```
cat /etc/os-release
```

---

## 📥 Install Docker

### Ubuntu
```
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
```
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
```
systemctl status docker
sudo docker --version
docker run hello-world
```

---

## ⚡ Enable Docker (if inactive)
```
sudo systemctl start docker
sudo systemctl enable docker
```

---

# 📚 Docker Command Cheat Sheet

👉 If you’re just starting out, remember these **Top 5 Commands**:
```
docker ps -a
docker run ...
docker stop ...
docker rm ...
docker exec -it ... bash
```

---

## 1. Basic Container Operations
```
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
```
docker stop <id|name>           # Stop a container
docker start <id|name>          # Start a stopped container
docker restart <id|name>        # Restart container
docker rm <id|name>             # Remove stopped container
docker container prune          # Remove all stopped containers
```

---

## 3. Managing Images
```
docker images                   # List local images
docker pull <image>:<tag>       # Pull image from Docker Hub
docker rmi <id|name>            # Remove image
docker image prune -a           # Remove unused images
```

---

## 4. Inspecting & Accessing Containers
```
docker exec -it <id|name> bash  # Open shell inside container
docker logs <id|name>           # Show logs
docker logs -f <id|name>        # Follow logs in real time
```

---

## 5. Building Images
```
docker build -t myapp:latest .
docker build -t myapp:latest --build-arg ENV=prod .
```

---

## 6. System Management
```
docker info                     # Show system info
docker system prune -a          # Clean up unused data
docker system df                # Show disk usage
```

---

## 7. Networks & Volumes
```
docker network ls               # List networks
docker network create mynet     # Create network
docker run -d --network=mynet --name=web nginx   # Run container in network
docker volume ls                # List volumes
docker volume prune             # Remove unused volumes
```

---

## 8. Bonus: Docker Compose
```
docker compose up -d            # Start services
docker compose down             # Stop & remove services
docker compose up -d --build    # Rebuild & restart services
```

---

✨ With this guide, you can quickly set up Docker on your VPS and manage containers like a pro!
