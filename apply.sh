#!/bin/bash

# Script to apply dotfiles to NixOS and rebuild the system

echo "Applying NixOS configuration from dotfiles..."

# Navigate to dotfiles directory
cd ~/dotfiles

# Try to pull latest changes from git
if [ -d .git ]; then
  echo "Pulling latest changes from git repository..."
  git checkout main
  git pull origin main
  if [ $? -ne 0 ]; then
    echo "Warning: Failed to pull from git repository"
  fi
else
  echo "Not a git repository, skipping git pull"
fi

# Copy files from dotfiles to /etc/nixos
echo "Copying configuration files to /etc/nixos..."
sudo cp -r ~/dotfiles/nixos/* /etc/nixos/

# Rebuild NixOS
echo "Rebuilding NixOS..."
sudo nixos-rebuild switch

echo "Done! NixOS configuration applied and system rebuilt."