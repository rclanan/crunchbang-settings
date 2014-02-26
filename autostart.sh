## Openbox autostart.sh
## ====================
## When you login to your CrunchBang Openbox session, this autostart script 
## will be executed to set-up your environment and launch any applications
## you want to run at startup.
##
## Note*: some programs, such as 'nm-applet' are run via XDG autostart.
## Run '/usr/lib/openbox/openbox-xdg-autostart --list' to list any
## XDG autostarted programs.
##
## More information about this can be found at:
## http://openbox.org/wiki/Help:Autostart
##
## If you do something cool with your autostart script and you think others
## could benefit from your hack, please consider sharing it at:
## http://crunchbang.org/forums/
##
## Have fun & happy CrunchBangin'! :)

## GNOME PolicyKit and Keyring
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &

## Set root window colour
hsetroot -solid "#2E3436" &

## Group start:
## 1. nitrogen - restores wallpaper
## 2. sleep - give compositor time to start
## 3. tint2 panel
(\
nitrogen --restore && \
sleep 2s && \
tint2 \
) &

## Volume control for systray
(sleep 2s && pnmixer) &

## Volume keys daemon
xfce4-volumed &

## Enable power management
xfce4-power-manager &

## Start Thunar Daemon
thunar --daemon &

## Detect and configure touchpad. See 'man synclient' for more info.
if egrep -iq 'touchpad' /proc/bus/input/devices; then
    synclient VertEdgeScroll=1 &
    synclient HorizEdgeScroll=1 &
    synclient VertTwoFingerScroll=1 &
    synclient HorizTwoFingerScroll=1 &
    synclient TapButton1=1 &
fi

## Start xscreensaver
xscreensaver -no-splash &

## Start Clipboard manager
(sleep 3s && clipit) &

## Set keyboard settings - 250 ms delay and 25 cps (characters per second) repeat rate.
## Adjust the values according to your preferances.
xset r rate 250 25 &

## Turn on/off system beep
xset b off &

# Display Settings
# --auto --off should assure that the laptop screen will be used if nothing else is found
VGA0=`xrandr -q | grep 'VGA-0' | awk '{ print $2 }'`
if [ $VGA0 = "connected" ];
then
  xrandr --output VGA-0 --mode 1920x1080 --primary --auto
  xrandr --output LVDS1 --off
else
  xrandr --output LVDS1 --mode 1920x1080 --auto --primary
fi

## GNOME PolicyKit and Keyring
(\
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 && \
/usr/bin/gnome-keyring-daemon --start --components=ssh && \
/usr/bin/gnome-keyring-daemon --start --components=secrets && \
/usr/bin/gnome-keyring-daemon --start --components=pkcs11 && \
/usr/bin/gnome-keyring-daemon --start --components=gpg \
) &

## Run the conky
conky -q &

# Autostart the Dropbox daemon
(sleep 60s && ~/.dropbox-dist/dropboxd) &

# Autostart Pidgin
(sleep 30s && pidgin) &

# Change to random Wallpaper
(sleep 2s && ~/.scripts/ch_wallpaper.sh)

# Compositor to the end. If this one's started in the group before, the icons in my taskbar
# have glitches
cb-compositor --start &

# Autostart the Dropbox deamon
(sleep 60s && ~/.dropbox-dist/dropboxd) &

## Autostart the update notifier (DIL)
update-notifier &

#Artha
(sleep 5s && artha) &

#Disable trackpad while typing
syndaemon -t -K -d -i 1
