AddCSLuaFile()

ENT.Base = "npc_ate_basic"
ENT.PrintName = "Zombie Lord"
ENT.Category = ""
ENT.Author = "LegendofRobbo"
ENT.Spawnable = true
ENT.AdminOnly = true


function ENT:SetUpStats()

-- dont bother changing any of this unless you like derpy shit
self.CanScream = true
self.RageLevel = 1
self.SpeedBuff = 1
self.Ouchies = 0

-- animations for the StartActivity function
self.AttackAnim = (ACT_MELEE_ATTACK_SWING)
self.WalkAnim = (ACT_WALK)
self.RunAnim = (ACT_WALK)
self.FlinchAnim = (ACT_FLINCH_PHYSICS)
self.FallAnim = (ACT_IDLE_ON_FIRE)


self.ZombieStats = {
["Model"] = "models/undead/undead.mdl",

["Damage"] = 50, -- how much damage per strike?
["Force"] = 500, -- how far to knock the player back upon striking them
["Infection"] = 0, -- percentage chance to infect them
["Reach"] = 80, -- how far can the zombies attack reach? in source units
["StrikeDelay"] = 0.6, -- how long does it take for the zombie to deal damage after beginning an attack
["AfterStrikeDelay"] = 1.2, -- how long should the zombie wait after a strike lands until reverting to its behaviour cycle

["Health"] = 800, -- self explanatory
["MoveSpeedWalk"] = 65, -- zombies move speed when idly wandering around
["MoveSpeedRun"] = 90, -- zombies move speed when moving towards a target
["VisionRange"] = 1200, -- how far is the zombies standard sight range in source units, this will be tripled when they are frenzied
["LoseTargetRange"] = 1500, -- how far must the target be from the zombie before it will lose interest and revert to wandering, this will be tripled when the zombie is frenzied

["Ability1"] = true,
["Ability1Range"] = 800,
["Ability1Cooldown"] = 25,
["Ability1TrigDelay"] = 0,

}


self.AttackSounds = {"npc/ichthyosaur/attack_growl1.wav",
"npc/ichthyosaur/attack_growl2.wav",  
}

self.AlertSounds = {"npc/antlion_guard/angry1.wav", "npc/antlion_guard/angry2.wav", "npc/antlion_guard/angry3.wav"}

self.IdleSounds = {
"npc/antlion_guard/frustrated_growl1.wav",
"npc/antlion_guard/frustrated_growl2.wav",
"npc/antlion_guard/frustrated_growl3.wav",
}

self.PainSounds = {"npc/stalker/stalker_pain1.wav",
"npc/stalker/stalker_pain2.wav", 
"npc/stalker/stalker_pain3.wav", 
}

self.DieSounds = {"npc/zombie/zombie_die1.wav",
"npc/zombie/zombie_die2.wav", 
"npc/zombie/zombie_die3.wav"
}

self.DoorBreak = Sound("npc/zombie/zombie_pound_door.wav")

self.Hit = Sound("npc/zombie/zombie_hit.wav")
self.Miss = Sound("npc/zombie/claw_miss1.wav")

self.Ability1CD = CurTime()

end


function ENT:SpecialSkill1()
if !self:IsValid() then return false end

local effectdata = EffectData()
effectdata:SetOrigin(self:GetPos() + Vector(0, 0, 60))
util.Effect("zw_master_pulse", effectdata)
self:EmitSound("ambient/machines/thumper_hit.wav", 120, 70)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 2000)) do
		if (self != v and v.Type == "nextbot") then
			v.RageLevel = 3
			v.SpeedBuff = 1.3
			local effectdata = EffectData()
			effectdata:SetOrigin(v:GetPos() + Vector(0, 0, 60))
			util.Effect("zw_master_strike", effectdata)
		end
	end

return true
end


function ENT:ApplyPlayerDamage(ply, damage, hitforce, infection)
local damageInfo = DamageInfo()
local dmg1 = damage

local armorvalue = 0
local plyarmor = ply:GetNWString("ArmorType")

if plyarmor and plyarmor != "none" then
local armortype = ItemsList[plyarmor]
armorvalue = tonumber((armortype["ArmorStats"]["reduction"]) / 100)
end

local armorbonus = dmg1 * armorvalue
local defencebonus = dmg1 * (0.025 * ply.StatDefense)

local dmg2 = dmg1 - (defencebonus + armorbonus)

damageInfo:SetAttacker(self)
damageInfo:SetDamage(dmg2)
damageInfo:SetDamageType(DMG_CLUB)

local force = ply:GetAimVector() * hitforce
force.z = 300
damageInfo:SetDamageForce(force)

self:EmitSound("ambient/energy/zap9.wav", 100, 80)
local effectdata = EffectData()
effectdata:SetOrigin(self:GetPos() + Vector(0, 0, 60))
util.Effect("zw_master_strike", effectdata)

ply:TakeDamageInfo(damageInfo)
--ply:EmitSound(self.Hit, 100, math.random(80, 110))
ply:ViewPunch(VectorRand():Angle() * 0.05)
ply:SetVelocity(force)
if math.random(0, 100) > (100 - infection) then
	ply.Infection = ply.Infection + 100
end
end


function ENT:OnInjured(damageInfo)
	local attacker = damageInfo:GetAttacker()
	local range = self:GetRangeTo(attacker)
	local dmg = damageInfo:GetDamage()

	self.Ouchies = (self.Ouchies or 0) + dmg

	self:EmitSound(table.Random(self.PainSounds), 100, math.random(90, 110))
	if attacker:IsPlayer() then
	self.target = attacker
	end
	if self.Ouchies > 100 then
	self:Teleport()
	self.Ouchies = 0
	end

	self.RageLevel = 3
end

function ENT:Teleport()
		local pos = self:GetPos() + Vector(math.random(-250,250), math.random(-250,250), 100)
		if !util.IsInWorld(pos) then timer.Simple(0.1, function() self:Teleport() end) return false end

		self:SetPos(pos)
		self:DropToFloor()
end