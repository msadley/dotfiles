#!/bin/bash

TARGET_APP="Ghostty"

# Query yabai for the first window ID matching the application name
WINDOW_ID=$(yabai -m query --windows | jq ".[] | select(.app == \"$TARGET_APP\") | .id" | head -n 1)

if [ -n "$WINDOW_ID" ]; then
  # 1. Tell yabai to target the specific window internally
  yabai -m window --focus "$WINDOW_ID"

  # 2. Force macOS to visually jump spaces to this application
  osascript -e "tell application \"$TARGET_APP\" to activate"
else
  # If it's not open, launch a new instance
  open -a "$TARGET_APP"
fi
