local item = {
  type = "item",
  name = "hay",
  icon = "__aurochs__/graphics/hayBaleIcon.png",
  subgroup = "auroch-farming",
  order = "c[hay]",
  stack_size = 200,
  fuel_category = "herbivorous",
  fuel_value = "2MJ",
  
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
  },
  subgroup = "auroch-farming",
  order = "c-[hay]",
}

data:extend({item, recipe})