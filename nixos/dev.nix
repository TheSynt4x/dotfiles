{ config, pkgs, ... }:

{
  # Enable Docker
  virtualisation.docker.enable = true;

  # Allow your user to use Docker without sudo
  users.users.null.extraGroups = [ "docker" ];

  # Enable MySQL 8.0.41
  services.mysql = {
    enable = true;
    package = pkgs.mysql80;
  };

  # Install system-wide development tools
  environment.systemPackages = with pkgs; [
    zsh
    git
    code-cursor
    docker-compose
    fnm
    dbeaver-bin
  ];

  programs.zsh = {
	enable = true;
	ohMyZsh = {
		enable = true;
		theme="amuse";
		plugins=["git" "docker"];
	};
	autosuggestions={
		enable = true;
	};
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
	fnm
  ];
}
