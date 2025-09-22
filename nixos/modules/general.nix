{ config, pkgs, ...}:

{
	imports = [
		(import ./micro.nix { inherit config pkgs; })
	];

	services.cron = {
		enable = true;
	};

	environment.systemPackages = with pkgs; [
		discord
		slack
		google-chrome
		vlc
		ffmpeg
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
