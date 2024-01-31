#!/bin/bash

# Function to install tree on macOS
install_tree_mac() {
    echo "Installing tree with Homebrew..."
    brew install tree
    echo "tree installation complete."
}

# Function to install tree on Debian-based Linux
install_tree_debian() {
    echo "Installing tree with apt..."
    sudo apt update && sudo apt install -y tree
    echo "tree installation complete."
}

# Function to install tree on Fedora-based Linux
install_tree_fedora() {
    echo "Installing tree with dnf..."
    sudo dnf install -y tree
    echo "tree installation complete."
}

# Main script starts here
OS="$(uname -s)"
case "${OS}" in
    Darwin*)
        command -v brew >/dev/null 2>&1 || { echo >&2 "Homebrew is required but it's not installed. Aborting."; exit 1; }
        install_tree_mac
        ;;
    Linux*)
        . /etc/os-release
        case "$ID" in
            debian|ubuntu)
                install_tree_debian
                ;;
            fedora)
                install_tree_fedora
                ;;
            *)
                echo "Unsupported Linux distribution. Please install tree manually."
                exit 1
                ;;
        esac
        ;;
    *)
        echo "Unsupported operating system: ${OS}"
        exit 1
        ;;
esac
