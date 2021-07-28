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

Config = {  }

Config[ "DebugLogging" ] = true -- do we want to save debug logs? logs are found in garrysmod/data/aftertheend/logs and can be sent to the developer to find and fix malfunctions within the gamemode

Config[ "WalkSpeed" ] = 150
Config[ "RunSpeed" ] = 300 -- remember that the speed skill increases your sprint speed by 10 for each level, so at 300 runspeed players can reach a possible maximum of 400 sprint speed

Config[ "MaxProps" ] = 60

Config[ "FactionCost" ] = 100 -- do you want faction making to cost money?
Config[ "VoluntaryPVP" ] = true -- is PvP voluntary? set to false to always force pvp, useful on gigantic maps like rp_stalker or if you just enjoy a more day-z ish experience

Config[ "Currency" ] = "Dollar" -- the s is added onto strings where needed, for example if you put the currency as "Dollar" it will come out as "Dollars" as needed

Config[ "NoobLevel" ] = 10 -- people who are this level or below are considered noobs
Config[ "NoobWeapon" ] = "weapon_zw_noobcannon" -- what gun to give to players if they are under the noob level and if they lost their previous one
Config[ "StartMoney" ] = 200 -- noob fund

Config[ "MaxZombies" ] = 60 -- how many standard zombies can exist at any given time, turn this down if your server is lagging from the zombie ai
Config[ "ZombieSpawnRate" ] = 15 -- fresh zombies will be spawned in every x seconds
Config[ "BossSpawnRate" ] = 3600 -- how fast the boss spawn timer will be run in seconds (3600 seconds = 1 hour).  Keep in mind that if there is less than 3 players online then the boss will never spawn regardless of spawn rate
Config[ "AirdropSpawnRate" ] = 4200 -- same as boss spawn rate but for airdrops

Config[ "MaxCaches" ] = 4 -- how many loot caches can exist in the map at any given time?

Config[ "VaultSize" ] = 200 -- vault size in kg
Config[ "FileSystem" ] = "Legacy" -- set to Legacy or PData
-- legacy saves player data as text files under garrysmod/data/aftertheend/profiles/(players steamid)/
-- Pdata saves their data to the servers sql file (garrysmod/sv.db)
-- Use the pdata system if you are having issues with text file saving/loading or if you prefer everything to be in the sql file.  No there isn't support for MySQL and there proably won't be unless you code it yourself.


-----------------------------ZOMBIE CLASSES-----------------------------

Config[ "ZombieClasses" ] = {

	["npc_ate_basic"] = { -- table name must be the entclass name of the zombie, see garrysmod/gamemodes/AfterTheEnd/entities for entclasses
		["SpawnChance"] = 65, -- spawn chance in %, be careful as the spawn chance of all your zombies totalled up must not exceed 100% (there is a helper function that will tell you if this has happened)
		["XPReward"] = 40, -- average xp reward for killing this zombie, varies with the VaryRewards setting above
		["MoneyReward"] = 20, -- average money reward for killing this zombie, varies with the VaryRewards setting above
	},

	["npc_ate_leaper"] = {
		["SpawnChance"] = 21,
		["XPReward"] = 50,
		["MoneyReward"] = 25,
	},

	["npc_ate_wraith"] = {
		["SpawnChance"] = 4,
		["XPReward"] = 60,
		["MoneyReward"] = 40,
	},

	["npc_ate_tank"] = {
		["SpawnChance"] = 6,
		["XPReward"] = 100,
		["MoneyReward"] = 80,
	},

	["npc_ate_puker"] = {
		["SpawnChance"] = 3,
		["XPReward"] = 90,
		["MoneyReward"] = 75,
	},

	["npc_ate_lord"] = {
		["SpawnChance"] = 1,
		["XPReward"] = 200,
		["MoneyReward"] = 150,
	},

}

-----------------------------BOSS CLASSES-----------------------------

Config[ "BossClasses" ] = {

	["npc_nextbot_boss_tyrant"] = {
		["SpawnChance"] = 100,
		["XPReward"] = 2500, -- remember that xp and money for bosses is distributed by who damaged them, if you did all of the damage you would get 2,500 cash and xp in this case
		["MoneyReward"] = 2500,
		["SpawnDelay"] = 20, -- how long to wait before actually spawning it, gives the radio message time to play out
		["AnnounceMessage"] = "[BOSS]: the Tyrant has appeared!",
		["BroadCast"] = function()
		RadioBroadcast(1, "This is an urgent broadcast on all bands!", "Watchdog")
		RadioBroadcast(4, "Siesmic readings are showing a massive quadruped approaching the area, most likely a tyrant", "Watchdog")
		RadioBroadcast(8, "It is currently inbound for this sector so you'd all better get inside something solid and make sure you have plenty of ammo", "Watchdog")
		end,
	},

}


-----------------------------NOOB GEAR-----------------------------

-- what to give to players when they join the server for the first time

Config[ "NoobGear" ] = {

	-- behold the beautiful new inventory format

	-- 3x bandages
	["item_bandage"] = 3,

	-- 3x antidote
	["item_antidote"] = 3,

	-- 1x bed
	["item_bed"] = 1,

	-- 3x tinned rations
	["item_tinnedfood"] = 3,

	-- 1x noob cannon
	["weapon_zw_noobcannon"] = 1,
}

-- what noobs will have in their vault

Config[ "NoobVault" ] = {
["weapon_zw_grenade_pipe"] = 3,
}






Config["Vehicles"] = {
	["Basic Hatchback (Yellow)"] = {
		["Health"] = 1000,
		["Description"] = "A basic hatchback, not the fastest or the strongest but it'll get you there (eventually)",
		["Seats"] = 2,
		["Fuel"] = 1000,
		["Model"] = "models/source_vehicles/car001a_hatchback_skin1.mdl",
		["Requirements"] = {
			["item_craft_wheel"] = 4,
			["item_craft_engine_small"] = 1,
			["item_craft_battery"] = 1,
			["item_craft_fueltank"] = 1,
			["item_craft_oil"] = 1,
			["item_scrap"] = 5,
			},
		},

	["Basic Hatchback (Red)"] = {
		["Health"] = 1000,
		["Description"] = "A basic hatchback, not the fastest or the strongest but it'll get you there (eventually)",
		["Seats"] = 2,
		["Fuel"] = 1000,
		["Model"] = "models/source_vehicles/car001a_hatchback_skin0.mdl",
		["Requirements"] = {
			["item_craft_wheel"] = 4,
			["item_craft_engine_small"] = 1,
			["item_craft_battery"] = 1,
			["item_craft_fueltank"] = 1,
			["item_craft_oil"] = 1,
			["item_scrap"] = 5,
			},
		},

	["Large Sedan"] = {
		["Health"] = 1250,
		["Description"] = "A large, rather slow sedan that can carry 4 people",
		["Seats"] = 4,
		["Fuel"] = 1000,
		["Model"] = "models/source_vehicles/car005a.mdl",
		["Requirements"] = {
			["item_craft_wheel"] = 4,
			["item_craft_engine_small"] = 1,
			["item_craft_battery"] = 1,
			["item_craft_fueltank"] = 1,
			["item_craft_oil"] = 1,
			["item_scrap"] = 8,
			},
		},

	["Hotrodded Hatchback (yellow)"] = {
		["Health"] = 1250,
		["Description"] = "A tougher, faster version of the standard hatchback",
		["Seats"] = 2,
		["Fuel"] = 1500,
		["Model"] = "models/source_vehicles/car001a_hatchback_skin0.mdl",
		["Requirements"] = {
			["item_craft_wheel"] = 4,
			["item_craft_engine_large"] = 1,
			["item_craft_battery"] = 1,
			["item_craft_fueltank"] = 2,
			["item_craft_oil"] = 2,
			["item_scrap"] = 5,
			},
		},


}


----------------------------------------------------------------------------------------------------------------
----------------------------------------------ADMIN CHECKS------------------------------------------------------
-- I'm creating these functions here so that you can alter the checks to suit your own servers ranking system --
--   Superadmins can spawn themselves weapons and cash, admins only have the ate_admin_clearzombies command   --
----------------------------------------------------------------------------------------------------------------

function SuperAdminCheck( ply )
if !ply:IsValid() then return false end
if ply:IsUserGroup("superadmin") or ply:IsSuperAdmin() then return true end

return false --above check failed so they must not be admin
end

function AdminCheck( ply )
if !ply:IsValid() then return false end
if ply:IsUserGroup("superadmin") or ply:IsSuperAdmin() or ply:IsUserGroup("admin") or ply:IsAdmin() then return true end

return false
end