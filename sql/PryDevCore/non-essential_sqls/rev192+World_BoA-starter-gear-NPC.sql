-- Ref vendor and set a higher guid for spawned creature
SET @BoA :=99006;
SET @guid :=138510;

-- Clean first before inserting data
DELETE FROM `creature` WHERE `id`=@BoA;
DELETE FROM `creature_template` WHERE `entry`=@BoA;
DELETE FROM `npc_vendor` WHERE `entry`=@BoA;

-- Create vendor that give BoA
INSERT INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction_A`,`faction_H`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`equipment_id`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`WDBVerified`) VALUES
(@BoA,            -- entry
0,                -- difficulty_entry_1
0,                -- difficulty_entry_2
0,                -- difficulty_entry_3
0,                -- KillCredit1
0,                -- KillCredit2
25900,            -- modelid1
0,                -- modelid2
0,                -- modelid3
0,                -- modelid4
'Azarel',         -- name
'BoA Trader',     -- subname
'',               -- IconeName
0,                -- gossip_menu_id
80,               -- minlevel
80,               -- maxlevel
0,                -- exp
35,               -- faction_A
35,               -- faction_h
4224,             -- npcflag
1,                -- speed_walk
1,                -- speed_run
2.5,              -- scale
0,                -- rank
1755,             -- mindmg
1755,             -- maxdmg
0,                -- dmgschool
1504,             -- attackpower
1,                -- dmg_multiplier
1500,             -- baseattacktime
0,                -- rangeattacktime
2,                -- unit_class
0,                -- unit_flags
0,                -- dynamicflags
0,                -- family
0,                -- trainer_type
0,                -- trainer_spell
0,                -- trainer_class
0,                -- trainer_race
0,                -- minrangedmg
0,                -- maxrangedmg
0,                -- rangedattackpower
7,                -- type
0,                -- type_flags
0,                -- lootid
0,                -- pickpocketloot
0,                -- skinloot
0,                -- resistance1
0,                -- resistance2
0,                -- resistance3
0,                -- resistance4
0,                -- resistance5
0,                -- resistance6
0,                -- spell1
0,                -- spell2
0,                -- spell3
0,                -- spell4
0,                -- spell5
0,                -- spell6
0,                -- spell7
0,                -- spell8
0,                -- PetSpellDataId
0,                -- VehicleId
0,                -- mingold
0,                -- maxgold
'',               -- AIName
0,                -- MovementType
3,                -- InhabitType
1,                -- Health_mod
1,                -- Mana_mod
1,                -- Armor_mod
0,                -- RacialLeader
0,                -- questItem1
0,                -- questItem2
0,                -- questItem3
0,                -- questItem4
0,                -- questItem5
0,                -- questItem6
0,                -- movementId
1,                -- RegenHealth
0,                -- equipment_id
0,                -- mechanic_immune_mask
2,                -- flags_extra
'',               -- ScriptName
0);               -- WDBVerified

-- Insert BoA item to vendor
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES 
(@BoA,0,42943,0,0,0), -- Bloodied Arcanite Reaper
(@BoA,0,42944,0,0,0), -- Balanced Heartseeker
(@BoA,0,42945,0,0,0), -- Venerable Dal'Rend's Sacred Charge
(@BoA,0,42946,0,0,0), -- Charmed Ancient Bone Bow
(@BoA,0,42947,0,0,0), -- Dignified Headmaster's Charge
(@BoA,0,42948,0,0,0), -- Devout Aurastone Hammer
(@BoA,0,42949,0,0,0), -- Polished Spaulders of Valor
(@BoA,0,42950,0,0,0), -- Champion Herod's Shoulder
(@BoA,0,42951,0,0,0), -- Mystical Pauldrons of Elements
(@BoA,0,42952,0,0,0), -- Stained Shadowcraft Spaulders
(@BoA,0,42984,0,0,0), -- Preened Ironfeather Shoulders
(@BoA,0,42985,0,0,0), -- Tattered Dreadmist Mantle
(@BoA,0,42991,0,0,0), -- Swift Hand of Justice
(@BoA,0,42992,0,0,0), -- Discerning Eye of the Beast
(@BoA,0,44091,0,0,0), -- Sharpened Scarlet Kris
(@BoA,0,44092,0,0,0), -- Reforged Truesilver Champion
(@BoA,0,44093,0,0,0), -- Upgraded Dwarven Hand Cannon
(@BoA,0,44094,0,0,0), -- The Blessed Hammer of Grace
(@BoA,0,44095,0,0,0), -- Grand Staff of Jordan
(@BoA,0,44096,0,0,0), -- Battleworn Thrash Blade
(@BoA,0,44097,0,0,0), -- Inherited Insignia of the Horde
(@BoA,0,44098,0,0,0), -- Inherited Insignia of the Alliance
(@BoA,0,44099,0,0,0), -- Strengthened Stockade Pauldrons
(@BoA,0,44100,0,0,0), -- Pristine Lightforge Spaulders
(@BoA,0,44101,0,0,0), -- Prized Beastmaster's Mantle
(@BoA,0,44102,0,0,0), -- Aged Pauldrons of The Five Thunders
(@BoA,0,44103,0,0,0), -- Exceptional Stormshroud Shoulders
(@BoA,0,44105,0,0,0), -- Lasting Feralheart Spaulders
(@BoA,0,44107,0,0,0), -- Exquisite Sunderseer Mantle
(@BoA,0,48677,0,0,0), -- Champion's Deathdealer Breastplate
(@BoA,0,48685,0,0,0), -- Polished Breastplate of Valor
(@BoA,0,48687,0,0,0), -- Preened Ironfeather Breastplate
(@BoA,0,48689,0,0,0), -- Stained Shadowcraft Tunic
(@BoA,0,48683,0,0,0), -- Mystical Vest of Elements
(@BoA,0,48691,0,0,0), -- Tattered Dreadmist Robe
(@BoA,0,48716,0,0,0), -- Venerable Mass of McGowan
(@BoA,0,48718,0,0,0), -- Repurposed Lava Dredger
(@BoA,0,50255,0,0,0); -- Dread Pirate Ring

-- Spawn vendor near the starting area for Horde and alliance.
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES 
-- Alliance side spawn
(@guid,@BoA,0,1,1,0,0,-9022.275391,-76.134964,88.489632,5.9219,100,0,0,4274,3994,0,0), -- Human (Northshire Valley)
(@guid+1,@BoA,0,1,1,0,0,-6170.66,350.627,400.116,1.93837,100,0,0,4274,3994,0,0), -- Dwarf and Gnome (Coldridge Valley)
(@guid+2,@BoA,1,1,1,0,0,10411.7,781.667,1322.71,5.26217,100,0,0,4274,3994,0,0), -- NightElf (Shadowglen)
(@guid+3,@BoA,530,1,1,0,0,-4112.79,-13749,73.5646,4.35504,100,0,0,4274,3994,0,0), -- Draenei (Crash Site)
-- Horde side spawn
(@guid+4,@BoA,1,1,1,0,0,-597.151,-4210.22,38.4318,4.08879,100,0,0,4274,3994,0,0), -- Orc and Troll (Valley of Trial)
(@guid+5,@BoA,0,1,1,0,0,1883.85,1614.12,93.4042,4.55138,100,0,0,4274,3994,0,0), -- Undead (Deathknell)
(@guid+6,@BoA,1,1,1,0,0,-2899.01,-231.723,53.8403,4.66684,100,0,0,4274,3994,0,0), -- Tauren (Camp Narache)
(@guid+7,@BoA,530,1,1,0,0,10359.4,-6408.47,38.5311,1.88496,100,0,0,4274,3994,0,0), -- BloodElf (The Sunspire)
-- DeathKnight side Spawn
(@guid+8,@BoA,609,1,1,0,0,2435.74,-5610.41,420.092,3.71887,100,0,0,4274,3994,0,0), -- DeathKnight (The Heart of Acherus) #1
(@guid+9,@BoA,0,1,1,0,0,2435.74,-5610.41,420.092,3.71887,100,0,0,4274,3994,0,0); -- DeathKnight (The Heart of Acherus) #2


-- If you dont like it and want it deleted from your database, just run this:
-- SET @BoA :=99006;

-- Delete BoA vendor from the datadase
-- DELETE FROM `creature` WHERE `id`=@BoA;
-- DELETE FROM `creature_template` WHERE `entry`=@BoA;
-- DELETE FROM `npc_vendor` WHERE `entry`=@BoA;