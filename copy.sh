tar --exclude='nixos/configuration.nix' \
    --exclude='nixos/hardware-configuration.nix' \
    -czf ~/dotfiles/nixos.tar.gz -C /etc nixos

tar -xzf ~/dotfiles/nixos.tar.gz -C ~/dotfiles/

# remove the tar.gz file
rm ~/dotfiles/nixos.tar.gz

cp -r ~/.config/waybar ~/dotfiles/wayland

cp -r ~/.config/wofi ~/dotfiles/wayland

cp -r ~/.config/dunst ~/dotfiles/wayland
