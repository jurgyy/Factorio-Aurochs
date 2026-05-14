local loco = table.deepcopy(data.raw["locomotive"]["locomotive"])

loco.name = "aurochs-locomotive"
loco.minable = {mining_time = 0.5, result = "aurochs-locomotive"}
loco.reversing_power_modifier = 0.8
loco.allow_manual_color = false
loco.max_health = 2000
loco.collision_box = {{-0.6, -1.2}, {0.6, 1.2}}
loco.selection_box = {{-1, -1.5}, {1, 1.5}}
loco.joint_distance = 2
loco.connection_distance = 1
loco.weight = 500
loco.icon = "__aurochs__/graphics/icon.png"
loco.max_speed = 0.04
loco.max_power = "50kW"
loco.braking_power = "20W"
loco.braking_force = nil
loco.allow_manual_color = false
loco.energy_source =
{
  type = "burner",
  fuel_categories = {"chemical"},
  effectivity = 1.3,
  fuel_inventory_size = 5,
  smoke = nil,
  -- {
  --   {
  --     name = "train-smoke",
  --     deviation = {0.3, 0.3},
  --     frequency = 100,
  --     position = {0, -2},
  --     starting_frame = 0,
  --     starting_frame_deviation = 60,
  --     height = 2,
  --     height_deviation = 0.5,
  --     starting_vertical_speed = 0.2,
  --     starting_vertical_speed_deviation = 0.1
  --   }
  -- }
}
loco.resistances =
{
  {
    type = "fire",
    decrease = 15,
    percent = 35
  },
  {
    type = "physical",
    decrease = 35,
    percent = 35
  },
  {
    type = "impact",
    decrease = 45,
    percent = 65
  },
  {
    type = "explosion",
    decrease = 10,
    percent = 25
  },
  {
    type = "acid",
    decrease = 3,
    percent = 20
  }
}
loco.pictures = nil
loco.wheels = nil
---@type SpritterOutput
local logs = require("graphics/log/Log")
-- local shift = logs.shift
-- loco.wheels = {
--   rotated = {
--     direction_count = logs.sprite_count,
--     scale = logs.scale,
--     shift = shift,
--     width = logs.width,
--     height = logs.height,
--     line_length = logs.line_length,
--     lines_per_file = logs.lines_per_file,
--     usage = "train",
--     priority = "very-low",
--     filenames = {
--       "__aurochs__/graphics/log/Log-0.png",
--       "__aurochs__/graphics/log/Log-1.png"
--     }
--   }
-- }

-- {
--   rotated = {
--     layers =
--     {
--       {
--         width = 100,
--         height = 100,
--         direction_count = 32,
--         allow_low_quality_rotation = false,
--         filenames =
--         {
--           "__Animated_trains__/graphics/Decapod_Locomotive/Build_preview.png"
--         },
--         line_length = 32,
--         lines_per_file = 1,
--         shift = {0, -0.5},
--         scale = 1
--       }
--     },
--   }
-- }

local item = table.deepcopy(data.raw["item-with-entity-data"]["locomotive"])
item.name = "aurochs-locomotive"
item.place_result = "aurochs-locomotive"
item.icon = "__aurochs__/graphics/icon.png"
item.stack_size = 5

local moo_sounds = require("prototypes/moo-sound")()

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

---@type data.PlaySoundTriggerEffectItem[]
local tieTriggerSound = {
  {
    type = "play-sound",
    probability = 0.01,
    sound = moo_sounds
  },
  {
    type = "play-sound",
    sound = bell_sounds
  }
}

-- loco.door_opening_sound = {
--   sound = moo_sounds
-- }

-- loco.door_closing_sound = {
--   sound = moo_sounds
-- }

--TODO:
--loco.stop_trigger
--loco.working_sound.active sound (entering the loco)
--loco.working_sound.deactive sound (exiting the loco)
loco.working_sound = {
  activate_sound = moo_sounds,
  deactivate_sound = moo_sounds,
  sound = moo_sounds,
  probability = 0
}

loco.drive_over_tie_trigger = tieTriggerSound
loco.drive_over_tie_trigger_minimal_speed = 0.02
loco.tie_distance = 1.5

data:extend({loco, item})
