#!/bin/bash
kanshi 2>&1 &

# steam 2>&1 &
# discord 2>&1 &
# flatpak run com.discordapp.Discord 2>&1 &
# spotify 2>&1 &
# flatpak run com.spotify.Client 2>&1 &
# flatpak run org.mozilla.firefox 2>&1 &
firefox 2>&1 &
# flatpak run org.keepassxc.KeePassXC 2>&1 &
keepassxc 2>&1 &
kitty tmux new-session -As main 2>&1 &

sleep 2
swaymsg reload

sleep 10
# ~/Applications/OneDriveGUI-1.0.2-x86_64_1b84c900adc54250fd543f66395bd957.AppImage 2>&1 &
onedrivegui 2>&1 &
