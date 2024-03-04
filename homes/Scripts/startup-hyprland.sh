#!/usr/bin/env bash

kitty tmux new -As main 2>&1 &
# firefox 2>&1 &
floorp 2>&1 &
keepassxc 2>&1 &

sleep 5

onedrivegui 2>&1 &
flatpak run com.protonvpn.www 2>&1 &

sleep 20

hyprctl keyword windowrule "workspace unset,kitty"
hyprctl keyword windowrule "workspace unset,firefox"
hyprctl keyword windowrule "workspace unset,floorp"
