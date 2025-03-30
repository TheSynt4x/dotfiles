#!/bin/bash

# Default paths
DOTFILES_DIR="$HOME/dotfiles"
NIXOS_DIR="/etc/nixos"
WAYLAND_CONFIG_DIR="$HOME/.config"

# Function to display usage information
usage() {
    echo "Usage: $0 [backup|pull|apply]"
    echo
    echo "Commands:"
    echo "  backup  - Copy current system configuration to dotfiles directory"
    echo "  pull    - Pull latest changes from git repository"
    echo "  apply   - Apply dotfiles configuration to system"
    echo
    echo "Default paths:"
    echo "  Dotfiles: $DOTFILES_DIR"
    echo "  NixOS: $NIXOS_DIR"
    echo "  Wayland config: $WAYLAND_CONFIG_DIR"
}

# Function to backup configuration
backup() {
    echo "Backing up configuration..."
    
    # Backup NixOS configuration using tar (excluding specific files)
    sudo tar --exclude='nixos/configuration.nix' \
        --exclude='nixos/hardware-configuration.nix' \
        -czf "$DOTFILES_DIR/nixos.tar.gz" -C /etc nixos

    # Extract the backup to dotfiles directory
    sudo tar -xzf "$DOTFILES_DIR/nixos.tar.gz" -C "$DOTFILES_DIR/"
    
    # Remove temporary tar file
    sudo rm "$DOTFILES_DIR/nixos.tar.gz"

    # Backup all Wayland configurations
    echo "Backing up Wayland configurations..."
    sudo cp -r "$WAYLAND_CONFIG_DIR"/* "$DOTFILES_DIR/wayland/"

    echo "Backup completed successfully!"
}

# Function to pull current system changes into dotfiles
pull() {
    echo "Pulling system changes into dotfiles..."

    # Pull NixOS configurations
    echo "Pulling NixOS configurations..."
    sudo cp -r "$NIXOS_DIR/"* "$DOTFILES_DIR/nixos/"

    # Pull Wayland configurations
    echo "Pulling Wayland configurations..."
    cp -r "$WAYLAND_CONFIG_DIR/"* "$DOTFILES_DIR/wayland/"

    echo "System changes pulled into dotfiles successfully!"
}

# Function to apply configuration
apply() {
    echo "Applying configuration..."

    # Copy Wayland configurations
    echo "Applying Wayland configurations..."
    sudo cp -r "$DOTFILES_DIR/wayland/"* "$WAYLAND_CONFIG_DIR/"

    # Copy NixOS configurations
    echo "Applying NixOS configurations..."
    sudo cp -r "$DOTFILES_DIR/nixos/"* "$NIXOS_DIR/"

    # Rebuild NixOS
    echo "Rebuilding NixOS..."
    sudo nixos-rebuild switch

    echo "Configuration applied successfully!"
}

# Main script logic
case "$1" in
    "backup")
        backup
        ;;
    "pull")
        pull
        ;;
    "apply")
        apply
        ;;
    "clean")
        sudo nix-collect-garbage -d
        sudo nixos-rebuild switch
    *)
        usage
        exit 1
        ;;
esac
