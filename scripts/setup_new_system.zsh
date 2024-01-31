#!/bin/zsh

COLOR_GREEN="\033[0;32m"

# Install fnm (Fast Node Manager)
# Check if fnm is installed
if ! command -v fnm &> /dev/null; then
    echo "fnm not found, installing..."
    curl -fsSL https://fnm.vercel.app/install | bash
    # Source the .zshrc file to ensure fnm is available in the current shell session
    source ~/.zshrc
else
    echo "${COLOR_GREEN}fnm is already installed."
fi

# Install the latest LTS version of Node using fnm
fnm install --lts

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit

# Install pnpm
npm install -g pnpm
source ~/.zshrc

# Setup pnpm global install directory
pnpm setup
source ~/.zshrc

# Install cookie-ai-cli
pnpm i -g cookie-ai-cli
source ~/.zshrc

# Install and setup Docker Engine (must always be last)
/bin/bash -c "$(curl -fsSL https://gist.githubusercontent.com/CalebBarnes/1cebffedda280138e6c4e6a5911310ab/raw/45251744edd379ce43fde75a6bec62e23b1e67b2/setup-docker.sh)"
