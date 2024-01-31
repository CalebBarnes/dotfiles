#!/bin/bash

# Specify Go version
GO_VERSION="1.21.6"

# Determine OS and Architecture
OS="linux"
ARCH="amd64"
case "$(uname -s)" in
    Darwin) OS="darwin";;
    Linux) OS="linux";;
    *) echo "Unsupported OS"; exit 1;;
esac
case "$(uname -m)" in
    x86_64) ARCH="amd64";;
    arm64) ARCH="arm64";;
    *) echo "Unsupported architecture"; exit 1;;
esac

# Construct the download URL
DOWNLOAD_URL="https://golang.org/dl/go${GO_VERSION}.${OS}-${ARCH}.tar.gz"

# Download, extract, and install
echo "Downloading Go ${GO_VERSION} for ${OS}/${ARCH}..."
curl -LO "$DOWNLOAD_URL"

echo "Extracting Go ${GO_VERSION} to /usr/local..."
sudo tar -C /usr/local -xzf "go${GO_VERSION}.${OS}-${ARCH}.tar.gz"

# Cleanup downloaded file
rm "go${GO_VERSION}.${OS}-${ARCH}.tar.gz"
# Correcting the path checks and additions to .zshrc
echo "Setting up Go paths..."

CONF_FILE="~/.zshrc"

# For .profile
if ! grep -q 'export PATH=$PATH:/usr/local/go/bin' ~/.profile; then
    echo 'Adding Go to PATH in ~/.profile...'
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
fi

# For .bashrc
if [ -f $HOME/.bashrc ]; then
    if ! grep -q 'export PATH=$PATH:/usr/local/go/bin' $HOME/.bashrc; then
        echo 'Adding Go to PATH in ~/.bashrc...'
        CONF_FILE="~/.bashrc"
        echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.bashrc
    fi
fi

# For .zshrc
if [ -f $HOME/.zshrc ]; then
    if ! grep -q 'export PATH=$PATH:/usr/local/go/bin' $HOME/.zshrc; then
        echo 'Adding Go to PATH in ~/.zshrc...'
        CONF_FILE="~/.zshrc"
        echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.zshrc
    fi
fi

echo "Go ${GO_VERSION} installation is complete. Please restart your terminal or source your profile to use Go."
echo 
echo "To source your profile, run:"
echo
echo "source $CONF_FILE"
echo
