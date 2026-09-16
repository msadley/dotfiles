return function()
	hl.on("hyprland.start", function()
		-- Start and lock caelestia on startup
		hl.exec_cmd("caelestia shell -d")
		hl.exec_cmd("sleep 1 && caelestia shell lock lock")

		-- System utils
		hl.exec_cmd("mpris-proxy")
		hl.exec_cmd("wl-paste --type text --watch cliphist store")
		hl.exec_cmd("wl-paste --type image --watch cliphist store")
		hl.exec_cmd("kanshi")

		-- Tray apps
		hl.exec_cmd("sleep 3 && whatsie")
		hl.exec_cmd("sleep 3 && mattermost-desktop")

		-- Scripts
		hl.exec_cmd("/home/adley/.config/hypr/scripts/scrcpy-fix.sh")
	end)
end
