#!/bin/bash

TARGET_APP="Orion"

WINDOW_ID=$(yabai -m query --windows | jq ".[] | select(.app == \"$TARGET_APP\") | .id" | head -n 1)

if [ -n "$WINDOW_ID" ]; then
  yabai -m window --focus "$WINDOW_ID"
  osascript -e "tell application \"$TARGET_APP\" to activate"
else
  open -a "$TARGET_APP"
fi
