{ pkgs, ... }:

{
  home.packages = with pkgs; [ btop git direnv starship fish ];

  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "tokyo-night";
        vim_keys = true;
      };
    };
    git = {
      enable = true;
      userEmail = "logancroberts@outlook.com";
      userName = "Logan Roberts";
    };
    direnv = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        format = ''
          $all
          ''${custom.date}$os$shell$character'';
        palette = "tokyonight";
        palettes.tokyonight = {
          green = "#73daca";
          red = "#f7768e";
          black = "#414868";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#c0caf5";
        };
        username = {
          show_always = true;
          format = "[$user@]($style)";
          style_user = "magenta";
        };
        hostname = {
          ssh_only = false;
          style = "magenta";
        };
        directory = {
          truncation_length = 8;
          truncation_symbol = ".../";
          style = "cyan";
        };
        shell = {
          disabled = false;
          fish_indicator = "[󰈺](green)"; # Use nerd font symbols
          bash_indicator = "[](green)";
          zsh_indicator = "[󰞷](green)";
        };
        os.disabled = false;
        line_break.disabled = true;
        character.error_symbol = "[✗](bold red) ";
        fill.symbol = " ";
        custom.date = {
          command = "date +%a' '%b' '%d' '%H:%M:%S";
          when = true;
          style = "magenta";
        };
      };
    };
  };

  home.file = {
    ".config/fish" = {
      recursive = true;
      source = ./configs/fish;
    };
  };
}
