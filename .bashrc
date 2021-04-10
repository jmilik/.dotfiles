#
# ~/.bashrc
#

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\033[33m[\u@\h \W]\$\033[39;49m '

shopt -s expand_aliases

alias e='emacsclient -nc'
