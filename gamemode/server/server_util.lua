/*-------------------------------------------------------------------------------------------------

 ▄▄▄        █████▒▄▄▄█████▓▓█████  ██▀███     ▄▄▄█████▓ ██░ ██ ▓█████    ▓█████  ███▄    █ ▓█████▄ 
▒████▄    ▓██   ▒ ▓  ██▒ ▓▒▓█   ▀ ▓██ ▒ ██▒   ▓  ██▒ ▓▒▓██░ ██▒▓█   ▀    ▓█   ▀  ██ ▀█   █ ▒██▀ ██▌
▒██  ▀█▄  ▒████ ░ ▒ ▓██░ ▒░▒███   ▓██ ░▄█ ▒   ▒ ▓██░ ▒░▒██▀▀██░▒███      ▒███   ▓██  ▀█ ██▒░██   █▌
░██▄▄▄▄██ ░▓█▒  ░ ░ ▓██▓ ░ ▒▓█  ▄ ▒██▀▀█▄     ░ ▓██▓ ░ ░▓█ ░██ ▒▓█  ▄    ▒▓█  ▄ ▓██▒  ▐▌██▒░▓█▄   ▌
 ▓█   ▓██▒░▒█░      ▒██▒ ░ ░▒████▒░██▓ ▒██▒     ▒██▒ ░ ░▓█▒░██▓░▒████▒   ░▒████▒▒██░   ▓██░░▒████▓ 
 ▒▒   ▓▒█░ ▒ ░      ▒ ░░   ░░ ▒░ ░░ ▒▓ ░▒▓░     ▒ ░░    ▒ ░░▒░▒░░ ▒░ ░   ░░ ▒░ ░░ ▒░   ▒ ▒  ▒▒▓  ▒ 
  ▒   ▒▒ ░ ░          ░     ░ ░  ░  ░▒ ░ ▒░       ░     ▒ ░▒░ ░ ░ ░  ░    ░ ░  ░░ ░░   ░ ▒░ ░ ▒  ▒ 
  ░   ▒    ░ ░      ░         ░     ░░   ░      ░       ░  ░░ ░   ░         ░      ░   ░ ░  ░ ░  ░ 
      ░  ░                    ░  ░   ░                  ░  ░  ░   ░  ░      ░  ░         ░    ░    
                                                                                            ░      


An apocalyptic RPG gamemode created by LegendofRobbo
Based on the ideas and concepts explored in Zombified World by Fizzadar and Chewgum

-------------------------------------------------------------------------------------------------*/


function GM:PlayerUse(ply, entity)
	if not entity then return end
	if not entity:IsValid() then return end
	return true
end

function Damagemods( target, dmginfo )
local attacker, inflictor, dmg = dmginfo:GetAttacker(), dmginfo:GetInflictor(), dmginfo:GetDamage()

	if target:GetClass() == "prop_physics" and target.maxhealth then
		target:SetHealth( target:Health() - dmginfo:GetDamage() )
		local ColorAmount =  ( ( target:Health() / target.maxhealth ) * 255 )
		target:SetColor( Color(ColorAmount, ColorAmount, ColorAmount, 255) )
		if target:Health() <= 0 then
			target:GibBreakClient(Vector(math.random(-50, 50),math.random(-50, 50),math.random(-50, 50)))
			target:Remove()
		end
	end

	if target:IsPlayer() and attacker:IsPlayer() and target != attacker and !target:IsPvPForced() and target.Territory != team.GetName(attacker:Team()) and Config[ "VoluntaryPVP" ] == true then

		if attacker:Team() == 1 and attacker:GetNWBool("pvp") == false then
			SystemMessage(attacker, "Your PvP is not enabled!", Color(255,205,205,255), true)
			dmginfo:SetDamage( 0 )
			return false

		elseif target:Team() == 1 and target:GetNWBool("pvp") == false then
			SystemMessage(attacker, "You can't attack loners unless they have PvP enabled!", Color(255,205,205,255), true)
			dmginfo:SetDamage( 0 )
			return false
		
		elseif (target:Team() == attacker:Team()) and not (target:Team() == 1 or attacker:Team() == 1) then
			SystemMessage(attacker, "You can't attack your team mates!", Color(255,205,205,255), true)
			dmginfo:SetDamage( 0 )
			return false
		end


		if timer.Exists("pvpnominge_"..target:UniqueID()) then timer.Destroy("pvpnominge_"..target:UniqueID()) end

		timer.Create( "pvpnominge_"..target:UniqueID(), 60, 1, function() -- this timer actually does nothing, its only purpose is to be checked if it exists
			if !target:IsValid() then return false end
			timer.Destroy("pvpnominge_"..target:UniqueID())
		end )



		if timer.Exists("pvpnominge_"..attacker:UniqueID()) then timer.Destroy("pvpnominge_"..attacker:UniqueID()) end

		timer.Create( "pvpnominge_"..attacker:UniqueID(), 60, 1, function() -- this timer actually does nothing, its only purpose is to be checked if it exists
			if !attacker:IsValid() then return false end
			timer.Destroy("pvpnominge_"..attacker:UniqueID())
		end )



	end

	if dmginfo:GetDamageType() == DMG_CRUSH and target:IsPlayer() then
	dmginfo:SetDamage(0)
	dmginfo:ScaleDamage( 0 )
	end

	if dmginfo:GetDamageType() == DMG_BLAST and target.Type == "nextbot" or target:IsNPC() then
	dmginfo:ScaleDamage( 1.5 )
	end


end
hook.Add( "EntityTakeDamage", "damagemodshook", Damagemods )

function GM:ScalePlayerDamage( ply, group, dmginfo )
	local armorvalue = 0
	local plyarmor = ply:GetNWString("ArmorType")

	if plyarmor and plyarmor != "none" then
	local armortype = ItemsList[plyarmor]
	armorvalue = tonumber((armortype["ArmorStats"]["reduction"]) / 100)
	end

	local attacker = dmginfo:GetAttacker()

	local defencebonus = dmginfo:GetDamage() * (0.025 * ply.StatDefense)--taken from damage
	local armorbonus = dmginfo:GetDamage() * armorvalue
	local attackbonus = dmginfo:GetDamage() * (0.025 * attacker.StatDamage) --added to damage
	
	local TheTotalDamage = dmginfo:GetDamage() + attackbonus - (defencebonus + armorbonus)
	
	if group == HITGROUP_HEAD then
		dmginfo:SetDamage( 2 * TheTotalDamage )
	elseif group == HITGROUP_CHEST then
		dmginfo:SetDamage( TheTotalDamage )
	elseif group == HITGROUP_STOMACH then
		dmginfo:SetDamage( 0.8 * TheTotalDamage )
	else
		dmginfo:SetDamage( 0.5 * TheTotalDamage )
	end

	-- the other half of this logic is within the actual trader entity, should stop queerbaits from trader camping with pvp on
	if ply:IsPvPGuarded() or attacker:IsPvPGuarded() then
		dmginfo:SetDamage( 0 )
	end

	/*
	for _, ent in pairs (ents.FindByClass("trader")) do
		if attacker:IsPlayer() and (ent:GetPos():Distance(ply:GetPos()) < 120 or ent:GetPos():Distance(attacker:GetPos()) < 120) then
			dmginfo:SetDamage( 0 )
		end
	end
	*/

	return dmginfo 
end


function GM:PlayerDeathThink( ply )

	if ply.RespawnTime and ply.RespawnTime < CurTime() then 
		if ( ply:KeyPressed( IN_ATTACK ) || ply:KeyPressed( IN_ATTACK2 ) || ply:KeyPressed( IN_JUMP ) ) then
			ply:Spawn()
		end
	end
	
end

function GM:DoPlayerDeath( ply, attacker, dmginfo )
	if( ply:GetActiveWeapon():GetClass() != "gmod_tool" and ply:GetActiveWeapon():GetClass() != "weapon_physgun" and ply:GetActiveWeapon():GetClass() != "ate_fists" and ply:GetActiveWeapon():GetClass() != "ate_buildtool") then
		local weapon_name = ply:GetActiveWeapon():GetClass()
		
		if ItemsList[weapon_name] and ply.Inventory[weapon_name] then

			SystemRemoveItem( ply, weapon_name )

			local EntDrop = ents.Create( "ate_droppeditem" )
			EntDrop:SetPos( ply:GetPos() + Vector(0, 0, 60) )
			EntDrop:SetAngles( Angle( 0, 0, 0 ) )
			EntDrop:SetModel(ItemsList[weapon_name]["Model"])
			EntDrop:SetNWString("ItemClass", weapon_name)
			EntDrop:Spawn()
			EntDrop:Activate()
			EntDrop:SetVelocity(ply:GetForward() * 80 + Vector(0,0,50))
			SendInventory( ply )
		end
	end
	
	ply.RespawnTime = CurTime() + 10

	if ply.Bounty >= 50 then
	local cashloss = ply.Bounty * 0.5

	local EntDrop = ents.Create( "ate_cash" )
		EntDrop:SetPos( ply:GetPos() + Vector(0, 0, 10))
		EntDrop:SetAngles( Angle( 0, 0, 0 ) )
		EntDrop:SetNWInt("CashAmount", math.floor(cashloss))
		EntDrop:Spawn()
		EntDrop:Activate()

	SystemMessage(ply, "You died and dropped 50% of your bounty pool! The rest has been lost forever! Remember to cash your bounty in at the traders regularly", Color(255,255,205,255), false)
	end

	ply.Bounty = 0

--	ply.Autorespawntime = CurTime() + 20
	
	ply:Flashlight( false )
	ply:Freeze( false )
	
	ply:CreateRagdoll()
	
	ply:AddDeaths( 1 )

	if attacker:IsPlayer() and attacker != ply then
		attacker:AddFrags( 1 ) 


	end
end
	
function GM:PlayerTraceAttack( ply, dmginfo, dir, trace )

	local attacker = dmginfo:GetAttacker()
	
	if !attacker:IsValid() or attacker == ply then
		return
	end
	
	util.Decal( "Blood", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal )

	return self.BaseClass:PlayerTraceAttack( ply, dmginfo, dir, trace )
end

function FormatSteamID( SteamID )

	local SteamID = SteamID, "STEAM_0:0:0"

	str = string.gsub( SteamID,"STEAM","" )
	str = string.gsub( str,":","" )
	str = string.gsub( str,"_","" )
	
	return str
	
end