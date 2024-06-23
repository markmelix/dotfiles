#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

if [ "$(tty)" = "/dev/tty1" -a -z "$(printenv HYPRLAND_INSTANCE_SIGNATURE)" ]; then
	exec ~/.local/bin/wlinitrc
fi
