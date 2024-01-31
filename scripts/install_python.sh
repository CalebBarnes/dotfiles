#!/bin/bash

# Function to install Python and pip on Debian-based Linux
install_on_debian() {
    echo "Updating package lists..."
    sudo apt update
    echo "Installing Python3 and pip..."
    sudo apt install -y python3-pip
    pip3 --version
}

# Function to install Python and pip on macOS
install_on_mac() {
    echo "Checking for Homebrew..."
    which brew
    if [ $? -ne 0 ]; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "Updating Homebrew..."
    brew update
    echo "Installing Python3..."
    brew install python
    echo "Checking pip3 version..."
    pip3 --version
}

# Detect the operating system
OS="$(uname -s)"
case "${OS}" in
    Linux*)     install_on_debian;;
    Darwin*)    install_on_mac;;
    *)          echo "Unsupported operating system: ${OS}"; exit 1;;
esac
