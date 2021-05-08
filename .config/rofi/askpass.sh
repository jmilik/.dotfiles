#!/bin/bash

# Based off https://github.com/davatorium/rofi/issues/584

rofi -dmenu -password -no-fixed-num-lines -p "$(printf "$1" | sed s/://)"
