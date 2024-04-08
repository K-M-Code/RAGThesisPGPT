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

# Split tmux window vertically
tmux split-window -v

# Split the top pane horizontally (to create 2 windows on top)
tmux split-window -h -t 0

# Arrange panes into a layout with 2 windows on top and 1 on the bottom
tmux select-layout even-horizontal

# Run 'htop' in the first top-left pane
tmux send-keys -t 0 'htop' C-m

# Run 'nvtop' in the second top-right pane
tmux send-keys -t 1 'nvtop' C-m

# Run 'make run' in the fourth bottom-right pane
tmux send-keys -t 2 'poetry install --extras "ui llms-llama-cpp vector-stores-postgres storage-nodestore-postgres embeddings-huggingface llms-openai-like"' C-m

tmux send-keys -t 2 'export PGPT_PROFILES="local"' C-m

tmux send-keys -t 2 'poetry run python scripts/setup' C-m

# Attach to tmux session
tmux attach -t "RAGThesisPGPT"

echo "Script execution completed successfully."
