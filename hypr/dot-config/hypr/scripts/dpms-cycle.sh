#!/bin/sh

# These sleep can't be reduced or removed. For some crazy unknown reason,
# removing or reducing makes the cursor invisible

sleep 0.01
hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "off", output = "eDP-1" }))'
sleep 0.01
hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "on", output = "eDP-1" }))'
