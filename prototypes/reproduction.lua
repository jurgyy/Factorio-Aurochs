local recipe = {
  type = "recipe",
  name = "auroch-reproduction",
  category = "basic-crafting",
  enabled = false,
  ingredients = {
    { name = "hay", amount = 10, type = "item" },
    { name = "domesticated-auroch", amount = 2, type = "item" },
  },
  energy_required = 300,
  results = {
    { name = "domesticated-auroch", amount = 3, type = "item" }
  },
  icon = "__aurochs__/graphics/reproductionIcon.png",
  allow_productivity = false,
  reset_freshness_on_craft = true,
  result_is_always_fresh = true,
  subgroup = "auroch-farming",
  order = "e-[reproduction]"
}

data:extend({recipe})