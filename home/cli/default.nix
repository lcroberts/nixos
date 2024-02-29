{ pkgs, ... }:

{
  imports = [ ./tmux.nix ./starship.nix ];
  home.packages = with pkgs; [
    btop
    direnv
    fish
    autojump
    fzf
    eza
    p7zip
    tldr
    bat
  ];

  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "tokyo-night";
        vim_keys = true;
      };
    };
    direnv = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };

  home.file = {
    ".config/fish" = {
      recursive = true;
      source = ../configs/fish;
    };
  };
}
