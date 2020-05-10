#!/bin/bash

dmenu_run_file=$(ls "$HOME/.config/rofi/custom-launcher/" | rofi -dmenu)
[[ -z $dmenu_run_file ]] && exit
exec $(cat "$HOME/.config/rofi/custom-launcher/$dmenu_run_file")
