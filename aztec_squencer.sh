#!/bin/bash

set -e

# Colors
CYAN='\033[0;36m'
GREEN='\033[1;32m'
RED='\033[1;31m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
RESET='\033[0m'
BOLD='\033[1m'

# ===============================
# BANNER
# ===============================
echo -e "${PURPLE}${BOLD}"
echo "=========================================================================="
cat <<'EOF'
     __            _        _                    _                   
  /\ \ \ _    | |  _ | |   _   _  _   | |_  _  _   __ 
 /  \/ // _ \  / _` | / _ \| '_ \ | | |  '_ \ | |/ _ \| '_  /
/ /\  /| (_)  (_|   /| | |  |_|  | | || |_|  /| |    / / 
\_\ \/  \_/  \,_| \__| |_| \,__| |_| \|\_||_|   /___|

EOF
echo "                        Aztec Node Installer by nodehunterz"
echo "=========================================================================="
echo -e "${RESET}"

# ===============================
# Prompt for user variables
# ===============================
read -rp "Enter your L1 RPC URL: " L1_RPC_URL
read -rp "Enter your L1 Consensus Host URL: " L1_CONSENSUS_URL
read -rp "Enter your Validator Private Key (0x...): " VALIDATOR_KEY
read -rp "Enter your Sequencer Coinbase Address (0x...): " COINBASE
read -rp "Enter your Public P2P IP: " P2P_IP

# ===============================
# Essential packages
# ===============================
echo -e "${BLUE}[INFO] Installing essential packages...${RESET}"
sudo apt update
sudo apt install -y curl git sudo nano lsof net-tools software-properties-common

# ===============================
# Node.js Installation (if needed)
# ===============================
if ! command -v node &>/dev/null; then
  echo -e "${BLUE}[INFO] Installing Node.js using NVM...${RESET}"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm install --lts
fi

# ===============================
# Install Aztec CLI
# ===============================
echo -e "${BLUE}[INFO] Installing Aztec CLI...${RESET}"
curl -s https://install.aztec.network | bash

echo 'export PATH="$HOME/.aztec/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.aztec/bin:$PATH"

# ===============================
# Setup Network
# ===============================
echo -e "${BLUE}[INFO] Setting up Aztec alpha-testnet environment...${RESET}"
aztec-up alpha-testnet

# ===============================
# Start Node
# ===============================
echo -e "${BLUE}[INFO] Starting Aztec node...${RESET}"

aztec start --node --archiver --sequencer \
  --network alpha-testnet \
  --l1-rpc-urls "$L1_RPC_URL" \
  --l1-consensus-host-urls "$L1_CONSENSUS_URL" \
  --sequencer.validatorPrivateKey $VALIDATOR_KEY \
  --sequencer.coinbase $COINBASE \
  --p2p.p2pIp=$P2P_IP \
  --p2p.maxTxPoolSize 1000000000
