#!/bin/sh

userresources="$HOME/.Xresources"
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
[[ -f $sysresources ]] && xrdb -merge $sysresources
[[ -f $sysmodmap ]] && xmodmap $sysmodmap
[[ -f "$userresources" ]] && xrdb -merge "$userresources"

# source profile
source ~/.xprofile

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#setxkbmap -option terminate:ctrl_alt_bksp

exec bspwm
