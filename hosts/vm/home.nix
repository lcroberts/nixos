{ pkgs, ... }:

let home = ../../home;
in {
  imports =
    [ "${home}/cli" "${home}/desktops/hyprland" "${home}/applications/kitty" ];

  home.username = "logan";
  home.homeDirectory = "/home/logan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs;
    [
      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
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
