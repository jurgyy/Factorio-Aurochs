local cart = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
---@type SpritterOutput
local build_preview = require("graphics/wagon/Preview")

cart.name = "aurochs-cart"
cart.minable = { mining_time = 1, result = "aurochs-cart"}
cart.icon = "__aurochs__/graphics/wagon/cart-icon.png"
cart.collision_box = {{-0.6, -1.2}, {0.6, 1.2}}
cart.selection_box = {{-1, -1.5}, {1, 1.5}}
cart.joint_distance = 2
cart.connection_distance = 2
cart.braking_power = "20W"
cart.braking_force = nil
cart.weight = 500
cart.pictures = {
    rotated = {
      layers = {
        {
          width = build_preview.width,
          height = build_preview.height,
          direction_count = build_preview.sprite_count,
          allow_low_quality_rotation = false,
          filenames =
          {
            "__aurochs__/graphics/wagon/Preview.png"
          },
          line_length = build_preview.line_length,
          lines_per_file = build_preview.lines_per_file,
          shift = build_preview.shift,
          scale = build_preview.scale
        }
      }
    }
  }
cart.wheels = nil
cart.drive_over_tie_trigger = nil
cart.drive_over_tie_trigger_minimal_speed = nil

local item = table.deepcopy(data.raw["item-with-entity-data"]["cargo-wagon"])
item.name = "aurochs-cart"
item.place_result = "aurochs-cart"
item.icon = "__aurochs__/graphics/wagon/cart-icon.png"
item.stack_size = 5

local recipe = {
  type = "recipe",
  name = "aurochs-cart",
  enabled = false,
  energy_required = 10,
  ingredients =
  {
    {name = "wood", amount = 40, type = "item"},
  },
  results = { {name = "aurochs-cart", amount = 1, type = "item"} }
}

data:extend({cart, item, recipe})