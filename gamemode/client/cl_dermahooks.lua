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


function DrawSleepOverlay() 
  
local LDFrame = vgui.Create( "DFrame" )  
LDFrame:SetPos( ScrW() / 2 - 350,ScrH() / 2 -125)  
LDFrame:SetSize( 700, 250 )  
LDFrame:SetTitle( "Sleeping...." )  
LDFrame:SetVisible( true )  
LDFrame:SetDraggable( true )  
LDFrame:ShowCloseButton( false ) 
LDFrame:SetBackgroundBlur( true )  
LDFrame:MakePopup()
LDFrame.Paint = function()
surface.SetDrawColor(0, 0, 0, 200)
surface.DrawRect(0, 0, LDFrame:GetWide(), LDFrame:GetTall())
Derma_DrawBackgroundBlur( LDFrame, CurTime() )
end
  
local PaintPanel = vgui.Create( "DPanel", LDFrame )  
  
PaintPanel:SetPos( 15, 30 )  
PaintPanel:SetSize( 670, 190 )  
PaintPanel.Paint = function()      
draw.RoundedBox(12, 0, 0, PaintPanel:GetWide(), PaintPanel:GetTall(), Color(30,30,30,150))
draw.SimpleText( "You will be able to wake up in 10 seconds", "TargetID", 155, 70, Color( 255, 255, 255, 255 ), 0, 1 )
--surface.SetDrawColor( 50, 50, 50, 255 )      
--surface.DrawRect( 0, 0, PaintPanel:GetWide(), PaintPanel:GetTall() ) 
--PaintPanel:SetCursor("hand"); 
end 
  
local Dlabel = vgui.Create("DLabel", PaintPanel); 
    Dlabel:SetText( "unless you died in your sleep of course" ) 
    Dlabel:SetSize(490, 30); 
    Dlabel:SetPos(230, 75); 

timer.Simple( 10,function()
	local OKButton = vgui.Create("DButton", PaintPanel); 
	OKButton:SetText("Wake Up")
	OKButton:SetTextColor(Color(255, 255, 255, 255))
	OKButton:SetSize(100, 30)
	OKButton:SetPos(270, 105)
	OKButton.DoClick = function()
	LDFrame:Close()
	end 
	OKButton.Paint = function()
	draw.RoundedBox(6, 0, 0, OKButton:GetWide(), OKButton:GetTall(), Color(90,90,30,150))
	end
end )

end 
usermessage.Hook( "DrawSleepOverlay", DrawSleepOverlay )



net.Receive( "UseDelay", function()

local delay = net.ReadUInt( 8 )
local remaining = CurTime() + delay

local t = ScrW() / 2 - 100
local s = ScrH() / 2 - 5

local DelayFrame = vgui.Create( "DFrame" )  
DelayFrame:SetPos( t, s + 50)  
DelayFrame:SetSize( 200, 50 )  
DelayFrame:SetTitle( "" )
DelayFrame:SetVisible( true )  
DelayFrame:SetDraggable( false )  
DelayFrame:ShowCloseButton( false ) 
DelayFrame:SetBackgroundBlur( true )  
DelayFrame:MakePopup()
--DelayFrame:Center()
DelayFrame.Paint = function( self, w, h )
local fraction = (remaining - CurTime()) / delay
surface.SetDrawColor(0, 0, 0, 200)
surface.DrawRect(0, 0, w, h)

surface.SetDrawColor(100, 0, 0, 250)
surface.DrawRect(10, h / 2, fraction * 180, 20)
surface.SetDrawColor(110, 0, 0, 250)
surface.DrawRect(10, h / 2, fraction * 180, 10)

surface.SetDrawColor(150, 0, 0, 200)
surface.DrawOutlinedRect(0, 0, w, h)
surface.DrawOutlinedRect(10, h / 2, w - 20, 20)
draw.DrawText( "Please wait...", "TargetID", 100, 5, Color(250, 250, 250), TEXT_ALIGN_CENTER )
end
/*
local Dlabel = vgui.Create("DLabel", DelayFrame)
    Dlabel:SetText( "Please Wait... " ) 
    Dlabel:SetFont( "TargetID" )
    Dlabel:SizeToContents()
    Dlabel:SetPos(45, 5)
*/

timer.Simple( delay, function()
if DelayFrame and DelayFrame:IsValid() then
DelayFrame:Remove()
end
end)

end)