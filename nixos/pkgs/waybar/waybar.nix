{ pkgs }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        mod = "dock";
        exclusive = true;
        "gtk-layer-shell" = true;
        "margin-top" = -1;
        passthrough = false;
        height = 41;
        "modules-left" = ["hyprland/workspaces"];
        "modules-center" = ["hyprland/window"];
        "modules-right" = [
          "cpu"
          "memory"
          "network"
          "battery"
          "pulseaudio/slider"
          "hyprland/language"
          "clock"
        ];

        "hyprland/window" = {
          "max-length" = 40;
          rewrite = {
            "" = "Babaji";
          };
          "separate-outputs" = true;
        };

        "hyprland/workspaces" = {
          "icon-size" = 32;
          spacing = 16;
          "on-scroll-up" = "hyprctl dispatch workspace r+1";
          "on-scroll-down" = "hyprctl dispatch workspace r-1";
          "persistent-workspaces" = {};
        };

        cpu = {
          interval = 5;
          format = "<span rise='1500'> {usage}%</span>";
          "max-length" = 10;
        };

        memory = {
          interval = 10;
          format = "{used:0.1f}GiB";
          "max-length" = 10;
          tooltip = true;
          "tooltip-format" = "RAM - {used:0.1f}GiB used";
        };

        network = {
          "format-wifi" = "<span rise='1500'>{icon}</span>";
          "format-ethernet" = "<span rise='1500'>  </span>";
          "format-disconnected" = "<span rise='1500'>󰌙</span>";
          "format-icons" = ["󰤯 " "󰤟 " "󰤢 " "󰤢 " "󰤨 "];
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "<span rise='1500'>{icon} {capacity}%</span>";
          "format-charging" = "<span rise='1500'> {capacity}%</span>";
          "format-plugged" = "<span rise='1500'> {capacity}%</span>";
          "format-alt" = "<span rise='1500'>{time} {icon}</span>";
          "format-icons" = [
            "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"
          ];
        };

        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
          "on-right-click" = "pavucontrol";
        };

        "hyprland/language" = {
          format = "{}";
          "format-en" = "en";
          "format-sv" = "sv";
        };

        clock = {
          format = "<span rise='1500'>{:%R | %d.%m.%Y}</span>";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "on-click-right" = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
      }
      {
        layer = "bottom";
        position = "bottom";
        mod = "dock";
        exclusive = true;
        "gtk-layer-shell" = true;
        "margin-bottom" = -1;
        passthrough = false;
        height = 41;
        "modules-left" = [];
        "modules-center" = ["wlr/taskbar"];
        "modules-right" = [];
        "wlr/taskbar" = {
          format = "{icon} {title:.17}";
          "icon-size" = 28;
          spacing = 3;
          "on-click-middle" = "close";
          "tooltip-format" = "{title}";
          "ignore-list" = [];
          "on-click" = "activate";
          "sort-by-app-id" = true;
        };
      }
    ];

    style = ''
      ${builtins.readFile ./style.css}
    '';
  };
}
