#!/usr/bin/env bash

# The portal passes 5 arguments:
# $1: Multiple files allowed (1 or 0)
# $2: Directory selection mode (1 or 0)
# $3: Save mode (1 or 0)
# $4: Starting path requested by the app
# $5: Output path where the portal expects the result

path="$4"
out="$5"

kitty --class yazi-picker -e yazi --chooser-file="$out" "$path"
