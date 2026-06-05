local item = {
  type = "item",
  name = "wheat-grass-seed",
  icon = "__aurochs__/graphics/wheatgrass/seedIcon.png",
  subgroup = "auroch-farming",
  order = "aa-[seed]",
  stack_size = 100
}

local growing_recipe = {
  type = "recipe",
  name = "wheat-grass",
  category = "basic-crafting",
  enabled = false,
  ingredients = {
    { name = "wheat-grass-seed", amount = 10, type = "item" },
    -- { name = "water", amount = 100, type = "fluid" }
  },
  energy_required = 20,
  results = {
    { name = "wheat-grass", amount_min = 0, amount_max = 10, type = "item" },
  },
  icon = "__aurochs__/graphics/wheatgrass/icon.png",
  allow_productivity = false,
  subgroup = "auroch-farming",
  order = "b-[wheat-grass]",
}

local seed_extraction_recipe = {
  type = "recipe",
  name = "wheat-grass-seed",
  category = "basic-crafting",
  enabled = false,
  ingredients = {
    { name = "wheat-grass", amount = 10, type = "item" },
  },
  energy_required = 20,
  results = {
    { name = "wheat-grass-seed", amount_min = 0, amount_max = 44, type = "item" },
  },
  icon = "__aurochs__/graphics/wheatgrass/seedIcon.png",
  allow_productivity = false,
  subgroup = "auroch-farming",
  order = "aa-[seed]",
}

data:extend{ item, growing_recipe, seed_extraction_recipe }