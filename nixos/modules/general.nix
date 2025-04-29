{ config, pkgs, ...}:

{
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

	fonts.packages = with pkgs; [
		nerdfonts
	];
}
