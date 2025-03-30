{ pkgs }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock;
    settings = {
      ignore-empty-password = true;
      color = "3a4a42";
      indicator-idle-visible = true;
      indicator-radius = 150;
      indicator-thickness = 30;

      inside-color = "3a4a42";
      inside-clear-color = "3a4a42";
      inside-ver-color = "3a4a42";
      inside-wrong-color = "3a4a42";

      key-hl-color = "aaaaaa";
      bs-hl-color = "d54e53aa";

      separator-color = "55555555";

      line-color = "3a4a42";
      line-uses-ring = true;

      text-color = "ffffff";
      text-clear-color = "b5bd68";
      text-caps-lock-color = "f0c674";
      text-ver-color = "ffffff";
      text-wrong-color = "cc6666";

      ring-color = "ffffff";
      ring-ver-color = "ffffff";
      ring-clear-color = "b5bd6811";
      ring-wrong-color = "cc6666";

      font = "JetBrainsMono Nerd Font";
    };
  };
}
