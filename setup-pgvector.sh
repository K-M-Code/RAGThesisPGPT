#!/bin/bash

# Update package lists
apt-get update

# Install nano, tree, and htop
apt-get install nano tree htop -y

# Install necessary packages for HTTPS access
apt-get install ca-certificates curl -y

# Create directory for apt keyrings
install -m 0755 -d /etc/apt/keyrings

# Download Docker GPG key and set permissions
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository to apt sources list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package lists with Docker repository
apt-get update

# Install Docker packages
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Check if Docker is installed successfully by listing running containers
docker ps
