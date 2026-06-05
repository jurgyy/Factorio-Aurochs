---@type data.UnitPrototype
local wild = {
  type = "unit",
  name = "wild-auroch",
  icon = "__aurochs__/graphics/wild-auroch/BullIcon.png",
  -- icon_size = data.raw["unit"]["medium-biter"].icon_size,
  flags = {"placeable-neutral", "placeable-off-grid", "not-repairable", "breaths-air", "get-by-unit-number"},
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
  corpse = "aurochs-corpse",
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
    sound = require("sounds/sounds").moo_sounds{category = "enemy"}
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
      "base_density = 10 * var('control:wheat-grass:size'),"..
      "base_spots_per_km2 = 20 * var('control:wheat-grass:frequency'),"..
      "candidate_spot_count = 20,"..
      "frequency_multiplier = var('control:wheat-grass:frequency')/20,"..
      "random_spot_size_minimum = 0.1,"..
      "random_spot_size_maximum = 0.4,"..
      "regular_blob_amplitude_multiplier = 0.5,"..
      "regular_patch_set_count = 6,"..
      "regular_patch_set_index = 4,"..
      "regular_rq_factor = 0.03,"..
      "seed1 = 1006,"..
      "size_multiplier = var('control:wheat-grass:size') * 1000,"..
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
domesticated.flags = {"placeable-player", "placeable-off-grid", "not-repairable", "breaths-air", "player-creation"}
domesticated.minable = {
  mining_time = 1,
  results = {
    {type = "item", name = "domesticated-auroch", amount = 1}
  },
  autoplace = nil
}
domesticated.order = "a"
domesticated.subgroup = "auroch-farming"

local domesticated_item = {
  type = "item",
  name = "domesticated-auroch",
  icon = "__aurochs__/graphics/wild-auroch/BullIcon.png",
  subgroup = domesticated.subgroup,
  order = domesticated.order,
  place_result = "domesticated-auroch",
  stack_size = 50,
  spoil_ticks = 60 * 60 * 5 -- 5 minutes
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

local corpse_spritter = require("graphics/wild-auroch/BullDeath")
local corpse_shadow_spritter = require("graphics/wild-auroch/BullDeathShadow")
local deacy_spritter = require("graphics/wild-auroch/BullDecay")
local decay_shadow_spritter = require("graphics/wild-auroch/BullDecayShadow")
---@type data.CorpsePrototype
local corpse = {
  type = "corpse",
  name = "aurochs-corpse",
  icon = wild.icon,
  icon_size = 64,
  animation = {
    animation_speed = 2,
    layers = {
      {
        direction_count = 32,
        filenames = util.filenames_from_spritter("__aurochs__/graphics/wild-auroch/BullDeath", corpse_spritter),
        width = corpse_spritter.width,
        height = corpse_spritter.height,
        frame_count = 7,
        line_length = corpse_spritter.line_length,
        lines_per_file = corpse_shadow_spritter.lines_per_file,
        scale = corpse_spritter.scale,
        shift = corpse_spritter.shift,
        -- flags = {"corpse-decay"}
      },
      {
        direction_count = 32,
        filenames = util.filenames_from_spritter("__aurochs__/graphics/wild-auroch/BullDeathShadow", corpse_shadow_spritter),
        width = corpse_shadow_spritter.width,
        height = corpse_shadow_spritter.height,
        frame_count = 7,
        line_length = corpse_shadow_spritter.line_length,
        lines_per_file = corpse_shadow_spritter.lines_per_file,
        scale = corpse_shadow_spritter.scale,
        shift = corpse_shadow_spritter.shift,
        draw_as_shadow = true
      }
    }
  },
  decay_animation = {
    layers = {
      {
        allow_forced_downscale = true,
        direction_count = 32,
        filenames = util.filenames_from_spritter("__aurochs__/graphics/wild-auroch/BullDecay", deacy_spritter),
        width = deacy_spritter.width,
        height = deacy_spritter.height,
        frame_count = 7,
        line_length = deacy_spritter.line_length,
        lines_per_file = deacy_spritter.lines_per_file,
        scale = deacy_spritter.scale,
        shift = deacy_spritter.shift
      },
      {
        direction_count = 32,
        filenames = util.filenames_from_spritter("__aurochs__/graphics/wild-auroch/BullDecayShadow", decay_shadow_spritter),
        width = decay_shadow_spritter.width,
        height = decay_shadow_spritter.height,
        frame_count = 7,
        line_length = decay_shadow_spritter.line_length,
        lines_per_file = decay_shadow_spritter.lines_per_file,
        scale = decay_shadow_spritter.scale,
        shift = decay_shadow_spritter.shift,
        draw_as_shadow = true
      }
    }
  },
  decay_frame_transition_duration = 360,
  direction_shuffle = nil, -- TODO?
  dying_speed = 0.014,
  final_render_layer = "lower-object-above-shadow",
  flags = {"placeable-neutral", "placeable-off-grid", "building-direction-16-way", "not-on-map"},
  ground_patch = {
    sheet = {
      allow_forced_downscale = true,
      filename = "__base__/graphics/entity/biter/blood-puddle-var-main.png",
      flags = {"low-object"},
      height = 134,
      line_length = 4,
      scale = 0.65,
      shift = {
        -0.015625,
        -0.015625
      },
      tint = {r = 0.5, g = 0, b = 0},
      variation_count = 4,
      width = 164
    }
  },
  ground_patch_fade_in_delay = 50,
  ground_patch_fade_in_speed = 0.002,
  ground_patch_fade_out_duration = 1200,
  ground_patch_fade_out_start = 3000,
  ground_patch_render_layer = "decals",
  hidden_in_factoriopedia = true,
  order = "a[corpse]-b[aurochs]-a[free]",
  selectable_in_game = false,
  selection_box = wild.selection_box,
  subgroup = "corpses",
  time_before_removed = 54000,
  use_decay_layer = false
}

data:extend({ wild, domesticated, domesticated_item, wild_item, corpse })