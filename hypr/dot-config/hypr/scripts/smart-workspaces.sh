#!/usr/bin/env bash

TARGET_WS=$1
APP_CLASS=$2
LAUNCH_CMD=$3

hyprctl dispatch workspace "$TARGET_WS"

if ! hyprctl clients -j | jq -e ".[] | select(.class == \"$APP_CLASS\" and .workspace.id == $TARGET_WS)" >/dev/null; then
  hyprctl dispatch exec "$LAUNCH_CMD"
fi
