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



include( "shared.lua" )
include( "sh_items.lua" )
include( "sh_loot.lua" )
include( "sh_spawnables.lua" )
include( "sh_config.lua" )
include( "client/cl_scoreboard.lua" )
include( "client/cl_hud.lua" )
include( "client/cl_modelsmenu.lua" )
include( "client/cl_createfaction.lua" )
include( "client/cl_contextmenu.lua" )
include( "client/cl_customdeathnotice.lua" )
include( "client/cl_spawnmenu.lua" )
include( "client/cl_tradermenu.lua" )
include( "client/cl_dermahooks.lua" )
include( "client/cl_lootmenu.lua" )


SelectedProp = "models/props_debris/wood_board04a.mdl" -- need to set this to something here to avoid a massive error spew

function ChooseProp( mdl )
	SelectedProp = mdl
	net.Start("ChangeProp")
	net.WriteString(mdl)
	net.SendToServer()
end

function ChooseStructure( struc )
	SelectedProp = SpecialSpawns[struc]["Model"]
	net.Start("ChangeProp")
	net.WriteString(struc)
	net.SendToServer()
end

function GM:Initialize()
	self.BaseClass:Initialize()
surface.CreateFont( "AmmoText", {
	font = "arial",
	size = 30,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
} )

surface.CreateFont( "OtherText", {
	font = "arial",
	size = 15,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
} )

surface.CreateFont( "CounterShit", {
    font    = "csd",
    size    = 38,
    weight  = 400,
    antialias = true,
    shadow = false
})

end

function GM:PostProcessPermitted( name )
	return false
end

ChosenModel = ""

function DeathView( player, origin, angles, fov )
if( !player:Alive() ) then
	local Ragdoll = player:GetRagdollEntity()
	if ( Ragdoll ) then
		local IsValid = Ragdoll:IsValid()
		if ( IsValid ) then
			local Eyes = Ragdoll:GetAttachment( Ragdoll:LookupAttachment( "Eyes" ) )
			if ( Eyes ) then		
				local View = { origin = Eyes.Pos, angles = Eyes.Ang, fov = 90 }
				return View
			end
		end
	end
end 
end
hook.Add( "CalcView", "DeathView", DeathView )


function GM:OnUndo( name, strCustomString )
	
-- this is still needed by the test zombies function
notification.AddLegacy( "Undo: "..name, 2, 3 )
surface.PlaySound( "buttons/button15.wav" )

end


net.Receive( "SystemMessage", function( length, client )
local msg = net.ReadString()
local col = net.ReadColor()
local sys = net.ReadBool()

if sys then
chat.AddText( Color(255,255,255,255), "[System] ", col, msg )
else
chat.AddText( col, msg )
end

end)


local radiosounds = {
	"npc/metropolice/vo/unitreportinwith10-25suspect.wav",
	"npc/metropolice/vo/wearesociostablethislocation.wav",
	"npc/metropolice/vo/readytoprosecutefinalwarning.wav",
	"npc/metropolice/vo/pickingupnoncorplexindy.wav",
	"npc/metropolice/vo/malcompliant10107my1020.wav",
	"npc/metropolice/vo/ivegot408hereatlocation.wav",
	"npc/metropolice/vo/investigating10-103.wav",
	"npc/metropolice/vo/is10-108.wav",
	"npc/metropolice/vo/ihave10-30my10-20responding.wav",
	"npc/metropolice/vo/holdingon10-14duty.wav",
	"npc/metropolice/vo/gota10-107sendairwatch.wav",
	"npc/metropolice/vo/get11-44inboundcleaningup.wav",
	"npc/metropolice/vo/hidinglastseenatrange.wav"
}

net.Receive( "RadioMessage", function( length, client )
local sender = net.ReadString()
local msg = net.ReadString()

chat.AddText( Color(155,255,155,255), "[Radio] "..sender..": ", Color(205,205,205,255), msg )
--surface.PlaySound("npc/metropolice/vo/off"..math.random(1,4)..".wav")
surface.PlaySound(table.Random(radiosounds))

end)