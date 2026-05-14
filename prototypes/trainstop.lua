---@type SpritterOutput
local base_spritter = require("graphics/TrainStop/Base")
---@type SpritterOutput
local top_spritter = require("graphics/TrainStop/Top")
---@type SpritterOutput
local ground_spritter = require("graphics/TrainStop/Ground")
---@type SpritterOutput
local shadow_spritter = require("graphics/TrainStop/Shadow")
---@type SpritterOutput
local integration_spritter = require("graphics/TrainStop/Integration")

local trainstop_item = table.deepcopy(data.raw["item"]["train-stop"])
trainstop_item.name = "aurochs-train-stop"
trainstop_item.place_result = "aurochs-train-stop"
trainstop_item.icon = "__aurochs__/graphics/TrainStop/TrainStopIcon.png"

local trainstop_recipe = {
  type = "recipe",
  name = "aurochs-train-stop",
  enabled = false,
  icon = trainstop_item.icon,
  energy_required = 1,
  ingredients =
  {
    {name = "wood", amount = 20, type = "item"},
    {name = "stone", amount = 10, type = "item"}
  },
  results = { {name = "aurochs-train-stop", amount = 1, type = "item"} }
}

local trainstop = table.deepcopy(data.raw["train-stop"]["train-stop"])
trainstop.name = "aurochs-train-stop"
trainstop.icon = trainstop_item.icon
trainstop.light1 = nil
trainstop.light2 = nil
trainstop.animations = {
  north = {
    layers = {
      {
        filename = "__aurochs__/graphics/TrainStop/base.png",
        width = base_spritter.width,
        height = base_spritter.height,
        scale = base_spritter.scale,
        shift = base_spritter.shift,
        x = base_spritter.width * 0,
        y = base_spritter.height * 0
      },
      {
        filename = "__aurochs__/graphics/TrainStop/Shadow.png",
        width = shadow_spritter.width,
        height = shadow_spritter.height,
        scale = shadow_spritter.scale,
        shift = shadow_spritter.shift,
        x = shadow_spritter.width * 0,
        y = shadow_spritter.height * 0,
        draw_as_shadow = true
      }
    }
  },
  east = {
    layers = {
      {
        filename = "__aurochs__/graphics/TrainStop/base.png",
        width = base_spritter.width,
        height = base_spritter.height,
        scale = base_spritter.scale,
        shift = base_spritter.shift,
        x = base_spritter.width * 1,
        y = base_spritter.height * 0
      },
      {
        filename = "__aurochs__/graphics/TrainStop/Shadow.png",
        width = shadow_spritter.width,
        height = shadow_spritter.height,
        scale = shadow_spritter.scale,
        shift = shadow_spritter.shift,
        x = shadow_spritter.width * 1,
        y = shadow_spritter.height * 0,
        draw_as_shadow = true
      }
    }
  },
  south = {
    layers = {
      {
        filename = "__aurochs__/graphics/TrainStop/base.png",
        width = base_spritter.width,
        height = base_spritter.height,
        scale = base_spritter.scale,
        shift = base_spritter.shift,
        x = base_spritter.width * 0,
        y = base_spritter.height * 1
      },
      {
        filename = "__aurochs__/graphics/TrainStop/Shadow.png",
        width = shadow_spritter.width,
        height = shadow_spritter.height,
        scale = shadow_spritter.scale,
        shift = shadow_spritter.shift,
        x = shadow_spritter.width * 0,
        y = shadow_spritter.height * 1,
        draw_as_shadow = true
      }
    }
  },
  west = {
    layers = {
      {
        filename = "__aurochs__/graphics/TrainStop/base.png",
        width = base_spritter.width,
        height = base_spritter.height,
        scale = base_spritter.scale,
        shift = base_spritter.shift,
        x = base_spritter.width * 1,
        y = base_spritter.height * 1
      },
      {
        filename = "__aurochs__/graphics/TrainStop/Shadow.png",
        width = shadow_spritter.width,
        height = shadow_spritter.height,
        scale = shadow_spritter.scale,
        shift = shadow_spritter.shift,
        x = shadow_spritter.width * 1,
        y = shadow_spritter.height * 1,
        draw_as_shadow = true
      }
    }
  }
}

trainstop.rail_overlay_animations = {
  north = {
    filename = "__aurochs__/graphics/TrainStop/Ground.png",
    width = ground_spritter.width,
    height = ground_spritter.height,
    scale = ground_spritter.scale,
    shift = ground_spritter.shift,
    x = ground_spritter.width * 0,
    y = ground_spritter.height * 0
  },
  east = {
    filename = "__aurochs__/graphics/TrainStop/Ground.png",
    width = ground_spritter.width,
    height = ground_spritter.height,
    scale = ground_spritter.scale,
    shift = ground_spritter.shift,
    x = ground_spritter.width * 1,
    y = ground_spritter.height * 0
  },
  south = {
    filename = "__aurochs__/graphics/TrainStop/Ground.png",
    width = ground_spritter.width,
    height = ground_spritter.height,
    scale = ground_spritter.scale,
    shift = ground_spritter.shift,
    x = ground_spritter.width * 0,
    y = ground_spritter.height * 1
  },
  west = {
    filename = "__aurochs__/graphics/TrainStop/Ground.png",
    width = ground_spritter.width,
    height = ground_spritter.height,
    scale = ground_spritter.scale,
    shift = ground_spritter.shift,
    x = ground_spritter.width * 1,
    y = ground_spritter.height * 1
  }
}

trainstop.integration_patch = {
  east = {
      filename = "__aurochs__/graphics/TrainStop/Integration.png",
      width = integration_spritter.width,
      height = integration_spritter.height,
      scale = integration_spritter.scale,
      shift = integration_spritter.shift,
      x = integration_spritter.width * 1,
      y = integration_spritter.height * 0
  },
  west = {
      filename = "__aurochs__/graphics/TrainStop/Integration.png",
      width = integration_spritter.width,
      height = integration_spritter.height,
      scale = integration_spritter.scale,
      shift = integration_spritter.shift,
      x = integration_spritter.width * 1,
      y = integration_spritter.height * 1
  },
  south = {
      filename = "__aurochs__/graphics/TrainStop/Integration.png",
      width = integration_spritter.width,
      height = integration_spritter.height,
      scale = integration_spritter.scale,
      shift = integration_spritter.shift,
      x = integration_spritter.width * 0,
      y = integration_spritter.height * 1
  },
  north = {
      filename = "__aurochs__/graphics/TrainStop/Integration.png",
      width = integration_spritter.width,
      height = integration_spritter.height,
      scale = integration_spritter.scale,
      shift = integration_spritter.shift,
      x = integration_spritter.width * 0,
      y = integration_spritter.height * 0
  },
}

trainstop.top_animations = {
  north = {
    layers = {
      {
        filename = "__aurochs__/graphics/TrainStop/Top.png",
        width = top_spritter.width,
        height = top_spritter.height,
        scale = top_spritter.scale,
        shift = top_spritter.shift,
        x = top_spritter.width * 0,
        y = top_spritter.height * 0
      }
    }
  },
  east = {
    layers = {
      {
        filename = "__aurochs__/graphics/TrainStop/Top.png",
        width = top_spritter.width,
        height = top_spritter.height,
        scale = top_spritter.scale,
        shift = top_spritter.shift,
        x = top_spritter.width * 1,
        y = top_spritter.height * 0
      }
    }
  },
  south = {
    layers = {
      {
        filename = "__aurochs__/graphics/TrainStop/Top.png",
        width = top_spritter.width,
        height = top_spritter.height,
        scale = top_spritter.scale,
        shift = top_spritter.shift,
        x = top_spritter.width * 0,
        y = top_spritter.height * 1
      }
    }
  },
  west = {
    layers = {
      {
        filename = "__aurochs__/graphics/TrainStop/Top.png",
        width = top_spritter.width,
        height = top_spritter.height,
        scale = top_spritter.scale,
        shift = top_spritter.shift,
        x = top_spritter.width * 1,
        y = top_spritter.height * 1
      }
    }
  }
}

data:extend{trainstop, trainstop_item, trainstop_recipe}