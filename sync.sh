#!/bin/bash

# Default paths
DOTFILES_DIR="$HOME/dotfiles"
NIXOS_DIR="/etc/nixos"
WAYLAND_CONFIG_DIR="$HOME/.config"

# Function to display usage information
usage() {
    echo "Usage: $0 [backup|symlink|clean]"
    echo
    echo "Commands:"
    echo "  backup  - Copy current system configuration to dotfiles directory (use before initial setup)"
    echo "  symlink - Create symlinks from system to dotfiles directory"
    echo "  clean   - Clean up old generations and rebuild NixOS"
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

# Function to create symlinks
create_symlinks() {
    echo "Creating symlinks..."

    # Create symlink for NixOS configuration
    echo "Creating symlink for NixOS configuration..."
    sudo rm -rf "$NIXOS_DIR"  # Remove existing directory
    sudo mkdir -p "$(dirname "$NIXOS_DIR")"
    sudo ln -sf "$DOTFILES_DIR/nixos" "$NIXOS_DIR"

    # Create symlinks for Wayland configurations
    echo "Creating symlinks for Wayland configurations..."
    mkdir -p "$WAYLAND_CONFIG_DIR"
    for dir in "$DOTFILES_DIR/wayland"/*; do
        if [ -d "$dir" ]; then
            folder_name=$(basename "$dir")
            echo "  Linking $folder_name..."
            rm -rf "$WAYLAND_CONFIG_DIR/$folder_name"  # Remove existing directory
            ln -sf "$dir" "$WAYLAND_CONFIG_DIR/$folder_name"
        fi
    done

    echo "Symlinks created successfully!"
}

# Main script logic
case "$1" in
    "backup")
        backup
        ;;
    "symlink")
        create_symlinks
        ;;
    "clean")
        sudo nix-collect-garbage -d
        sudo nixos-rebuild switch
        ;;
    *)
        usage
        exit 1
        ;;
esac
