#
# ~/.bashrc
#

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='\033[33m[\u@\h \W]\$\033[0m '
export PS1="\[\033[38;5;3m\][\u@\h \W]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

shopt -s expand_aliases

alias e='emacsclient -nc'
alias dotfiles='/usr/bin/git --git-dir=/home/jmilik/.dotfiles/.git --work-tree=/home/jmilik/.dotfiles/'
