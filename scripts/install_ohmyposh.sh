#!/bin/bash

# Install Oh My Posh
install_oh_my_posh() {
    echo "Installing Oh My Posh..."
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh
    echo "Oh My Posh installed successfully."
}

# Install Hasklig Nerd Font using Oh My Posh
install_hasklig_nerd_font() {
    echo "Installing Hasklig Nerd Font..."
    oh-my-posh font install "Hasklug Nerd Font"
    echo "Hasklig Nerd Font installed successfully."
}

# Function to setup Oh My Posh on the system
setup_oh_my_posh() {
    # Detect if wget is installed, if not attempt to install
    if ! command -v wget &> /dev/null; then
        echo "wget could not be found, attempting to install..."
        if [[ "$OS" == "Linux" ]]; then
            sudo apt-get install wget -y
        elif [[ "$OS" == "Darwin" ]]; then
            brew install wget
        fi
    fi

    install_oh_my_posh
    install_hasklig_nerd_font
}

# Detect the operating system
OS="$(uname)"
case "$OS" in
    Linux|Darwin)
        setup_oh_my_posh
        ;;
    *)
        echo "Unsupported operating system: $OS"
        exit 1
        ;;
esac
