script.on_init(function()
  ---@type table<unit_number, AurochData>
  storage.aurochs = {}
end)

require("control/remote") -- Loads remote interface for the ATL on built event
local aurochs_ai = require("control/auroch-ai")

script.on_event(defines.events.on_player_dropped_item, aurochs_ai.events.drop_event)
script.on_event(defines.events.on_ai_command_completed, aurochs_ai.events.ai_completed_event)
script.on_event(defines.events.on_built_entity, aurochs_ai.events.built_entity, {
  {filter = "name", name = "domesticated-auroch"},
})
script.on_event(defines.events.on_player_mined_entity, aurochs_ai.events.mined_entity, {
  {filter = "rolling-stock", mode = "and"},
  {filter = "name", name = "aurochs-locomotive-ATL", mode = "and"},
})
script.on_nth_tick(60, aurochs_ai.events.nth_tick)