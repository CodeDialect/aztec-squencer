# Aztec Squencer Setup Guide

This guide walks you through setting up the Aztec Squencer.

## Step 1: Install Dependencies

Update and upgrade your system, then install required packages:

```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install nano curl screen git -y
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


## Step 4: Run Docker Setup

```bash
./docker.sh
```

## Step 5: Start a Screen Session

```bash
screen -S aztec
```

## Step 6: Run the Aztec Squencer

```bash
./aztec-squencer.sh
```

---

**Note:** Press `Ctrl+A` then `D` to detach from the screen session. Reconnect with `screen -r aztec`.
