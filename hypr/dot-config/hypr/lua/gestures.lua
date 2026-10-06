return function()
	hl.gesture({
		fingers = 3,
		direction = "left",
		scale = 0.4,
		action = function()
			hl.dispatch(hl.dsp.focus({ workspace = "+1" }))
		end,
	})

	hl.gesture({
		fingers = 3,
		direction = "right",
		scale = 0.4,
		action = function()
			hl.dispatch(hl.dsp.focus({ workspace = "-1" }))
		end,
	})

	hl.gesture({
		fingers = 3,
		direction = "down",
		action = "special",
		workspace_name = "special",
	})
end
