{
  pkgs,
  inputs,
  ...
}: let
  home = ../../homes;
in {
  imports = ["${home}/common" "${home}/common/virt-dconf.nix"];

  home.username = "logan";
  home.homeDirectory = "/home/logan";
  nixpkgs = {
    overlays = [
      inputs.neovim-nightly-overlay.overlay
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    flatpak
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  programs.git = {
    enable = true;
    userEmail = "logancroberts@outlook.com";
    userName = "Logan Roberts";
  };

  home.file = {
    "Scripts" = {
      recursive = true;
      source = "${home}/Scripts";
    };
    ".config/fcitx5" = {
      force = true;
      recursive = true;
      source = "${home}/configs/fcitx5";
    };
    ".local/share/fcitx5/themes" = {
      force = true;
      recursive = true;
      source = "${home}/configs/fcitx5-themes";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
