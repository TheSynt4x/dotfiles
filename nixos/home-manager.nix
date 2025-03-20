{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
  plasma-manager = builtins.fetchTarball "https://github.com/nix-community/plasma-manager/archive/master.tar.gz";
in
{
  imports =
    [
      (import "${home-manager}/nixos")
    ];

  users.users.null.isNormalUser = true;
  home-manager.users.null = { pkgs, ... }: {
    imports = [ "${plasma-manager}/modules" ];

    home.stateVersion = "24.11";

    # Configure KDE Plasma using plasma-manager
    programs.plasma = {
      enable = true;

      configFile = {
        "kwinrc"."Desktops"."Number" = {
          value = 4;
          immutable = true; # Prevents changes from the settings app
        };
        "kwinrc"."Desktops"."Rows" = 1;
        "kxkbrc"."Layout"."DisplayNames" = ",";
        "kxkbrc"."Layout"."LayoutList" = "se,us";
        "kxkbrc"."Layout"."Use" = true;
        "kxkbrc"."Layout"."VariantList" = ",";
        "kwinrc"."Xwayland"."Scale" = 1.0;
        "kdeglobals"."Sounds"."Enable" = false;
        "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
      };

      shortcuts = {
        kwin = {
          "Switch to Desktop 1" = "Alt+1";
          "Switch to Desktop 2" = "Alt+2";
          "Switch to Desktop 3" = "Alt+3";
          "Switch to Desktop 4" = "Alt+4";
          "Window Maximize"     = "Meta+Up"; 
          "Window to Desktop 1" = "Ctrl+Alt+1";
          "Window to Desktop 2" = "Ctrl+Alt+2";
          "Window to Desktop 3" = "Ctrl+Alt+3";
          "Window to Desktop 4" = "Ctrl+Alt+4";
        };
        
        "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Alt+Shift";
      };

      dataFile = {
        "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" = true;
      };
    };
  };
}
