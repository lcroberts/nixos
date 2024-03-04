{
  pkgs,
  lib,
  ...
}: {
  imports = [../wayland-wm];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mainMod" = "SUPER";
      "$altMod" = "ALT";
      exec = [
        "pkill waybar; waybar"
        "pkill swaybg; swaybg -i ~/Pictures/Wallpapers/currentbg"
      ];
      exec-once = [
        "/nix/store/$(ls -la /nix/store | grep polkit-kde-agent | grep '^d' | awk '{print $9}')/libexec/polkit-kde-authentication-agent-1 &"
        "nm-applet"
        "onedrivegui"
        "fcitx5"
      ];
      bind = [
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, T, togglesplit," # dwindle
        "$mainMod, F, fullscreen"
        # Move focus with mainMod + vim keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        # Switch workspaces with mainMod + [0-9]
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
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
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
        # Move window with vim keybinds
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, J, movewindow, d"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, L, movewindow, r"
        # Move workspace with vim keybinds
        "$mainMod Control, H, movecurrentworkspacetomonitor, l"
        "$mainMod Control, L, movecurrentworkspacetomonitor, r"
        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        # Group Keybinds
        "$mainMod $altMod, H, moveintogroup, l"
        "$mainMod $altMod, J, moveintogroup, j"
        "$mainMod $altMod, K, moveintogroup, u"
        "$mainMod $altMod, L, moveintogroup, r"
        "$mainMod $altMod, E, moveoutofgroup"
        "$mainMod $altMod, M, togglegroup"
        "$mainMod $altMod, N, changegroupactive, f"
        # Useful binds
        "$altMod, D, exec, rofi -no-lazy-grab -show drun"
        "$mainMod, Return, exec, kitty"
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod Control SHIFT, S, exec, systemctl suspend"
        "$mainMod Control SHIFT, M, exit"
        # Use pactl to adjust volume in PulseAudio.
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        # add media controls
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        # Reload Hyprland config
        "$mainMod SHIFT, C, exec, hyprctl reload"
        # Lock keybind
        "Control SHIFT, L, exec, ~/Scripts/lock.sh"
        # Copy area with grimshot
        "$altMod SHIFT, S, exec, grimshot copy area"
        # Swap workspaces on monitors
        "$mainMod SHIFT, S, swapactiveworkspaces, DP-1 DP-3"
        # Kanshi reloads
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
      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(7aa2f7ee) rgba(565f89ee) 45deg";
        "col.inactive_border" = "rgba(1a1b26aa)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      animations = {
        enabled = true;
        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {new_is_master = true;};
      gestures = {workspace_swipe = false;};
      windowrulev2 = [
        "workspace 1 silent, class:^(kitty)"
        "workspace 2 silent, class:^(firefox)"
        "workspace 2 silent, class:^(floorp)"
        "workspace 3 silent, class:^(discord)"
        "workspace 4 silent, class:^(Spotify|spotify)"
        "workspace 5 silent, class:.*(keepassxc|KeePassXC).*"
        "workspace 5 silent, title:.*(KeePassXC|keepassxc).*"
        "workspace 10 silent, class:^(Steam|steam)$"
        "workspace 10 silent, class:^(Steam|steam)., title:^(Steam|steam)$"
        "workspace 9, class:^(steam_app)"
        "workspace 9, class:^(gamescope)"
        "workspace 10 silent, class:^(lutris)$"
        "workspace 9, class:^(valheim)"
        "fullscreen, class:^(valheim)"
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "float, title:(OneDriveGUI)"
        "float, class:(xdg-desktop-portal-gtk)"
        "float, title:(Steam Settings)"
      ];
      misc = {vrr = true;};
    };
  };
}
