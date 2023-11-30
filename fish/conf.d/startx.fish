# If running from tty1 start xorg
if test -z "$DISPLAY" -a (tty) = /dev/tty1
    exec startx -- vt1 &>/dev/null
end
