---@type data.Sound
local bell_sounds = {
  category = "environment",
  variations = {}
}
for i = 1,7 do
  table.insert(bell_sounds.variations --[[@as data.SoundDefinition.struct]], {
    filename = "__aurochs__/sounds/cowbells-" .. i .. ".wav",
    min_volume = 0.3,
    max_volume = 0.5,
    min_speed = 1,
    max_speed = 1
  })
end

return bell_sounds