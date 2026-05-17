---@param food string Food item name
---@param amount integer Food amount
local function create_feeding_recipe(food, amount)
  local item_prototype = data.raw.item[food]
  if not item_prototype then
    error("Food item '" .. food .. "' not found")
  end

  local recipe = {
    type = "recipe",
    name = "feed-auroch-" .. food,
    localised_name = {"recipe-name.feed-auroch", {"item-name." .. food}},
    enabled = false,
    ingredients = {
      { name = "hay", amount = amount, type = "item" },
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
        icon = item_prototype.icon,
        scale = 0.5,
        shift = {16, 16}
      }
    },
  }

  data:extend({recipe})

  local tech = data.raw.technology["domestication"]
  if not tech then
    error("Domestication technology not found")
  end
  table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = recipe.name
  })
end

create_feeding_recipe("hay", 1)
create_feeding_recipe("wheat-grass", 3)