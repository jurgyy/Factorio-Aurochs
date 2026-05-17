local empty_rotated_animation = {
  filename = "__base__/graphics/icons/water-wube.png",
  width = 1,
  height= 1,
  direction_count = 1,
  animation_speed = 1
}

local empty_attack_parameters = {
  type = "projectile",
  ammo_category = "bullet",
  cooldown = 1,
  range = 0,
  ammo_type =
  {
    target_type = "entity",
  },
  animation = empty_rotated_animation
}

local attack_proxy =
{
  type = "unit",
  name = "aurochs-attack-proxy",
  icon = "__base__/graphics/icons/water-wube.png",
  icon_size = 32,
  flags = {"placeable-neutral", "placeable-off-grid", "not-on-map", "not-in-kill-statistics", "not-repairable"},
  order = "zzzzzz",
  max_health = 1,
  collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
  collision_mask = {colliding_with_tiles_only = true, layers = {}},
  --selection_box = nil,
  selection_box = {{-0.3, -0.3}, {0.3, 0.3}},
  attack_parameters = empty_attack_parameters,
  movement_speed = 0,
  distance_per_frame = 0,
  --pollution_to_join_attack = 0,
  distraction_cooldown = 0,
  vision_distance = 0,
  hidden = true,
  --run_animation = empty_rotated_animation(),
  run_animation =
  {
    filename = "__base__/graphics/entity/steel-chest/steel-chest.png",
    scale = 0.125,
    width = 64,
    height = 80,
    tint = {r=0.50, g = 0.25, b = 0.25, a = 0.6}
  }
}

-- local resource_spec = shared.resources.spec[resource.name]
-- local damaged_trigger =
-- {
--   shared.sound_enabled and resource_spec and shared.resources.sound_triggers[resource_spec.resource_type] or nil
-- }

-- local particle = resource.minable.mining_particle
-- if particle then
--   table.insert(damaged_trigger,
--   {
--     type = "create-particle",
--     repeat_count = 3,
--     particle_name = particle,
--     initial_height = 0,
--     speed_from_center = 0.025,
--     speed_from_center_deviation = 0.025,
--     initial_vertical_speed = 0.025,
--     initial_vertical_speed_deviation = 0.025,
--     offset_deviation = resource.selection_box
--   })
--   attack_proxy.dying_trigger_effect =
--   {
--     type = "create-particle",
--     repeat_count = 5,
--     particle_name = particle,
--     initial_height = 0,
--     speed_from_center = 0.045,
--     speed_from_center_deviation = 0.035,
--     initial_vertical_speed = 0.045,
--     initial_vertical_speed_deviation = 0.035,
--     offset_deviation = resource.selection_box
--   }
-- end

-- if next(damaged_trigger) then
--   attack_proxy.damaged_trigger_effect = damaged_trigger
-- end

data:extend{attack_proxy}
