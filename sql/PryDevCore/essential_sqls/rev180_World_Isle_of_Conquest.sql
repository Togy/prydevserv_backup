UPDATE gameobject_template SET size=2.151325 WHERE entry=195451;
UPDATE gameobject_template SET size=2.151325 WHERE entry=195452;
UPDATE gameobject_template SET size=3.163336 WHERE entry=195223;
UPDATE creature_template SET speed_run=1.142857 WHERE entry=36154;
UPDATE creature_template SET speed_run=1.142857 WHERE entry=36169;

-- Canon of the Alliance gunboat
UPDATE `creature_template` SET `spell1`=69495,`VehicleId`='452' WHERE `entry` =34929;

-- Canon of the Horde gunboat 
UPDATE `creature_template` SET `spell1`=68825,`VehicleId`='453' WHERE `entry` =34935;

-- the cannon of the keep
UPDATE `creature_template` SET `VehicleId`=160,`spell1`=67452,`spell2`='68169' WHERE `entry` =34944;

-- Catapult
UPDATE `creature_template` SET `VehicleId`=438,`spell1`=66218,`spell2`=66296 WHERE `entry`=34793;

-- Wrecker
UPDATE `creature_template` SET `VehicleId`='509',`spell1`='67442',`spell2`='68068' WHERE `entry` =34775;

-- Siege engine
UPDATE `creature_template` SET `VehicleId`=447,`spell1`=67816,`spell2`=69502 WHERE `entry`=34776;

-- Siege engine
UPDATE `creature_template` SET `VehicleId`=436,`spell1`=67816,`spell2`=69502 WHERE `entry`=35069;

-- Launcher sword
UPDATE `creature_template` SET `VehicleId`=447,`spell1`=68827,`spell2`=69515 WHERE `entry`=34802;

-- Launcher sword
UPDATE `creature_template` SET `VehicleId`=447,`spell1`=68827,`spell2`=69515 WHERE `entry`=35273;

-- Flame Turret
UPDATE `creature_template` SET `spell1`='68832' WHERE `entry` =34778;

-- Flame Turret
UPDATE `creature_template` SET `spell1`='68832' WHERE `entry` =36356;

-- Turret head
UPDATE `creature_template` SET `spell1`=67462,`spell2`=69505 WHERE `entry`=34777;

-- Turret head
UPDATE `creature_template` SET `spell1`=67462,`spell2`=69505 WHERE `entry`=36355;

-- Catapult speed
UPDATE creature_template SET `speed_run`=2.428571,`speed_walk`=2.8 WHERE `entry`=34793;

-- Overlord Agmar &   script
UPDATE creature_template SET `ScriptName`='boss_isle_of_conquest' WHERE `entry` IN (34924,34922);

DELETE FROM `trinity_string` WHERE entry BETWEEN 12011 AND 12039;
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(12039, 'the alliance keep', '', '', '', '', '', '', '', ''),
(12038, 'the Horde keep', '', '', '', '', '', '', '', ''),
(12037, 'The Alliance took the Horde keep!', '', '', '', '', '', '', '', ''),
(12036, 'The Horde took the Alliance keep!', '', '', '', '', '', '', '', ''),
(12035, '%s the keep!', '', '', '', '', '', '', '', ''),
(12034, '%s attacked the Horde keep!', '', '', '', '', '', '', '', ''),
(12033, '%s attacked the Alliance keep!', '', '', '', '', '', '', '', ''),
(12032, 'The west gate of the Horde keep is destroyed!', '', '', '', '', '', '', '', ''),
(12031, 'The east gate of the Horde keep was destroyed!', '', '', '', '', '', '', '', ''),
(12030, 'The south gate of the Horde keep was destroyed!', '', '', '', '', '', '', '', ''),
(12029, 'The west gate of the Alliance keep is destroyed!', '', '', '', '', '', '', '', ''),
(12028, 'The east gate of the Alliance keep is destroyed!', '', '', '', '', '', '', '', ''),
(12027, 'The north gate of the Alliance keep is destroyed!', '', '', '', '', '', '', '', ''),
(12026, 'The battle will begin in 15 seconds!', '', '', '', '', '', '', '', ''),
(12025, '$n has assaulted the %s', '', '', '', '', '', '', '', ''),
(12024, '$n has defended the %s', '', '', '', '', '', '', '', ''),
(12023, '$n claims the %s! If left unchallenged, the %s will control it in 1 minute!', '', '', '', '', '', '', '', ''),
(12022, 'Alliance', '', '', '', '', '', '', '', ''),
(12021, 'Horde', '', '', '', '', '', '', '', ''),
(12020, 'The %s has taken the %s', '', '', '', '', '', '', '', ''),
(12019, 'Workshop', '', '', '', '', '', '', '', ''),
(12018, 'Docks', '', '', '', '', '', '', '', ''),
(12017, 'Refinery', '', '', '', '', '', '', '', ''),
(12016, 'Quarry', '', '', '', '', '', '', '', ''),
(12015, 'Hangar', '', '', '', '', '', '', '', ''),
(12014, 'The battle has begun!', '', '', '', '', '', '', '', ''),
(12013, 'The battle will begin in 30 seconds!', '', '', '', '', '', '', '', ''),
(12012, 'The battle will begin in one minute!', '', '', '', '', '', '', '', ''),
(12011, 'The battle will begin in two minutes!', '', '', '', '', '', '', '', '');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (66548, 66549, 66550);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(66548, 66550, 0, 'Isle of Conquest (OUT>IN)'),
(66549, 66550, 0, 'Isle of Conquest (IN>OUT)'),
(66550, -66549, 2, 'Isle of Conquest Teleport (OUT>IN) Debuff limit'),
(66550, -66548, 2, 'Isle of Conquest Teleport (IN>OUT) Debuff limit');

DELETE FROM `creature` WHERE `id` = 23472 AND `map` = 628;
DELETE FROM `creature` WHERE `id` = 22515 AND `map` = 628;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(250194, 23472, 628, 3, 1, 0, 0, 1139.92, -780.212, 48.6757, 3.16908, 300, 0, 0, 4120, 0, 0, 0),
(250214, 22515, 628, 3, 1, 0, 0, 323.214, -884.536, 48.9155, 1.59435, 300, 0, 0, 4120, 0, 0, 0),
(250212, 22515, 628, 3, 1, 0, 0, 325.953, -782.401, 48.9163, 4.65741, 300, 0, 0, 4120, 0, 0, 0),
(250210, 22515, 628, 3, 1, 0, 0, 393.258, -858.941, 48.9161, 3.22484, 300, 0, 0, 4120, 0, 0, 0),
(250208, 22515, 628, 3, 1, 0, 0, 1233.08, -840.021, 48.9176, 1.51268, 300, 0, 0, 4120, 0, 0, 0),
(250206, 22515, 628, 3, 1, 0, 0, 1162.9, -746.146, 48.6285, 6.1536, 300, 0, 0, 4120, 0, 0, 0),
(250203, 22515, 628, 3, 1, 0, 0, 1235.15, -689.807, 49.1079, 1.52132, 300, 0, 0, 4120, 0, 0, 0),
(250198, 23472, 628, 3, 1, 0, 0, 1235.61, -863.124, 48.9713, 4.7171, 300, 0, 0, 4120, 0, 0, 0),
(250196, 23472, 628, 3, 1, 0, 0, 1236.6, -663.616, 47.8887, 3.00572, 300, 0, 0, 4120, 0, 0, 0),
(250182, 23472, 628, 3, 1, 0, 0, 324.262, -745.282, 49.4923, 1.55901, 300, 0, 0, 4120, 0, 0, 0),
(250180, 23472, 628, 3, 1, 0, 0, 311.937, -918.894, 48.6856, 4.76736, 300, 0, 0, 4120, 0, 0, 0),
(250186, 23472, 628, 3, 1, 0, 0, 430.61, -857.491, 48.198, 0.074609, 300, 0, 0, 4120, 0, 0, 0);


REPLACE INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(66630, 'spell_gen_gunship_portal'),
(66637, 'spell_gen_gunship_portal'),
(66656, 'spell_gen_parachute_ic');

DELETE FROM `achievement_criteria_data` WHERE criteria_id IN (12062,12063,12064,12065);
INSERT INTO `achievement_criteria_data` (criteria_id,type,ScriptName) VALUES
(12062,11,'achievement_bg_control_all_nodes'),
(12063,11,'achievement_bg_control_all_nodes'),
(12064,11,'achievement_bg_control_all_nodes'),
(12065,11,'achievement_bg_control_all_nodes');

-- Achievement Four Car Garage
UPDATE `creature_template` SET `ScriptName`='npc_four_car_garage' WHERE `entry` IN (34802,34793,34775,35069,34776);
-- Achievement Glaive Grave
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=12183;
INSERT INTO `achievement_criteria_data` (criteria_id,type,ScriptName) VALUES (12183,11,'achievement_bg_ic_glaive_grave');

-- Achievement Mowed Down
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=12068;
INSERT INTO `achievement_criteria_data` (criteria_id,type,ScriptName) VALUES (12068,11,'achievement_bg_ic_mowed_down');

-- Achievement Resource Glut
DELETE FROM `achievement_criteria_data` WHERE criteria_id IN (12060,12061);
INSERT INTO `achievement_criteria_data` (criteria_id,type,ScriptName) VALUES
(12060,11,'achievement_bg_ic_resource_glut'),
(12061,11,'achievement_bg_ic_resource_glut');