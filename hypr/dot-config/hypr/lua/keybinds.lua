return function()
	local vars = require("lua.vars")
	local hyper = "SUPER"
	local hyperMod = "SUPER + ALT"
	local hyperModAlt = "SUPER + ALT + SHIFT"

	-- general tools
	hl.bind(hyper .. " + T", hl.dsp.exec_cmd(vars.terminal))
	hl.bind(hyper .. " + E", hl.dsp.exec_cmd(vars.fileManager))
	hl.bind(hyper .. " + F", hl.dsp.exec_cmd(vars.browser))
	hl.bind(hyper .. " + C", hl.dsp.window.close())
	hl.bind(hyper .. " + space", hl.dsp.global("caelestia:launcher"))
	hl.bind(hyper .. " + L", hl.dsp.global("caelestia:lock"))
	hl.bind(hyperModAlt .. " + H", hl.dsp.exec_cmd("systemctl hibernate"))
	hl.bind(hyper .. " + P", hl.dsp.global("caelestia:screenshot"))
	hl.bind(hyper .. " + comma", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"))
	hl.bind(hyper .. " + period", hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p"))

	-- workspace control
	hl.bind(hyper .. " + 0", hl.dsp.focus({ workspace = tostring(10) }))
	hl.bind(hyperMod .. " + 0", hl.dsp.window.move({ workspace = (tostring(10)) }))

	for i = 1, 9 do
		hl.bind(hyper .. " + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
		hl.bind(
			hyperMod .. " + " .. i,
			hl.dsp.window.move({
				workspace = tostring(i),
			})
		)
	end

	hl.bind(
		hyper .. " + left",
		hl.dsp.focus({
			workspace = "-1",
		})
	)

	hl.bind(
		hyper .. " + right",
		hl.dsp.focus({
			workspace = "+1",
		})
	)

	hl.bind(
		hyperMod .. " + left",
		hl.dsp.window.move({
			workspace = "-1",
		})
	)

	hl.bind(
		hyperMod .. " + right",
		hl.dsp.window.move({
			workspace = "+1",
		})
	)

	hl.bind(
		hyper .. " + tab",
		hl.dsp.focus({
			workspace = "previous",
		})
	)

	-- window control
	hl.bind(hyperMod .. " + f", hl.dsp.window.float())
	hl.bind(hyperMod .. " + m", hl.dsp.window.drag())
	hl.bind(hyperMod .. " + r", hl.dsp.window.resize())
	hl.bind(hyperMod .. " + p", hl.dsp.window.pin())

	hl.bind(
		hyperMod .. " + Return",
		hl.dsp.window.fullscreen({
			mode = "fullscreen",
			action = "toggle",
		})
	)

	hl.bind(
		hyperMod .. " + z",
		hl.dsp.window.fullscreen({
			mode = "maximized",
			action = "toggle",
		})
	)

	-- medial control
	hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
	hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
	hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
	hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

	-- backlight control
	hl.bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"))
	hl.bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"))
end
