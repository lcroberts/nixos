{pkgs, ...}: {
  imports = [./tmux ./starship.nix ./btop.nix ./nvim-packages.nix ./fish];
  home.packages = with pkgs; [direnv p7zip tldr bat yt-dlp];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
