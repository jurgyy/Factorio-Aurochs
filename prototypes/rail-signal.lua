local signals = {
  {
    name = "dirt-rail-signal",
    type = "rail-signal",
    folder = "RailSignal",
    spritter = "RailSignal",
    order = {
      green = 0,
      yellow = 1,
      red = 2
    }
  },
  {
    name = "dirt-rail-chain-signal",
    type = "rail-chain-signal",
    folder = "ChainSignal",
    spritter = "ChainSignal",
    order = {
      green = 0,
      yellow = 1,
      red = 2,
      blue = 3
    }
  }
}

for i, signal_def in pairs(signals) do
  ---@type SpritterOutput
  local signal_spritter = require("graphics/" .. signal_def.folder .. "/" .. signal_def.spritter)
  local signal_shadow_spritter = require("graphics/" .. signal_def.folder .. "/Shadow")

  local signal = table.deepcopy(data.raw[signal_def.type][signal_def.type])

  signal.name = signal_def.name
  -- signal.collision_box = {{-1.4, -1.6}, {1.4, 1.6}}
  -- signal.collision_mask = { 
  --   layers = {
  --     is_lower_object = true,
  --     water_tile = true,
  --     floor = true,
  --     rail = true,
  --     item = true,
  --     object = true,
  --     player = true
  -- }}
  -- signal.ground_picture_set = {
  --   lights = {},
  --   signal_color_to_structure_frame_index = {
  --     green = 0,
  --     red = 2,
  --     yellow = 1
  --   }
  -- }
  signal.ground_picture_set.lights = {}
  signal.ground_picture_set.rail_piece = nil
  signal.ground_picture_set.structure_render_layer = "object"
  signal.ground_picture_set.signal_color_to_structure_frame_index = signal_def.order
  signal.ground_picture_set.structure = {
    layers = {
      {
        direction_count = 16,
        filename = "__aurochs__/graphics/" .. signal_def.folder .. "/".. signal_def.spritter ..".png",
        frame_count = signal_spritter.line_length,
        height = signal_spritter.height,
        line_length = signal_spritter.line_length,
        priority = "high",
        scale = signal_spritter.scale,
        shift = signal_spritter.shift,
        width = signal_spritter.width
      },
      {
        direction_count = 16,
        draw_as_shadow = true,
        filename = "__aurochs__/graphics/" .. signal_def.folder .. "/Shadow.png",
        frame_count = signal_shadow_spritter.line_length,
        height = signal_shadow_spritter.height,
        line_length = signal_shadow_spritter.line_length,
        priority = "high",
        scale = signal_shadow_spritter.scale,
        shift = signal_shadow_spritter.shift,
        width = signal_shadow_spritter.width
      }
    }
  }
  signal.minable = {mining_time = 0.1, result = signal_def.name}
  --signal.ground_picture_set.selection_box_shift[1] = {100, 100}
  -- for _, shift in pairs(signal.ground_picture_set.selection_box_shift) do
  --   shift[1] = 100
  --   shift[2] = 100
  -- end

  --signal.elevated_picture_set = nil

  local signal_item = {
    type = "item",
    name = signal_def.name,
    icon = "__aurochs__/graphics/" .. signal_def.folder .. "/" .. signal_def.spritter .. "Icon.png",
    icon_size = 64,
    subgroup = "train-transport",
    order = "b[signal]-a[" .. i .. "]",
    place_result = signal_def.name,
    stack_size = 50
  }

  local signal_recipe = {
    type = "recipe",
    name = signal_def.name,
    enabled = false,
    energy_required = 1,
    ingredients =
    {
      {name = "wood", amount = 2, type = "item"},
    },
    results = { {name = signal_def.name, amount = 1, type = "item"} }
  }

  data:extend({signal, signal_item, signal_recipe})
end