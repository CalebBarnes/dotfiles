#!/bin/sh

# Path to your .zshrc in the home directory
ZSHRC_SOURCE="$HOME/.zshrc"
# Destination path within your dotfiles repository
ZSHRC_DEST="$(git rev-parse --show-toplevel)/.zshrc"

# Copy the .zshrc file to your dotfiles repo
cp "$ZSHRC_SOURCE" "$ZSHRC_DEST"

# Add the .zshrc file to the staging area
git add "$ZSHRC_DEST"

# Optionally, you can include a message or log
echo ".zshrc synchronized."

exit 0
