{pkgs, ...}: {
  home.packages = with pkgs; [fish autojump fzf eza bat pigz];

  home.file = {
    ".config/fish" = {
      recursive = true;
      source = ./config;
    };
  };
}
