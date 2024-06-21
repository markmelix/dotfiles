#!/bin/bash

# This script will randomly go through the files of a directory, setting it
# up as the wallpaper at regular intervals
#
# NOTE: this script is in bash (not posix shell), because the RANDOM variable
# we use is not defined in posix

if [[ $# -lt 1 ]] || [[ -z "$1"   ]]; then
	echo "Usage:
	$0 <switch interval in seconds>"
	exit 1
fi

# Edit below to control the images transition
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION=fade

DIR=~/pics/wallpapers/$(cat ~/pics/wallpapers/chosen_pack)

# This controls (in seconds) when to switch to the next image
INTERVAL=$1

while true; do
	find "$DIR" -type f -o -type l \
		| while read -r img; do
			echo "$((RANDOM % 1000)):$img"
		done \
		| sort -n | cut -d':' -f2- \
		| while read -r img; do
			swww img "$img"
			sleep $INTERVAL
		done
done
