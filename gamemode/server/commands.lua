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

-------------------------------------------------------------------Inventory Commands------------------------------------------------------------------

function TogglePVP( ply )
if timer.Exists("pvptoggle_"..ply:UniqueID()) then SystemMessage(ply, "Don't spam the pvp command!", Color(255,205,205,255), true) return false end
if timer.Exists("pvpnominge_"..ply:UniqueID()) then SystemMessage(ply, "Unable to toggle PvP: you have damaged or taken damage from another player within the last 60 seconds!", Color(255,205,205,255), true) return false end

ply:SetPvPGuarded( 2 )

SystemMessage(ply, "Toggling PvP in 5 seconds...", Color(205,205,255,255), true)
ply:EmitSound("npc/attack_helicopter/aheli_mine_drop1.wav", 100, 100)

local nerds = ents.FindInSphere(ply:GetPos(), 800)

if ply:GetNWBool("pvp") == false then
for _, v in pairs(nerds) do
if !v:IsPlayer() then continue end
if v == ply then continue end
SystemMessage(v, "PROXIMITY WARNING: "..ply:Nick().." is enabling PvP! Shoot him now before its fully activated!", Color(255,105,105,255), false)
end
end


timer.Create( "pvptoggle_"..ply:UniqueID(), 5, 1, function()

	if !ply:IsValid() or !ply:Alive() then return false end

	if timer.Exists("pvpnominge_"..ply:UniqueID()) then SystemMessage(ply, "Unable to toggle PvP: you have damaged or taken damage from another player within the last 60 seconds!", Color(255,205,205,255), true) return false end

	if ply:GetNWBool("pvp") == true then ply:SetNWBool("pvp", false) SystemMessage(ply, "You have disabled PvP", Color(205,205,205,255), true)
	else
	ply:SetNWBool("pvp", true) SystemMessage(ply, "You have enabled PvP", Color(205,255,205,255), true)
	end
	ply:SetPvPGuarded( 0 )
	timer.Destroy("pvptoggle_"..ply:UniqueID())
end)

end
concommand.Add( "ate_togglepvp", TogglePVP )


function TrashProps( ply )
if !ply:IsValid() then return false end
	for k, v in pairs(ents.GetAll()) do
		if v:GetNWEntity("owner") == ply then v:Remove() end
	end

	ply:ConCommand("play physics/metal/metal_large_debris1.wav")
	SystemMessage(ply, "You cleared all your props.", Color(205,205,255,255), true)
end
concommand.Add( "ate_clearmyprops", TrashProps )


function DropCash( ply, cmd, args )
if !ply:IsValid() then return false end

local cash = math.floor(args[1])
local plycash = tonumber(ply.Money)

if cash < 1 then SystemMessage(ply, "Invalid drop amount, must be at least 1 "..Config[ "Currency" ].."!", Color(255,205,205,255), true) return false end
if plycash < cash then SystemMessage(ply, "You don't have that many "..Config[ "Currency" ].."s!", Color(255,205,205,255), true) return false end

ply.Money = plycash - cash


local vStart = ply:GetShootPos()
local vForward = ply:GetAimVector()
local trace = {}
trace.start = vStart
trace.endpos = vStart + (vForward * 70)
trace.filter = ply
local tr = util.TraceLine( trace )
local EntDrop = ents.Create( "ate_cash" )
EntDrop:SetPos( tr.HitPos + Vector(0, 0, 5))
EntDrop:SetAngles( Angle( 0, 0, 0 ) )
EntDrop:SetNWInt("CashAmount", cash)
EntDrop:Spawn()
EntDrop:Activate()

SystemMessage(ply, "You dropped "..cash.." "..Config[ "Currency" ].."s!", Color(205,255,205,255), true)

net.Start("UpdatePeriodicStats")
net.WriteFloat( ply.Level )
net.WriteFloat( ply.Money )
net.WriteFloat( ply.XP )
net.WriteFloat( ply.StatPoints )
net.WriteFloat( ply.Bounty )
net.Send( ply )

end
concommand.Add( "ate_dropcash", DropCash )