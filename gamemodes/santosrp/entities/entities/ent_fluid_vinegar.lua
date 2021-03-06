
-----------------------------------------------------
--[[
	Name: init.lua
	For: SantosRP
	By: Ultra 
]]--

if SERVER then
	AddCSLuaFile()
end

ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Base = "ent_base_fluid"

function ENT:ConfigInit()
	if SERVER then
		self:SetModel( "models/props_junk/glassjug01.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:PhysWake()

		self:SetFluidID( "Vinegar" )
		self:SetEffect( "waterFx", Vector(-0.088151, -0.650788, 8.061775) )
		self:SetCarryAngles( Angle(0, 180, 0), Angle(80, 180, 0) )
	end
	
	if CLIENT then self:SetPourSound( "ambient/water/leak_1.wav" ) end
end