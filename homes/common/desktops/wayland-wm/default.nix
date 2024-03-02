{pkgs, ...}: {
  home.packages = with pkgs; [
    wl-clipboard
    sway-contrib.grimshot
    playerctl
    brightnessctl
    swayidle
    swaylock-effects
    swaybg
    xwaylandvideobridge
  ];

  imports = [./rofi ./waybar ./kanshi];
}
