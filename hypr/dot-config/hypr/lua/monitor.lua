return function()
	hl.monitor({
		output = "eDP-1",
		mode = "1920x1200@60",
		position = "auto",
		scale = "1.2",
	})

	hl.monitor({
		output = "HDMI-A-1",
		mirror = "eDP-1",
	})

	hl.config({
		xwayland = {
			force_zero_scaling = true,
		},
	})

	hl.env("GDK_SCALE", "1")
end
