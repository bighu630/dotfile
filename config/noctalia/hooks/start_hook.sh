#/bin/bash
if ! pgrep -x "mpd-mpris" > /dev/null; then
    mpd-mpris &
fi
