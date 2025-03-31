{
  config,
  pkgs,
  lib,
  userConfig,
  ...
}:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  # Additional packages you might need
  environment.systemPackages = with pkgs; [
    grimblast # For screenshots
    wofi # Application launcher
    waybar # Status bar
    swaybg # Wallpaper
    kitty # Terminal
    nautilus # File manager
    bibata-cursors
    swaylock
    xdg-desktop-portal-hyprland # Ensure proper integration with applications
    mako
    wl-clipboard
    micro
    pavucontrol
  ];
  
  services.tlp = {
    enable = true;

    settings = {
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

  services.xserver.excludePackages = [ pkgs.xterm ];

  programs.hyprland.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # to use vscode under wayland

  users.users.${userConfig.username}.isNormalUser = true;
  home-manager.users.${userConfig.username} =
    { pkgs, ... }:
    {
      home.stateVersion = "24.11";
      home.sessionVariables.NIXOS_OZONE_WL = "1"; # ???

      # hyperland conf
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          # Environment variables
          env = [
            "XCURSOR_SIZE,32"
            "HYPRCURSOR_SIZE,32"
            "XCURSOR_THEME,Bibata-Modern-Classic"
          ];

          # Monitor configuration
          monitor = [
            ",highres,auto,auto"
          ];

          # Autostart
          exec-once = [
            "waybar"
            "swaybg -i ~/bg.jpg -m fill"
          ];

          # Input settings
          input = {
            kb_layout = "us,se";
            kb_variant = "";
            kb_model = "";
            kb_options = "grp:alt_shift_toggle";
            kb_rules = "";
            follow_mouse = 1;
            touchpad.natural_scroll = false;
            sensitivity = 0; # -1.0 - 1.0, 0 means no modification
          };

          # General appearance
          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            "col.active_border" = "rgba(ffffffee)";
            "col.inactive_border" = "rgba(000000ee)";
            layout = "master";
            resize_on_border = false;
            allow_tearing = false;
          };

          # Decoration (window styling)
          decoration = {
            rounding = 5;
            active_opacity = 1.0;
            inactive_opacity = 1.0;

            shadow = {
              enabled = false;
              range = 4;
              render_power = 3;
              color = "rgba(1a1a1aee)";
            };

            blur = {
              enabled = true;
              size = 3;
              passes = 1;
              vibrancy = 0.1696;
            };
          };

          # Animations
          animations = {
            enabled = true;
            bezier = [
              "easeOutQuint,0.23,1,0.32,1"
              "easeInOutCubic,0.65,0.05,0.36,1"
              "linear,0,0,1,1"
              "almostLinear,0.5,0.5,0.75,1.0"
              "quick,0.15,0,0.1,1"
            ];
            animation = [
              "global, 1, 10, default"
              "border, 1, 5.39, easeOutQuint"
              "windows, 1, 4.79, easeOutQuint"
              "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
              "windowsOut, 1, 1.49, linear, popin 87%"
              "fadeIn, 1, 1.73, almostLinear"
              "fadeOut, 1, 1.46, almostLinear"
              "fade, 1, 3.03, quick"
              "layers, 1, 3.81, easeOutQuint"
              "layersIn, 1, 4, easeOutQuint, fade"
              "layersOut, 1, 1.5, linear, fade"
              "fadeLayersIn, 1, 1.79, almostLinear"
              "fadeLayersOut, 1, 1.39, almostLinear"
              "workspaces, 1, 1.94, almostLinear, fade"
              "workspacesIn, 1, 1.21, almostLinear, fade"
              "workspacesOut, 1, 1.94, almostLinear, fade"
            ];
          };

          # Dwindle layout
          dwindle = {
            pseudotile = true; # Master switch for pseudotiling
            preserve_split = true;
          };

          # Master layout
          master = {
            new_status = "master";
            mfact = 0.5;
          };

          # Misc settings
          misc = {
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
          };

          # Gestures
          gestures = {
            workspace_swipe = true;
          };

          # Keybindings
          "$mainMod" = "ALT";
          bind =
            [
              "$mainMod, T, exec, kitty"
              "$mainMod, C, killactive"
              # "$mainMod, M, exit"
              "$mainMod, E, exec, nautilus"
              "$mainMod, V, togglefloating"
              "$mainMod, R, exec, wofi --show drun"
              ", Print, exec, grimblast copy area"

              # Window navigation
              "$mainMod, H, movefocus, l"
              "$mainMod, L, movefocus, r"
              "$mainMod, K, movefocus, u"
              "$mainMod, J, movefocus, d"

              "SUPER, L, exec, swaylock -i ~/bg.jpg"

              "$mainMod, S, togglespecialworkspace, slack"
              "$mainMod, D, togglespecialworkspace, dev"

              "$mainMod, B, exec, ~/toggle_waybar.sh"

              # Media keys
              ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
              ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
              ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

              # Additional media controls
              ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
              ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
              ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
              ", XF86AudioNext, exec, playerctl next"
              ", XF86AudioPause, exec, playerctl play-pause"
              ", XF86AudioPlay, exec, playerctl play-pause"
              ", XF86AudioPrev, exec, playerctl previous"

              ", XF86Display, exec, ~/autodisplay.sh"

              # Workspace navigation with mouse
              "$mainMod, mouse_down, workspace, e+1"
              "$mainMod, mouse_up, workspace, e-1"
            ]
            ++ (
              # Generate workspace keybindings dynamically
              builtins.concatLists (
                builtins.genList (
                  x:
                  let
                    ws = toString (x + 1);
                  in
                  [
                    "$mainMod, ${ws}, workspace, ${ws}"
                    "CTRL $mainMod, ${ws}, movetoworkspace, ${ws}"
                  ]
                ) 9
              )
            );

          # Window rules
          windowrulev2 = [
            "suppressevent maximize, class:.*"
            "suppressevent fullscreen, class:.*"
            "tile,class:.*"
            "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
          ];

          exec = [
            "~/autodisplay.sh"
          ];

          # Workspace rules
          workspace = [
            "1, on-created-empty:[tile] google-chrome-stable --profile-directory=\"Default\""
            "2, on-created-empty:[tile] google-chrome-stable --profile-directory=\"Profile 1\""
            "3, on-created-empty:[tile] dbeaver"
            "4, on-created-empty:[tile] cursor"
            "special:slack, on-created-empty:[floating] slack"
            "special:dev, on-created-empty:[tile] ~/dev.sh"
          ];
        };

        # Extra configuration
        extraConfig = ''
          # Any additional Hyprland config that's easier to write as plain text
          bindm = $mainMod, mouse:272, movewindow
          bindm = $mainMod, mouse:273, resizewindow
        '';
      };
    };
}
