local smoke_animations = require("__base__/prototypes/entity/smoke-animations")

local sounds = require("sounds/sounds")
local moo_sounds = sounds.moo_sounds()
local bell_sounds = sounds.bell_sounds()

local smoke = smoke_animations.trivial_smoke{
  name = "aurochs-locomotive-smoke",
  duration = 240,
  color = {r = 115, g = 89, b = 55, a = 200},
  render_layer = "lower-object",
  affected_by_wind = false,
  start_scale = 0.1,
  end_scale = 3,
}

---@type data.TriggerEffect
local tieTriggerSound = {
  {
    type = "play-sound",
    probability = 0.01,
    sound = moo_sounds
  },
  {
    type = "play-sound",
    sound = bell_sounds
  },
  {
    type = "create-trivial-smoke",
    smoke_name = smoke.name,
    repeat_count = 6,
    offset_deviation = {
      {-1.5, -2.5},
      {1.5, .5}
    }
  }
}

---@type data.LocomotivePrototype
local loco = {
  name = "aurochs-locomotive",
  type = "locomotive",
  alert_icon_shift = {0, -0.75},
  drawing_box_vertical_extension = 1,
  collision_box = {{-0.6, -1.2}, {0.6, 1.2}},
  selection_box = {{-1, -1.5}, {1, 1.5}},
  flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-repairable", "breaths-air"},
  icon = "__aurochs__/graphics/loco/BullDraftIcon.png",
  icon_size = 64,
  impact_category = "organic",
  minable = {mining_time = 0.5, result = "aurochs-locomotive"},
  mined_sound = {
    switch_vibration_data = {
      filename = "__core__/sound/deconstruct-medium.bnvib",
      gain = 0.25
    },
    variations = {{
      filename = "__core__/sound/deconstruct-medium.ogg",
      volume = 0.8
    }}
  },
  working_sound = {
    activate_sound = moo_sounds,
    deactivate_sound = moo_sounds,
    sound = moo_sounds,
    probability = 0
  },
  corpse = nil, --TODO
  max_health = 400,
  braking_power = "20W", -- TODO tweak?
  ---@diagnostic disable-next-line: assign-type-mismatch
  braking_force = nil, -- TODO tweak?
  energy_per_hit_point = 5,
  friction = 0.5, -- TODO tweak?
  ---@diagnostic disable-next-line: assign-type-mismatch
  friction_force = nil, -- TODO tweak?
  weight = 500,
  allow_remote_driving = true,
  deliver_category = "vehicle",
  minimap_representation = {
    filename = "__base__/graphics/entity/locomotive/minimap-representation/locomotive-minimap-representation.png",
    flags = {"icon"},
    scale = 0.5,
    size = {20, 40},
  },
  selected_minimap_representation = {
    filename = "__base__/graphics/entity/locomotive/minimap-representation/locomotive-selected-minimap-representation.png",
    flags = {"icon"},
    scale = 0.5,
    size = {20, 40},
  },
  -- stop_trigger TODO?
  air_resistance = 0.0075, -- TODO tweak?
  connection_distance = 1,
  joint_distance = 2,
  max_speed = 0.04,
  vertical_selection_shift = -0.5,
  allow_manual_color = false,
  drive_over_tie_trigger = tieTriggerSound,
  drive_over_tie_trigger_minimal_speed = 0.02,
  pictures = nil, -- Pictures are rendered by Animated Trains Library
  tie_distance = 1.5,
  energy_source = {
    type = "burner",
    fuel_categories = {"herbivorous"},
    effectivity = 1.3,
    fuel_inventory_size = 5,
    smoke = nil,
    burner_usage = "auroch-food"
  },
  max_power = "50kW",
  reversing_power_modifier = 0.7,
}

local item = table.deepcopy(data.raw["item-with-entity-data"]["locomotive"])
item.name = loco.name
item.place_result = loco.name
item.icon = loco.icon
item.stack_size = 5
item.spoil_ticks = 60 * 60 * 5 -- 5 minutes


local recipe = {
  type = "recipe",
  name = loco.name,
  enabled = false,
  icon = loco.icon,
  energy_required = 10,
  allow_productivity = false,
  ingredients = {
    {name = "domesticated-auroch", amount = 2, type = "item"},
    {name = "wood", amount = 10, type = "item"}
  },
  results = { {name = loco.name, amount = 1, type = "item"} }
}

loco.damaged_trigger_effect = {
  damage_type_filters = "fire",
  entity_name = "red-blood-explosion",
  type = "create-entity",
  offset_deviation = {{-1, -1}, {1, 1}},
}
-- TODO maybe also add pained moos?
-- loco.damaged_trigger_effect = {
--   type = "play-sound",
--   sound = moo_sounds
-- }

data:extend({loco, item, smoke, recipe})