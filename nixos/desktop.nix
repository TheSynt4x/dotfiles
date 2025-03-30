{
  config,
  pkgs,
  lib,
  userConfig,
  ...
}:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
    ./modules/tlp.nix
  ];

  # Additional packages you might need
  environment.systemPackages = with pkgs; [
    grimblast # For screenshots
    wofi # Application launcher
    waybar # Status bar
    swaybg # Wallpaper
    kitty # Terminal
    nautilus # File manager
    bibata-cursors # Cursor theme
    swaylock # Screen locker
    xdg-desktop-portal-hyprland # Ensure proper integration with applications
    mako # Notification daemon
    wl-clipboard # Clipboard manager
    micro # Text editor
    pavucontrol # Audio control
  ];

  services.xserver.excludePackages = [ pkgs.xterm ];

  programs.hyprland.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # to use vscode under wayland

  users.users.${userConfig.username}.isNormalUser = true;
  home-manager.users.${userConfig.username} =
    { pkgs, ... }:
    {
      home.stateVersion = "24.11";
      home.sessionVariables.NIXOS_OZONE_WL = "1"; # ???

      imports = [
        (import ./pkgs/hyprland/hyprland.nix { inherit pkgs ; } )
        (import ./pkgs/swaylock/swaylock.nix { inherit pkgs ; } )
        (import ./pkgs/waybar/waybar.nix { inherit pkgs ; } )
        (import ./pkgs/wofi/wofi.nix { inherit pkgs ; } )
        (import ./pkgs/kitty/kitty.nix { inherit pkgs ; } )
        # ./pkgs/mako.nix
      ];
    };
}
