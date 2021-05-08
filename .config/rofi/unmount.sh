#!/bin/bash

mnt_location=$(find /mnt -mindepth 1 -maxdepth 1 -not -empty -type d | rofi -dmenu -p "unmount")
[[ -z $mnt_location ]] && exit
sudo -A umount "$mnt_location"
