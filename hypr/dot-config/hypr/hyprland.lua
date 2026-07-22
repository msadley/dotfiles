-- Executing the setup functions
require("lua.input")()
require("lua.keybinds")()
require("lua.monitor")()
require("lua.styling")()
require("lua.gestures")()

-- Running autostart commands
require("lua.autostart")()
