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
dohuddraw = 1

local wralpha = 0 -- wraith blind effect

Spawn = 0

function GetReqXPClient()
	return math.floor( 1000 + (Mylevel  * 300) ^ 1.04 )
end
/*
function GetReqXPClient()
	return math.floor( 1000 * 1.12^(Mylevel - 1) )
end
*/

Mystamina = 0
Myhunger = 0
Myfatigue = 0
Myinfection = 0
Mybattery = 0
Mylevel = 0
Mymoney = 0
Myxp = 0
Mypoints = 0
Mybounty = 0


net.Receive( "UpdateStats", function( length ) -- this net message is recieved once per frame

local stam = net.ReadFloat()
local hung = net.ReadFloat()
local fat = net.ReadFloat()
local infec = net.ReadFloat()
--local bat = net.ReadFloat()

Mystamina = stam
Myhunger = hung
Myfatigue = fat
Myinfection = infec
--Mybattery = bat

end)

net.Receive( "UpdatePeriodicStats", function( length ) -- this net message is only recieved when one of these values need to be updated

local level = net.ReadFloat()
local money = net.ReadFloat()
local setxp = net.ReadFloat()
local points = net.ReadFloat()
local bounty = net.ReadFloat()

Mylevel = level
Mymoney = money
Myxp = setxp
Mypoints = points
Mybounty = bounty

end)



surface.CreateFont( "Arial", {
	font = "Arial",
	size = 12,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "TargetIDTiny", {
	font = "Trebuchet MS",
	size = 17,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


local XPColor = Color( 255, 255, 255, 0 )
local XPGained = 0
local MoneyGained = 0
local MoneyColor = Color( 255, 255, 255, 0 )

function GM:HUDDrawTargetID()	
	return false
end

net.Receive( "Payout", function( length )

local xpgain = net.ReadFloat()
local moneygain = net.ReadFloat()

XPGained = xpgain
MoneyGained = moneygain
XPColor = Color( 255, 255, 255, 255 )
MoneyColor = Color( 255, 255, 255, 255 )
timer.Create( "payout_timer", 2, 1, function() XPColor = Color( 255, 255, 255, 0 ) MoneyColor = Color( 255, 255, 255, 0 ) end )
end)


local function GetMyPvP()
if LocalPlayer():IsPvPGuarded() then return 1 end
if LocalPlayer():Team() == 1 and LocalPlayer():GetNWBool("pvp") then return 2 end
if LocalPlayer():Team() != 1 then return 2 end
if LocalPlayer():IsPvPForced() then return 3 end
return 0
end


local function DrawNames( )
	local trace = { }


	trace.start = LocalPlayer():EyePos()
	trace.endpos = trace.start + LocalPlayer():GetAimVector() * 1500
	trace.filter = LocalPlayer()
	
	local tr = util.TraceLine( trace )
	local ply = tr.Entity
	if ply:IsValid( ) and ply:IsPlayer() and ply != LocalPlayer() and ply:Alive() then
	local headPos = ( ply:GetShootPos( ) + Vector( 0, 0, 18 ) ):ToScreen()
				surface.SetFont( "TargetID" )

				local message = ply:Name()
				local wo, ho = surface.GetTextSize( message )

				surface.SetFont( "TargetIDSmall" )

				local message2 = "Health: " .. ply:Health() .. "%"
				local wo2, ho2 = surface.GetTextSize( message2 )

				local message3 = "Faction: "..team.GetName(ply:Team())
				local wo3, ho3 = surface.GetTextSize( message3 )

				local message4 = "Level: " .. ply:GetNWInt( "PlyLevel", 1 )
				local wo4, ho4 = surface.GetTextSize( message4 )

				if ply:IsPvPGuarded() then
				draw.SimpleTextOutlined(  "p", "CounterShit", headPos.x - 15, headPos.y - 62, Color( 50, 250, 0, 255 ), 0, 0, 2, Color( 0, 50, 0, 255 ) )
				elseif ply:IsPvPForced() or (ply:Team() == 1 and ply:GetNWBool("pvp") == true) or ( ply:Team() != 1 and ply:Team() != LocalPlayer():Team() ) then
				draw.SimpleTextOutlined(  "C", "CounterShit", headPos.x - 25, headPos.y - 60, Color( 255, 50, 0, 255 ), 0, 0, 2, Color( 50, 0, 0, 255 ) )
				end

				draw.SimpleTextOutlined(  ply:Name(), "TargetID", headPos.x - (wo /2 ), headPos.y - 40, Color( 255, 255, 255, 255 ), 0, 0, 2, Color( 0, 0, 0, 255 ) )
				draw.SimpleTextOutlined(  "Health: " .. ply:Health() .. "%", "TargetIDSmall", headPos.x - (wo2 / 2), headPos.y - 20, Color( 255, math.Clamp(ply:Health() * 2.5, 0, 255), math.Clamp(ply:Health() * 2.5, 0, 255), 255 ), 0, 0, 1, Color( 0, 0, 0, 255 ) )
				draw.SimpleTextOutlined(  "Level: " .. ply:GetNWInt( "PlyLevel", 1 ) , "TargetIDSmall", headPos.x - (wo4 / 2 ) - 2, headPos.y - 7, Color( 255, 205, 255, 255 ), 0, 0, 1, Color( 0, 0, 0, 255 ) )
				draw.SimpleTextOutlined(  "Faction: "..team.GetName(ply:Team()), "TargetIDSmall", headPos.x - (wo3 / 2 ) - 2, headPos.y + 7, team.GetColor(ply:Team()), 0, 0, 1, Color( 0, 0, 0, 255 ) )

	end

end

MaxClipAmmo = {}

local function DrawVitals( )
	if( !LocalPlayer():Alive() or !LocalPlayer():IsValid() ) then return end
	local me = LocalPlayer()
	if( me:GetActiveWeapon() == NULL or me:GetActiveWeapon() == "gmod_camera" ) then return end  
	local Health = me:Health()
--	local MaxHealth = 100 + ( me:GetNWInt( "StatHealth" ) * 5 )                   -- fix this bullshit later
	local MaxHealth = 100
	local Armor = me:Armor()
	local MaxArmor = 100
--	local HealthTexture = surface.GetTextureID( "gui/silkicons/heart" )
--	local ArmorTexture = surface.GetTextureID( "gui/silkicons/shield" )
	local DGradientCenter = surface.GetTextureID( "gui/center_gradient" )
	local SWEP = me:GetActiveWeapon()
	local AmmoClip1 = me:GetActiveWeapon():Clip1()
	local AmmoClip2 = me:GetActiveWeapon():Clip2()
	local MaxAmmoType = me:GetAmmoCount( me:GetActiveWeapon():GetPrimaryAmmoType() )
	
	if not MaxClipAmmo[SWEP] then
		MaxClipAmmo[SWEP] = AmmoClip1
	elseif AmmoClip1 > MaxClipAmmo[SWEP] then
		MaxClipAmmo[SWEP] = AmmoClip1
	end
	
	local glow = math.abs(math.sin(CurTime() * 2) * 255)

	if Myhunger < 1000 then
	draw.SimpleText( "WARNING: YOU ARE STARVING! FIND FOOD NOW!", "TargetID", 21, ScrH() - 240, Color( 255, glow, glow, 255 ), 0, 1 )
	end

	if Myfatigue > 9000 then
	draw.SimpleText( "WARNING: YOU ARE EXTREMELY TIRED! FIND SOMEWHERE TO SLEEP!", "TargetID", 21, ScrH() - 220, Color( 255, glow, glow, 255 ), 0, 1 )
	end

	if Myinfection > 9000 then
	draw.SimpleText( "WARNING: YOU ARE SEVERELY INFECTED! FIND A CURE NOW!", "TargetID", 21, ScrH() - 200, Color( 255, glow, glow, 255 ), 0, 1 )
	end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------HEALTH
	--Health Box
	draw.RoundedBox( 1,  10,  ScrH() - 110, 180, 100, Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(90, 0, 0 ,255)
	surface.DrawOutlinedRect(10, ScrH() - 110, 180, 100)
	--Health Text
	draw.SimpleText( "Health: " .. Health .. "%", "TargetIDSmall", 21, ScrH() - 96, Color( 255, 255, 255, 255 ), 0, 1 )
	
	--Health bar base
	draw.RoundedBox( 2, 20, ScrH() - 86, 160, 20, Color( 50, 0, 0, 160 ) )	

	if( Health > 0 ) then
	--Health Bar
	local hpbarclamp = math.Clamp(160 * ( Health / MaxHealth ), 0, 160)
	draw.RoundedBox( 4, 20, ScrH() - 86, hpbarclamp, 20, Color( 150, 0, 0, 160 ) )
	draw.RoundedBox( 4, 20, ScrH() - 86, hpbarclamp, 10, Color( 150, 0, 0, 100 ) )
	end
	
	
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ARMOR
	
	--Battery
	draw.SimpleText( "Battery: "..math.floor(Mybattery).." %", "TargetIDSmall", 21, ScrH() - 46, Color( 255, 255, 255, 255 ), 0, 1 )
	
	draw.RoundedBox( 2, 20, ScrH() - 36, 160, 20, Color( 0, 0, 50, 160 ) )
	
	if Mybattery >= 1 then
	draw.RoundedBox( 4, 20, ScrH() - 36, 80 * (Mybattery / 100), 20, Color( 0, 100, 155, 160 ) )
	draw.RoundedBox( 4, 20, ScrH() - 36, 80 * (Mybattery / 100), 10, Color( 0, 100, 155, 160 ) )
	end

	surface.SetDrawColor(0, 0, 0 ,255)
	surface.DrawRect(58, ScrH() - 36, 4, 20 )
	surface.DrawRect(98, ScrH() - 36, 4, 20 )
	surface.DrawRect(138, ScrH() - 36, 4, 20 )
	surface.DrawOutlinedRect(20, ScrH() - 36, 160, 20 )
	surface.DrawOutlinedRect(19, ScrH() - 37, 162, 22 )
	
	

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------AMMO
	if( MaxAmmoType != 0 or AmmoClip1 > 0 ) then
	IsAmmoBox = true
	--Ammo Box
--	draw.RoundedBox( 1,  ScrW() - 190,  ScrH() - 180, 180, 50, Color( 0, 0, 0, 160 ) )
	draw.RoundedBox( 1,  ScrW() - 220,  ScrH() - 120, 200, 50, Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(200, 100, 0 ,255)
	surface.DrawOutlinedRect(ScrW() - 220,  ScrH() - 120, 200, 50)
	
	--Ammo Text
	draw.SimpleText( "Ammo: " .. AmmoClip1 .. "/" .. MaxAmmoType, "TargetIDSmall", ScrW() - 209, ScrH() - 110, Color( 255, 255, 255, 255 ), 0, 1 )
	
	--Ammo bar base
	draw.RoundedBox( 2, ScrW() - 200, ScrH() - 98, 160, 20, Color( 150, 100, 0, 100 ) )
	
	if( AmmoClip1 > 0 ) then
	--Ammo Bar
	draw.RoundedBox( 4, ScrW() - 200, ScrH() - 98, 160 * ( AmmoClip1 / MaxClipAmmo[SWEP] ), 20, Color( 200, 110, 0, 200 ) )
	draw.RoundedBox( 4, ScrW() - 200, ScrH() - 98, 160 * ( AmmoClip1 / MaxClipAmmo[SWEP] ), 10, Color( 200, 150, 0, 50 ) )
	end
	else IsAmmoBox = false end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------XP
	--XP Box
	draw.RoundedBox( 1,  ScrW() - 220,  ScrH() - 60, 200, 50, Color( 0, 0, 0, 200 ) )
	draw.RoundedBox( 1,  ScrW() - 430,  ScrH() - 60, 200, 50, Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(90, 0, 0 ,255)
	surface.DrawOutlinedRect(ScrW() - 220,  ScrH() - 60, 200, 50)
	surface.SetDrawColor(40, 90, 0 ,255)
	surface.DrawOutlinedRect(ScrW() - 430,  ScrH() - 60, 200, 50)
	
	--XP Text
	draw.SimpleText( "XP: " .. math.floor( Myxp ) .. "/" .. GetReqXPClient( me ), "TargetIDSmall", ScrW() - 209, ScrH() - 46, Color( 255, 255, 255, 255 ), 0, 1 )
	
	--XP bar base
	draw.RoundedBox( 2, ScrW() - 200, ScrH() - 36, 160, 20, Color( 50, 0, 0, 160 ) )
	
	--XP Bar
	draw.RoundedBox( 4, ScrW() - 200, ScrH() - 36, math.Clamp( 160 * ( Myxp / GetReqXPClient( me ) ), 3, 160), 20, Color( 150, 0, 0, 160 ) )
	
	--Show points too
	draw.SimpleText( "Pts: " .. Mypoints, "TargetIDSmall", ScrW() - 286, ScrH() - 36, Color( 255, 255, 255, 255 ), 0, 1 )

	--bounty

	draw.SimpleText( "Bounty: " .. Mybounty, "TargetIDSmall", ScrW() - 419, ScrH() - 36, Color( 255, 255, 255, 255 ), 0, 1 )

	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Stamina

	draw.RoundedBox( 1,  200,  ScrH() - 170, 180, 160, Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(125, 125, 55 ,255)
	surface.DrawOutlinedRect(200,  ScrH() - 170, 180, 160)
	
	--Stamina Text      
	draw.SimpleText( "Stamina: " .. Mystamina.."%", "TargetIDTiny", 210, ScrH() - 154, Color( 205, 205, 205, 255 ), 0, 1 )


	--Stamina bar base
	draw.RoundedBox( 2, 210, ScrH() - 144, 160, 15, Color( 50, 50, 0, 160 ) )
	
	if Mystamina > 0 then
		--Stamina Bar
		draw.RoundedBox( 4, 210, ScrH() - 144, Mystamina * 1.6, 15, Color( 100, 150, 0, 160 ) )
		draw.RoundedBox( 4, 210, ScrH() - 144, Mystamina * 1.6, 8, Color( 100, 150, 0, 160 ) )

	end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Hunger


	--Hunger bar base
	draw.RoundedBox( 2, 210, ScrH() - 108, 160, 15, Color( 50, 0, 50, 160 ) )

	--hunger bar
	if math.Round(Myhunger / 100) > 0 then
	draw.RoundedBox( 4, 210, ScrH() - 108, math.Round(Myhunger / 100) * 1.6, 15, Color( 90, 0, 120, 160 ) )
	draw.RoundedBox( 4, 210, ScrH() - 108, math.Round(Myhunger / 100) * 1.6, 8, Color( 120, 0, 120, 80 ) )
	end


	--Hunger Text
	draw.SimpleText( "Hunger: "..math.Round(Myhunger / 100).."%", "TargetIDTiny", 210, ScrH() - 118, Color( 205, 205, 205, 255 ), 0, 1 )

	--Fatigue bar base
	draw.RoundedBox( 2, 210, ScrH() - 72, 160, 15, Color( 0, 50, 50, 160 ) )

	--Fatigue bar
	if math.Round(Myfatigue / 100) > 0 then
	draw.RoundedBox( 4, 210, ScrH() - 72, math.Round(Myfatigue / 100) * 1.6, 15, Color( 0, 80, 80, 160 ) )
	draw.RoundedBox( 4, 210, ScrH() - 72, math.Round(Myfatigue / 100) * 1.6, 8, Color( 0, 100, 100, 80 ) )
	end



	--Fatigue Text
	draw.SimpleText( "Fatigue: "..math.Round(Myfatigue / 100).."%", "TargetIDTiny", 210, ScrH() - 82, Color( 205, 205, 205, 255 ), 0, 1 )





	--Infection bar base
	draw.RoundedBox( 2, 210, ScrH() - 36, 160, 15, Color( 80, 0, 0, 160 ) )

	--Infection bar
	if math.Round(Myinfection / 100) > 0 then
	draw.RoundedBox( 4, 210, ScrH() - 36, math.Round(Myinfection / 100) * 1.6, 15, Color( 250, 0, 0, 160 ) )
	draw.RoundedBox( 4, 210, ScrH() - 36, math.Round(Myinfection / 100) * 1.6, 8, Color( 50, 0, 0, 100 ) )
	end


	--Infection Text
	draw.SimpleText( "Infection: "..math.Round(Myinfection / 100).."%", "TargetIDTiny", 210, ScrH() - 46, Color( 205, 205, 205, 255 ), 0, 1 )




	--Levels & cash box
	draw.RoundedBox( 1,  10,  ScrH() - 170, 180, 50, Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(55, 55, 155 ,255)
	surface.DrawOutlinedRect(10,  ScrH() - 170, 180, 50)
	
	--Levels & cash, just above health and armor
	draw.SimpleText( "Level: " .. math.floor( Mylevel ), "TargetIDSmall", 20, ScrH() - 154, Color( 255, 255, 255, 255 ), 0, 1 )
	draw.SimpleText( "Money: " .. math.floor( Mymoney ), "TargetIDSmall", 20, ScrH() - 134, Color( 255, 255, 255, 255 ), 0, 1 )
	
	--XP gained
	draw.SimpleText( XPGained .. " XP Gained!", "TargetID", ScrW() / 2 + 10, ScrH() / 2, XPColor, 0, 1 )
	
	--XP gained
	draw.SimpleText( MoneyGained .. " Cash Gained!", "TargetID", ScrW() / 2 + 10, ScrH() / 2 + 15, MoneyColor, 0, 1 )
	

-- Compass

local angles = tostring(math.Round(-me:GetAngles().y + 180))
local nang = math.rad(angles)
local eang = math.rad(angles - 90)
local sang = math.rad(angles - 180)
local wang = math.rad(angles - 270)

local nx = 40*math.cos(-nang) + 80
local ny = 40*math.sin(-nang) + 80
local ex = 40*math.cos(-eang) + 80
local ey = 40*math.sin(-eang) + 80
local sx = 40*math.cos(-sang) + 80
local sy = 40*math.sin(-sang) + 80
local wx = 40*math.cos(-wang) + 80
local wy = 40*math.sin(-wang) + 80

	surface.DrawCircle(80,80, 30 , Color(155,155,155,55))
	surface.DrawCircle(80,80, 5 , Color(155,155,155,55))
	surface.SetDrawColor(155,155,155,255)
	surface.DrawLine( 80, 80, 80, 60 )

	draw.SimpleText( "N", "TargetID", nx - 5, ny - 10, Color(205,205,205,255), 0, 0 ) -- add 5 and 10 to x and y, i dont know why it puts them in the wrong position but whatever
	draw.SimpleText( "E", "TargetID", ex - 5, ey - 10, Color(205,205,205,255), 0, 0 )
	draw.SimpleText( "S", "TargetID", sx - 5, sy - 10, Color(205,205,205,255), 0, 0 )
	draw.SimpleText( "W", "TargetID", wx - 5, wy - 10, Color(205,205,205,255), 0, 0 )

/*
-- Threat level

	local threats = {
		"Minimal",
		"Low",
		"Moderate",
		"High",
		"Very high",
		"Hell on Earth",
	}

	surface.SetFont( "TargetID" )
	local txx, txy = surface.GetTextSize( "Threat level: "..threats[1] )
	surface.SetDrawColor(0,0,0,200)
	surface.DrawRect( 135, 35, txx + 15, 27)
	surface.SetDrawColor(90,0,0,255)
	surface.DrawOutlinedRect( 135, 35, txx + 15, 27)
	draw.SimpleText( "Threat level: "..threats[1], "TargetID", 140, 40, Color(205,205,205,255), 0, 0 )
*/

	-- draw pvp status

	local mpvp = GetMyPvP()
	local mpvptab = {
		[0] = "Disabled",
		[1] = "Guarded",
		[2] = "Enabled",
		[3] = "Forced",
	}

	if mpvp == 3 then
	surface.SetDrawColor(100,0,0,200)
	else
	surface.SetDrawColor(0,0,0,200)
	end
	surface.DrawRect( 135, 70, 150, 27)
	surface.SetDrawColor(40,0,40,255)
	surface.DrawOutlinedRect( 135, 70, 150, 27)

	draw.SimpleText( "PvP: "..mpvptab[mpvp], "TargetID", 175, 75, Color(205,205,205,255), 0, 0 )
	if mpvp == 2 or mpvp == 3 then
	draw.SimpleTextOutlined(  "C", "CounterShit", 130, 75, Color( 255, 50, 0, 255 ), 0, 0, 2, Color( 50, 0, 0, 255 ) )
	elseif mpvp == 1 then
	draw.SimpleTextOutlined(  "p", "CounterShit", 140, 73, Color( 50, 250, 0, 255 ), 0, 0, 2, Color( 0, 50, 0, 255 ) )
	else
	draw.SimpleTextOutlined(  "C", "CounterShit", 130, 75, Color( 50, 50, 50, 255 ), 0, 0, 2, Color( 20, 0, 0, 255 ) )
	end

for _, ent in pairs (ents.FindByClass("trader")) do

	if ent:GetPos():Distance(me:GetPos()) < 120 then

	draw.RoundedBox( 2, ScrW() / 2 - 230, 20, 460, 60, Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(155, 0, 0 ,255)
	surface.DrawOutlinedRect(ScrW() / 2 - 230, 20, 460, 60)
	draw.SimpleText( "You are in a trader protection zone", "TargetID", ScrW() / 2 - 135, 40, Color( 255, 255, 255, 255 ), 0, 1 )
	draw.SimpleText( "You cannot hurt other players or be hurt by them while in this area", "TargetIDSmall", ScrW() / 2 - 221, 60, Color( 255, 255, 255, 255 ), 0, 1 )
end
end


end


/*
timer.Simple(3, function() mouthbreather = CreateSound( LocalPlayer(), "player/breathe1.wav" ) end)
local dingus = Material( "overlays/scope_lens" )
local dingus2 = Material( "sprites/scope_arc" )
local function GasMaskOverlay()
		surface.SetDrawColor( Color(0,0,0,205))
		surface.SetMaterial( dingus )
		surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		surface.SetDrawColor( Color(0,0,0,105))
		surface.SetMaterial( dingus2 )
		surface.DrawTexturedRectRotated( ScrW() - 250, ScrH() - 250, 600, 600, 0 )
		surface.DrawTexturedRectRotated( ScrW() - 250, 250, 600, 600, 90 )
		surface.DrawTexturedRectRotated( 250, 250, 600, 600, 180 )
		surface.DrawTexturedRectRotated( 250, ScrH() - 250, 600, 600, 270 )

		if !mouthbreather:IsPlaying() then mouthbreather:Play() end
end

local gasmask = false
concommand.Add("gastest", function() surface.PlaySound( "npc/combine_soldier/gear3.wav" ) gasmask = !gasmask end)
*/

function GM:HUDPaint()
if dohuddraw != 1 then return false end

/*
	if gasmask then 
		GasMaskOverlay() 
	else
		mouthbreather:Stop()
	end
*/

	self.BaseClass:HUDPaint()

	DrawVitals()
	DrawNames()
	DrawMiscThings()

	if ( LocalPlayer():Alive() ) then
		Spawn = CurTime() + 10
	else
	if LocalPlayer():IsValid() then
		surface.SetDrawColor(255, 0, 0, 255)
		surface.DrawOutlinedRect( ScrW( ) / 2 - 135, 90, 270, 40 )
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect( ScrW( ) / 2 - 135, 90, 270, 40 )
--		draw.RoundedBox( 6, ScrW( ) / 2 - 113, 80, 280, 45, Color( 0, 0, 0, 200 ) )
		if Spawn > CurTime() then
		draw.DrawText( "You can respawn in " .. math.Clamp( math.floor( (Spawn - CurTime()) + 1 ), 0, 10 ) .. " seconds", "TargetID", ScrW( ) / 2 - 116, 105 - 5, Color( 255,255,255,255 ), 0 )
		else
		draw.DrawText( "You are now able to respawn!", "TargetID", ScrW( ) / 2 - 116, 105 - 5, Color( 255,255,255,255 ), 0 )
		end
	end
	end
end

function GM:HUDShouldDraw( name )
	local donotdraw = 
	{ 
	
	"CHudHealth",
	"CHudAmmo",
	"CHudSecondaryAmmo",
	"CHudBattery"
	
	}
	
	for k, v in pairs( donotdraw ) do
		if( name == v ) then return false end
	end
	
	return true
end

function GM:RenderScreenspaceEffects( )
	local modify = {}
	local color = 1
	
	if ( LocalPlayer():Health() < 50 ) then
		if ( LocalPlayer():Alive() ) then
			color = math.Clamp( color - ( ( 50 - LocalPlayer():Health() ) * 0.025 ), 0, color )
		else
			color = 0
		end
		
		DrawMotionBlur( math.Clamp( 1 - ( ( 50 - LocalPlayer():Health() ) * 0.025 ), 0.1, 1 ), 1, 0 )
	end

	if wralpha > 220 then DrawMotionBlur(0.4, 0.8, 0.01) end
	
	modify["$pp_colour_addr"] = 0
	modify["$pp_colour_addg"] = 0
	modify["$pp_colour_addb"] = 0
	modify["$pp_colour_brightness"] = 0
	modify["$pp_colour_contrast"] = 1
	modify["$pp_colour_colour"] = color
	modify["$pp_colour_mulr"] = 0
	modify["$pp_colour_mulg"] = 0
	modify["$pp_colour_mulb"] = 0
	
	DrawColorModify( modify )
end



function DrawMiscThings()



for _, ent in pairs (ents.FindByClass("structure_base_core")) do
	if ent:GetPos():Distance(LocalPlayer():GetPos()) < 900 and ent:GetNWEntity("owner"):IsValid() and ent:GetMaterial() != "models/wireframe" then
	local t2 = ScrW() / 2 - 175
	local s2 = 85
	surface.SetDrawColor(255, 0, 0, 255)
	surface.DrawOutlinedRect( t2, s2, 350, 45 )
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect( t2, s2, 350, 45 )
	local facmsg = "Faction: "..team.GetName(ent:GetNWEntity("owner"):Team())
--	local xz, xy = surface.GetTextSize( facmsg )
		if ent:GetNWEntity("owner"):Team() == LocalPlayer():Team() then
		draw.DrawText( "You are in friendly territory", "TargetID", t2 + 65, s2 + 4, Color( 205, 255, 205, 255 ) )
		draw.DrawText( facmsg , "TargetID", ScrW() / 2, s2 + 22, team.GetColor(ent:GetNWEntity("owner"):Team()), 1 )
		else
		draw.DrawText( "You are in another factions territory!", "TargetID", t2 + 32, s2 + 4, Color( 255, 255, 255, 255 ) )
		draw.DrawText( facmsg , "TargetID", ScrW() / 2, s2 + 22, team.GetColor(ent:GetNWEntity("owner"):Team()), 1 )
		end

	end
end


for _, ent in pairs (ents.FindByClass("airdrop_cache")) do
	if ent:GetPos():Distance(LocalPlayer():GetPos()) < 1200 and ent:GetNWBool("ADActive") then
	local t2 = ScrW() / 2 - 175
	local s2 = 25
	surface.SetDrawColor(255, 0, 0, 255)
	surface.DrawOutlinedRect( t2, s2, 350, 45 )
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect( t2, s2, 350, 45 )
	draw.DrawText( "You are in an active airdrop zone!", "TargetID", t2 + 42, s2 + 4, Color( 255, 205, 205, 255 ) )
	draw.DrawText( "PvP is forced, beware of other survivors!", "TargetID", t2 + 15, s2 + 22, Color( 255, 205, 205, 255 ) )
	end
end


	local CurTargetEnt = nil
	local TargetText = { }
	local trace = { }


	trace.start = LocalPlayer():EyePos()
	trace.endpos = trace.start + LocalPlayer():GetAimVector() * 120
	trace.filter = LocalPlayer()
	
	local tr = util.TraceLine( trace )
	if !tr.Entity:IsValid() then return false end


	if tr.Entity:GetClass() == "prop_flimsy" or tr.Entity:GetClass() == "prop_strong" or SpecialSpawns[tr.Entity:GetClass()] then 
	local owner = tr.Entity:GetNWEntity("owner")
	if !owner or !owner:IsValid() then return false end
	local t = ScrW() / 2 - 175
	local s = ScrH() - 100
	surface.SetDrawColor(255, 0, 0, 255)
	surface.DrawOutlinedRect( t, s, 350, 65 )
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect( t, s, 350, 65 )
	draw.DrawText( tr.Entity.PrintName, "TargetID", t + 5, s + 4, Color( 255, 255, 255, 255 ) )
	draw.DrawText( "Owner: ".. owner:Nick(), "TargetID", t + 5, s + 22, Color( 255, 255, 255, 255 ) )
	draw.DrawText( "Faction:", "TargetID", t + 5, s + 40, Color( 255, 255, 255, 255 ) )
	draw.DrawText( team.GetName(owner:Team()), "TargetID", t + 72, s + 40, team.GetColor(owner:Team()) )


	local shp = tr.Entity:GetNWInt( "ate_integrity", -1 )
	local smaxhp = tr.Entity:GetNWInt( "ate_maxintegrity", -1 )
	if shp < 0 or smaxhp < 0 then return end
	local dix = tr.Entity:LocalToWorld( tr.Entity:OBBCenter() ):ToScreen()
	local fraction = shp / smaxhp
	surface.SetDrawColor(0, 0, 0, 100)
	surface.DrawRect( dix.x - 75, dix.y, 150, 25 )

	surface.SetDrawColor(100, 0, 0, 190)
	surface.DrawRect(dix.x - 75, dix.y, fraction * 150, 25)
	surface.SetDrawColor(110, 0, 0, 190)
	surface.DrawRect(dix.x - 75, dix.y, fraction * 150, 12)

	surface.SetDrawColor(150, 0, 0, 200)
	surface.DrawOutlinedRect( dix.x - 75, dix.y, 150, 25 )
	draw.DrawText( math.Round(fraction * 100).."%", "TargetID", dix.x, dix.y + 4, Color( 255, 255, 255, 155 ) , 1 )

	end
	

	if tr.Entity:GetClass() == "ate_droppeditem" then 

	local name = tr.Entity:GetNWString("ItemClass")

	local itemtable = ItemsList[name]
	if !itemtable then return false end
	local rarity = itemtable.Rarity

local rarecol
local raretext
if rarity == 1 then rarecol = Color(155,155,155,255) raretext = "Junk"
elseif rarity == 2 then rarecol = Color(155,155,255,255) raretext = "Common"
elseif rarity == 3 then rarecol = Color(105,255,105,255) raretext = "Uncommon"
elseif rarity == 4 then rarecol = Color(255,200,0,255) raretext = "Rare"
elseif rarity == 5 then rarecol = Color(155,100,180,255) raretext = "Unique"
elseif rarity == 6 then rarecol = Color(205,0,205,255) raretext = "Legendary"
elseif rarity == 7 then rarecol = Color(255,255,255,255) raretext = "Unobtainable"
elseif rarity == 8 then rarecol = Color(170,255,170,255) raretext = "Event"
end


	local t = ScrW() / 2 - 100
	local s = ScrH() / 2 + 100
	surface.SetDrawColor(255, 0, 0, 255)
	surface.DrawOutlinedRect( t, s, 200, 65 )
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect( t, s, 200, 65 )
	draw.DrawText( itemtable.Name, "TargetID", t + 5, s + 4, Color( 255, 255, 255, 255 ) )
	draw.DrawText( itemtable.Weight.."kg", "TargetID", t + 5, s + 22, Color( 255, 255, 155, 255 ) )
	draw.DrawText( "Rarity: "..raretext, "TargetID", t + 5, s + 40, rarecol )
	end


	if tr.Entity:GetClass() == "loot_cache" or tr.Entity:GetClass() == "loot_cache_weapon" then 

	local t = ScrW() / 2 - 75
	local s = ScrH() / 2 + 100
	surface.SetDrawColor(255, 0, 0, 255)
	surface.DrawOutlinedRect( t, s, 150, 45 )
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect( t, s, 150, 45 )
	draw.DrawText( "Loot Cache", "TargetID", t + 5, s + 4, Color( 255, 255, 255, 255 ) )
	draw.DrawText( "Press E to pick up", "TargetID", t + 5, s + 22, Color( 255, 255, 255, 255 ) )
	end


	if tr.Entity:GetClass() == "ate_cash" then 

	if !tr.Entity:GetNWInt("CashAmount") then return false end
	local t = ScrW() / 2 - 75
	local s = ScrH() / 2 + 100
	surface.SetDrawColor(255, 0, 0, 255)
	surface.DrawOutlinedRect( t, s, 150, 45 )
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect( t, s, 150, 45 )
	draw.DrawText( tr.Entity:GetNWInt("CashAmount").." Dollars", "TargetID", t + 5, s + 4, Color( 255, 255, 255, 255 ) )
	draw.DrawText( "Press E to pick up", "TargetID", t + 5, s + 22, Color( 255, 255, 255, 255 ) )
	end


end

net.Receive("WraithBlind", function()
wralpha = 255
end)

function WraithBlind()
if wralpha > 220 then wralpha = wralpha - 0.1
elseif wralpha > 1 then wralpha = wralpha - 1
else return end

surface.SetDrawColor(0, 0, 0, math.Round(wralpha))
surface.DrawRect(0, 0, surface.ScreenWidth(), surface.ScreenHeight())
end
hook.Add("HUDPaint", "WraithBlind", WraithBlind)



hook.Add("PostDrawOpaqueRenderables", "circle", function()
for _, ent in pairs (ents.FindByClass("structure_base_core")) do

	if ent:GetPos():Distance(LocalPlayer():GetPos()) < 2000 and ent:GetNWEntity("owner"):IsValid() and ent:GetMaterial() != "models/wireframe" then
	local Pos = ent:GetPos()
	local Ang = ent:GetAngles()
	local owner = ent:GetNWEntity("owner")
	if !owner:IsValid() then continue end
	local ownercol = team.GetColor(owner:Team()) or Color(0, 0, 0, 0)
	cam.Start3D2D(Pos + ent:GetUp() * 10, Ang, 0.6)
local TexturedQuadStructure =
{
	texture = surface.GetTextureID( 'particle/particle_ring_sharp' ),
	color   = ownercol,
	x 	= -1500,
	y 	= -1500,
	w 	= 3000,
	h 	= 3000
}

draw.TexturedQuad( TexturedQuadStructure )
	cam.End3D2D()

end

end

for _, ent in pairs (ents.FindByClass("airdrop_cache")) do

	if ent:GetPos():Distance(LocalPlayer():GetPos()) < 2000 and ent:GetNWBool("ADActive") then
	local Pos = ent:GetPos()
	local Ang = Angle(0,0,0)
	cam.Start3D2D(Pos + ent:GetUp() * 10, Ang, 0.6)
local TexturedQuadStructure =
{
	texture = surface.GetTextureID( 'particle/particle_ring_blur' ),
	color   = Color(255,0,0),
	x 	= -2000,
	y 	= -2000,
	w 	= 4000,
	h 	= 4000,
}

draw.TexturedQuad( TexturedQuadStructure )
	cam.End3D2D()

end

end

end)

