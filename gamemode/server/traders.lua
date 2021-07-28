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


TradersData = ""

function LoadTraders()
if not file.IsDir("aftertheend/spawns/traders", "DATA") then
   file.CreateDir("aftertheend/spawns/traders")
end
	if file.Exists( "aftertheend/spawns/traders/" .. string.lower(game.GetMap()) .. ".txt", "DATA" ) then
		TradersData = ""
		TradersData = file.Read( "aftertheend/spawns/traders/" .. string.lower(game.GetMap()) .. ".txt", "DATA" )
		print( "Traders file loaded" )
	else
		TradersData = ""
		print( "No traders file for this map" )
	end
end
LoadTraders()

function SpawnTraders()
	if( TradersData != "" ) then
		local targets = ents.FindByClass( "trader" )
		for k, v in pairs( targets ) do
			v:Remove()
		end
		local TradersList = string.Explode( "\n", TradersData )
		for k, v in pairs( TradersList ) do
			Trader = string.Explode( ";", v )
			local pos = util.StringToType( Trader[1], "Vector" )
			local ang = util.StringToType( Trader[2], "Angle" )
			local EntDrop = ents.Create( "trader" )
			EntDrop:SetPos( pos )
			EntDrop:SetAngles( ang )
			EntDrop:SetNetworkedString( "Owner", "World" )
			EntDrop:Spawn()
			EntDrop:Activate()
		end
	end
end
timer.Simple(1, function() SpawnTraders() end) --spawn them right away

function AddTrader( ply, cmd, args )
	if !SuperAdminCheck( ply ) then 
		SystemMessage(ply, "Only superadmins can use this command!", Color(255,205,205,255), true)
		return
	end
	
	LoadTraders() --reload them
	
	if( TradersData == "" ) then
		NewData = tostring( ply:GetPos() ) .. ";" .. tostring( ply:GetAngles() )
	else
		NewData = TradersData .. "\n" .. tostring( ply:GetPos() ) .. ";" .. tostring( ply:GetAngles() )
	end
	
	file.Write( "aftertheend/spawns/traders/" .. string.lower(game.GetMap()) .. ".txt", NewData )
	
	SendChat( ply, "Added a Trader Spawnpoint" )

	timer.Simple(1, function() SpawnTraders() end)
end
concommand.Add( "ate_addtrader", AddTrader )

function ClearTraders( ply, cmd, args )
if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "Only superadmins can use this command!", Color(255,205,205,255), true)
	return
end

if file.Exists(	"aftertheend/spawns/traders/" .. string.lower(game.GetMap()) .. ".txt", "DATA") then
	file.Delete("aftertheend/spawns/traders/" .. string.lower(game.GetMap()) .. ".txt")
end
SendChat( ply, "Deleted all trader spawnpoints" )
end
concommand.Add( "ate_cleartraderspawns", ClearTraders )

function RefreshTraders(ply, cmd, args)
if !SuperAdminCheck( ply ) then 
	SystemMessage(ply, "Only superadmins can use this command!", Color(255,205,205,255), true)
	return
end
LoadTraders()
timer.Simple(1, function() SpawnTraders() end)
end
concommand.Add( "ate_refreshtraders", RefreshTraders )