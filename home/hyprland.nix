{ pkgs, config, lib, inputs, ... }:

{
  programs.hyprland.enable = true;
  programs.hyprland.package =
    inputs.hyprland.packages."${pkgs.system}".hyprland;

  home.packages = with pkgs; [
    wl-clipboard
    waybar
    kanshi
    sway-contrib.grimshot
    kitty
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
    settings = {
      "$mainMod" = "SUPER";
      "$altMod" = "ALT";
      bind = [
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, T, togglesplit, # dwindle"
        "$mainMod, F, fullscreen"
        "# Move focus with mainMod + vim keys"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "# Switch workspaces with mainMod + [0-9]"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "# Move active window to a workspace with mainMod + SHIFT + [0-9]"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "# Move window with vim keybinds"
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, J, movewindow, d"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, L, movewindow, r"
        "# Move workspace with vim keybinds"
        "$mainMod Control, H, movecurrentworkspacetomonitor, l"
        "$mainMod Control, L, movecurrentworkspacetomonitor, r"
        "# Scroll through existing workspaces with mainMod + scroll"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "# Group Keybinds"
        "$mainMod $altMod, H, moveintogroup, l"
        "$mainMod $altMod, J, moveintogroup, j"
        "$mainMod $altMod, K, moveintogroup, u"
        "$mainMod $altMod, L, moveintogroup, r"
        "$mainMod $altMod, E, moveoutofgroup"
        "$mainMod $altMod, M, togglegroup"
        "$mainMod $altMod, N, changegroupactive, f"
        "# Useful binds"
        "$altMod, D, exec, rofi -no-lazy-grab -show drun"
        "$mainMod, Return, exec, kitty"
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod Control SHIFT, S, exec, systemctl suspend"
        "$mainMod Control SHIFT, M, exit"
        "# Use pactl to adjust volume in PulseAudio."
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        "# add media controls"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        "# Reload Hyprland config"
        "$mainMod SHIFT, C, exec, hyprctl reload"
        "# Lock keybind"
        "Control SHIFT, L, exec, ~/Scripts/lock.sh"
        "# Copy area with grimshot"
        "$altMod SHIFT, S, exec, grimshot copy area"
        "# Swap workspaces on monitors"
        "$mainMod SHIFT, S, swapactiveworkspaces, DP-1 DP-3"
        "# Kanshi reloads"
        "$mainMod SHIFT, M, exec, reset-monitor.sh"
        "$mainMod SHIFT, N, exec, setup-monitor.sh"
      ];
      binde = [
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
      ];
      bindr = [
        "$altMod Control, M, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      exec = [
        "pkill waybar; waybar"
        "pkill kanshi; kanshi"
        "pkill swaybg; swaybg -i ~/Pictures/Wallpapers/currentbg"
      ];
      exec-once = [
        "/nix/store/$(ls -la /nix/store | grep polkit-kde-agent | grep '^d' | awk '{print $9}')/libexec/polkit-kde-authentication-agent-1 &"
      ];
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.tokyonight-gtk-theme;
      name = "Tokyonight-Dark-BL";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}
