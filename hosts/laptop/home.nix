{
  pkgs,
  inputs,
  lib,
  ...
}: let
  home = ../../homes;
in {
  imports = ["${home}/common" "${home}/common/desktops/hyprland"];

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
    libsForQt5.qt5ct
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
    ".config/qt5ct" = {
      recursive = true;
      source = "${home}/configs/qt5ct";
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  wayland.windowManager.hyprland.extraConfig = ''
    monitor=eDP-1,3840x2160@60,0x0,2
    monitor=,preferred,auto,1,mirror,eDP-1
    input {
      kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =
        numlock_by_default = true

        follow_mouse = 1

        touchpad {
          natural_scroll = true
        }

      sensitivity = 0.5 # -1.0 - 1.0, 0 means no modification.
    }
  '';

  home.pointerCursor = {
    x11.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.tokyo-night-gtk;
      name = "Tokyonight-Dark-BL";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
