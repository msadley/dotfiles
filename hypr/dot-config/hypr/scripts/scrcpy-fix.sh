#!/usr/bin/env bash

# Listen to Hyprland's IPC socket2 for window events
socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" STDOUT | while read -r line; do

  if [[ "$line" == "openwindow>>"* ]]; then
    # Extract the comma-separated data: address,workspace,class,title
    window_data="${line#openwindow>>}"
    IFS=',' read -r address workspace class title <<<"$window_data"

    # Target scrcpy application class
    if [[ "$class" == "scrcpy" ]]; then
      hex_address="0x$address"

      # Wait for opening animation and window geometry initialization
      sleep 0.25

      hyprctl eval "
        local addr = '$hex_address'
        local win
        for i = 1, 10 do
          win = hl.get_window('address:' .. addr)
          if win and win.size.x > 0 and win.size.y > 0 then break end
        end
        if win then
          -- Ensure scrcpy is floating
          if not win.floating then
            hl.dispatch(hl.dsp.window.float({ window = 'address:' .. addr }))
          end

          -- Calculate native aspect ratio of scrcpy stream
          local aspect = win.size.x / win.size.y
          local mon = win.monitor

          -- Calculate usable max height (accounting for scale, top/bottom reserved bars, and layout gaps)
          local top_res = (mon.reserved and mon.reserved.top) or 0
          local bot_res = (mon.reserved and mon.reserved.bottom) or 0
          local gaps_out = 8
          local max_usable_h = math.floor((mon.height / mon.scale) - top_res - bot_res - (gaps_out * 2))
          local target_w = math.floor(max_usable_h * aspect)

          -- Resize floating window to max usable height keeping aspect ratio
          hl.dispatch(hl.dsp.window.resize({ x = target_w, y = max_usable_h, window = 'address:' .. addr }))

          -- Set window as tiled (toggle float off)
          if win.floating then
            hl.dispatch(hl.dsp.window.float({ window = 'address:' .. addr }))
          end

          -- Get tiled layout height and calculate exact aspect-ratio tiled width
          win = hl.get_window('address:' .. addr)
          local tiled_h = win.size.y
          local tiled_w = math.floor(tiled_h * aspect)

          -- Resize true tiled layout container to match exact floating aspect ratio
          hl.dispatch(hl.dsp.window.resize({ x = tiled_w, y = tiled_h, window = 'address:' .. addr }))
        end
      "
    fi
  fi
done



