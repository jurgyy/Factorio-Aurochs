---@type data.Sound
local moo_sounds = {
  category = "environment",
  variations = {}
}
for i = 1,8 do
  table.insert(moo_sounds.variations --[[@as data.SoundDefinition.struct]], {
    filename = "__aurochs__/sounds/moo-" .. i .. ".wav",
    min_volume = 1,
    max_volume = 1.5,
    min_speed = 0.8,
    max_speed = 1.2
  })
end

return moo_sounds