
-----------------------------------------------------
--[[
	Name: fas2_attachment.lua
	For: SantosRP
	By: Rustic7
]]--

local Item = {}
Item.Name = "SG 552 30rnd Magazine"
Item.Desc = "SG 552 extended mag attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "sg55x30mag"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 20
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 5,
	["Metal Bar"] = 2,
	["Metal Bracket"] = 2,
	["Chunk of Plastic"] = 4,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "SKS 30rnd Magazine"
Item.Desc = "SKS extended mag attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "sks30mag"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 14
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 5,
	["Metal Bar"] = 2,
	["Metal Bracket"] = 4,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "ACOG 4x"
Item.Desc = "Acog attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "acog"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 23
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 5,
	["Metal Bar"] = 2,
	["Metal Pipe"] = 2,
	["Chunk of Plastic"] = 1,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "ELCAN C79"
Item.Desc = "C79 attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "c79"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 20
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 4,
	["Metal Bar"] = 2,
	["Metal Pipe"] = 2,
	["Chunk of Plastic"] = 1,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "CompM4"
Item.Desc = "Comp M4 attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "compm4"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 21
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 5,
	["Metal Bar"] = 2,
	["Metal Pipe"] = 2,
	["Chunk of Plastic"] = 1,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "EoTech 553"
Item.Desc = "EoTech attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "eotech"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 20
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 5,
	["Metal Bar"] = 2,
	["Metal Pipe"] = 2,
	["Chunk of Plastic"] = 1,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "Foregrip"
Item.Desc = "Foregrip attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "foregrip"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 23
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 5,
	["Metal Bar"] = 2,
	["Metal Pipe"] = 2,
	["Chunk of Plastic"] = 1,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "Harris Bipod"
Item.Desc = "Harris bipod attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "harrisbipod"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 25
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 5,
	["Metal Bar"] = 2,
	["Metal Pipe"] = 2,
	["Chunk of Plastic"] = 2,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "Leupold MK4"
Item.Desc = "Leopold MK4 attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "leupold"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 25
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 5,
	["Metal Bar"] = 2,
	["Metal Pipe"] = 2,
	["Chunk of Plastic"] = 2,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "PSO-1"
Item.Desc = "PSO-1 attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "pso1"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 20
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 5,
	["Metal Bar"] = 2,
	["Metal Pipe"] = 2,
	["Chunk of Plastic"] = 2,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "Suppressor"
Item.Desc = "Suppressor attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "suppressor"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 25
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 3,
	["Metal Bar"] = 2,
	["Metal Pipe"] = 2,
	["Chunk of Plastic"] = 2,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "Tritium Sights"
Item.Desc = "Tritium sights attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "tritiumsights"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 15
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 3,
	["Metal Bar"] = 2,
	["Metal Pipe"] = 2,
	["Chunk of Plastic"] = 2,
}
GM.Inv:RegisterItem( Item )

local Item = {}
Item.Name = "UZI Wooden Stock"
Item.Desc = "UZI wooden stock attachment."
Item.Model = "models/Items/BoxMRounds.mdl"
Item.Weight = 3
Item.Volume = 1
Item.CanDrop = true
Item.Illegal = true
Item.DropClass = "prop_physics_multiplayer"
Item.WeaponAttachENT = "uziwoodenstock"

Item.CraftingEntClass = "ent_gunsmithing_table"
Item.CraftSkill = "Gun Smithing"
Item.CraftSkillLevel = 17
Item.CraftSkillXP = 5
Item.CraftRecipe = {
	["Metal Plate"] = 3,
	["Metal Bar"] = 2,
	["Metal Pipe"] = 2,
	["Chunk of Plastic"] = 2,
}
GM.Inv:RegisterItem( Item )