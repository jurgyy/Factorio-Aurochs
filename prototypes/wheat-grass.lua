local grass = data.raw["optimized-decorative"]["green-hairy-grass"]
if not grass then error("Could not find green-hairy-grass decorative") end

local decorative_trigger_effects = require("__base__.prototypes.decorative.decorative-trigger-effects")

data.raw["optimized-decorative"]["green-hairy-grass"] = nil
---@type SpritterOutput
local wheatgrass_spritter = require("graphics/wheatgrass/Grass")
local wheatgrass_shadow_spritter = require("graphics/wheatgrass/Shadow")

---@type data.SimpleEntityPrototype
local entity_grass = {
  name = "wheat-grass",
  type = "simple-entity",
  flags = {"placeable-neutral", "placeable-off-grid"},
  icon = "__aurochs__/graphics/wheatgrass/icon.png",
  subgroup = "grass",
  order = "a[decorative]-l[grass]-a[nauvis]-c[grass]",
  collision_box = {{-.9, -.9}, {.9, .9}},
  selection_box = {{-1.1, -1.1}, {1.1, 1.1}},
  collision_mask = {layers = {water_tile = true, doodad = true}},
  damaged_trigger_effect = decorative_trigger_effects.green_hairy_grass(),
  dying_trigger_effect = decorative_trigger_effects.green_hairy_grass(),
  minable = {
    mining_time = 0.5,
    results =
    {
      {type = "item", name = "wheat-grass", amount_min = 1, amount_max = 5}
      -- {type = "item", name = "coal", amount = 1, probability = 0.1}
    }
  },
  -- map_color = {r = 51, g = 66, b = 29},
  map_color = {r = 0, g = 255, b = 255},
  --mined_sound = TODO
  impact_category = "organic",
  render_layer = "object",
  max_health = 100,
  autoplace = {
    order = "a[doodad]-a[grass]-b[aurochs]",
    probability_expression = "min(good_moist, center_path, resource_spread)",
    local_expressions = {
      viable = "max(0, good_moist)",
      good_moist = "clamp(moisture_nauvis - 0.10, 0, 1)", -- Not the driest areas
      path = "max(0, 1 - trees_forest_path_cutout_faded)^4",
      center_path = "clamp(path * 2 - 1, 0, 1)",
      resource_spread = "clamp(resource_expression, 0, 1)* random_penalty{x = x, y = y, source = 1, amplitude = 1 /0.40833333333333}",
      resource_expression = "resource_autoplace_all_patches{"..
        "base_density = 500 * var('control:wheat-grass:size'),"..
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
  },
  -- pictures = grass.pictures
  pictures = {
    sheet = {
      layers = {
        {
          filename = "__aurochs__/graphics/wheatgrass/Grass.png",
          width = wheatgrass_spritter.width,
          height = wheatgrass_spritter.height,
          variation_count = wheatgrass_spritter.sprite_count,
          scale = wheatgrass_spritter.scale,
          shift = wheatgrass_spritter.shift,
          line_length = wheatgrass_spritter.line_length,
        },
        {
          filename = "__aurochs__/graphics/wheatgrass/Shadow.png",
          width = wheatgrass_shadow_spritter.width,
          height = wheatgrass_shadow_spritter.height,
          variation_count = wheatgrass_shadow_spritter.sprite_count,
          scale = wheatgrass_shadow_spritter.scale,
          shift = wheatgrass_shadow_spritter.shift,
          draw_as_shadow = true,
          line_length = wheatgrass_shadow_spritter.line_length,
        }
      }
    }
  }
}

---@type data.AutoplaceControl
local autoplace_control = {
  type = "autoplace-control",
  name = "wheat-grass",
  category = "resource",
  order = "a[doodad]-a[grass]-b[aurochs]"
}

---@type data.PlanetPrototypeMapGenSettings
local mapgen = data.raw.planet.nauvis.map_gen_settings

mapgen.autoplace_controls["wheat-grass"] = {}

---@type { ["decorative"|"entity"|"tile"]: data.AutoplaceSettings }?
local autoplace = data.raw.planet.nauvis.map_gen_settings.autoplace_settings
if not autoplace then error("Could not find autoplace settings") end

autoplace.decorative.settings["green-hairy-grass"] = nil
autoplace.entity.settings["wheat-grass"] = {}

---@type data.ItemPrototype
local item = {
  type = "item",
  name = "wheat-grass",
  icon = "__aurochs__/graphics/wheatgrass/itemIcon.png",
  subgroup = "grass",
  order = "a[doodad]-a[grass]-b[aurochs]",
  stack_size = 100
}

data:extend({entity_grass, autoplace_control, item})