---@type data.UnitPrototype
local wild = {
  type = "unit",
  name = "wild-auroch",
  icon = "__aurochs__/graphics/wild-auroch/BullIcon.png",
  -- icon_size = data.raw["unit"]["medium-biter"].icon_size,
  flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
  order = "c-auroch-a",
  subgroup = "enemies",
  max_health = 200,
  attack_parameters = {
    type = "projectile",
    ammo_category = "melee",
    ammo_type = {
      target_type = "entity",
      action = {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {
            {
              type = "damage",
              damage = { amount = 20, type = "physical" }
            }
          }
        }
      }
    },
    animation = {
      layers = {
        util.sprite_load_spritter("__aurochs__/graphics/wild-auroch/BullEating",
        {
            animation_speed = 0.4,
            frame_count = 16,
            direction_count = 32,
            flags = {"low-object"},
            surface = "nauvis",
            usage = "enemy"
          }
        ),
        util.sprite_load_spritter("__aurochs__/graphics/wild-auroch/BullEatingShadow",
        {
            animation_speed = 0.4,
            frame_count = 16,
            direction_count = 32,
            draw_as_shadow = true,
            flags = {"low-object"},
            surface = "nauvis",
            usage = "enemy"
          }
        ),
      }
    },
    cooldown = 60,
    cooldown_deviation = 0.2,
    range = 0.5,
    range_mode = "bounding-box-to-bounding-box",
  },
  collision_box = {{-0.6, -0.6}, {0.6, 0.6}},
  selection_box = {{-0.65, -0.95}, {0.65, 1.45}},
  sticker_box = {{-0.4, -0.6}, {0.4, 1.0}},
  -- corpse = {}, TODO
  -- dying_sound = {}, TODO
  movement_speed = 0.05,
  distance_per_frame = 0.165,
  rotation_speed = 0.01,
  distraction_cooldown = 300,
  healing_per_tick = 0.01,
  impact_category = "organic",
  max_persue_distance = 50,
  min_persue_time = 5 * 60,
  resistances = {
    {
      type = "physical",
      decrease = 4,
      percent = 20
    }
  },
  vision_distance = 30,

  run_animation = {
    layers = {
      util.sprite_load_spritter("__aurochs__/graphics/wild-auroch/BullWild",
        {
          frame_count = 16,
          direction_count = 32,
          flags = {"low-object"},
          surface = "nauvis",
          usage = "enemy"
        }
      ),
      util.sprite_load_spritter("__aurochs__/graphics/wild-auroch/BullWildShadow",
        {
          frame_count = 16,
          direction_count = 32,
          draw_as_shadow = true,
          flags = {"low-object"},
          surface = "nauvis",
          usage = "enemy"
        }
      ),
    }
  },
  water_reflection = data.raw["unit"]["medium-biter"].water_reflection,
  -- running_sound_animation_positions = { 4, 6, 11, 14 }
  -- walking_sound = {} TODO
  working_sound = {
    max_sounds_per_prototype = 2,
    probability = 0.0014,
    sound = require("prototypes/moo-sound")(1, 1.5, "enemy")
  },
  autoplace = {
    order = "a[doodad]-a[wild]-b[aurochs]",
    probability_expression = "viable * spots * 0.01",
    force = "neutral",
    local_expressions = {
      viable = "max(0, good_moist)",
      spots = "multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 1, octaves = 3, input_scale = 1/50} * multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 2, octaves = 3, input_scale = 1/200} - 0.98",
      good_moist = "-(4 * moisture_nauvis - 2)^2 + 0.5"
    }
  },
  damaged_trigger_effect = {
    damage_type_filters = "fire",
    entity_name = "red-blood-explosion",
    type = "create-entity",
    offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}},
  }
}

---@type { ["decorative"|"entity"|"tile"]: data.AutoplaceSettings }?
local autoplace = data.raw.planet.nauvis.map_gen_settings.autoplace_settings
if not autoplace then error("Could not find autoplace settings") end

autoplace.entity.settings["wild-auroch"] = {}
wild.autoplace = {
  order = "a[doodad]-a[grass]-b[aurochs]",
  probability_expression = "min(good_moist, center_path, resource_spread) * 0.1",
  local_expressions = {
    viable = "max(0, good_moist)",
    good_moist = "clamp(moisture_nauvis - 0.10, 0, 1)", -- Not the driest areas
    path = "max(0, 1 - trees_forest_path_cutout_faded)^4",
    center_path = "clamp(path * 2 - 1, 0, 1)",
    resource_spread = "clamp(resource_expression, 0, 1)* random_penalty{x = x, y = y, source = 1, amplitude = 1 /0.40833333333333}",
    resource_expression = "resource_autoplace_all_patches{"..
      "base_density = 10 * var('control:prairie-grass:size'),"..
      "base_spots_per_km2 = 20 * var('control:prairie-grass:frequency'),"..
      "candidate_spot_count = 20,"..
      "frequency_multiplier = var('control:prairie-grass:frequency')/20,"..
      "random_spot_size_minimum = 0.1,"..
      "random_spot_size_maximum = 0.4,"..
      "regular_blob_amplitude_multiplier = 0.5,"..
      "regular_patch_set_count = 6,"..
      "regular_patch_set_index = 4,"..
      "regular_rq_factor = 0.03,"..
      "seed1 = 1006,"..
      "size_multiplier = var('control:prairie-grass:size') * 1000,"..
      "has_starting_area_placement = 0,"..
      "starting_blob_amplitude_multiplier = 0.125,"..
      "starting_patch_set_count = default_starting_resource_patch_set_count,"..
      "starting_patch_set_index = 0,"..
      "starting_rq_factor = 0.14285714285714"..
    "}"
  }
}

local domesticated = table.deepcopy(wild)
domesticated.name = "domesticated-auroch"
domesticated.order = "c-auroch-b"
domesticated.minable = {
  mining_time = 1,
  results = {
    {type = "item", name = "domesticated-auroch", amount = 1}
  },
  autoplace = nil
}

local domesticated_item = {
  type = "item",
  name = "domesticated-auroch",
  icon = "__aurochs__/graphics/wild-auroch/BullIcon.png",
  subgroup = "intermediate-product",
  order = "b-auroch-b",
  place_result = "domesticated-auroch",
  stack_size = 50
}

local wild_item = {
  type = "item",
  name = "wild-auroch",
  icon = "__aurochs__/graphics/wild-auroch/BullIcon.png",
  subgroup = "enemies",
  order = "b-auroch-a",
  place_result = "wild-auroch",
  stack_size = 50
}

data:extend({ wild, domesticated, domesticated_item, wild_item })