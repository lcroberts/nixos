{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    luajit
    gcc
    python3
    go
    nodePackages.npm
    rustup
    alejandra
    gnumake
    lldb
    ripgrep
  ];
}
