local item = {
  type = "item",
  name = "hay",
  icon = "__aurochs__/graphics/hayBaleIcon.png",
  subgroup = "intermediate-product",
  order = "a[doodad]-a[grass]-a[hay]",
  stack_size = 200,
}

local recipe = {
  type = "recipe",
  name = "hay",
  category = "basic-crafting",
  enabled = false,
  ingredients = {
    { name = "wheat-grass", amount = 5, type = "item" },
  },
  energy_required = 20,
  results = {
    { name = "hay", amount = 1, type = "item" }
  }
}

data:extend({item, recipe})