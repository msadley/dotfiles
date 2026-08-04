return function()
	hl.config({
		general = {
			gaps_in = 5,
			gaps_out = 8,
			border_size = 0,
			resize_on_border = false,
			allow_tearing = false,
			layout = "dwindle",
		},

		decoration = {
			rounding = 20,
			rounding_power = 2,

			active_opacity = 1.0,
			inactive_opacity = 1.0,

			shadow = {
				enabled = true,
				range = 4,
				render_power = 3,
			},

			blur = {
				enabled = true,
				size = 3,
				passes = 1,
				vibrancy = 0.1696,
			},
		},
	})

	hl.config({
		dwindle = {
			preserve_split = true,
		},
	})

	hl.config({
		master = {
			new_status = "master",
		},
	})

	hl.config({
		scrolling = {
			fullscreen_on_one_column = true,
		},
	})

	hl.config({
		misc = {
			force_default_wallpaper = 0,
			disable_hyprland_logo = true,
		},
	})
end
