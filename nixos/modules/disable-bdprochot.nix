{ config, pkgs, ...}:

{
  boot.kernelModules = [ "msr" ];
  systemd.services.disable-bdprochot = {
 	description = "Disable bd prochot";
	after = [ "multi-user.target" ];
	wantedBy = [ "multi-user.target" ];
	serviceConfig = {
		Type = "oneshot";
		ExecStart = [ "/run/current-system/sw/bin/wrmsr 0x1FC 2" ];
	};
  };
}
