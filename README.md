# Aztec Sequencer Setup Guide

This guide walks you through setting up and registering the Aztec Sequencer.

---

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

---

## Step 2: Clone the Repository

```bash
git clone https://github.com/CodeDialect/aztec-squencer.git
cd aztec-squencer
```

---

## Step 3: Make Scripts Executable

```bash
chmod +x docker.sh
chmod +x aztec_squencer.sh
```

---

## Step 4: Run Docker Setup

```bash
./docker.sh
```

---

## Step 5: Start a Screen Session

```bash
screen -S aztec
```

---

If you are using vps then
## Step 6: Enable Firewall & Open Required Ports

```bash
# Basic SSH Access
ufw allow 22
ufw allow ssh

# Aztec Sequencer Ports
ufw allow 40400
ufw allow 8080

# Enable Firewall
ufw enable
ufw reload
```
---

## Step 7: Find Your Public IP

To check and save your public IP address:

```bash
curl ipv4.icanhazip.com
```

---

## Step 8: Run the Aztec Sequencer

```bash
./aztec_squencer.sh
```

---


## Step 9: Get the Latest Proven Block Number

```bash
curl -s -X POST -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"node_getL2Tips","params":[],"id":67}' http://localhost:8080 | jq -r ".result.proven.number"
```

Save the block number you get from the output (example: `20905`).

---

## Step 10: Generate Your Sync Proof

Replace both instances of `BLOCK_NUMBER` with the number you got in Step 9:

```bash
curl -s -X POST -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"node_getArchiveSiblingPath","params":["BLOCK_NUMBER","BLOCK_NUMBER"],"id":67}' http://localhost:8080 | jq -r ".result"
```

---

## Step 11: Register With Discord
https://discord.gg/aztec and go to start operator channel
1. Join the official Aztec Discord.
2. In the appropriate channel, type:

```
/operator start
```

3. Youâ€™ll be prompted to provide:
   - **Address**: Your validator (Ethereum) address  
   - **Block-number**: Block number from Step 9  
   - **Proof**: Base64 string from Step 10

---

**Note:** Press `Ctrl+A` then `D` to detach from the screen session. Reconnect later using:

```bash
screen -r aztec
```
