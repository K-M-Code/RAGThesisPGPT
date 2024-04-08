#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
# Update apt packages
apt-get update

# Install tree, htop, nvtop, python 3.11, pipx, and tmux
apt-get install tree htop nvtop python3.11 pipx tmux -y

# Set up pipx
pipx ensurepath

# Install torchvision via pip
pip install torchvision

# Install poetry via pipx
pipx install poetry --force

# Set up pipx
pipx ensurepath

# Install Ollama CLI
curl -fsSL https://ollama.com/install.sh | sh

# Start Ollama CLI
ollama serve > /dev/null 2>&1 &

# Wait for Ollama to start (optional)
sleep 5

# Check if Ollama is running
if ! pgrep -x "ollama" > /dev/null
then
    echo "Error: Ollama app is not running."
    exit 1
fi

# Pull required Ollama repositories
ollama pull mistral
ollama pull mxbai-embed-large
ollama pull nomic-embed-text:1.5

# Kill Ollama CLI (if necessary)
pkill -f ollama

# Add cloudflare gpg key
mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add this repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' | tee /etc/apt/sources.list.d/cloudflared.list

# install cloudflared
apt-get update && apt-get install cloudflared

# Start new tmux session
tmux new-session -d -s "cloudflared"

tmux send-keys -t 0 'cloudflared access tcp --hostname postgres.kunalmenon.com --url 127.0.0.1:5432' C-m

# Clone the specified GitHub repository
git clone https://github.com/K-M-Code/RAGThesisPGPT.git

# Change directory to the cloned repository
cd RAGThesisPGPT/

# Start new tmux session
tmux new-session -d -s "RAGThesisPGPT"

# Split tmux window horizontally
tmux split-window -h

# Split the top pane vertically
tmux split-window -v -t 0

# Split the bottom pane horizontally
tmux split-window -h -t 1

# Arrange panes into a 2x2 grid layout
tmux select-layout tiled

# Run 'htop' in the first top-left pane
tmux send-keys -t 0 'htop' C-m

# Run 'nvtop' in the second top-right pane
tmux send-keys -t 1 'nvtop' C-m

# Run 'ollama serve' in the third bottom-left pane
tmux send-keys -t 2 'ollama serve' C-m

# Run 'make run' in the fourth bottom-right pane
tmux send-keys -t 3 'poetry install --extras "llms-ollama ui vector-stores-postgres embeddings-ollama storage-nodestore-postgres"' C-m
#tmux send-keys -t 3 'export PGPT_PROFILES="ollama-pg"' C-m
#tmux send-keys -t 3 'make run' C-m

# Attach to tmux session
tmux attach -t "RAGThesisPGPT"

echo "Script execution completed successfully."
