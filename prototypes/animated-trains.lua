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
    animation_speed_multiplier = 16.5,
    frames_per_rotation = 16
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
    animation_speed_multiplier = 6,
    frames_per_rotation = 8
  }
}, {
  type = "mod-data",
  name = "auroch-loco-entity-built-config",
  data_type = "atl-entity-built-config",
  data = {
    entities = {
      "aurochs-locomotive",
    },
    remote_interface = "aurochs",
    remote_function = "on_built_locomotive"
  }
}}