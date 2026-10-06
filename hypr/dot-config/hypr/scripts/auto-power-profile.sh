#!/bin/bash

function update_profile() {
  if grep -q 0 /sys/class/power_supply/AC/online 2>/dev/null; then
    powerprofilesctl set power-saver
  else
    powerprofilesctl set balanced
  fi
}

update_profile

udevadm monitor --subsystem-match=power_supply | while read -r line; do
  if echo "$line" | grep -q "change"; then
    update_profile
  fi
done
