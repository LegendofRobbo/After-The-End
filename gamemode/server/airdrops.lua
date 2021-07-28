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

local DropData = ""



function LoadAD()
if not file.IsDir("aftertheend/spawns/airdrops", "DATA") then
   file.CreateDir("aftertheend/spawns/airdrops")
end
	if file.Exists( "aftertheend/spawns/airdrops/" .. string.lower(game.GetMap()) .. ".txt", "DATA" ) then
		DropData = "" --reset it
		DropData = file.Read( "aftertheend/spawns/airdrops/" .. string.lower(game.GetMap()) .. ".txt", "DATA" )
		print( "Airdrop spawnpoints loaded" )
	else
		DropData = "" --just in case
		print( "No airdrop spawnpoints found for this map" )
	end
end
LoadAD()

function AddAD( ply, cmd, args )
	if !SuperAdminCheck( ply ) then 
		SystemMessage(ply, "Only superadmins can use this command!", Color(255,205,205,255), true)
		return
	end
	
	LoadAD() --reload them
	
	local tr = util.TraceLine( {
		start = ply:GetPos(),
		endpos = ply:GetPos() + Vector(0, 0, 90000),
		mask = MASK_SOLID_BRUSHONLY,
	} )
	if !tr.HitSky then SystemMessage(ply, "You can only place airdrop spawns in areas that are visible to the skybox!", Color(255,205,205,255), true) return end
	local hitp = tr.HitPos - Vector( 0, 0, 80 )

	if( DropData == "" ) then
		NewData = tostring( hitp ) .. ";" .. tostring( ply:GetAngles() )
	else
		NewData = DropData .. "\n" .. tostring( hitp ) .. ";" .. tostring( ply:GetAngles() )
	end
	
	file.Write( "aftertheend/spawns/airdrops/" .. string.lower(game.GetMap()) .. ".txt", NewData )
	
	SendChat( ply, "Added an airdrop spawnpoint" )
end
concommand.Add( "ate_addairdropspawn", AddAD )


function ClearAD( ply, cmd, args )
if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "Only superadmins can use this command!", Color(255,205,205,255), true)
	return
end

if file.Exists(	"aftertheend/spawns/airdrops/" .. string.lower(game.GetMap()) .. ".txt", "DATA") then
	file.Delete("aftertheend/spawns/airdrops/" .. string.lower(game.GetMap()) .. ".txt")
end
DropData = ""
SendChat( ply, "Deleted all airdrop spawnpoints" )
end
concommand.Add( "ate_clearairdropspawns", ClearAD )




function SpawnAirdrop()

if table.Count(player.GetAll()) < 3 then return end

RadioBroadcast(1, "Christmas has come early ladies!", "Shamus")
RadioBroadcast(4, "Got a little present for y'all to entertain yourselves with!", "Shamus")
RadioBroadcast(8, "Be careful survivors! That airdrop crate is fitted with an IFF jammer.", "Watchdog")
RadioBroadcast(12, "If you go near it you'll need to watch your back or risk being shot by other loot hunters!", "Watchdog")


timer.Simple(20, function()

local cratedropped = false

if  DropData == "" then return end

	local DropList = string.Explode( "\n", DropData )
	for k, v in RandomPairs( DropList ) do
		if cratedropped then break end
		local Booty = string.Explode( ";", v )
		local pos = util.StringToType( Booty[1], "Vector" )
		local ang = util.StringToType( Booty[2], "Angle" )

		local dropent = ents.Create( "airdrop_cache" )
		dropent:SetPos( pos )
		dropent:SetAngles( ang )
		local testinv = {
			["Junk"] = {math.random(0, 2), 1, 1},
			["Ammo"] = {math.random(1, 2), 1, 3},
			["Meds"] = {math.random(0, 1), 1, 3},
			["Food"] = {math.random(0, 2), 1, 3},
			["Sellables"] = {math.random(0, 1), 1, 2},
		}

		if math.random(1, 100) > 50 then
			testinv["TyrantWeapons"] = {1, 1, 1}
		else
			testinv["FactionWeapons"] = {1, 1, 1}
		end

		local loot = RollLootTable( testinv )
		MakeLootContainer( dropent, loot )

		dropent:Spawn()
		dropent:Activate()
		cratedropped = true
	end


for k, v in pairs(player.GetAll()) do v:EmitSound("ambient/overhead/hel1.wav") end

SystemBroadcast( "An air drop crate has appeared!", Color(255,255,255,255), false)

end)

end
timer.Create( "AirdropSpawnTimer", tonumber(Config[ "AirdropSpawnRate" ]), 0, SpawnAirdrop )





/*
-- derp, this isnt finished yet obviusly

function TestAirdrop( ply, cmd, args )

local vStart = ply:GetShootPos()
local vForward = ply:GetAimVector()
local trace = {}
trace.start = vStart
trace.endpos = vStart + (vForward * 5000)
trace.filter = ply
local tr = util.TraceLine( trace )
local dropent = ents.Create( "airdrop_cache" )
dropent:SetPos( tr.HitPos )
dropent:SetAngles( Angle( 0, 0, 0 ) )
dropent:Spawn()
dropent:Activate()

for k, v in pairs(player.GetAll()) do v:EmitSound("ambient/overhead/hel1.wav") end

local testinv = {
	["Junk"] = {math.random(0, 2), 1, 1},
	["Ammo"] = {math.random(1, 2), 1, 3},
	["Meds"] = {math.random(0, 1), 1, 3},
	["Food"] = {math.random(0, 2), 1, 3},
	["Sellables"] = {math.random(0, 1), 1, 2},
--	["NoobWeapons"] = {1, 1, 1},
}

if math.random(1, 100) > 50 then
	testinv["TyrantWeapons"] = {1, 1, 1}
else
	testinv["FactionWeapons"] = {1, 1, 1}
end

local loot = RollLootTable( testinv )
MakeLootContainer( dropent, loot )

SystemBroadcast( "An air drop crate has appeared!", Color(255,255,255,255), false)

undo.Create("Test Cache")
undo.AddEntity( dropent )
undo.SetPlayer( ply )
undo.Finish()

end
--concommand.Add( "testairdrop", TestAirdrop )
-- this is disabled for now
*/