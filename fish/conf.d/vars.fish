# Global variables configuration

# XDG user directories
set -x XDG_DESKTOP_DIR "$HOME/.desktop"
set -x XDG_DOCUMENTS_DIR "$HOME/docs"
set -x XDG_DOWNLOAD_DIR "$HOME/downloads"
set -x XDG_MUSIC_DIR "$HOME/music"
set -x XDG_PICTURES_DIR "$HOME/pics"
set -x XDG_PUBLICSHARE_DIR "$HOME/pub"
set -x XDG_TEMPLATES_DIR "$HOME/.templates"
set -x XDG_VIDEOS_DIR "$HOME/videos"

# VISUAL ontains command to run the full-fledged editor that is used for more
# demanding tasks
if systemctl --user is-active --quiet emacs
    set -x VISUAL "emacsclient -c"
else if test -f /usr/bin/nvim
    set -x VISUAL nvim
else if test -f /usr/bin/vim
    set -x VISUAL vim
else if test -f /usr/bin/vi
    set -x VISUAL vi
end

# EDITOR contains the command to run the lightweight program used for editing
# files
if systemctl --user is-active --quiet emacs
    set -x EDITOR "emacsclient --tty"
else if test -f /usr/bin/nvim
    set -x EDITOR nvim
else if test -f /usr/bin/vim
    set -x EDITOR vim
else if test -f /usr/bin/vi
    set -x EDITOR vi
end

# TERM contains default terminal emulator program
set -x TERM alacritty
set -x TERMINAL $TERM

# BROWSER contains the path to the web browser
set browser chromium
if test -f /usr/bin/$browser
    set -x BROWSER $browser
end

# PAGER contains command to run the program used to list the contents of files
set -x PAGER less

# Override the driver for VA-API
# See https://wiki.archlinux.org/title/Hardware_video_acceleration#Configuring_VA-API
set -x LIBVA_DRIVER_NAME iHD
