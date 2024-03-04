#!/usr/bin/env bash
pkill kanshi
kanshi -c $HOME/.config/kanshi/games 2>&1 &
