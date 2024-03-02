{pkgs, ...}: {
  home.packages = with pkgs; [tmux];

  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      unbind C-b
      set -g prefix C-space
      bind C-space send-prefix

      # Fix terminal colors
      # set-option -sa terminal-overrides ",xterm*:Tc"
      set -sg terminal-overrides ",*:RGB"

      # Enable Mouse toggle
      set -g mouse on
      bind-key m set-option mouse \; display-message "mouse #{?mouse,on,off}"

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      bind-key -rn C-f run-shell "tmux neww tmux-sessionizer"
      bind-key -r i run-shell "tmux neww tmux-cht"
      bind-key -r h run-shell "tmux-sessionizer main"

      bind-key -rn M-Up resize-pane -U 3
      bind-key -rn M-Down resize-pane -D 3
      bind-key -rn M-Left resize-pane -L 3
      bind-key -rn M-Right resize-pane -R 3

      # Start numbering from 1
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Set vi-mode
      set-window-option -g mode-keys vi
      # Keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Enable Clear
      bind C-space send-keys 'C-l'

      # Change list-keys bind
      bind-key -r ? list-keys -aN

      # Open panes in current window
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # Undercurl
      # set -g default-terminal "''${TERM}"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0



      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'christoomey/vim-tmux-navigator'
      set -g @plugin "janoamaral/tokyo-night-tmux"
      # Set clipboard for tmux yank
      set -g set-clipboard on

    '';
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      tmuxPlugins.open
      tmuxPlugins.tmux-fzf
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-dir $XDG_DATA_HOME/tmux/resurrect
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-processes 'btop'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10'
        '';
      }
      {
        plugin = tmuxPlugins.mkTmuxPlugin {
          pluginName = "tokyo-night-tmux";
          version = "6189acc";
          rtpFilePath = "tokyo-night.tmux";
          src = pkgs.fetchFromGitHub {
            owner = "janoamaral";
            repo = "tokyo-night-tmux";
            rev = "6189acc8b3c76afd545b824494884684f57b714d";
            sha256 = "sha256-am3qcVJOt27gpu1UQ+o1jPnCX68kDzSHvER12Lh2cvY=";
          };
        };
      }
    ];
  };

  home.file = {
    ".config/tmux-cht-commands".source = ./tmux-cht-commands;
    ".config/tmux-cht-languages".source = ./tmux-cht-languages;
  };
}
