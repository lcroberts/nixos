{pkgs, ...}: {
  home.packages = with pkgs; [
    wl-clipboard
    sway-contrib.grimshot
    playerctl
    brightnessctl
  ];

  imports = [./rofi ./waybar ./kanshi];
}
