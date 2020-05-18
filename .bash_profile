#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx -- -logverbose 6
fi

# opam configuration
test -r /home/joseph/.opam/opam-init/init.sh && . /home/joseph/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
