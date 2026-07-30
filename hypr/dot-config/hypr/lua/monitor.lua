return function()
	hl.monitor({
		output = "eDP-1",
		mode = "preferred",
		position = "auto",
		scale = "1.2",
	})

	hl.config({
		xwayland = {
			force_zero_scaling = true,
		},
	})

	hl.env("GDK_SCALE", "2")
end
