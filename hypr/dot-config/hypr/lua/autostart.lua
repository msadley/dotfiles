return function()
  hl.on("hyprland.start",
    function()
      hl.exec_cmd("caelestia shell -d")
      hl.exec_cmd("mpris-proxy")
    end
  )
end
