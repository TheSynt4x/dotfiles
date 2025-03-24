#!/bin/bash

# Script to copy NixOS config files to dotfiles repo
# Excludes configuration.nix and hardware-configuration.nix

echo "Copying NixOS config files to dotfiles repo..."

# Create the target directory if it doesn't exist
mkdir -p ~/dotfiles/nixos

# Copy all files from /etc/nixos to ~/dotfiles/nixos except the excluded ones
find /etc/nixos -type f \
  ! -name "configuration.nix" \
  ! -name "hardware-configuration.nix" \
  -exec cp {} ~/dotfiles/nixos/ \;

echo "Done! NixOS config files copied to ~/dotfiles/nixos"