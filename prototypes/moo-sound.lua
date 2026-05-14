---@param min_volume number? Defaults to 1
---@param max_volume number? Defaults to 1.5
---@param category string? Defaults to "environment"
---@return data.Sound
local function getMooSounds(min_volume, max_volume, category)
  if not min_volume then min_volume = 1 end
  if not max_volume then max_volume = 1.5 end
  if not category then category = "environment" end
  ---@type data.Sound
  local moo_sounds = {
    category = category,
    variations = {}
  }
  for i = 1,8 do
    table.insert(moo_sounds.variations --[[@as data.SoundDefinition.struct]], {
      filename = "__aurochs__/sounds/moo-" .. i .. ".wav",
      min_volume = min_volume,
      max_volume = max_volume,
      min_speed = 0.8,
      max_speed = 1.2
    })
  end

  return moo_sounds
end

return getMooSounds