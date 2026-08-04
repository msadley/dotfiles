return function()
	hl.window_rule({
		match = {
			class = "com.pocoguy.Muse",
		},
		workspace = "special:music",
	})

	hl.window_rule({
		match = {
			class = "kitty",
		},
		opacity = 0.93,
	})

	hl.window_rule({
		match = {
			class = "yazi-picker",
		},
		float = true,
		center = true,
		size = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
		opacity = 0.8,
	})
end
