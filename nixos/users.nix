{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		zsh
	];

	programs.zsh = {
		enable = true;
		ohMyZsh = {
			enable = true;
			theme="amuse";
			plugins=["git" "docker"];
		};
		autosuggestions = {
			enable = true;
		};
	};

	users.defaultUserShell = pkgs.zsh;

	users.users.null = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = ["wheel" "docker"];
	};
}
