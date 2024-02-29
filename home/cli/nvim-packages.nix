{ pkgs, ... }:

{
  home.packages = with pkgs; [
    luajit
    gcc
    python3
    go
    nodePackages.npm
    rustup
    nixfmt
    gnumake
    lldb
    ripgrep
  ];
}
