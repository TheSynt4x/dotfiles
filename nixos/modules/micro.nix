{ config, pkgs, ...}:

{
	environment.systemPackages = with pkgs; [
        micro
		(pkgs.runCommand "vi" { } ''
            mkdir -p $out/bin
            ln -s ${pkgs.micro}/bin/micro $out/bin/vi
        '')
        (pkgs.runCommand "nano" { } ''
        mkdir -p $out/bin
        ln -s ${pkgs.micro}/bin/micro $out/bin/nano
        '')
        (pkgs.runCommand "editor" { } ''
        mkdir -p $out/bin
        ln -s ${pkgs.micro}/bin/micro $out/bin/editor
        '')
	];

	users.users.root = {
		shell = pkgs.zsh;
	};

	environment.etc = {
		"alternatives/nano".source = "${pkgs.micro}/bin/micro";
		"alternatives/vi".source = "${pkgs.micro}/bin/micro";
	};

	environment.variables = {
		EDITOR = "micro";
		VISUAL = "micro";
		GIT_EDITOR = "micro";
	};

	environment.shellAliases = {
  		nano = "micro";
  		vi = "micro";
  		vim = "micro";
	};

	security.sudo.extraConfig = ''
		Defaults        env_keep += "EDITOR VISUAL"
	'';	
}
