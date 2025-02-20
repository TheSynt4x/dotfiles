{ config, pkgs, ... }:

{
	users.users.null = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = ["wheel" "docker"];
	};
}
