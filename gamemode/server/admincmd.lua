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


function AdminGive( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "Only superadmins can use this command!", Color(255,205,205,255), true)
	return
end

local name = args[1]
local addqty = args[2] or 1
local item = ItemsList[name]
if !item then SystemMessage(ply, "This item does not exist!", Color(255,205,205,255), true) return false end

if (CalculateWeight(ply) + item.Weight) > (40 + ((ply.StatStrength or 0) * 2)) then SendChat(ply, "You don't have any inventory space left for this item!") return false end

SystemGiveItem( ply, name, addqty )

SystemMessage(ply, "You gave yourself "..addqty.."x "..item["Name"], Color(155,255,155,255), true)
FullyUpdatePlayer( ply )
ply:ConCommand( "play buttons/button24.wav" )
end
concommand.Add("ate_admin_giveitem", AdminGive)

function AdminGiveCash( ply, cmd, args )
if !ply:IsValid() then return false end

if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "Only superadmins can use this command!", Color(255,205,205,255), true)
	return
end

local addqty = args[1] or 1

ply.Money = ply.Money + addqty
SystemMessage(ply, "You gave yourself "..addqty.." "..Config[ "Currency" ].."s!", Color(155,255,155,255), true)

FullyUpdatePlayer( ply )
ply:ConCommand( "play buttons/button24.wav" )
end
concommand.Add("ate_admin_givecash", AdminGiveCash)

/*
function AdminClearProps( ply, cmd, args )
if !ply:IsValid() then return false end

if ( !ply:IsUserGroup("superadmin") or !ply:IsSuperAdmin()) or ( !ply:IsUserGroup("admin") or !ply:IsAdmin()) then 
	SystemMessage(ply, "Only admins can use this command!", Color(255,205,205,255), true)
	return
end

	for k, v in pairs( ents.FindByClass( "prop_flimsy" ) ) do
		v.Remove()
	end

	for k, v in pairs( ents.FindByClass( "prop_strong" ) ) do
		v.Remove()
	end


end
concommand.Add("ate_admin_cleanup", AdminClearProps)
*/


function AdminClearZeds( ply, cmd, args )
if !ply:IsValid() then return false end

if !AdminCheck( ply ) then 
	SystemMessage(ply, "Only admins can use this command!", Color(255,205,205,255), true)
	return
end

	if args[1] == "force" then
		-- force remove all nextbots and npcs
		for k, v in pairs( ents.GetAll() ) do
			if v.Type == "nextbot" or ( v:IsNPC() and v:GetClass() != "trader" ) then v.LastAttacker = nil v:Remove() end
		end

	else

	for k, v in pairs(Config[ "ZombieClasses" ]) do
		for _, ent in pairs(ents.FindByClass(k)) do ent.LastAttacker = nil ent:Remove() end
	end

	end


end
concommand.Add("ate_admin_clearzombies", AdminClearZeds)