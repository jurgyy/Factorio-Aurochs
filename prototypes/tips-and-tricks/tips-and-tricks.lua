local tnt = {
  type = "tips-and-tricks-item",
  name = "aurochs-domestication",
  tag = "[item=wild-auroch]",
  category = "game-interaction",
  order = "p-aurochs-1",
  -- trigger =
  -- {
  --   type = "research",
  --   technology = "aurochs-domestication"
  -- },
  simulation = {
    mods = {"aurochs"},
    game_view_settings = {
      default_show_value = false,
      show_controller_gui = true,
      show_quickbar = true,
      update_entity_selection = true
    },
    init_file = "__aurochs__/prototypes/tips-and-tricks/tips-and-tricks-init.lua"
  }
}

data:extend {tnt}