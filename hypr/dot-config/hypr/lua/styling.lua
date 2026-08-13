return function()
	hl.config({
		general = {
			gaps_in = 4,
			gaps_out = 8,
			border_size = 0,
			resize_on_border = false,
			allow_tearing = false,
			layout = "dwindle",
		},

		decoration = {
			rounding = 20,
			rounding_power = 3,

			active_opacity = 1.0,
			inactive_opacity = 1.0,

			shadow = { enabled = false },

			blur = {
				enabled = true,
				size = 3,
				passes = 1,
				vibrancy = 0.1696,
			},
		},

		dwindle = {
			preserve_split = false,
		},

		master = {
			new_status = "master",
		},

		scrolling = {
			fullscreen_on_one_column = true,
		},

		misc = {
			force_default_wallpaper = 0,
			disable_hyprland_logo = true,
		},
	})
end
