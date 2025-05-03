# Aztec Squencer Setup Guide

This guide walks you through setting up the Aztec Squencer.

## Step 1: Install Dependencies

Update and upgrade your system, then install required packages:

```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install nano curl screen -y
```

If you get `sudo: command not found`, install sudo:

```bash
apt install sudo -y
```

## Step 2: Clone the Repository

```bash
git clone https://github.com/CodeDialect/aztec-squencer.git
cd aztec-squencer
```

## Step 3: Make Scripts Executable

```bash
chmod +x docker.sh
chmod +x aztec-squencer.sh
```

## Step 4: Install Docker (if not already installed)

Ensure Docker is installed and running. You can install it with:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Start Docker if it isnâ€™t running:

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

## Step 5: Run Docker Setup

```bash
./docker.sh
```

## Step 6: Start a Screen Session

```bash
screen -S aztec
```

## Step 7: Run the Aztec Squencer

```bash
./aztec-squencer.sh
```

---

**Note:** Press `Ctrl+A` then `D` to detach from the screen session. Reconnect with `screen -r aztec`.
