local vanilla_blood_fountain = data.raw["particle-source"]["blood-fountain-hit-spray"]
local blood_fountain = table.deepcopy(vanilla_blood_fountain)
blood_fountain.particle = "red-blood-particle"
blood_fountain.name = "red-blood-fountain"

local vanilla_blood_particle = data.raw["optimized-particle"]["blood-particle"]
local blood_particle = table.deepcopy(vanilla_blood_particle)
blood_particle.name = "red-blood-particle"
blood_particle.pictures.sheet.tint = {r = 0.6, g = 0, b = 0}

local vanilla_explosion = data.raw["explosion"]["enemy-damaged-explosion"]
local damage_explosion = table.deepcopy(vanilla_explosion)
damage_explosion.name = "red-blood-explosion"
damage_explosion.created_effect.action_delivery.target_effects[1].entity_name = "red-blood-fountain"

data:extend({blood_fountain, blood_particle, damage_explosion })