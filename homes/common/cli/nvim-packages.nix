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
    python311Packages.python-lsp-server
    go
    nodejs_21
    rustup
    alejandra
    gnumake
    lldb
    ripgrep
  ];
}
