{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./cli ./desktops/hyprland ./applications];
}
