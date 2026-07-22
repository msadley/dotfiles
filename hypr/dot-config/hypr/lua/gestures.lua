return function()
  hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
  })

  hl.gesture({
    fingers = 3,
    direction = "up",
    action = "special",
    workspace_name = "special"
  })

  hl.gesture({
    fingers = 3,
    direction = "down",
    action = "special",
    workspace_name = "music"
  })

  hl.gesture({
    fingers = 4,
    direction = "down",
    action = "special",
    workspace_name = "communication"
  })
  hl.gesture({
    fingers = 4,
    direction = "up",
    action = "special",
    workspace_name = "todo"
  })
end
