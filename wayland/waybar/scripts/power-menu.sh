#!/bin/bash

entries="Suspend\n⭮ Reboot\n⏻ Shutdown"

selected=$(echo -e $entries | wofi --width 250 --height 210 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  suspend)
    systemctl suspend;;
  reboot)
    systemctl reboot;;
  shutdown)
    systemctl poweroff;;
esac 