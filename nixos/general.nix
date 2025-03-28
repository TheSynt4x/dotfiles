{ config, pkgs, ...}:

{
	environment.systemPackages = with pkgs; [
		discord
		slack
		google-chrome
		vlc
		ffmpeg
	];
	
	fonts.packages = with pkgs; [
		nerdfonts
	];
}
