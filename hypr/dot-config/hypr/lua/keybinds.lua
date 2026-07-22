return function()
  local vars = require("lua.vars")
  local hyper = "SUPER"

  hl.bind(hyper .. " + T", hl.dsp.exec_cmd(vars.terminal))
  hl.bind(hyper .. " + E", hl.dsp.exec_cmd(vars.fileManager))
  hl.bind(hyper .. " + F", hl.dsp.exec_cmd(vars.browser))
  hl.bind(hyper .. " + C", hl.dsp.window.close())
  hl.bind(hyper .. " + space", hl.dsp.global("caelestia:launcher"))
end
