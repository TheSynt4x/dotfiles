#!/bin/bash

# Script to copy NixOS config files to dotfiles repo while preserving directory structure
# Excludes configuration.nix and hardware-configuration.nix

echo "Copying NixOS config files to dotfiles repo..."

# Create the target directory if it doesn't exist
mkdir -p ~/dotfiles/nixos

# Use rsync to copy files while preserving directory structure
# --archive (-a) preserves permissions, timestamps, and directory structure
# --exclude excludes specific files
# --relative (-R) tells rsync to maintain full path structure
rsync -aR \
  --exclude 'configuration.nix' \
  --exclude 'hardware-configuration.nix' \
  /etc/nixos/. ~/dotfiles/nixos/

echo "Done! NixOS config files copied to ~/dotfiles/nixos"