local recipe = {
  type = "recipe",
  name = "feed-auroch",
  enabled = false,
  ingredients = {
    { name = "hay", amount = 1, type = "item" },
    { name = "domesticated-auroch", amount = 1, type = "item" },
  },
  energy_required = 2,
  results = {
    { name = "domesticated-auroch", amount = 1, type = "item" }
  },
  reset_freshness_on_craft = true,
  icons = {
    {
      icon = "__aurochs__/graphics/wild-auroch/BullIcon.png",
      icon_size = 64,
      tint = {r = 0.4, g = 0.8, b = 0.4}
    }
  },
}

data:extend({recipe})