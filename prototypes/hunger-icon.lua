local icon = {
  type = "item",
  name = "aurochs-hunger-icon",
  hidden = true,
  icons = {
    {
      icon = "__core__/graphics/icons/alerts/food-icon-red.png",
      icon_size = 64,
      scale = 1
    }
  },
  order = "a-[aurochs]-hunger-icon",
  stack_size = 1
}

data:extend({icon})