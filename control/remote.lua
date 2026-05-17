local aurochs_ai = require("control/auroch-ai")

remote.add_interface("aurochs",
{
  ---@param event EventData.on_built_entity
  on_built_locomotive = function(event)
    aurochs_ai.events.built_entity(event)
  end
})