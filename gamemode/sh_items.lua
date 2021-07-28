
/*
Item template:

["item_healthkit"] = { 											-- what the item will be called within the games code, can be anything as long as you don't use the same name twice
	["Name"] = "Medkit", 										-- what the item will be called ingame
	["Cost"] = 200,												-- how many Gold will it cost if you buy it from the trader?
	["Model"] = "models/Items/HealthKit.mdl",					-- the items model
	["Description"] = "stuff",									-- the description will show up in the trader buy menu and in your inventory when you mouse over it
	["Weight"] = 1,												-- weight in kilograms (if your american and want to use imperial then your shit out of luck m8)
	["Supply"] = 0,												-- how many of these items does each trader have in stock? stock refills every 24 hours.  Putting 0 means unlimited stock, Putting -1 as stock will make it so the item isn't sold by traders
	["Rarity"] = 1,												-- 1 = junk, 2 = common, 3 = uncommon, 4 = rare, 5 = unique, 6 = legendary
	["Category"] = 1,											-- 1 = supplies, 2 = ammunition, 3 = weapons, any other = ignored by trader
	["UseFunc"] = stuff 										-- the function to call when the player uses the item from their inventory, you will need lua skillz here
	["DropFunc"] = stuff 										-- the function to call when the player drops the item
}


// IMPORTANT NOTE: use and drop functions must always return true or false here.  Returning true will subtract one of that item type from the player, returning false will make it so nothing is subtracted.
see server/player_inventory.lua for more info


*/



ItemsList = {
	["item_bandage"] = {
		["Name"] = "Bandage",
		["Cost"] = 45,
		["Model"] = "models/props/cs_office/paper_towels.mdl",
		["Description"] = "A rolled up bandage that can be used to stop bleeding or to splint broken limbs",
		["Weight"] = 0.5,
		["Supply"] = 0,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 25, 0, "physics/cardboard/cardboard_box_strain"..math.random(1,3)..".wav") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_bandage") return drop end,
	},

	["item_healthkit"] = {
		["Name"] = "Medkit",
		["Cost"] = 150,
		["Model"] = "models/Items/HealthKit.mdl",
		["Description"] = "An all purpose medkit that contains various medical supplies and a small dose of zombie antidote",
		["Weight"] = 1,
		["Supply"] = 30,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 50, 20, "items/medshot4.wav") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_healthkit") return drop end,
	},

	["item_antidote"] = {
		["Name"] = "Antidote",
		["Cost"] = 100,
		["Model"] = "models/healthvial.mdl",
		["Description"] = "A rare and expensive antidote that is capable of curing the zombie plague, It's a shame this wasn't invented until most of the world had already been overrun",
		["Weight"] = 0.25,
		["Supply"] = 15,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local healing = UseFunc_Heal(ply, 5, 50, "items/medshot4.wav") return healing end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_antidote") return drop end,
	},

	["item_soda"] = {
		["Name"] = "Can of Softdrink",
		["Cost"] = 20,
		["Model"] = "models/props_junk/PopCan01a.mdl",
		["Description"] = "An old pre apocalyptic softdrink, it even still has bubbles left in it! Restores 10% hunger",
		["Weight"] = 0.25,
		["Supply"] = 0,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 10, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_soda") return drop end,
	},

	["item_beerbottle"] = {
		["Name"] = "Bottle of Beer",
		["Cost"] = 50,
		["Model"] = "models/props_junk/garbage_glassbottle003a.mdl",
		["Description"] = "Makes the apocalypse a bit more bearable. Restores 20% hunger",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 20, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_beerbottle") return drop end,
	},

	["item_tinnedfood"] = {
		["Name"] = "Tinned Rations",
		["Cost"] = 40,
		["Model"] = "models/props_junk/garbage_metalcan001a.mdl",
		["Description"] = "A tin of god knows what, the label fell off a long time ago.  Restores 25% hunger",
		["Weight"] = 0.5,
		["Supply"] = 50,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 25, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_tinnedfood") return drop end,
	},

	["item_potato"] = {
		["Name"] = "Potato",
		["Cost"] = 50,
		["Model"] = "models/props_phx/misc/potato.mdl",
		["Description"] = "A potato, tastes awful raw but it's edible nonetheless.  Restores 30% hunger",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 30, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_potato") return drop end,
	},

	["item_traderfood"] = {
		["Name"] = "Trader's Special",
		["Cost"] = 60,
		["Model"] = "models/props_junk/garbage_takeoutcarton001a.mdl",
		["Description"] = "A box of rather dubious looking meat and ramen, prepared for you by your friendly local trader.  Restores 50% Hunger",
		["Weight"] = 0.75,
		["Supply"] = 25,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 50, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_traderfood") return drop end,
	},

	["item_trout"] = {
		["Name"] = "River Trout",
		["Cost"] = 80,
		["Model"] = "models/props/CS_militia/fishriver01.mdl",
		["Description"] = "A tasty, fresh river trout.  Restores 75% Hunger",
		["Weight"] = 0.75,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 75, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_trout") return drop end,
	},

	["item_melon"] = {
		["Name"] = "Watermelon",
		["Cost"] = 80,
		["Model"] = "models/props_junk/watermelon01.mdl",
		["Description"] = "A fresh, tasty watermelon, fresh from the farming compounds up in the mountains.  Restores 100% Hunger",
		["Weight"] = 1,
		["Supply"] = 10,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 100, "npc/barnacle/barnacle_gulp2.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_melon") return drop end,
	},

	["item_burger"] = {
		["Name"] = "Cheez Burger",
		["Cost"] = 20,
		["Model"] = "models/food/burger.mdl",
		["Description"] = "I can haz cheezburger?",
		["Weight"] = 0.5,
		["Supply"] = -1,
		["Rarity"] = 6,
		["Category"] = 1,
		["UseFunc"] = function(ply) local food = UseFunc_Eat(ply, 100, "vo/npc/male01/yeah02.wav") return food end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_burger") return drop end,
	},


	["item_bed"] = {
		["Name"] = "Bed",
		["Cost"] = 50,
		["Model"] = "models/props/de_inferno/bed.mdl",
		["Description"] = "Allows you to sleep and set your spawn location.",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
		["DropFunc"] = function(ply) local bool = UseFunc_DeployBed(ply, 1) return bool end,
	},

	["item_sleepingbag"] = {
		["Name"] = "Sleeping Bag",
		["Cost"] = 500,
		["Model"] = "models/props_c17/FurnitureMattress001a.mdl",
		["Description"] = "A sleeping bag that can be re-used.",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) UseFunc_Sleep(ply, false) return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_sleepingbag") return drop end,
	},

	["item_amnesiapills"] = {
		["Name"] = "Amnesia Pills",
		["Cost"] = 250,
		["Model"] = "models/props_lab/jar01b.mdl",
		["Description"] = "A bottle of pills that cause you to forget everything you've ever learned.  Resets all your stats and refunds your stat points",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) local bool = UseFunc_Respec(ply) return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_amnesiapills") return drop end,
	},






-- sellables





	["item_scrap"] = {
		["Name"] = "Scrap Metal",
		["Cost"] = 400,
		["Model"] = "models/Gibs/helicopter_brokenpiece_02.mdl",
		["Description"] = "Scrap metal.  It doesn't really do anything but the traders might still buy it from you",
		["Weight"] = 1,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_scrap") return drop end,
	},

	["item_chems"] = {
		["Name"] = "Chemicals",
		["Cost"] = 600,
		["Model"] = "models/props_junk/plasticbucket001a.mdl",
		["Description"] = "Some old chemicals that might be useful for explosives.  The trader will pay good money for this",
		["Weight"] = 1.5,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_chems") return drop end,
	},

	["item_tv"] = {
		["Name"] = "Old TV",
		["Cost"] = 800,
		["Model"] = "models/props_c17/tv_monitor01.mdl",
		["Description"] = "An old television that appears to be intact.  The trader will pay good money for this",
		["Weight"] = 2,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_tv") return drop end,
	},

	["item_beer"] = {
		["Name"] = "Crate of Beer",
		["Cost"] = 1000,
		["Model"] = "models/props/CS_militia/caseofbeer01.mdl",
		["Description"] = "A crate of unopened beer.  The trader will pay good money for this",
		["Weight"] = 2,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_beer") return drop end,
	},

	["item_hamradio"] = {
		["Name"] = "Ham Radio",
		["Cost"] = 1500,
		["Model"] = "models/props_lab/citizenradio.mdl",
		["Description"] = "A working ham radio.  The trader will pay good money for this",
		["Weight"] = 2.5,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_hamradio") return drop end,
	},

	["item_computer"] = {
		["Name"] = "Old Computer",
		["Cost"] = 2000,
		["Model"] = "models/props_lab/harddrive02.mdl",
		["Description"] = "Working computers are a very rare find these days.  The trader will pay good money for this",
		["Weight"] = 2,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, I don't have any use for it") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_computer") return drop end,
	},


	["item_blueprint_sawbow"] = {
		["Name"] = "Saw-Bow Blueprint",
		["Cost"] = 5000,
		["Model"] = "models/props_lab/clipboard.mdl",
		["Description"] = "A clipboard containing some highly interesting blueprints for a crossbow that fires sawblades.  I should take this to the trader and see what he thinks.",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, He might be able to build this thing") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_blueprint_sawbow") return drop end,
	},

	["item_blueprint_railgun"] = {
		["Name"] = "Railgun Blueprint",
		["Cost"] = 5000,
		["Model"] = "models/props_lab/clipboard.mdl",
		["Description"] = "A clipboard containing some highly interesting blueprints for a high tech railgun.  I should take this to the trader and see what he thinks.",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should probably take this to the trader, He might be able to build this thing") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_blueprint_railgun") return drop end,
	},









-- junk




	["item_junk_tin"] = {
		["Name"] = "Empty Tin",
		["Cost"] = 0,
		["Model"] = "models/props_junk/garbage_metalcan002a.mdl",
		["Description"] = "This once contained food, now it only contains despair",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_tin") return drop end,
	},

	["item_junk_boot"] = {
		["Name"] = "Old Boot",
		["Cost"] = 0,
		["Model"] = "models/props_junk/Shoe001a.mdl",
		["Description"] = "Smells like cheesy feet",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_boot") return drop end,
	},


	["item_junk_paper"] = {
		["Name"] = "Old Newspaper",
		["Cost"] = 0,
		["Model"] = "models/props_junk/garbage_newspaper001a.mdl",
		["Description"] = "The latest news and gossip from 1993",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_paper") return drop end,
	},

	["item_junk_keyboard"] = {
		["Name"] = "Keyboard",
		["Cost"] = 0,
		["Model"] = "models/props_c17/computer01_keyboard.mdl",
		["Description"] = "There aren't any computers left to connect this to",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_keyboard") return drop end,
	},

	["item_junk_pot"] = {
		["Name"] = "Garden Pot",
		["Cost"] = 0,
		["Model"] = "models/props_junk/terracotta01.mdl",
		["Description"] = "There's no time for watching grass grow these days.",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_pot") return drop end,
	},

	["item_junk_paint"] = {
		["Name"] = "Bucket of Dried Paint",
		["Cost"] = 0,
		["Model"] = "models/props_junk/metal_paintcan001a.mdl",
		["Description"] = "Dried up old paint",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_paint") return drop end,
	},

	["item_junk_doll"] = {
		["Name"] = "Toy Doll",
		["Cost"] = 0,
		["Model"] = "models/props_c17/doll01.mdl",
		["Description"] = "Creepy looking little bastard",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_doll") return drop end,
	},

	["item_junk_pot"] = {
		["Name"] = "Rusted Tin Pot",
		["Cost"] = 0,
		["Model"] = "models/props_interiors/pot02a.mdl",
		["Description"] = "This could be useful if it wasn't rusted through at the bottom",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_pot") return drop end,
	},

	["item_junk_hula"] = {
		["Name"] = "Hula Doll",
		["Cost"] = 0,
		["Model"] = "models/props_lab/huladoll.mdl",
		["Description"] = "Wind it up and it does the macarena! pretty cool but you can't eat it, fuck it or use it as a weapon so in the trash it goes.",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_hula") return drop end,
	},

	["item_junk_nailbox"] = {
		["Name"] = "Empty Nail Box",
		["Cost"] = 0,
		["Model"] = "models/props_lab/box01a.mdl",
		["Description"] = "This once contained nails, now a family of cockroaches live in it.",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_nailbox") return drop end,
	},

	["item_junk_twig"] = {
		["Name"] = "Twig",
		["Cost"] = 0,
		["Model"] = "models/props/cs_office/Snowman_arm.mdl",
		["Description"] = "Get some wood",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 1,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "This is just useless trash") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_twig") return drop end,
	},









-- crafting related




	["item_craft_fueltank"] = {
		["Name"] = "Fuel Tank",
		["Cost"] = 500,
		["Model"] = "models/props_junk/metalgascan.mdl",
		["Description"] = "An empty fuel tank, used to craft vehicles",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should find a vehicle dealer so i can build a vehicle with this") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_junk_fueltank") return drop end,
	},

	["item_craft_wheel"] = {
		["Name"] = "Car Wheel",
		["Cost"] = 300,
		["Model"] = "models/props_vehicles/carparts_wheel01a.mdl",
		["Description"] = "A car wheel fitted with a tyre that still holds air",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should find a vehicle dealer so i can build a vehicle with this") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_wheel") return drop end,
	},

	["item_craft_oil"] = {
		["Name"] = "Engine Oil",
		["Cost"] = 500,
		["Model"] = "models/props_junk/garbage_plasticbottle001a.mdl",
		["Description"] = "A bottle of engine lubricant, required to make an engine run without exploding",
		["Weight"] = 0.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should find a vehicle dealer so i can build a vehicle with this") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_oil") return drop end,
	},

	["item_craft_battery"] = {
		["Name"] = "Battery Cell",
		["Cost"] = 500,
		["Model"] = "models/Items/car_battery01.mdl",
		["Description"] = "A standard battery used in many different things",
		["Weight"] = 0.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I can't do anything with this just now, i should go find a crafting station or vehicle dealer") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_battery") return drop end,
	},

	["item_craft_ecb"] = {
		["Name"] = "Electronic Control Box",
		["Cost"] = 250,
		["Model"] = "models/props_lab/reciever01b.mdl",
		["Description"] = "An electronic control box used in the construction of various vehicles and special weapons",
		["Weight"] = 0.2,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I can't do anything with this just now, i should go find a crafting station or vehicle dealer") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_ecb") return drop end,
	},

	["item_craft_engine_small"] = {
		["Name"] = "Small engine",
		["Cost"] = 500,
		["Model"] = "models/gibs/airboat_broken_engine.mdl",
		["Description"] = "A small petrol engine, it looks to be in decent condition",
		["Weight"] = 0.5,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should find a vehicle dealer so i can build a vehicle with this") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_engine_small") return drop end,
	},

	["item_craft_engine_large"] = {
		["Name"] = "Large engine",
		["Cost"] = 1000,
		["Model"] = "models/props_c17/TrapPropeller_Engine.mdl",
		["Description"] = "A big block engine, this looks like a bit of love and care would restore it to working order.",
		["Weight"] = 1,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 1,
		["UseFunc"] = function(ply) SendChat(ply, "I should find a vehicle dealer so i can build a vehicle with this") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_craft_engine_large") return drop end,
	},









-- guns









	["weapon_zw_noobcannon"] = {
		["Name"] = "Noob Cannon",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_pist_glock18.mdl",
		["Description"] = "My first peashooter, given to all players that are under level 10 when they spawn",
		["Weight"] = 1.5,
		["Supply"] = -1, -- -1 stock means the traders will never sell this item
		["Rarity"] = 1,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_noobcannon") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_noobcannon") if drop then ply:StripWeapon("weapon_zw_noobcannon")end  return drop end,
	},

	["weapon_zw_pigsticker"] = {
		["Name"] = "Pig Sticker",
		["Cost"] = 100,
		["Model"] = "models/weapons/w_knife_ct.mdl",
		["Description"] = "A combat knife that can save your ass if you run out of ammo",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 1,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_pigsticker") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_pigsticker") if drop then ply:StripWeapon("weapon_zw_pigsticker")end  return drop end,
	},

	["weapon_zw_axe"] = {
		["Name"] = "Axe",
		["Cost"] = 1000,
		["Model"] = "models/props/CS_militia/axe.mdl",
		["Description"] = "Can i axe you a question?",
		["Weight"] = 2,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_axe") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_axe") if drop then ply:StripWeapon("weapon_zw_axe")end  return drop end,
	},

	["weapon_ate_wrench"] = {
		["Name"] = "Builder's Wrench",
		["Cost"] = 300,
		["Model"] = "models/props_c17/tools_wrench01a.mdl",
		["Description"] = "A wrench that is required to build and repair props and base components.  Can also be used as a bashing weapon though it isn't very effective.",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_ate_wrench") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_ate_wrench") if drop then ply:StripWeapon("weapon_zw_wrench")end  return drop end,
	},

	["weapon_zw_scrapsword"] = {
		["Name"] = "Scrap Sword",
		["Cost"] = 2000,
		["Model"] = "models/props_c17/TrapPropeller_Blade.mdl",
		["Description"] = "A massive, heavy blade made of rusty scrap metal welded together.  I hope you have taken your tetanus vaccine",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scrapsword") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scrapsword") if drop then ply:StripWeapon("weapon_zw_scrapsword")end  return drop end,
	},

	["weapon_zw_g20"] = {
		["Name"] = "G20 Gov Issue",
		["Cost"] = 250,
		["Model"] = "models/weapons/w_pist_glock18.mdl",
		["Description"] = "A newer model of glock that was popular among police and servicemen before the apocalpyse",
		["Weight"] = 2,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_g20") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_g20") if drop then ply:StripWeapon("weapon_zw_g20")end  return drop end,
	},

	["weapon_zw_57"] = {
		["Name"] = "FN FiveSeven",
		["Cost"] = 350,
		["Model"] = "models/weapons/w_pist_fiveseven.mdl",
		["Description"] = "A fast firing pistol that spews a hail of small high velocity bullets",
		["Weight"] = 2,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_57") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_57") if drop then ply:StripWeapon("weapon_zw_57")end  return drop end,
	},

	["weapon_zw_u45"] = {
		["Name"] = "U-45 Whisper",
		["Cost"] = 400,
		["Model"] = "models/weapons/w_pist_usp.mdl",
		["Description"] = "A silencable pistol that used to be popular among swat and miltary outfits",
		["Weight"] = 2.5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_u45") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_u45") if drop then ply:StripWeapon("weapon_zw_u45")end  return drop end,
	},


	["weapon_zw_warren50"] = {
		["Name"] = "Warren .50",
		["Cost"] = 600,
		["Model"] = "models/weapons/w_pist_deagle.mdl",
		["Description"] = "A powerful and flashy pistol that fires heavy magnum rounds, warrens are still in high demand despite their high skill requirement to use effectively",
		["Weight"] = 3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_warren50") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_warren50") if drop then ply:StripWeapon("weapon_zw_warren50")end  return drop end,
	},

	["weapon_zw_python"] = {
		["Name"] = "Python Magnum",
		["Cost"] = 900,
		["Model"] = "models/weapons/w_357.mdl",
		["Description"] = "A bulky revolver that fires large caliber magnum bullets",
		["Weight"] = 3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_python") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_python") if drop then ply:StripWeapon("weapon_zw_python")end  return drop end,
	},

	["weapon_zw_dual"] = {
		["Name"] = "Dual Cutlass-9s",
		["Cost"] = 1400,
		["Model"] = "models/weapons/w_pist_elite.mdl",
		["Description"] = "A pair of custom built pistols that once belonged to a gunslinger of great renown",
		["Weight"] = 4,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_dual") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_dual") if drop then ply:StripWeapon("weapon_zw_dual")end  return drop end,
	},

	["weapon_zw_satan"] = {
		["Name"] = "Hand Cannon",
		["Cost"] = 1500,
		["Model"] = "models/weapons/w_m29_satan.mdl",
		["Description"] = "This thing is fucking huge, i hope i can fire it without breaking my wrist",
		["Weight"] = 4,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_satan") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_satan") if drop then ply:StripWeapon("weapon_zw_satan")end  return drop end,
	},

	["weapon_zw_mp11"] = {
		["Name"] = "MP-11 PDW",
		["Cost"] = 850,
		["Model"] = "models/weapons/w_smg_mac10.mdl",
		["Description"] = "An old machine pistol, makes for a decent close quarters weapon but performs poorly at longer ranges.  Uses pistol ammo",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_mp11") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_mp11") if drop then ply:StripWeapon("weapon_zw_mp11")end  return drop end,
	},

	["weapon_zw_rg900"] = {
		["Name"] = "RG-900",
		["Cost"] = 1000,
		["Model"] = "models/weapons/w_smg_tmp.mdl",
		["Description"] = "A modern tactical machine pistol fitted with an integrated silencer.  Uses pistol ammo",
		["Weight"] = 4.5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_rg900") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_rg900") if drop then ply:StripWeapon("weapon_zw_rg900")end  return drop end,
	},

	["weapon_zw_k5a"] = {
		["Name"] = "Kohl K5-A",
		["Cost"] = 1250,
		["Model"] = "models/weapons/w_smg_mp5.mdl",
		["Description"] = "This old german SMG may be an outdated design but it still packs a punch on the battlefield.  Uses pistol rounds",
		["Weight"] = 5.5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_k5a") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_k5a") if drop then ply:StripWeapon("weapon_zw_k5a")end  return drop end,
	},

	["weapon_zw_stinger"] = {
		["Name"] = "Stinger SR",
		["Cost"] = 1400,
		["Model"] = "models/weapons/w_smg1.mdl",
		["Description"] = "A burst fire machine pistol designed to be accurate enough to go toe to toe with longer range attackers",
		["Weight"] = 6,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_stinger") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_stinger") if drop then ply:StripWeapon("weapon_zw_stinger")end  return drop end,
	},

	["weapon_zw_bosch"] = {
		["Name"] = "Bosch-Sterling B-60",
		["Cost"] = 1750,
		["Model"] = "models/weapons/w_sten.mdl",
		["Description"] = "A dated but still reasonably effective SMG with an interesting side loading magazine",
		["Weight"] = 6.5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_bosch") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_bosch") if drop then ply:StripWeapon("weapon_zw_bosch")end  return drop end,
	},

	["weapon_zw_k8"] = {
		["Name"] = "Kohl K8",
		["Cost"] = 2000,
		["Model"] = "models/weapons/w_smg_ump45.mdl",
		["Description"] = "The last weapon design released by Kohl before germany was overrun by the zombies, this is a modern SMG that offers excellent power, efficiency and accuracy.  Uses pistol ammo",
		["Weight"] = 6.5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_k8") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_k8") if drop then ply:StripWeapon("weapon_zw_k8")end  return drop end,
	},

	["weapon_zw_k8c"] = {
		["Name"] = "Kohl K8-C",
		["Cost"] = 2500,
		["Model"] = "models/weapons/w_hk_usc.mdl",
		["Description"] = "An accurate carbine variant of the kohl K8 smg.  Uses pistol ammo",
		["Weight"] = 6,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_k8c") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_k8c") if drop then ply:StripWeapon("weapon_zw_k8c")end  return drop end,
	},

	["weapon_zw_shredder"] = {
		["Name"] = "The Shredder",
		["Cost"] = 2500,
		["Model"] = "models/weapons/w_smg_p90.mdl",
		["Description"] = "An experimental SMG that fires a hail of small high velocity bullets.  Uses pistol ammo",
		["Weight"] = 6,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_shredder") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_shredder") if drop then ply:StripWeapon("weapon_zw_shredder")end  return drop end,
	},

	["weapon_zw_boomstick"] = {
		["Name"] = "Boom Stick",
		["Cost"] = 1800,
		["Model"] = "models/weapons/w_double_barrel_shotgun.mdl",
		["Description"] = "A double barreled shotgun, you can't beat the classics",
		["Weight"] = 6,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_boomstick") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_boomstick") if drop then ply:StripWeapon("weapon_zw_boomstick")end  return drop end,
	},

	["weapon_zw_enforcer"] = {
		["Name"] = "M3 Enforcer",
		["Cost"] = 2200,
		["Model"] = "models/weapons/w_shot_m3super90.mdl",
		["Description"] = "A 12 guage pump shotgun that was commonly used by police and sport shooters before the apocalpyse",
		["Weight"] = 6.5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_enforcer") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_enforcer") if drop then ply:StripWeapon("weapon_zw_enforcer")end  return drop end,
	},

	["weapon_zw_sweeper"] = {
		["Name"] = "XS-12 Sweeper",
		["Cost"] = 4500,
		["Model"] = "models/weapons/w_shot_xm1014.mdl",
		["Description"] = "A 12 guage pump shotgun that was commonly used by police and sport shooters before the apocalpyse",
		["Weight"] = 7,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_sweeper") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_sweeper") if drop then ply:StripWeapon("weapon_zw_sweeper")end  return drop end,
	},

	["weapon_zw_ranger"] = {
		["Name"] = "XR-15 Ranger",
		["Cost"] = 3200,
		["Model"] = "models/weapons/w_rif_m4a1.mdl",
		["Description"] = "An iconic american rifle that has been kept up to modern standards via constant upgrades",
		["Weight"] = 8,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_ranger") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_ranger") if drop then ply:StripWeapon("weapon_zw_ranger")end  return drop end,
	},

	["weapon_zw_fusil"] = {
		["Name"] = "Fusil F1",
		["Cost"] = 3350,
		["Model"] = "models/weapons/w_rif_famas.mdl",
		["Description"] = "A tough, accurate rifle that was used in large numbers by the european union as they tried to quell the zombie plague",
		["Weight"] = 7.5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_fusil") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_fusil") if drop then ply:StripWeapon("weapon_zw_fusil")end  return drop end,
	},

	["weapon_zw_amex"] = {
		["Name"] = "Amex Carbine",
		["Cost"] = 3500,
		["Model"] = "models/weapons/w_rif_xamas.mdl",
		["Description"] = "A modern tactical carbine that is designed with urban combat in mind",
		["Weight"] = 7,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_amex") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_amex") if drop then ply:StripWeapon("weapon_zw_amex")end  return drop end,
	},

	["weapon_zw_stugcommando"] = {
		["Name"] = "Stug Commando",
		["Cost"] = 4000,
		["Model"] = "models/weapons/w_rif_sg552.mdl",
		["Description"] = "A shortened version of the Stug 556LR Sniper that has been optimized for use as an assault rifle",
		["Weight"] = 7.5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_stugcommando") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_stugcommando") if drop then ply:StripWeapon("weapon_zw_stugcommando")end  return drop end,
	},


	["weapon_zw_krukov"] = {
		["Name"] = "Krukov KA-74",
		["Cost"] = 5000,
		["Model"] = "models/weapons/w_rif_ak47.mdl",
		["Description"] = "A basic but still highly effective russian assault rifle",
		["Weight"] = 9,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_krukov") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_krukov") if drop then ply:StripWeapon("weapon_zw_krukov")end  return drop end,
	},

	["weapon_zw_l303"] = {
		["Name"] = "Lior L303",
		["Cost"] = 5500,
		["Model"] = "models/weapons/w_rif_galil.mdl",
		["Description"] = "A rugged assault rifle that was used by the Saudi Union before their homeland was nuked in an attempt to halt the spread of zombies",
		["Weight"] = 9.5,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_l303") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_l303") if drop then ply:StripWeapon("weapon_zw_l303")end  return drop end,
	},

	["weapon_zw_mars"] = {
		["Name"] = "MARS rifle",
		["Cost"] = 6500,
		["Model"] = "models/weapons/w_rif_tavor.mdl",
		["Description"] = "An advanced assault rifle chambered in an experimental 8x46mm bullet.  Uses rifle ammo",
		["Weight"] = 8.5,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_mars") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_mars") if drop then ply:StripWeapon("weapon_zw_mars")end  return drop end,
	},

	["weapon_zw_scar"] = {
		["Name"] = "FN SCAR",
		["Cost"] = 10000,
		["Model"] = "models/weapons/w_fn_scar_h.mdl",
		["Description"] = "The pinnacle of modern assault rifles, was produced in very small numbers before the apocalyose so a gun like this is a rare find indeed.  Uses rifle ammo",
		["Weight"] = 8.5,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scar") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scar") if drop then ply:StripWeapon("weapon_zw_scar")end  return drop end,
	},

	["weapon_zw_lmg"] = {
		["Name"] = "Sawtooth LMG-4",
		["Cost"] = 7500,
		["Model"] = "models/weapons/w_mach_m249para.mdl",
		["Description"] = "A bulky light machine gun built to provide constant suppression against enemies in combat",
		["Weight"] = 10,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_lmg") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_lmg") if drop then ply:StripWeapon("weapon_zw_lmg")end  return drop end,
	},


	["weapon_zw_antelope"] = {
		["Name"] = "Antelope 7.62",
		["Cost"] = 4000,
		["Model"] = "models/weapons/w_snip_scout.mdl",
		["Description"] = "A scoped sporting rifle that was often used for hunting before the zombie apocalypse.  Uses sniper ammo",
		["Weight"] = 8,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_antelope") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_antelope") if drop then ply:StripWeapon("weapon_zw_antelope")end  return drop end,
	},

	["weapon_zw_scimitar"] = {
		["Name"] = "Kohl K24 Scimitar",
		["Cost"] = 6000,
		["Model"] = "models/weapons/w_snip_g3sg1.mdl",
		["Description"] = "A burst fire sniper created by kohl to give infantry squads long range capabilites in battle",
		["Weight"] = 8.5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scimitar") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scimitar") if drop then ply:StripWeapon("weapon_zw_scimitar")end  return drop end,
	},

	["weapon_zw_dragunov"] = {
		["Name"] = "Dragunova",
		["Cost"] = 10000,
		["Model"] = "models/weapons/w_svd_dragunov.mdl",
		["Description"] = "The russians found this old sniper rifle to be particularly effective at popping off zombies, now you will too",
		["Weight"] = 9,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_dragunov") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_dragunov") if drop then ply:StripWeapon("weapon_zw_dragunov")end  return drop end,
	},

	["weapon_zw_blackhawk"] = {
		["Name"] = "Blackhawk Sniper",
		["Cost"] = 6500,
		["Model"] = "models/weapons/w_snip_sg550.mdl",
		["Description"] = "A powerful military sniper fitted with a silencer and NVG scope.  Uses sniper ammo",
		["Weight"] = 10,
		["Supply"] = -1,
		["Rarity"] = 4,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_blackhawk") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_blackhawk") if drop then ply:StripWeapon("weapon_zw_blackhawk")end  return drop end,
	},

	["weapon_zw_punisher"] = {
		["Name"] = "The Punisher",
		["Cost"] = 15000,
		["Model"] = "models/weapons/w_acc_int_aw50.mdl",
		["Description"] = "A massively powerful sniper rifle chambered in the .50BMG cartridge.  Uses sniper ammo",
		["Weight"] = 12,
		["Supply"] = 5,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_punisher") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_punisher") if drop then ply:StripWeapon("weapon_zw_punisher")end  return drop end,
	},
	
	["weapon_zw_scrapcrossbow"] = {
		["Name"] = "Explosive Crossbow",
		["Cost"] = 8000,
		["Model"] = "models/weapons/w_crossbow.mdl",
		["Description"] = "A crossbow cobbled together from various spare parts, it can fire explosive bolts.  Uses steel bolts",
		["Weight"] = 10,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_scrapcrossbow") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_scrapcrossbow") if drop then ply:StripWeapon("weapon_zw_scrapcrossbow")end  return drop end,
	},

	["weapon_zw_winchester"] = {
		["Name"] = "WINchester",
		["Cost"] = 2000,
		["Model"] = "models/weapons/w_winchester_1873.mdl",
		["Description"] = "They don't call this the WINchester for nothing amirite.  Uses Magnum rounds",
		["Weight"] = 7.5,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_winchester") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_winchester") if drop then ply:StripWeapon("weapon_zw_winchester")end  return drop end,
	},

	["weapon_zw_perrin"] = {
		["Name"] = "Perrin P-64",
		["Cost"] = 2000,
		["Model"] = "models/weapons/w_pp19_bizon.mdl",
		["Description"] = "A russian weapon designed to put assualt rifle levels of firepower in the hands of tankers and support crews.  Uses pistol rounds",
		["Weight"] = 6,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_perrin") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_perrin") if drop then ply:StripWeapon("weapon_zw_perrin")end  return drop end,
	},

	["weapon_zw_dammerung"] = {
		["Name"] = "Dammerung Assault Shotgun",
		["Cost"] = 2000,
		["Model"] = "models/weapons/w_usas_12.mdl",
		["Description"] = "A fully automatic 20 round assault shotgun that chews anybody in the room into pulpy red goop.  Uses shotgun rounds",
		["Weight"] = 9,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_dammerung") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_dammerung") if drop then ply:StripWeapon("weapon_zw_dammerung")end  return drop end,
	},

	["weapon_zw_rpg"] = {
		["Name"] = "RPG Launcher",
		["Cost"] = 20000,
		["Model"] = "models/weapons/w_rocket_launcher.mdl",
		["Description"] = "An RPG launcher primarily designed for busting vehicles or fortifications.  Uses rockets",
		["Weight"] = 9,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_rpg") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_rpg") if drop then ply:StripWeapon("weapon_zw_rpg")end  return drop end,
	},


	["weapon_zw_fuckinator"] = {
		["Name"] = "The Fuckinator",
		["Cost"] = 10000,
		["Model"] = "models/weapons/w_pist_p228.mdl",
		["Description"] = "Point away from face",
		["Weight"] = 2,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_fuckinator") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_fuckinator") if drop then ply:StripWeapon("weapon_zw_fuckinator")end  return drop end,
	},

	["weapon_zw_germanator"] = {
		["Name"] = "The Germanator",
		["Cost"] = 3000,
		["Model"] = "models/weapons/w_mp40smg.mdl",
		["Description"] = "An antique SMG that fires an unnecessarily large caliber bullet. Uses pistol ammo",
		["Weight"] = 4,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_germanator") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_germanator") if drop then ply:StripWeapon("weapon_zw_germanator")end  return drop end,
	},

	["weapon_zw_807"] = {
		["Name"] = "RM-807",
		["Cost"] = 4200,
		["Model"] = "models/weapons/w_remington_870_tact.mdl",
		["Description"] = "A 12 guage pump shotgun that fires extra strength magnum shells. Uses shotgun ammo",
		["Weight"] = 6.5,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_807") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_807") if drop then ply:StripWeapon("weapon_zw_807")end  return drop end,
	},




-- ammo

	["item_pistolammo"] = {
		["Name"] = "Pistol Bullets",
		["Cost"] = 25,
		["Model"] = "models/Items/BoxSRounds.mdl",
		["Description"] = "An ammo box that contains 100 pistol rounds",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 1,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "Pistol") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_pistolammo") return drop end,
	},

	["item_magammo"] = {
		["Name"] = "Magnum Bullets",
		["Cost"] = 35,
		["Model"] = "models/Items/357ammo.mdl",
		["Description"] = "An ammo box that contains 50 magnum rounds",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "357") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_magammo") return drop end,
	},

	["item_buckshotammo"] = {
		["Name"] = "Shotgun Slugs",
		["Cost"] = 45,
		["Model"] = "models/Items/BoxBuckshot.mdl",
		["Description"] = "An ammo box that contains 50 shotgun rounds",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "Buckshot") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_buckshotammo") return drop end,
	},

	["item_rifleammo"] = {
		["Name"] = "Rifle Bullets",
		["Cost"] = 55,
		["Model"] = "models/Items/BoxMRounds.mdl",
		["Description"] = "An ammo box that contains 100 assault rifle rounds",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 100, "ammo_rifle") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_rifleammo") return drop end,
	},

	["item_sniperammo"] = {
		["Name"] = "Sniper Ammo",
		["Cost"] = 80,
		["Model"] = "models/Items/BoxMRounds.mdl",
		["Description"] = "An ammo box that contains 50 sniper rifle bullets",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 50, "ammo_sniper") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_sniperammo") return drop end,
	},

	["item_crossbowbolt"] = {
		["Name"] = "Steel Bolts",
		["Cost"] = 100,
		["Model"] = "models/Items/CrossbowRounds.mdl",
		["Description"] = "An bundle of 20 steel bolts",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 20, "XBowBolt") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_crossbowbolt") return drop end,
	},

	["item_rocketammo"] = {
		["Name"] = "RPG Rocket",
		["Cost"] = 200,
		["Model"] = "models/weapons/w_missile_closed.mdl",
		["Description"] = "A missile designed for use with the RPG launcher",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 2,
		["UseFunc"] = function(ply) local bool = UseFunc_GiveAmmo(ply, 1, "RPG_Round") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "item_rocketammo") return drop end,
	},
	
    ["weapon_zw_plasmalauncher"] = {
		["Name"] = "Experimental Plasma Cannon",
		["Cost"] = 0,
		["Model"] = "models/weapons/w_physics.mdl",
		["Description"] = "The EPC is an experimental plasma launcher that uses no ammo and fires highly volatile and explosive plasma blasts.",
		["Weight"] = 20,
		["Supply"] = -1,
		["Rarity"] = 7,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_plasmalauncher") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_plasmalauncher") if drop then ply:StripWeapon("weapon_zw_plasmalauncher")end  return drop end,
	},

    ["weapon_zw_minigun"] = {
		["Name"] = "GAU-8C Chaingun",
		["Cost"] = 15000,
		["Model"] = "models/weapons/w_m134_minigun.mdl",
		["Description"] = "An enormous minigun that spews a constant stream of hot lead.",
		["Weight"] = 15,
		["Supply"] = -1,
		["Rarity"] = 5,
		["Category"] = 3,
		["UseFunc"] = function(ply) UseFunc_EquipGun(ply, "weapon_zw_minigun") return false end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_minigun") if drop then ply:StripWeapon("weapon_zw_minigun")end  return drop end,
	},

    ["weapon_zw_grenade_pipe"] = {
		["Name"] = "Pipe Bomb",
		["Cost"] = 100,
		["Model"] = "models/props_lab/pipesystem03a.mdl",
		["Description"] = "An explosive pipe bomb that can be useful for blowing up crowds of zombies or raining fire on enemy bases.",
		["Weight"] = 0.25,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_pipe", "nade_pipebombs") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_pipe") if drop then ply:StripWeapon("weapon_zw_grenade_pipe")end  return drop end,
	},

    ["weapon_zw_grenade_flare"] = {
		["Name"] = "Distress Flare",
		["Cost"] = 20,
		["Model"] = "models/props_lab/pipesystem03a.mdl",
		["Description"] = "A distress flare that is useful for lighting up dark areas",
		["Weight"] = 0.25,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_flare", "nade_flares") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_flare") if drop then ply:StripWeapon("weapon_zw_grenade_flare")end  return drop end,
	},

    ["weapon_zw_grenade_frag"] = {
		["Name"] = "Frag Grenade",
		["Cost"] = 175,
		["Model"] = "models/weapons/w_eq_fraggrenade.mdl",
		["Description"] = "A high powered military fragmentation grenade, these are a relatively rare find in this post apocalyptic world",
		["Weight"] = 0.25,
		["Supply"] = -1,
		["Rarity"] = 3,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_frag", "Grenade") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_frag") if drop then ply:StripWeapon("weapon_zw_grenade_frag")end  return drop end,
	},

    ["weapon_zw_grenade_molotov"] = {
		["Name"] = "Molotov Cocktail",
		["Cost"] = 175,
		["Model"] = "models/props_junk/garbage_glassbottle003a.mdl",
		["Description"] = "A bottle full of petrol with a burning rag stuffed into the top.  Perfect for hosting a zombie BBQ",
		["Weight"] = 0.25,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 3,
		["UseFunc"] = function(ply) local bool = UseFunc_EquipNade(ply, "weapon_zw_grenade_molotov", "nade_molotov") return bool end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropItem(ply, "weapon_zw_grenade_molotov") if drop then ply:StripWeapon("weapon_zw_grenade_molotov")end  return drop end,
	},






	["item_armor_leather"] = {
		["Name"] = "Leather Armor",
		["Cost"] = 2000,
		["Model"] = "models/player/group03/male_01.mdl",
		["Description"] = "A number of stiff leather pads stitched into your suit, will protect you against cuts and bites but it won't stop a bullet\nProtection: 5%\nSpeed Penalty: 0\nAttachment Slots: 1\nBattery: 0",
		["Weight"] = 1,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_leather") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_leather") return drop end,

		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 5,    -- damage reduction in percentage
			["speedloss"] = 0,    -- speed loss in source units ( default player sprint speed: 300 (400 with maxed speed stat))
			["slots"] = 1, 	      -- attachment slots
			["battery"] = 0,      -- battery capacity, suits with 0 battery will only be able to use passive attachments
			["allowmodels"] = nil -- force the player to be one of these models, nil to let them choose from the default citizen models
		}
	},

	["item_armor_chain"] = {
		["Name"] = "Chainmail Suit",
		["Cost"] = 2500,
		["Model"] = "models/player/group03/male_05.mdl",
		["Description"] = "A chainmail vest and leather pad combo that is worn underneath your oversuit\nProtection: 7.5%\nSpeed Penalty: 1\nAttachment Slots: 1\nBattery: 0",
		["Weight"] = 2,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_chain") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_chain") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 7.5,
			["speedloss"] = 10,
			["slots"] = 1,
			["battery"] = 0,
			["allowmodels"] = nil
		}
	},

	["item_armor_scrap"] = {
		["Name"] = "Scrap Armor",
		["Cost"] = 5000,
		["Model"] = "models/player/group03/male_05.mdl",
		["Description"] = "A set of scrap metal attached to your suit via straps and clips, offers good protection for the price range but it's rather bulky and heavy\nProtection: 10%\nSpeed Penalty: 3\nAttachment Slots: 2\nBattery: 0",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_scrap") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_scrap") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 10,
			["speedloss"] = 30,
			["slots"] = 2,
			["battery"] = 0,
			["allowmodels"] = nil
		}
	},

	["item_armor_slavshit"] = {
		["Name"] = "Slavshit Armor",
		["Cost"] = 8000,
		["Model"] = "models/player/stalker/bandit_brown.mdl",
		["Description"] = "CHEEKI BREEKI! it may look like an old overcoat but there's actually a light flak jacket and leather padding under there that offers ok-ish protection\nProtection: 10%\nSpeed Penalty: 1\nAttachment Slots: 2\nBattery: 0",
		["Weight"] = 2,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_slavshit") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_slavshit") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 10,
			["speedloss"] = 10,
			["slots"] = 2,
			["battery"] = 0,
			["allowmodels"] = {"models/player/stalker/bandit_brown.mdl", "models/player/stalker/bandit_black.mdl", "models/player/stalker/duty_vet.mdl"}
		}
	},

	["item_armor_merc"] = {
		["Name"] = "Mercenary Armor",
		["Cost"] = 11000,
		["Model"] = "models/player/guerilla.mdl",
		["Description"] = "A flak jacket worn with various other garments. It provides a good mix of protection and mobility for an affordable price.\nProtection: 15%\nSpeed Penalty: 2\nAttachment Slots: 2\nBattery: 50",
		["Weight"] = 3,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_merc") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_merc") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 15,
			["speedloss"] = 20,
			["slots"] = 2,
			["battery"] = 50,
			["allowmodels"] = {"models/player/guerilla.mdl", "models/player/arctic.mdl", "models/player/leet.mdl", "models/player/phoenix.mdl"}
		}
	},

	["item_armor_swat"] = {
		["Name"] = "SWAT Armor",
		["Cost"] = 16000,
		["Model"] = "models/player/gasmask.mdl",
		["Description"] = "Heavy riot gear used by swat teams and other special operations personnel.\nProtection: 17.5%\nSpeed Penalty: 5\nAttachment Slots: 2\nBattery: 50",
		["Weight"] = 4,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_swat") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_swat") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 17.5,
			["speedloss"] = 50,
			["slots"] = 2,
			["battery"] = 50,
			["allowmodels"] = {"models/player/gasmask.mdl", "models/player/riot.mdl", "models/player/swat.mdl" , "models/player/urban.mdl"}
		}
	},

	["item_armor_military"] = {
		["Name"] = "Military Armor",
		["Cost"] = 22000,
		["Model"] = "models/player/stalker/military_spetsnaz_green.mdl",
		["Description"] = "A set of high end military armor.\nProtection: 17.5%\nSpeed Penalty: 3.5\nAttachment Slots: 2\nBattery: 100",
		["Weight"] = 5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_military") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_military") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 20,
			["speedloss"] = 35,
			["slots"] = 2,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/military_spetsnaz_green.mdl", "models/player/stalker/military_spetsnaz_black.mdl"}
		}
	},

	["item_armor_veteran"] = {
		["Name"] = "Veteran's Armor",
		["Cost"] = 30000,
		["Model"] = "models/player/stalker/loner_vet.mdl",
		["Description"] = "A set of custom armor built by a veteran survivor.\nProtection: 25%\nSpeed Penalty: 3\nAttachment Slots: 3\nBattery: 100",
		["Weight"] = 5,
		["Supply"] = 0,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_veteran") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_veteran") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 25,
			["speedloss"] = 30,
			["slots"] = 3,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/loner_vet.mdl", "models/player/stalker/freedom_vet.mdl", "models/player/stalker/duty_vet.mdl"}
		}
	},

	["item_armor_master"] = {
		["Name"] = "Master's Armor",
		["Cost"] = 30000,
		["Model"] = "models/player/stalker/monolith_vet.mdl",
		["Description"] = "A set of veteran's armor that has been upgraded even further.\nProtection: 27.5%\nSpeed Penalty: 2\nAttachment Slots: 3\nBattery: 150",
		["Weight"] = 6,
		["Supply"] = -1,
		["Rarity"] = 2,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_master") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_master") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 27.5,
			["speedloss"] = 20,
			["slots"] = 3,
			["battery"] = 150,
			["allowmodels"] = {"models/player/stalker/monolith_vet.mdl"}
		}
	},

	["item_armor_exo"] = {
		["Name"] = "Exosuit Mk-1",
		["Cost"] = 40000,
		["Model"] = "models/player/stalker/loner_exo.mdl",
		["Description"] = "A set of armor consisting of heavy flak plating supported by a network of struts and servomotors.\nProtection: 35%\nSpeed Penalty: 6\nAttachment Slots: 3\nBattery: 100",
		["Weight"] = 10,
		["Supply"] = 0,
		["Rarity"] = 3,
		["Category"] = 4,
		["UseFunc"] = function(ply) UseFunc_EquipArmor(ply, "item_armor_exo") end,
		["DropFunc"] = function(ply) local drop = UseFunc_DropArmor(ply, "item_armor_exo") return drop end,
		-- armor only values
		["ArmorStats"] = {
			["reduction"] = 35,
			["speedloss"] = 60,
			["slots"] = 3,
			["battery"] = 100,
			["allowmodels"] = {"models/player/stalker/loner_exo.mdl", "models/player/stalker/freedom_exo.mdl", "models/player/stalker/merc_exo.mdl", "models/player/stalker/duty_exo.mdl"}
		}
	},

}


function UseFunc_Sleep(ply, bheal)
SendChat( ply, "You are now asleep" )
umsg.Start( "DrawSleepOverlay", ply )
umsg.End()
ply.Fatigue = 0
if bheal then
ply:SetHealth( 100 + ( ply.StatHealth * 5 ))
end
end


function UseFunc_DropItem(ply, item)
if !SERVER then return false end
if !ply:IsValid() or !ItemsList[item] or !ply:Alive() then return false end

local vStart = ply:GetShootPos()
local vForward = ply:GetAimVector()
local trace = {}
trace.start = vStart
trace.endpos = vStart + (vForward * 70)
trace.filter = ply
local tr = util.TraceLine( trace )
local EntDrop = ents.Create( "ate_droppeditem" )
EntDrop:SetPos( tr.HitPos )
EntDrop:SetAngles( Angle( 0, 0, 0 ) )
EntDrop:SetModel(ItemsList[item]["Model"])
EntDrop:SetNWString("ItemClass", item)
EntDrop:Spawn()
EntDrop:Activate()

return true

end


function UseFunc_DropArmor(ply, item) -- same as drop item but we don't want to set the dropped item to a playermodel do we?
if !SERVER then return false end
if !ply:IsValid() or !ItemsList[item] or !ply:Alive() then return false end

local vStart = ply:GetShootPos()
local vForward = ply:GetAimVector()
local trace = {}
trace.start = vStart
trace.endpos = vStart + (vForward * 70)
trace.filter = ply
local tr = util.TraceLine( trace )
local EntDrop = ents.Create( "ate_droppeditem" )
EntDrop:SetPos( tr.HitPos )
EntDrop:SetAngles( Angle( 0, 0, 0 ) )
EntDrop:SetModel("models/props/cs_office/cardboard_box01.mdl")
EntDrop:SetNWString("ItemClass", item)
EntDrop:Spawn()
EntDrop:Activate()

if ply.EquippedArmor == tostring(item) then
UseFunc_RemoveArmor(ply, item)
end

return true

end


function UseFunc_EquipArmor(ply, item)
if !SERVER then return false end
if !ply:IsValid() or !ItemsList[item] or !ply:Alive() then return false end

local used = ItemsList[item]

SendUseDelay( ply, 2 )

ply:EmitSound("npc/combine_soldier/zipline_hitground1.wav")

timer.Simple(2, function()
if !ply:IsValid() or !ply:Alive() then return false end
SystemMessage(ply, "You equipped "..used["Name"], Color(205,255,205,255), false)
ply.EquippedArmor = tostring(item)
ply:SetNWString("ArmorType", tostring(item))
RecalcPlayerModel( ply )
RecalcPlayerSpeed(ply)
end )


return false

end

function UseFunc_RemoveArmor(ply, item)
if !SERVER then return false end
if !ply:IsValid() then return false end

local used = ItemsList[item]

ply.EquippedArmor = "none"
ply:SetNWString("ArmorType", "none")
RecalcPlayerModel( ply )
RecalcPlayerSpeed(ply)

return false

end

function UseFunc_DeployBed(ply, type)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end

local vStart = ply:GetShootPos()
local vForward = ply:GetAimVector()
local trace = {}
trace.start = vStart
trace.endpos = vStart + (vForward * 70)
trace.filter = ply
local tr = util.TraceLine( trace )
local EntDrop = ents.Create( "bed" )
EntDrop:SetPos( tr.HitPos )
EntDrop:SetAngles( Angle( 0, 0, 0 ) )
EntDrop:Spawn()
EntDrop:Activate()
EntDrop.Owner = ply

for k, v in pairs(ents.FindByClass( "bed") ) do
	if v == EntDrop then continue end
	if !v.Owner:IsValid() or v.Owner == ply then v:Remove() end
end

return true

end


function UseFunc_EquipGun(ply, gun)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end
	if ply:GetActiveWeapon() != gun then
		ply:Give( gun )
		ply:SelectWeapon( gun )
	end
return false
end

function UseFunc_EquipNade(ply, gun, nadetype)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end
ply:GiveAmmo( 1, nadetype )
ply:Give( gun )

if ply:GetActiveWeapon() != gun then
	ply:SelectWeapon( gun )
end

return true
end

function UseFunc_GiveAmmo(ply, amount, type)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end
	ply:GiveAmmo( amount, type )
return true
end


function UseFunc_Heal(ply, hp, infection, snd)
if !SERVER then return false end
if !ply:IsValid() then return false end
	if ply:Alive() then
			if ply:Health() >= (100 + ( 5 * ply.StatHealth )) and ply.Infection < 1 then SendChat( ply, "You are perfectly fine, using this item would be wasteful." ) return false end
			ply:SetHealth( math.Clamp( ply:Health() + (hp * ( 1 + (ply.StatMedSkill * 0.05) )), 0, 100 + ( ply.StatHealth * 5 ) ) )
			ply.Infection = math.Clamp( ply.Infection - ((infection * 100) + ( 500 * ply.StatMedSkill )), 0, 10000 )
			ply:EmitSound(snd, 100, 100)
			SendUseDelay( ply, 2 )
			return true
	else
		SendChat( ply, "You should have healed yourself while you were still alive, idiot" ) -- if they try to call this function when they are dead
		print(ply.StatMedSkill)
		return false
	end
end

function UseFunc_Eat(ply, hunger, snd)
if !SERVER then return false end
if !ply:IsValid() then return false end
	if ply:Alive() then
			if ply.Hunger > 9000 then SendChat( ply, "You don't feel hungry." ) return false end
			ply.Hunger = math.Clamp( ply.Hunger + (hunger * 100), 0, 10000 )
			ply:EmitSound(snd, 100, 100)
			SendUseDelay( ply, 2 )
			return true
	else
		SendChat( ply, "Dead men have no use for food" ) -- if they try to call this function when they are dead
		return false
	end
end

function UseFunc_Respec(ply)
if !SERVER then return false end
if !ply:IsValid() or !ply:Alive() then return false end

local refund = 0 + ply.StatPoints
ply.StatPoints = 0

for k, v in pairs( StatsListServer ) do
	local TheStatPieces = string.Explode( ";", v )
	local TheStatName = TheStatPieces[1]
	refund = refund + tonumber(ply[ TheStatName ])
	ply[ TheStatName ] = 0
end

ply.StatPoints = refund

ply:EmitSound("npc/barnacle/barnacle_gulp2.wav")

net.Start("UpdatePeriodicStats")
net.WriteFloat( ply.Level )
net.WriteFloat( ply.Money )
net.WriteFloat( ply.XP )
net.WriteFloat( ply.StatPoints )
net.WriteFloat( ply.Bounty )
net.Send( ply )

net.Start("UpdatePerks")
net.WriteFloat( ply.StatDefense )
net.WriteFloat( ply.StatDamage )
net.WriteFloat( ply.StatSpeed )
net.WriteFloat( ply.StatHealth )
net.WriteFloat( ply.StatKnowledge )
net.WriteFloat( ply.StatMedSkill )
net.WriteFloat( ply.StatStrength )
net.WriteFloat( ply.StatEndurance )
net.WriteFloat( ply.StatSalvage )
net.WriteFloat( ply.StatBarter )
net.WriteFloat( ply.StatEngineer )
net.WriteFloat( ply.StatImmune )
net.WriteFloat( ply.StatSurvivor )
net.Send( ply )

SystemMessage(ply, "You took an amnesia pill and forgot everything you've learned! All stats have been reset to 0 and stat points refunded", Color(255,255,205,255), true)

return true

end