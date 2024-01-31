#!/bin/bash

# Function to install fd on macOS
install_fd_mac() {
    echo "Installing fd with Homebrew..."
    brew install fd
    echo "fd installation complete."
}

# Function to install fd on Debian-based Linux
install_fd_debian() {
    echo "Installing fd with apt..."
    sudo apt update && sudo apt install -y fd-find
    echo "Creating a symlink to fd (as fd-find is the package name)..."
    sudo ln -s $(which fdfind) /usr/local/bin/fd
    echo "fd installation complete."
}

# Function to install fd on Fedora-based Linux
install_fd_fedora() {
    echo "Installing fd with dnf..."
    sudo dnf install -y fd-find
    echo "Creating a symlink to fd (as fd-find is the package name)..."
    sudo ln -s $(which fdfind) /usr/local/bin/fd
    echo "fd installation complete."
}

# Main script starts here
OS="$(uname -s)"
case "${OS}" in
    Darwin*)
        command -v brew >/dev/null 2>&1 || { echo >&2 "Homebrew is required but it's not installed. Aborting."; exit 1; }
        install_fd_mac
        ;;
    Linux*)
        . /etc/os-release
        case "$ID" in
            debian|ubuntu)
                install_fd_debian
                ;;
            fedora)
                install_fd_fedora
                ;;
            *)
                echo "Unsupported Linux distribution. Please install fd manually."
                exit 1
                ;;
        esac
        ;;
    *)
        echo "Unsupported operating system: ${OS}"
        exit 1
        ;;
esac
