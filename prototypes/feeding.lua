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
  allow_productivity = false,
  icons = {
    {
      icon = "__aurochs__/graphics/wild-auroch/headIcon.png",
    },
    {
      icon = "__aurochs__/graphics/hayBaleIcon.png",
      scale = 0.5,
      shift = {16, 16}
    }
  },
}

data:extend({recipe})