#!/bin/sh

direction=$1
workspaceId="$(hyprctl activeworkspace -j | jq '.id')"
if [ "$direction" = "f" ] && [ $workspaceId -lt 10 ]; then
    hyprctl dispatch workspace +1
elif [ "$direction" = "b" ]; then
    hyprctl dispatch workspace -1
fi
