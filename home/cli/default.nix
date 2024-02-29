{ pkgs, ... }:

{
  imports = [ ./tmux.nix ./starship.nix ./btop.nix ];
  home.packages = with pkgs; [ direnv fish autojump fzf eza p7zip tldr bat ];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/fish" = {
      recursive = true;
      source = ../configs/fish;
    };
  };
}
