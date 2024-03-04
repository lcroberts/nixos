#!/usr/bin/env bash
shopt -s extglob

# A wrapper script to launch cheat engine within a certain steam wine prefix.
# To use it you need to provide an argument matching one of the values in the
# case statement. It will automatically launch it within the wine prefix.
# It is also possible to provide the steam app id as an argument as well.
# The ce_executable path may need to be changed depending on what version of CE
# you have intsalled. `protonhax init %command%` needs to be present in your
# steam launch options as well.
ce_executable="$HOME/.wine/drive_c/Program Files/Cheat Engine 7.5/cheatengine-x86_64.exe"

case $1 in
    ds3)
        app_id=374320
        ;;
    dsr)
        app_id=570940
        ;;
    remnant2)
        app_id=1282100
        ;;
    mhw)
        app_id=582010
        ;;
    +([0-9]) ) # Match any number which should be a steam app id
        app_id=$1
        ;;
    *)
        echo "Invalid argument. Please input one of the following programs, or input a valid steam app id:"
        echo "ds3 (Dark Souls III), dsr (Dark Souls Remastered), remnant2, mhw (Monster Hunter World)"
        exit
        ;;
esac

protonhax run $app_id "$ce_executable"
