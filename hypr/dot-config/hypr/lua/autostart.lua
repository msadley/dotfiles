return function()
	hl.on("hyprland.start", function()
		hl.exec_cmd("caelestia shell -d")
		hl.exec_cmd("mpris-proxy")
		hl.exec_cmd("wl-paste --type text --watch cliphist store")
		hl.exec_cmd("wl-paste --type image --watch cliphist store")
		hl.exec_cmd("whatsie")
	end)
end
