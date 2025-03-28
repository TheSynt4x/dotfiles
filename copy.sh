#!/bin/bash

# Script to copy NixOS config files to dotfiles repo while preserving directory structure
# Excludes configuration.nix and hardware-configuration.nix

echo "Copying NixOS config files to dotfiles repo..."

# Create the target directory if it doesn't exist
mkdir -p ~/dotfiles/etc/nixos

# Use rsync to copy files while excluding specific ones
rsync -av --exclude='configuration.nix' \
         --exclude='hardware-configuration.nix' \
         /etc/nixos ~/dotfiles/

echo "Done! NixOS config files copied from /etc/nixos to ~/dotfiles/nixos"