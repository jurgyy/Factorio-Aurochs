local tech = {
  type = "technology",
  name = "domestication",
  icon = "__aurochs__/graphics/DomesticationTechIcon.png",
  icon_size = 256,
  effects = {
    {
      type = "unlock-recipe",
      recipe = "aurochs-locomotive"
    },
    {
      type = "unlock-recipe",
      recipe = "aurochs-cart"
    },
    {
      type = "unlock-recipe",
      recipe = "aurochs-train-stop"
    },
    {
      type = "unlock-recipe",
      recipe = "dirt-rail-planner"
    },
    {
      type = "unlock-recipe",
      recipe = "dirt-rail-signal"
    },
    {
      type = "unlock-recipe",
      recipe = "dirt-rail-chain-signal"
    },
    {
      type = "unlock-recipe",
      recipe = "hay"
    },
    {
      type = "unlock-recipe",
      recipe = "auroch-reproduction"
    },
    {
      type = "unlock-recipe",
      recipe = "wheat-grass"
    },
    {
      type = "unlock-recipe",
      recipe = "wheat-grass-seed"
    },
  },
  research_trigger = {
    type = "scripted",
    trigger_description = {
      "research-trigger.domestication"
    }
  }
}

data:extend({ tech })