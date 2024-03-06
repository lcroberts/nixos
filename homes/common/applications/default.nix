{pkgs, ...}: {
  imports = [./kitty];
  home.packages = with pkgs; [
    stable.onedrive
    stable.onedrivegui
    obsidian
    anki-bin
    spotifywm
    vesktop # discord with vencord
    stable.floorp
    keepassxc
    evince
    kdePackages.filelight
    drawio
    mpv
  ];
}
