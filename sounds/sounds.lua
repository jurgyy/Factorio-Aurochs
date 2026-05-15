local sounds = {}

---@class SoundParameters
---@field min_volume number?
---@field max_volume number?
---@field min_speed number?
---@field max_speed number?
---@field category data.SoundType?

---@param parameters SoundParameters?
---@return data.Sound
sounds.moo_sounds = function(parameters)
  local parameters = parameters or {}
  local min_volume = parameters.min_volume or 1
  local max_volume = parameters.max_volume or 1.5
  local min_speed = parameters.min_speed or 0.8
  local max_speed = parameters.max_speed or 1.2
  local category = parameters.category or "environment"

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
      min_speed = min_speed,
      max_speed = max_speed
    })
  end

  return moo_sounds
end

sounds.bell_sounds = function(parameters)
  local parameters = parameters or {}
  local min_volume = parameters.min_volume or 0.3
  local max_volume = parameters.max_volume or 0.5
  local min_speed = parameters.min_speed or 1
  local max_speed = parameters.max_speed or 1
  local category = parameters.category or "environment"

  ---@type data.Sound
  local bell_sounds = {
    category = category,
    variations = {}
  }
  for i = 1,7 do
    table.insert(bell_sounds.variations --[[@as data.SoundDefinition.struct]], {
      filename = "__aurochs__/sounds/cowbells-" .. i .. ".wav",
      min_volume = min_volume,
      max_volume = max_volume,
      min_speed = min_speed,
      max_speed = max_speed
    })
  end

  return bell_sounds
end

sounds.bush_sounds = function(parameters)
  local parameters = parameters or {}
  local min_volume = parameters.min_volume or 3
  local max_volume = parameters.max_volume or 4
  local min_speed = parameters.min_speed or 0.9
  local max_speed = parameters.max_speed or 1.1
  local category = parameters.category or "environment"

  ---@type data.Sound
  local bush_sounds = {
    category = category,
    variations = {}
  }
  for i = 1,6 do
    table.insert(bush_sounds.variations --[[@as data.SoundDefinition.struct]], {
      filename = "__aurochs__/sounds/bush-" .. i .. ".wav",
      min_volume = min_volume,
      max_volume = max_volume,
      min_speed = min_speed,
      max_speed = max_speed
    })
  end

  return bush_sounds
end

return sounds