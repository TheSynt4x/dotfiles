#!/bin/bash

# Script to apply dotfiles to NixOS and rebuild the system

sudo cp -r ~/dotfiles/wayland/* ~/.config

echo "Applying NixOS configuration from dotfiles..."

# Navigate to dotfiles directory

# Copy files from dotfiles to /etc/nixos
echo "Copying configuration files to /etc/nixos..."
sudo cp -r ~/dotfiles/nixos/* /etc/nixos/

echo "Rebuilding NixOS..."
sudo nixos-rebuild switch
echo "NixOS rebuild complete"
