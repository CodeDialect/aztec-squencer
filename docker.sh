#!/bin/bash

set -e

# Colors
CYAN='\033[0;36m'
GREEN='\033[1;32m'
RED='\033[1;31m'
RESET='\033[0m'
BOLD='\033[1m'

echo -e "${CYAN}${BOLD}--- Installing Docker (Official Method) ---${RESET}"

# Remove old versions
echo -e "${CYAN}Removing old Docker versions (if any)...${RESET}"
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
  sudo apt-get remove -y $pkg &>/dev/null || true
done

# Set up Docker repo
echo -e "${CYAN}Setting up Docker repository...${RESET}"
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" |
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
echo -e "${CYAN}Installing Docker components...${RESET}"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add user to docker group
echo -e "${CYAN}Adding user '${USER}' to the docker group...${RESET}"
sudo usermod -aG docker "$USER"
newgrp docker
# Restart Docker and test
echo -e "${CYAN}Starting Docker service...${RESET}"
sudo systemctl enable docker
sudo systemctl restart docker

# Let the group change take effect in the current shell
echo -e "${CYAN}Refreshing group membership (newgrp)...${RESET}"
newgrp docker <<EONG

echo -e "${GREEN}${BOLD}Testing Docker with hello-world...${RESET}"
docker run hello-world

if [ $? -eq 0 ]; then
  echo -e "${GREEN}${BOLD}Docker installed and running successfully!${RESET}"
else
  echo -e "${RED}${BOLD}Docker failed to run. Check permissions or restart shell.${RESET}"
fi

EONG
