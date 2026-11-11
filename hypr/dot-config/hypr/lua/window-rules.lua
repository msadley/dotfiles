return function()
	hl.window_rule({
		fullscreen_state = "0 0",
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

	hl.window_rule({
		match = {
			class = "yazi-picker",
		},
		float = true,
		center = true,
		size = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
		opacity = 0.8,
	})

	hl.window_rule({
		match = {
			class = "Logseq",
		},
		workspace = "special silent",
		opacity = 0.95,
	})

	hl.window_rule({
		match = {
			class = "org.pulseaudio.pavucontrol",
		},
		float = true,
		center = true,
		size = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
	})

	hl.window_rule({
		match = {
			class = "scrcpy",
		},
		float = true,
	})

	hl.window_rule({
		match = {
			class = "org.quickshell",
		},
		float = true,
	})
end
