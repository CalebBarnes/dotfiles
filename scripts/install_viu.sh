#!/bin/bash

# Function to install viu on macOS
install_viu_mac() {
    echo "Installing viu for macOS..."
    brew install viu
}

# Function to install viu on Linux (Debian/Ubuntu)
install_viu_linux() {
    echo "Checking for Cargo (Rust package manager)..."

    # Check if cargo is installed, if not, install Rust and Cargo
    if ! command -v cargo &> /dev/null; then
        echo "Cargo not found, installing Rust and Cargo..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source "$HOME/.cargo/env"
    fi

    echo "Installing viu for Linux..."
    cargo install viu
}


# Detect the operating system
OS="$(uname)"
case "$OS" in
    Linux) install_viu_linux ;;
    Darwin) install_viu_mac ;;
    *)
        echo "Unsupported operating system: $OS"
        exit 1
        ;;
esac

echo "Installation complete."
