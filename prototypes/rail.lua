--- Old implementation of rail with all rails in one picture
require("prototypes/rail-pictures")

local curved_rail_a = table.deepcopy(data.raw["curved-rail-a"]["curved-rail-a"])
local curved_rail_b = table.deepcopy(data.raw["curved-rail-b"]["curved-rail-b"])
local straingt_rail = table.deepcopy(data.raw["straight-rail"]["straight-rail"])
local half_diagonal_rail = table.deepcopy(data.raw["half-diagonal-rail"]["half-diagonal-rail"])

local rail_planner = table.deepcopy(data.raw["rail-planner"]["rail"])
rail_planner.name = "dirt-rail-planner"
rail_planner.icon = "__aurochs__/graphics/DirtTrack/DirtTrackIcon.png"
rail_planner.localised_name = nil

local rails = {curved_rail_a, curved_rail_b, straingt_rail, half_diagonal_rail}
for _, rail in pairs(rails) do
  rail.name = "dirt-" .. rail.name
  rail.minable.result = rail_planner.name
  rail.placeable_by.item = rail_planner.name
end

-- straingt_rail.pictures = new_rail_pictures("straight")
-- curved_rail_a.pictures = new_rail_pictures("curved-a")
-- curved_rail_b.pictures = new_rail_pictures("curved-b")


rail_planner.place_result = "dirt-straight-rail"
rail_planner.rails = {straingt_rail.name, curved_rail_a.name, curved_rail_b.name, half_diagonal_rail.name}


--- New implementation with each rail in a separate picture

-- Image mapping for the images in graphics/DirtTrack/:
-- 0001.png: curve-a west (piece 16)
-- 0002.png: curve-b west (piece 15)
-- 0003.png: curve-b northeast (piece 14)
-- 0004.png: curve-a northeast (piece 13)
-- 0005.png: curve-a south (piece 12)
-- 0006.png: curve-b south (piece 11)
-- 0007.png: curve-b northwest (piece 10)
-- 0008.png: curve-a northwest (piece 9)
-- 0009.png: curve-a east (piece 8)
-- 0010.png: curve-b east (piece 7)
-- 0011.png: curve-b southwest (piece 6)
-- 0012.png: curve-a southwest (piece 5)
-- 0013.png: curve-a north (piece 4)
-- 0014.png: curve-b north (piece 3)
-- 0015.png: curve-b southeast (piece 2)
-- 0016.png: curve-a southeast (piece 1)

-- 0017.png: straight east
-- 0018.png: straight north
-- 0019.png: straight southeast
-- 0020.png: straight northeast

-- 0021.png: half-diagonal north
-- 0022.png: half-diagonal southeast
-- 0023.png: half-diagonal east
-- 0024.png: half-diagonal northeast

-- metadata:
-- size: 448 x 448
-- shift 0, 0
-- scale 0.5

local ground_rail_render_layers =
{
  stone_path_lower = "rail-stone-path-lower",
  stone_path = "rail-stone-path",
  tie = "rail-tie",
  screw = "rail-screw",
  metal = "rail-metal"
}

--- @type data.RailPictureSet
local curved_rail_a_pictures = {
  render_layers = ground_rail_render_layers,
  north = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0013.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  northeast = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0004.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  east = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0009.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  southeast = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0016.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  south = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0005.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  southwest = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0012.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  west = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0001.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  northwest = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0008.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  }
}

--- @type data.RailPictureSet
local curved_rail_b_pictures = {
  render_layers = ground_rail_render_layers,
  north = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0014.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  northeast = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0003.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  east = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0010.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  southeast = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0015.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  south = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0006.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  southwest = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0011.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  west = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0002.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  northwest = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0007.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  }
}

--- @type data.RailPictureSet
local straight_rail_pictures = {
  render_layers = ground_rail_render_layers,
  north = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0018.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  northeast = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0020.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  east = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0017.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  southeast = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0019.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  south = {},
  southwest = {},
  west = {},
  northwest = {}
}

--- @type data.RailPictureSet
local half_diagonal_rail_pictures = {
  render_layers = ground_rail_render_layers,
  north = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0021.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  northeast = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0022.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  east = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0024.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  southeast = {
    stone_path_background = {
      sheet = {
        filename = "__aurochs__/graphics/DirtTrack/0023.png",
        width = 448,
        height = 448,
        variation_count = 1,
        scale = 0.5
      }
    }
  },
  south = {},
  southwest = {},
  west = {},
  northwest = {}
}

--rail_planner.pictures = rail_planner_pictures
curved_rail_a.pictures = curved_rail_a_pictures
curved_rail_b.pictures = curved_rail_b_pictures
straingt_rail.pictures = straight_rail_pictures
half_diagonal_rail.pictures = half_diagonal_rail_pictures

local recipe = {
  type = "recipe",
  name = rail_planner.name,
  icon = rail_planner.icon,
  enabled = false,
  energy_required = 1,
  ingredients =
  {
    {name = "stone", amount = 5, type = "item"},
  },
  results = { {name = rail_planner.name, amount = 10, type = "item"} }
}

data:extend{rail_planner, curved_rail_a, curved_rail_b, straingt_rail, half_diagonal_rail, recipe}
