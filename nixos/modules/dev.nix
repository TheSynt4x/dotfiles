{ config, pkgs, userConfig, ... }:

let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
  # Enable Docker
  virtualisation.docker.enable = true;
  networking.firewall = {
      enable = true;
      extraCommands = ''
        iptables -I INPUT 1 -s 172.16.0.0/12 -p tcp -d 172.17.0.1 -j ACCEPT
        iptables -I INPUT 2 -s 172.16.0.0/12 -p udp -d 172.17.0.1 -j ACCEPT
      '';
    };
  
  # Allow your user to use Docker without sudo
  users.users.${userConfig.username}.extraGroups = [ "docker" ];

  # Enable MySQL 8.0.41
  services.mysql = {
    enable = true;
    package = pkgs.mysql80;

    # Specify the MySQL configuration settings
    settings = {
      mysqld = {
        bind-address = "0.0.0.0";  # Allow external connections
        port = 3306;  # MySQL default port
        default-time-zone = "+00:00";  # Set timezone to UTC (change if needed)
        transaction-isolation = "READ-COMMITTED";  # Set transaction isolation level
      };
    };
  };

  # Install system-wide development tools
  environment.systemPackages = with pkgs; [
    unstable.code-cursor
    docker-compose
    git
    vscode
    fnm
    dbeaver-bin
    lz4
    pv
    htop
    zsh
    p7zip
    zip
    fastfetch
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    fnm
  ];
  
  services.envfs.enable = true;
}
