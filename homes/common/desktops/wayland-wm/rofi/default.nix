{pkgs, ...}: {
  home.packages = with pkgs; [rofi-wayland];
  home.file.".config/rofi/config.rasi".source = ./config.rasi;
  home.file.".local/share/rofi/themes/tokyonight.rasi".source =
    ./tokyonight.rasi;
}
