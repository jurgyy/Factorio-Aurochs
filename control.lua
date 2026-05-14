script.on_init(function()
  ---@type table<unit_number, AurochData>
  storage.aurochs = {}
end)

local aurochs_ai = require("control.auroch-ai")

script.on_event(defines.events.on_player_dropped_item, aurochs_ai.events.drop_event)
script.on_event(defines.events.on_ai_command_completed, aurochs_ai.events.ai_completed_event)