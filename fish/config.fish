fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.config/emacs/bin
fish_add_path ~/.emacs.d/bin
fish_add_path /usr/local/texlive/2024/bin/x86_64-linux
fish_add_path (yarn global bin)

function run_on_write
    set file $argv
    while inotifywait -qe close_write $file
        ./$file
    end
end

function e
    emacsclient --tty $argv
end

function dot
    cd ~/.dotfiles
    dotter $argv
    cd -
end

function restart_emacs
    emacsclient --eval "(kill-emacs)"
    emacs --daemon
    emacsclient --create-frame --no-wait --alternate-editor ''
end

function blank -d "Output empty screen to the terminal"
    set offset 2
    for i in (seq (math (tput lines) + $offset))
        echo
    end
end

set fish_greeting
set fish_prompt_pwd_dir_length 0

# Use emacs keybindings inside a shell
function fish_user_key_bindings
    fish_default_key_bindings
end

# Functions needed for bash style history substitution
# Note that they work only in default (emacs) keybinding mode
# See https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

bind ! __history_previous_command
bind '$' __history_previous_command_arguments

function du
    /usr/bin/du -h --max-depth=1 $argv 2>/dev/null | sort -h
end

# Change some of the ls colors
eval (dircolors -c ~/.dircolors)

eval (ssh-agent -c) >/dev/null

alias cls="clear"
alias q="exit"
alias free="free -ht"

alias ls="lsd --group-directories-first"
alias ll="ls -l"
alias la="ls -l -A"

alias maek="make"
alias meak="make"

alias i3cfg="e ~/.config/i3/config"
alias fishcfg="e ~/.config/fish/config.fish"

alias pkg="sudo pacman"
alias pkgi="pkg -S"
alias pkgs="pkg -Ss"
alias pkgu="pkg -Syu --noconfirm && ~/scripts/setupxinput"
alias pkgr="pkg -R"
alias pkgrf="pkg -Rcsn"

alias aur="paru"
alias auri="aur -S"
alias aurs="aur -Ss"
alias auru="pkgu && aur -Su --aur"
alias aurr="aur -R"
alias aurrf="aur -Rcsn"

alias gst="git status"

alias f="df -h /dev/mapper/system && echo && free -h"
alias xo="xdg-open"
alias cal="cal -m"
alias top="btop"
alias py="python"
alias taskmanager="QT_QPA_PLATFORM=xcb stacer"
alias zdate="date +\"%Y%m%d%H%M\""
alias drag="dragon-drop --on-top"
alias copy="xclip -sel clipboard"
alias dotfiles="cd $HOME/.dotfiles"
alias lt="exa -aT --color=always --group-directories-first --icons --git-ignore"

# restore cursor after plymouth
tput cvvis

set -x COMPOSE_BAKE true
set -x COMPOSE_PARALLEL_LIMIT 1
set -x VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT 1

# Starship is one of the most powerful prompts written in Rust
eval (starship init fish)
