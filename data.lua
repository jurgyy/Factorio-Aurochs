require("prototypes/util")

data:extend{{
  type = "mod-data",
  name = "atl-config-aurochs",
  data_type = "atl-config",
  data = {
    name = "aurochs-locomotive",
    layers = {
      {
        file_path = "__aurochs__/graphics/loco/BullDraft",
        draw_as_shadow = false,
        spritter_table = require("graphics/loco/BullDraft"),
        flags = { "low-object" }
      },
      {
        file_path = "__aurochs__/graphics/loco/BullDraftShadow",
        draw_as_shadow = true,
        spritter_table = require("graphics/loco/BullDraftShadow"),
      }
    },
    animation_speed_multiplier = 16.5
  }
}, {
  type = "mod-data",
  name = "atl-config-aurochs-cart",
  data_type = "atl-config",
  data = {
    name = "aurochs-cart",
    layers = {
      {
        file_path = "__aurochs__/graphics/wagon/Object",
        draw_as_shadow = false,
        spritter_table = require("graphics/wagon/Object"),
        flags = { "low-object" }
      },
      {
        file_path = "__aurochs__/graphics/wagon/Shadow",
        draw_as_shadow = true,
        spritter_table = require("graphics/wagon/Shadow"),
      }
    },
    animation_speed_multiplier = 6
  }
}}

require("prototypes/locomotive")
require("prototypes/cart")
require("prototypes/rail")
require("prototypes/trainstop")
require("prototypes/rail-signal")
require("prototypes/wheat-grass")
require("prototypes/aurochs")
require("prototypes/attack-proxy")
require("prototypes/technology")
require("prototypes/blood")