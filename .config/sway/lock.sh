#!/bin/bash

swayidle -w \
		timeout 15 'swaymsg "output * dpms off"' \
		resume 'swaymsg "output * dpms on"' &


swaylock --image ./pokemon-wallpaper2.png


pkill --newest swayidle
