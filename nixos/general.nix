{ config, pkgs, ...}:

{
	environment.systemPackages = with pkgs; [
		discord
		slack
		google-chrome
		vlc
		p7zip
		ffmpeg
	];
}
