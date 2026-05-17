---@type data.BurnerUsagePrototype
local burner_usage = {
  type = "burner-usage",
  name = "auroch-food",
  accepted_fuel_key = "description.accepted-food",
  burned_in_key = "digested-by",
  empty_slot_caption = {"gui.food"},
  empty_slot_description = {"gui.food-description"},
  no_fuel_status = {"message.aurochs-hunger-warning"},
  icon = {
    filename = "__core__/graphics/icons/alerts/food-icon-red.png",
    flags = {"icon"},
    size = 64
  },
  empty_slot_sprite = {
    filename = "__core__/graphics/icons/mip/empty-food-slot.png",
    flags = {"gui-icon"},
    mipmap_count = 2,
    size = 64
  }
}
data:extend({burner_usage})