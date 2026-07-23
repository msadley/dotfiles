return function()
  local vars = require("lua.vars")
  local hyper = "SUPER"

  hl.bind(hyper .. " + T", hl.dsp.exec_cmd(vars.terminal))
  hl.bind(hyper .. " + E", hl.dsp.exec_cmd(vars.fileManager))
  hl.bind(hyper .. " + F", hl.dsp.exec_cmd(vars.browser))
  hl.bind(hyper .. " + C", hl.dsp.window.close())
  hl.bind(hyper .. " + space", hl.dsp.global("caelestia:launcher"))

  hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
  hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
  hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

  hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
  hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
  hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

  hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl --class=backlight s 5000+"), { locked = true })
  hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl --class=backlight s 5000-"), { locked = true })
end
