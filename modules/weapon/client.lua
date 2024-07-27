if not lib then return end

local Weapon = {}
local Items = require 'modules.items.client'
local Utils = require 'modules.utils.client'

-- generic group animation data
local anims = {}
anims[`GROUP_MELEE`] = { 'melee@holster', 'unholster', 200, 'melee@holster', 'holster', 600 }
anims[`GROUP_PISTOL`] = { 'reaction@intimidation@cop@unarmed', 'intro', 400, 'reaction@intimidation@cop@unarmed', 'outro', 450 }
anims[`GROUP_STUNGUN`] = anims[`GROUP_PISTOL`]

local function vehicleIsCycle(vehicle)
	local class = GetVehicleClass(vehicle)
	return class == 8 or class == 13
end



return Weapon
