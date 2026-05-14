---@diagnostic disable-next-line: duplicate-doc-alias
---@alias unit_number integer
---@alias force_id uint

local AurochsAI = {
  events = {}
}

---@class AurochData
---@field unit_number unit_number The unit number of the auroch entity
---@field entity LuaEntity The auroch entity
---@field state AurochState
---@field target_food LuaEntity?
---@field target_food_force force_id?
---@field attack_proxy LuaEntity? The proxy entity used for attacking food, if any
---@field last_eaten int? The tick at which the auroch last ate food, used for hunger cooldown
---@field domestication table<force_id, integer> A measure of how domesticated the auroch is. After reaching a certain threshold, the auroch stops being wild and becomes minable.

local hunger_timeout = 1 * 60 -- ticks after which an auroch can be fed again

---@enum AurochState
local AurochState = {
  Idle = 0,
  FoodSpotted = 1,
  GotoFood = 2,
  Eating = 3,
}

script.on_init(function()
  ---@type table<unit_number, AurochData>
  storage.aurochs = {}
end)

local auroch_food = {
  grass = true,
  hay = true,
  ["steel-plate"] = true -- DEBUG
}

local function create_attack_proxy(surface, position)
  local x = position.x or position[1]
  local y = position.y or position[2]
  y = y - 0.3
  local proxy = surface.create_entity{name = "aurochs-attack-proxy", position = {x = x, y = y}, force = "neutral"}
  return proxy
end


---@param event EventData.on_player_dropped_item
function AurochsAI.events.drop_event(event)
  local player = game.get_player(event.player_index)
  if not player then return end

  local dropped_entity = event.entity
  if not dropped_entity or not dropped_entity.valid then return end

  local stack = dropped_entity.stack
  if not stack or not stack.valid then return end

  local name = stack.name
  if not auroch_food[name] then return end

  game.print("Auroch food dropped: " .. name, {skip = defines.print_skip.never, sound = defines.print_sound.never})

  local surface = dropped_entity.surface
  local position = dropped_entity.position
  local aurochs = surface.find_entities_filtered{
    name = "wild-auroch",
    position = position,
    radius = 10
  }

  if #aurochs == 0 then return end

  local new_auroch = true

  ---@type LuaEntity?
  local auroch = nil
  for _, candidate in pairs(aurochs) do
    if candidate.valid then
      local auroch_data = storage.aurochs[candidate.unit_number]
      if auroch_data then
        if auroch_data.state == AurochState.Idle and (not auroch_data.last_eaten or game.tick - auroch_data.last_eaten > hunger_timeout) then
          auroch = candidate
          new_auroch = false
          break
        end
      else
        auroch = candidate
        break
      end
    end
  end

  if not auroch then return end

  local force = game.players[event.player_index].force.index
  if not force then error("Could not find player force of dropped food item") end

  if new_auroch then
    storage.aurochs[auroch.unit_number] = {
      unit_number = auroch.unit_number,
      state = AurochState.GotoFood,
      entity = auroch,
      target_food = dropped_entity,
      target_food_force = force,
      domestication = {}
    }
  else
    storage.aurochs[auroch.unit_number].state = AurochState.GotoFood
    storage.aurochs[auroch.unit_number].target_food = dropped_entity
    storage.aurochs[auroch.unit_number].target_food_force = force
  end

  auroch.commandable.set_command{
    ---@diagnostic disable-next-line: assign-type-mismatch
    type = defines.command.go_to_location,
    destination_entity = dropped_entity,
    radius = 0.2
  }
end

local function set_idle(auroch_data)
  game.print("Auroch " .. auroch_data.unit_number .. " is now idle", {skip = defines.print_skip.never, sound = defines.print_sound.never})
  auroch_data.state = AurochState.Idle
  auroch_data.entity.commandable.set_command{
    type = defines.command.wander
  }
end

local function cleanup_attack_proxy(auroch_data)
  if auroch_data.attack_proxy then
    if auroch_data.attack_proxy.valid then
      auroch_data.attack_proxy.destroy()
    end
    auroch_data.attack_proxy = nil
  end
end

local function cleanup_auroch(auroch_data)
  cleanup_attack_proxy(auroch_data)
  storage.aurochs[auroch_data.unit_number] = nil
end

---@param auroch_data AurochData
local function handle_domestication(auroch_data)
  game.print("Auroch " .. auroch_data.unit_number .. " has become domesticated!", {skip = defines.print_skip.never, sound = defines.print_sound.never})

  local auroch = auroch_data.entity
  if not auroch.valid then
    cleanup_auroch(auroch_data)
    game.print("But it seems to have died before we could fully domesticate it...", {skip = defines.print_skip.never, sound = defines.print_sound.never})
    return
  end

  local surface = auroch.surface
  local position = auroch.position
  local direction = auroch.direction
  auroch.destroy()

  local force_id = auroch_data.target_food_force
  local domesticated = surface.create_entity{name = "domesticated-auroch", position = position, direction = direction, force = force_id}
  local force = game.forces[force_id]
  if not force.technologies["domestication"].researched then
    force.script_trigger_research("domestication")
  end
end

local function handle_food_spotted_completed(auroch_data, event)
  game.print("Auroch " .. auroch_data.unit_number .. " completed food spotted command with result: " .. event.result, {skip = defines.print_skip.never, sound = defines.print_sound.never})
end

local function handle_goto_food_completed(auroch_data, event)
  game.print("Auroch " .. auroch_data.unit_number .. " completed goto food command with result: " .. event.result, {skip = defines.print_skip.never, sound = defines.print_sound.never})
  if event.result ~= defines.behavior_result.success then
    set_idle(auroch_data)
    return
  end

  local auroch = auroch_data.entity
  if not auroch.valid then
    cleanup_auroch(auroch_data)
    return
  end

  local attack_proxy = create_attack_proxy(auroch_data.target_food.surface, auroch_data.target_food.position)
  if not attack_proxy.valid then 
    set_idle(auroch_data)
    return
  end

  auroch_data.attack_proxy = attack_proxy
  auroch_data.entity.commandable.set_command{
    type = defines.command.attack,
    target = attack_proxy
  }
  auroch_data.state = AurochState.Eating
end

local function handle_eating_completed(auroch_data, event)
  game.print("Auroch " .. auroch_data.unit_number .. " completed eating command with result: " .. event.result, {skip = defines.print_skip.never, sound = defines.print_sound.never})
  if event.result ~= defines.behavior_result.success then
    set_idle(auroch_data)
    cleanup_attack_proxy(auroch_data)
    return
  end

  local auroch = auroch_data.entity
  if not auroch.valid then
    cleanup_auroch(auroch_data)
    return
  end

  cleanup_attack_proxy(auroch_data)
  local target_food = auroch_data.target_food
  if not target_food or not target_food.valid then
    set_idle(auroch_data)
    return
  end

  local stack_count = target_food.stack.count
  if stack_count > 1 then
    target_food.stack.count = stack_count - 1
  else
    target_food.destroy()
  end

  local force = auroch_data.target_food_force

  auroch_data.last_eaten = event.tick
  auroch_data.domestication[force] = (auroch_data.domestication[force] or 0) + 1
  if auroch_data.domestication[force] >= 5 then
    handle_domestication(auroch_data)
    return
  end
  game.print("Auroch " .. auroch_data.unit_number .. " has domestication level: " .. auroch_data.domestication[force], {skip = defines.print_skip.never, sound = defines.print_sound.never})
  set_idle(auroch_data)
end

---@param event EventData.on_ai_command_completed
function AurochsAI.events.ai_completed_event(event)
  local auroch_data = storage.aurochs[event.unit_number]
  if not auroch_data then
    game.print("Unrelated AI command completed: " .. event.result, {skip = defines.print_skip.never, sound = defines.print_sound.never})
    return
  end
  if auroch_data.state == AurochState.FoodSpotted then
    handle_food_spotted_completed(auroch_data, event)
  elseif auroch_data.state == AurochState.GotoFood then
    handle_goto_food_completed(auroch_data, event)
  elseif auroch_data.state == AurochState.Eating then
    handle_eating_completed(auroch_data, event)
  end
end

return AurochsAI