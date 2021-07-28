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



function GM:OnSpawnMenuOpen()

	gui.EnableScreenClicker( true )
	PropMenu()
	PropsFrame:SetVisible( true )
end

function GM:OnSpawnMenuClose( )
if PropsFrame:IsValid() then
	PropsFrame:SetVisible( false )
	PropsFrame:Remove()
	gui.EnableScreenClicker( false )
end
end


function PropMenu()
	PropsFrame = vgui.Create( "DFrame" )
	PropsFrame:SetSize( 1000, 700 )
    PropsFrame:Center()
	PropsFrame:SetTitle ( "" )
	PropsFrame:SetDraggable( false )
	PropsFrame:SetVisible( true )
	PropsFrame:ShowCloseButton( false )
	PropsFrame:MakePopup()
	PropsFrame.Paint = function()
	draw.RoundedBox( 2,  0,  0, PropsFrame:GetWide(), PropsFrame:GetTall(), Color( 0, 0, 0, 200 ) )
	surface.SetDrawColor(150, 0, 0 ,255)
	surface.DrawOutlinedRect(0, 0, PropsFrame:GetWide(), PropsFrame:GetTall())
	end

local PropertySheet = vgui.Create( "DPropertySheet", PropsFrame )
PropertySheet:SetPos( 5, 5 )
PropertySheet:SetSize( 990, 690 )
PropertySheet.Paint = function()
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, PropertySheet:GetWide(), PropertySheet:GetTall())
	for k, v in pairs(PropertySheet.Items) do
		if (!v.Tab) then continue end
	
		v.Tab.Paint = function(self,w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(50,25,25))
		end
	end
end

----------------------------------------------flimsy props-------------------------------------------------------
 
local FlimsyPanel = vgui.Create( "DPanelList" )
FlimsyPanel:SetTall( 635 )
FlimsyPanel:SetWide( 980 )
FlimsyPanel:SetPos( 5, 25 )
FlimsyPanel:EnableVerticalScrollbar( true )
FlimsyPanel:EnableHorizontal( true )
FlimsyPanel:SetSpacing( 5 )

local discount = 1 - ((Perks.Engineer or 0) * 0.03)

for k, v in SortedPairsByMemberValue( FLIMSYPROPS, "COST" ) do

    local ItemBackground = vgui.Create( "DPanel" )
    ItemBackground:SetPos( 5, 5 )
    ItemBackground:SetSize( 150, 150 )
    ItemBackground.Paint = function() -- Paint function
        draw.RoundedBoxEx(8,1,1,ItemBackground:GetWide()-2,ItemBackground:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
	surface.SetDrawColor(50, 50, 50 ,255)
	surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
    end

    local ItemDisplay = vgui.Create( "SpawnIcon", ItemBackground )
    ItemDisplay:SetPos( 35, 5 )
    ItemDisplay:SetModel( k )
    ItemDisplay:SetToolTip(false)
    ItemDisplay:SetSize(75,75)
    ItemDisplay.PaintOver = function()
        return
    end
    ItemDisplay.OnMousePressed = function()
        return false
    end

    local ItemName = vgui.Create( "DLabel", ItemBackground )
    ItemName:SetFont( "TargetIDSmall" )
    ItemName:SetColor( Color(205,205,205,255) )
    ItemName:SetText( v.NAME )
    ItemName:SizeToContents()
    ItemName:Center()
    local x,y = ItemName:GetPos();
    ItemName:SetPos( x, y + 20)

    local ItemCost = vgui.Create( "DLabel", ItemBackground )
    ItemCost:SetFont( "TargetIDSmall" )
    ItemCost:SetColor( Color(155,255,155,255) )
    ItemCost:SetText( "Cost: ".. math.floor(v.COST * discount).." Gold" )
    ItemCost:SizeToContents()
    ItemCost:Center()
    local x,y = ItemCost:GetPos();
    ItemCost:SetPos( x, y + 40)

    local ItemToughness = vgui.Create( "DLabel", ItemBackground )
    ItemToughness:SetFont( "TargetIDSmall" )
    if v.TOUGHNESS == 1 then
    ItemToughness:SetText( "Strength: Weak" )
    ItemToughness:SetColor( Color(255,255,155,155) )
    elseif v.TOUGHNESS == 2 then
    ItemToughness:SetText( "Strength: Medium" )
    ItemToughness:SetColor( Color(255,205,155,155) )
	else
    ItemToughness:SetText( "Strength: Strong" )
    ItemToughness:SetColor( Color(255,155,155,155) )
	end
    ItemToughness:SizeToContents()
    ItemToughness:Center()
    local x,y = ItemToughness:GetPos();
    ItemToughness:SetPos( x, y + 60)


    local ItemClicker = vgui.Create( "DButton", ItemBackground )
    ItemClicker:SetText("")
    ItemClicker:SetPos( 0, 0 )
    ItemClicker:SetSize( ItemBackground:GetWide(), ItemBackground:GetTall() )
    ItemClicker.Paint = function() -- Paint function
	return false
    end
	ItemClicker.DoClick = function() RunConsoleCommand("use","zw_buildtool")
	ChooseProp( tostring(k) )
	end


FlimsyPanel:AddItem( ItemBackground )
end



----------------------------------------------strong props-------------------------------------------------------

local StrongPanel = vgui.Create( "DPanelList" )
StrongPanel:SetTall( 635 )
StrongPanel:SetWide( 980 )
StrongPanel:SetPos( 5, 25 )
StrongPanel:EnableVerticalScrollbar( true )
StrongPanel:EnableHorizontal( true )
StrongPanel:SetSpacing( 5 )

for k, v in SortedPairsByMemberValue( TOUGHPROPS, "COST" ) do

    local ItemBackground = vgui.Create( "DPanel" )
    ItemBackground:SetPos( 5, 5 )
    ItemBackground:SetSize( 150, 150 )
    ItemBackground.Paint = function() -- Paint function
        draw.RoundedBoxEx(8,1,1,ItemBackground:GetWide()-2,ItemBackground:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
	surface.SetDrawColor(50, 50, 50 ,255)
	surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
    end

    local ItemDisplay = vgui.Create( "SpawnIcon", ItemBackground )
    ItemDisplay:SetPos( 35, 5 )
    ItemDisplay:SetModel( k )
    ItemDisplay:SetToolTip(false)
    ItemDisplay:SetSize(75,75)
    ItemDisplay.PaintOver = function()
        return
    end
    ItemDisplay.OnMousePressed = function()
        return false
    end

    local ItemName = vgui.Create( "DLabel", ItemBackground )
    ItemName:SetFont( "TargetIDSmall" )
    ItemName:SetColor( Color(205,205,205,255) )
    ItemName:SetText( v.NAME )
    ItemName:SizeToContents()
    ItemName:Center()
    local x,y = ItemName:GetPos();
    ItemName:SetPos( x, y + 20)

    local ItemCost = vgui.Create( "DLabel", ItemBackground )
    ItemCost:SetFont( "TargetIDSmall" )
    ItemCost:SetColor( Color(155,255,155,255) )
    ItemCost:SetText( "Cost: ".. math.floor(v.COST * discount).." Gold" )
    ItemCost:SizeToContents()
    ItemCost:Center()
    local x,y = ItemCost:GetPos();
    ItemCost:SetPos( x, y + 40)

    local ItemToughness = vgui.Create( "DLabel", ItemBackground )
    ItemToughness:SetFont( "TargetIDSmall" )
    if v.TOUGHNESS == 1 then
    ItemToughness:SetText( "Strength: Weak" )
    ItemToughness:SetColor( Color(255,255,155,155) )
    elseif v.TOUGHNESS == 2 then
    ItemToughness:SetText( "Strength: Medium" )
    ItemToughness:SetColor( Color(255,205,155,155) )
	else
    ItemToughness:SetText( "Strength: Strong" )
    ItemToughness:SetColor( Color(255,155,155,155) )
	end
    ItemToughness:SizeToContents()
    ItemToughness:Center()
    local x,y = ItemToughness:GetPos();
    ItemToughness:SetPos( x, y + 60)


    local ItemClicker = vgui.Create( "DButton", ItemBackground )
    ItemClicker:SetText("")
    ItemClicker:SetPos( 0, 0 )
    ItemClicker:SetSize( ItemBackground:GetWide(), ItemBackground:GetTall() )
    ItemClicker.Paint = function() -- Paint function
	return false
    end
	ItemClicker.DoClick = function() RunConsoleCommand("use","zw_buildtool")
	ChooseProp( tostring(k) )
	end


StrongPanel:AddItem( ItemBackground )
end


local SpecialPanel = vgui.Create( "DPanelList" )
SpecialPanel:SetTall( 635 )
SpecialPanel:SetWide( 980 )
SpecialPanel:SetPos( 5, 25 )
SpecialPanel:EnableVerticalScrollbar( true )
SpecialPanel:EnableHorizontal( true )
SpecialPanel:SetSpacing( 5 )


for k, v in SortedPairsByMemberValue( SpecialSpawns, "Cost" ) do

    local ItemBackground = vgui.Create( "DPanel" )
    ItemBackground:SetPos( 5, 5 )
    ItemBackground:SetSize( 150, 150 )
    ItemBackground.Paint = function() -- Paint function
        draw.RoundedBoxEx(8,1,1,ItemBackground:GetWide()-2,ItemBackground:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
	surface.SetDrawColor(50, 50, 50 ,255)
	surface.DrawOutlinedRect(0, 0, ItemBackground:GetWide(), ItemBackground:GetTall())
    end

    local ItemDisplay = vgui.Create( "SpawnIcon", ItemBackground )
    ItemDisplay:SetPos( 35, 5 )
    ItemDisplay:SetModel( v.Model )
    ItemDisplay:SetToolTip(v.Description)
    ItemDisplay:SetSize(75,75)
    ItemDisplay.PaintOver = function()
        return
    end
    ItemDisplay.OnMousePressed = function()
        return false
    end

    local ItemName = vgui.Create( "DLabel", ItemBackground )
    ItemName:SetFont( "TargetIDSmall" )
    ItemName:SetColor( Color(205,205,205,255) )
    ItemName:SetText( v.Name )
    ItemName:SizeToContents()
    ItemName:Center()
    local x,y = ItemName:GetPos();
    ItemName:SetPos( x, y + 20)

    local ItemCost = vgui.Create( "DLabel", ItemBackground )
    ItemCost:SetFont( "TargetIDSmall" )
    ItemCost:SetColor( Color(155,255,155,255) )
    ItemCost:SetText( "Cost: ".. v.Cost.." Gold" )
    ItemCost:SizeToContents()
    ItemCost:Center()
    local x,y = ItemCost:GetPos();
    ItemCost:SetPos( x, y + 40)


    local ItemClicker = vgui.Create( "DButton", ItemBackground )
    ItemClicker:SetText("")
    ItemClicker:SetPos( 15, 125 )
    ItemClicker:SetTextColor( Color(255,255,255,255) )
    ItemClicker:SetText( "Place Blueprint" )
    ItemClicker:SetSize( 120, 20 )
    ItemClicker.Paint = function() -- Paint function
	surface.SetDrawColor(20, 20, 60 ,200)
	surface.DrawRect( 0, 0, ItemClicker:GetWide(), ItemClicker:GetTall() )
	surface.SetDrawColor(0, 0, 150 ,255)
	surface.DrawOutlinedRect( 0, 0, ItemClicker:GetWide(), ItemClicker:GetTall() )
    end
	ItemClicker.DoClick = function() RunConsoleCommand("use","zw_buildtool")
	ChooseStructure( k )
	end


SpecialPanel:AddItem( ItemBackground )
end





 
PropertySheet:AddSheet( "Flimsy Props", FlimsyPanel, "icon16/bin.png", 
false, false, "Flimsy props aren't particularly strong and can be damaged by everything.  On the upside they are dirt cheap." )
PropertySheet:AddSheet( "Strong Props", StrongPanel, "icon16/shield.png", 
false, false, "Strong props can only be damaged by explosives or zombie attacks.  They are a bit more costly than flimsy props though." )
PropertySheet:AddSheet( "Faction Structures", SpecialPanel, "icon16/brick.png", 
false, false, "This menu contains special structres such as functional doors, base components etc." )

end