{ config, pkgs, lib, ... }:

let
  userConfig = {
    username = "null";
    homeDirectory = "/home/null";
    defaultLocale = "en_US.UTF-8";
  };
in
{
  imports = [
    (import ./desktop.nix { inherit config pkgs lib userConfig; })
    (import ./modules/dev.nix { inherit config pkgs userConfig; })
    (import ./modules/general.nix { inherit config pkgs userConfig; })
  ];

  # User configuration
  users.defaultUserShell = pkgs.zsh;
  users.users.${userConfig.username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ];
  };

  # ZSH configuration
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "amuse";
      plugins = [ "git" "docker" ];
    };
    autosuggestions.enable = true;
  };

  # System-wide settings
  i18n.defaultLocale = userConfig.defaultLocale;
}