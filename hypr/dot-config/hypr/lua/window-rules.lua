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
end
