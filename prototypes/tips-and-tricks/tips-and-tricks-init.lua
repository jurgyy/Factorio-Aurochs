---@diagnostic disable: undefined-global
require("__core__/lualib/story")

---@diagnostic disable-next-line: unknown-cast-variable
---@cast game LuaGameScript
---@diagnostic disable-next-line: unknown-cast-variable
---@cast story_elapsed_check fun(seconds: number): fun(): boolean

game.simulation.active_quickbars = 1
local player = game.simulation.create_test_player{name = "Jurgy"}
player.character.teleport{6, 0}
player.force.research_all_technologies()

game.simulation.camera_player = player
game.simulation.camera_position = {0, 0.5}
game.simulation.camera_player_cursor_position = player.position
player.set_quick_bar_slot(1, "wheat-grass")

local surface = game.surfaces[1]

surface.create_entity{
  name = "wild-auroch",
  position = {-3, 0},
  force = "neutral"
}

local story_table =
{
  {
    {
      name = "start",
      init = function() end,
      condition = story_elapsed_check(0),
      action = function()
        player.insert({name="wheat-grass", count=5})
      end
    },
    {
      condition = function()
        local target = game.simulation.get_widget_position({type = "quickbar-slot", data = "wheat-grass"})
        if not target then error("Could not find quickbar slot for wheat-grass") end
        return game.simulation.move_cursor({position = target})
      end
    },
    {
      condition = story_elapsed_check(0.25),
      action = function()
        game.simulation.control_press{control = "pipette", notify = false}
      end
    },
    { condition = function() return game.simulation.move_cursor({position = {0, 0}}) end},
    { condition = story_elapsed_check(0.25) },
    {
      init = function() game.simulation.control_down{control = "drop-cursor", notify = true} end,
      condition = story_elapsed_check(0.25),
      action = function()
        game.simulation.control_up{control = "drop-cursor"}
      end
    },
    {
      condition = function() return game.simulation.move_cursor({position = {0, 20}}) end,
    },
    -- {
    --   condition = story_elapsed_check(0.5),
    --   action = function()
    --     game.simulation.control_press{control = "pipette", notify = true}
    --   end
    -- },
    -- { condition = story_elapsed_check(0.25) },
    -- { condition = function() return game.simulation.move_cursor({position = {-5, -3}}) end},
    -- {
    --   init = function() game.simulation.control_down{control = "build", notify = true} end,
    --   condition = function() return game.simulation.move_cursor({position = {4, -3}}) end,
    -- },
    -- {
    --   condition = story_elapsed_check(0.25),
    --   action = function()
    --     game.simulation.control_press{control = "rotate", notify = false}
    --     game.simulation.control_press{control = "rotate", notify = false}
    --     player.clear_cursor()
    --     if not fuel then
    --       story_jump_to(storage.story, "after-fuel")
    --     end
    --   end
    -- },
    -- {
    --   condition = function()
    --     local target = game.simulation.get_widget_position({type = "quickbar-slot", data = fuel})
    --     ---@cast target -?
    --     return game.simulation.move_cursor({position = target})
    --   end
    -- },
    -- {
    --   condition = story_elapsed_check(0.25),
    --   action = function()
    --     game.simulation.control_press{control = "pipette", notify = false}
    --   end
    -- },
    -- { condition = function() return game.simulation.move_cursor({position = {4.5, 0.5}}) end},
    -- {
    --   init = function() game.simulation.control_down{control = "inventory-transfer", notify = true} end,
    --   condition = function()
    --     return game.simulation.move_cursor({position = {-4.5, 0.5}})
    --   end,
    --   action = function()
    --     game.simulation.control_up{control = "inventory-transfer", notify = true}
    --     player.clear_cursor()
    --   end
    -- },
    -- {
    --   name = "after-fuel",
    --   condition = function()
    --     local target = game.simulation.get_widget_position({type = "quickbar-slot", data = "transport-belt"})
    --     ---@cast target -?
    --     return game.simulation.move_cursor({position = target})
    --   end
    -- },
    -- {
    --   condition = story_elapsed_check(0.25),
    --   action = function()
    --     game.simulation.control_press{control = "pipette", notify = false}
    --   end
    -- },
    -- {
    --   condition = story_elapsed_check(0.25),
    --   action = function()
    --     game.simulation.control_press{control = "rotate", notify = false}
    --   end
    -- },
    -- { condition = function() return game.simulation.move_cursor({position = {-4.5, 3.5}}) end},
    -- {
    --   init = function() game.simulation.control_down{control = "build", notify = true} end,
    --   condition = function() return game.simulation.move_cursor({position = {6.5, 3.5}}) end,
    --   action = function() game.simulation.control_press{control = "build", notify = false} end
    -- },
    -- {
    --   condition = story_elapsed_check(0.25),
    --   action = function()
    --     game.simulation.control_press{control = "reverse-rotate", notify = false}
    --     action = player.clear_cursor()
    --   end
    -- },
    -- { condition = function() return game.simulation.move_cursor({position = {0, 4}}) end},
    -- {
    --   condition = story_elapsed_check(3),
    --   action = function()
    --     surface.build_checkerboard{left_top = {x = -6, y = -4}, right_bottom = {x = 5, y = -1}}
    --     player.character.clear_items_inside()
    --     for _, entity in pairs (surface.find_entities_filtered{area = {{-5.5, -3.5}, {5.5, 4.5}}}) do
    --       if entity.name ~= "character" then
    --         entity.destroy{raise_destroy = true}
    --       end
    --     end

    --     remote.call("canal-excavator", "reset")
    --     story_jump_to(storage.story, "start")
    --   end
    -- }
  }
}
tip_story_init(story_table)