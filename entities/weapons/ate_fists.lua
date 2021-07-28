
AddCSLuaFile()

SWEP.PrintName	= "Hands"

SWEP.Author		= "LegendofRobbo"
SWEP.Purpose	= "Use right click to pick shit up and left click to smack your bitch up"

SWEP.DrawCrosshair	= false
SWEP.Spawnable	= true
SWEP.UseHands	= true
SWEP.DrawAmmo	= false

SWEP.ViewModel	= "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel	= ""

SWEP.ViewModelFOV	= 52
SWEP.Slot			= 0
SWEP.SlotPos		= 0

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"

local SwingSound = Sound( "weapons/slam/throw.wav" )
local HitSound = Sound( "Flesh.ImpactHard" )

SWEP.PassiveMode = false

function SWEP:Initialize()

	self:SetHoldType( "fist" )

end

function SWEP:PreDrawViewModel( vm, wep, ply )

	vm:SetMaterial( "engine/occlusionproxy" ) -- Hide that view model with hacky material

end

SWEP.HitDistance = 48

function SWEP:SetupDataTables()
	
	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
	self:NetworkVar( "Float", 1, "NextIdle" )
	self:NetworkVar( "Int", 2, "Combo" )
	
end

function SWEP:UpdateNextIdle()

	local vm = self.Owner:GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() )
	
end

function SWEP:PrimaryAttack( )

if self.Owner:KeyDown(IN_USE) then
self:SetNextPrimaryFire( CurTime() + 0.8 )
self:SetNextSecondaryFire( CurTime() + 0.8 )
if ( IsFirstTimePredicted() ) then
self.PassiveMode = !self.PassiveMode
end

else
	if self.PassiveMode then return false end

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local anim = "fists_right" 

	if math.random(1,2) == 1 then
	anim = "fists_left"
	end

	if ( self:GetCombo() >= 2 ) then
		anim = "fists_uppercut"
	end

	self.Owner:ViewPunch( Angle(math.random(0.5, 1.5), math.random(0.5, 1.5), math.random(0.5, 1.5)) )

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self:EmitSound( SwingSound )

	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.2 )
	
	self:SetNextPrimaryFire( CurTime() + 0.9 )
	self:SetNextSecondaryFire( CurTime() + 0.9 )
end

end


function SWEP:CanCarry(entity)
	local physicsObject = entity:GetPhysicsObject()

	if (!IsValid(physicsObject)) then
		return false
	end

	if (physicsObject:GetMass() > 150 or !physicsObject:IsMoveable()) then
		return false
	end

	if (IsValid(entity.carrier)) then
		return false
	end

	return true
end

function SWEP:DoPickup(entity)
	if (entity:IsPlayerHolding()) then
		return
	end

	timer.Simple(FrameTime() * 10, function()
		if (!IsValid(entity) or entity:IsPlayerHolding()) then
			return
		end


		self.Owner:PickupObject(entity)
		self.Owner:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 3)..".wav", 75)
	end)

	self:SetNextPrimaryFire( CurTime() + 0.9 )
	self:SetNextSecondaryFire(CurTime() + 1)
end


function SWEP:SecondaryAttack()
	if ( !IsFirstTimePredicted() ) then
	 return
	end
	local trace = self.Owner:GetEyeTraceNoCursor()
	local entity = trace.Entity

	if (SERVER and IsValid(entity)) then
		local distance = self.Owner:EyePos():Distance(trace.HitPos)

		if (distance > 100) then
			return
		end

		if (!entity:IsPlayer() and !entity:IsNPC() and self:CanCarry(entity)) then
			local phys = entity:GetPhysicsObject()
			phys:Wake()
			self:DoPickup(entity)
			self:SetNextSecondaryFire(CurTime() + 0.5)
		else
		if !entity:IsPlayer() and !entity:IsNPC() then
		SendChat( self.Owner, "I can't pick this up!" )
		end
		self:SetNextSecondaryFire(CurTime() + 0.5)
		end
	end
end


function SWEP:DealDamage()

	local anim = self:GetSequenceName(self.Owner:GetViewModel():GetSequence())

	self.Owner:LagCompensation( true )
	
	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
		filter = self.Owner
	} )

	if ( !IsValid( tr.Entity ) ) then 
		tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mins = Vector( -10, -10, -8 ),
			maxs = Vector( 10, 10, 8 )
		} )
	end

	-- We need the second part for single player because SWEP:Think is ran shared in SP.
	if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then
		self:EmitSound( HitSound )
	end

	local hit = false

	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local dmginfo = DamageInfo()
	
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )

		dmginfo:SetInflictor( self )
		dmginfo:SetDamage( math.random( 8, 12 ) )

		if ( anim == "fists_left" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * 4912 + self.Owner:GetForward() * 9998 ) -- Yes we need those specific numbers
		elseif ( anim == "fists_right" ) then
			dmginfo:SetDamageForce( self.Owner:GetRight() * -4912 + self.Owner:GetForward() * 9989 )
		elseif ( anim == "fists_uppercut" ) then
			dmginfo:SetDamageForce( self.Owner:GetUp() * 5158 + self.Owner:GetForward() * 10012 )
			dmginfo:SetDamage( math.random( 12, 24 ) )
		end

		tr.Entity:TakeDamageInfo( dmginfo )
		hit = true

	end

	if ( SERVER && IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass(), tr.HitPos )
		end
	end

	if ( SERVER ) then
		if ( hit && anim != "fists_uppercut" ) then
			self:SetCombo( self:GetCombo() + 1 )
		else
			self:SetCombo( 0 )
		end
	end

	self.Owner:LagCompensation( false )

end

function SWEP:OnRemove()
	
	if ( IsValid( self.Owner ) ) then
		local vm = self.Owner:GetViewModel()
		if ( IsValid( vm ) ) then vm:SetMaterial( "" ) end
	end
	
end

function SWEP:Holster( wep )

	self:OnRemove()

	return true

end

function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )
	
	self:UpdateNextIdle()
	
	if ( SERVER ) then
		self:SetCombo( 0 )
	end
	
	return true

end

function SWEP:Think()
	
	local vm = self.Owner:GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()

	if self.PassiveMode == true then self:SetHoldType( "normal" ) else self:SetHoldType( "fist" ) end
	
	if ( idletime > 0 && CurTime() > idletime ) then

		vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )
		
		self:UpdateNextIdle()

	end
	
	local meleetime = self:GetNextMeleeAttack()
	
	if ( meleetime > 0 && CurTime() > meleetime ) then

		self:DealDamage()
		
		self:SetNextMeleeAttack( 0 )

	end
	
	if ( SERVER && CurTime() > self:GetNextPrimaryFire() + 0.1 ) then
		
		self:SetCombo( 0 )
		
	end
	
end

function SWEP:DrawHUD()

	if not (LocalPlayer():InVehicle()) then
	surface.DrawCircle( ScrW() /2 -17, ScrH() /2 -16, 3, Color(50, 50, 50, 45) )
	surface.DrawCircle( ScrW() /2 +16, ScrH() /2 -16, 3, Color(50, 50, 50, 45) )

	surface.DrawCircle( ScrW() /2 -17, ScrH() /2 +16, 3, Color(50, 50, 50, 45) )
	surface.DrawCircle( ScrW() /2 +16, ScrH() /2 +16, 3, Color(50, 50, 50, 45) )

--	surface.DrawCircle( ScrW() /2 -1, ScrH() /2, 16, Color(50, 50, 50, 55) )

--	surface.SetDrawColor(155, 155, 155, 155)

--	surface.DrawLine(ScrW() /2 + 7, ScrH() /2 -12, ScrW() /2 -9, ScrH() /2 -12) -- top
--	surface.DrawLine(ScrW() /2 + 7, ScrH() /2 +12, ScrW() /2 -9, ScrH() /2 +12) -- bottom

--	surface.DrawCircle( ScrW() /2, ScrH() /2, 12, Color(200, 200, 250, 255) )
--	surface.DrawCircle( ScrW() /2, ScrH() /2, 14, Color(50, 50, 50, 255) )
end
end

function SWEP:GetViewModelPosition( pos, ang )
 	if self.PassiveMode then
	ang:RotateAroundAxis( ang:Right(), -16 )
	end
 
	return pos, ang
 
end