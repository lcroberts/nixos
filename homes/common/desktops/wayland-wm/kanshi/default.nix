{ pkgs, ... }:

{
  home.packages = with pkgs; [ kanshi ];
  home.file.".config/kanshi" = {
    recursive = true;
    source = ./config;
  };
}
