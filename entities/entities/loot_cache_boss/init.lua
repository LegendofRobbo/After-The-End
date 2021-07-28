AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when the SENT is spawned
function ENT:Initialize()
	self.Entity:SetModel( "models/props/de_prodigy/ammo_can_02.mdl" )
 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
 	self.Entity:SetColor( Color(255, 255, 255, 255) )
	self.Entity:SetUseType( SIMPLE_USE )
	
	local PhysAwake = self.Entity:GetPhysicsObject()
	if ( PhysAwake:IsValid() ) then
		PhysAwake:Wake()
	end 
end

function ENT:SpawnFunction( userid, tr )
end

function ENT:Use( activator, caller )
if !caller:IsValid() or !caller:IsPlayer() or !self.LootType or !caller:Alive() then self:Remove() return false end
	local name = self.LootType
	local item = ItemsList[name]

	local weightcheck = LootTableBoss[name]["Weight"]
	local qtycheck = LootTableBoss[name]["Qty"]

	if !name or !item or !weightcheck or !qtycheck then SendChat(caller, "Sorry, this loot cache was bugged and was auto removed to avoid breaking the game, please tell an admin or developer") return false end

	if !item then return false end
	if (CalculateWeight(caller) + weightcheck) > (40 + ((caller.StatStrength or 0) * 2)) then SendChat(caller, "You don't have enough space for this item! It weighs: "..weightcheck.."kg") return false end

	SystemGiveItem( caller, name, qtycheck )

	SendChat(caller, "You picked up a boss drop cache containing [ "..LootTableBoss[name]["Name"].." ]")
	SystemBroadcast( caller:Nick().." has found a boss cache!", Color(255,255,255,255), true)
	SendInventory( caller )
	caller:EmitSound("items/ammopickup.wav", 100, 100)
	self:Remove()
end