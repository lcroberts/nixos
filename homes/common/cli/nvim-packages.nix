{pkgs, ...}: {
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

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
