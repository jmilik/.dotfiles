#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR='emacsclient -nc'
export VISUAL='emacsclient -nc'

alias su='su -l'
alias e='emacsclient -nc'
alias dotfiles='/usr/bin/git --git-dir=/home/joseph/.dotfiles/ --work-tree=/home/joseph'
