{ config, pkgs, ...}:

{
  services.tlp = {
    enable = true;

    settings = {
      # Common settings
      START_CHARGE_THRESH_BAT0 = 20;
      STOP_CHARGE_THRESH_BAT0 = 100;

      # CPU scaling governor
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      #Disk I/O scheduler
      DISK_IOSCHED_ON_AC = "cfq";
      DISK_IOSCHED_ON_BAT = "deadline";

      # Wi-Fi power saving
      WIFI_PWR_ON_AC = "on";
      WIFI_PWR_ON_BAT = "on";

      # USB autosuspend
      USB_AUTOSUSPEND_ON_AC = 0;
      USB_AUTOSUSPEND_ON_BAT = 1;
    };
  };
}
