{ config, pkgs, ... }:

{
	programs.zsh.enable = true;
	
	users.defaultUserShell = pkgs.zsh;

	users.users.null = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = ["wheel" "docker"];
	};
}
