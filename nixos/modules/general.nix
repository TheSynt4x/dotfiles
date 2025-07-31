{ config, pkgs, ...}:

{
	imports = [
		(import ./micro.nix { inherit config pkgs; })
	];

	environment.systemPackages = with pkgs; [
		discord
		slack
		google-chrome
		vlc
		ffmpeg
		udiskie
	];
	
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};

	fonts.packages = [ 
		pkgs.nerd-fonts.jetbrains-mono
	];
}
