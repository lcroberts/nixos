#!/usr/bin/env bash

vidname=$(($(date +%s%N)/1000000)).mp4
mkdir -p $HOME/Videos/Shitposts
yt-dlp -o $HOME/Videos/Shitposts/$vidname --recode-video mp4 $1
