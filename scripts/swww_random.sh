#!/bin/bash

export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION=fade

DIR=~/pics/wallpapers/$(cat ~/pics/wallpapers/chosen_pack)

find "$DIR" -type f -o -type l \
	| while read -r img; do
		echo "$((RANDOM % 1000)):$img"
	done \
	| sort -n | cut -d':' -f2- \
	| while read -r img; do
		swww img "$img"
		exit
	done
