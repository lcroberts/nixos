{pkgs, ...}: {
  home.packages = with pkgs; [waybar];

  home.file.".config/waybar" = {
    recursive = true;
    source = ./config;
  };
}
