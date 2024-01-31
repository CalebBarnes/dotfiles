#!/bin/bash

# Install Zsh on Debian-based Linux
install_zsh_linux() {
    echo "Installing Zsh..."
    sudo apt update && sudo apt install -y zsh
    echo "Zsh installation complete."
}

# Change the default shell to Zsh
change_shell_to_zsh() {
    # Check if Zsh is not the default shell
    if [ "$(echo $SHELL)" != "$(which zsh)" ]; then
        echo "Changing the default shell to Zsh..."
        chsh -s $(which zsh)
        echo "Default shell changed to Zsh. Please log out and log back in for the changes to take effect."
    else
        echo "Zsh is already the default shell."
    fi
}

# Install Zsh on macOS (if necessary) and change the default shell
install_and_change_shell_mac() {
    if ! command -v zsh &> /dev/null; then
        echo "Zsh is not installed. Installing Zsh..."
        brew install zsh
    else
        echo "Zsh is already installed."
    fi
    change_shell_to_zsh
}

# Main script starts here

# Detect the operating system
OS="$(uname -s)"
case "${OS}" in
    Linux*)     install_zsh_linux; change_shell_to_zsh;;
    Darwin*)    install_and_change_shell_mac;;
    *)          echo "Unsupported operating system: ${OS}"; exit 1;;
esac
