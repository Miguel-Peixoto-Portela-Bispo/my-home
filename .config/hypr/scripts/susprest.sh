#bin/sh

$RESTSCREEN=$HOME/.config/hypr/scripts/restscreen.sh

killall swayidle && swayidle -w timeout 5 'susp' resume "$RESTSCREEN"
