#!/bin/bash
output_1_name=$(swaymsg -t get_outputs --raw | jq '.[0].name' -r)
output_2_name=$(swaymsg -t get_outputs --raw | jq '.[1].name' -r)
workspace_on_1=$(swaymsg -t get_outputs --raw | jq '.[0].current_workspace' -r)
workspace_on_2=$(swaymsg -t get_outputs --raw | jq '.[1].current_workspace' -r)
swaymsg workspace "$workspace_on_1"
swaymsg move workspace to output "$output_2_name"
swaymsg workspace "$workspace_on_2"
swaymsg move workspace to output "$output_1_name"
