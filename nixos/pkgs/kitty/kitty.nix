{ pkgs }:
{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.85";
      font_family = "JetBrainsMono Nerd Font";
      
      # Layout settings
      enabled_layouts = "grid,tall:bias=50;full_size=1;mirrored=false,*";
      
      # Tab bar settings
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      
      # Window settings
      window_margin_width = 0;
      window_padding_width = 0;
      single_window_margin_width = 0;
      draw_minimal_borders = "yes";
      window_border_width = "0.5pt";
    };
  };

  home.file.".config/kitty/dev".text = ''
    new_tab dev
    cd ~/Projects/dev-environment/

    # Large terminal on the left
    launch --location=hsplit

    # Two smaller terminals on the right (stacked)
    launch --location=hsplit
    launch --location=vsplit

    # Create the "general" tab with one full-screen terminal
    new_tab general
    cd ~
    launch
  '';
}
