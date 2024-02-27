#!/bin/bash

# image=~/Pictures/Wallpapers/currentbg
# swaylock -i $image

inside=1a1b26
text=c0caf5
wrong=F28B82
ring=bb9af7
line=292e42
keypress=c0caf5
swaylock --screenshots --clock --effect-blur 7x7 --indicator \
    --line-color $line --line-clear-color $line --line-ver-color $line \
    --inside-color $inside --inside-clear-color $inside --inside-ver-color $inside \
    --ring-color $ring --ring-clear-color $ring  --ring-ver-color $ring \
    --line-wrong-color $line --ring-wrong-color $wrong --inside-wrong-color $inside \
    --bs-hl-color $wrong --key-hl-color $keypress --separator-color $line \
    --text-color $text --text-clear-color $text --text-ver-color $text --text-wrong-color $wrong
