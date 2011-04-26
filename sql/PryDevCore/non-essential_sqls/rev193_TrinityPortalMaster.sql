-- # Portal Master
-- # By Rochet2
-- # Downloaded from http://code.google.com/p/teleportnpcmangostrinity/
-- # Bugs and contact with E-mail: Rochet2@post.com
-- # Start

-- -----------------------------------------------------------------------------------------------------------------------------
-- # Defining what the entries and numbers are. Change if something overwrites something in your database

SET @TELENPC := 300000; -- # (1)
SET @GOPTION := 30000; -- # (9)
SET @GMENU := @GOPTION; -- # (9) Changes as Goption changes
SET @GSCRIPT := 30000; -- # (130)
SET @NPCTXT := 300000; -- # (5)

-- -----------------------------------------------------------------------------------------------------------------------------
-- # Delete code (For re running)

DELETE FROM creature_template WHERE entry=@TELENPC;
DELETE FROM gossip_menu WHERE entry=@GMENU OR entry=@GMENU+1 OR entry=@GMENU+2 OR entry=@GMENU+3 OR entry=@GMENU+4 OR entry=@GMENU+5 OR entry=@GMENU+6 OR entry=@GMENU+7 OR entry=@GMENU+8;
DELETE FROM gossip_menu_option WHERE menu_id=@GOPTION OR menu_id=@GOPTION+1 OR menu_id=@GOPTION+2 OR menu_id=@GOPTION+3 OR menu_id=@GOPTION+4 OR menu_id=@GOPTION+5 OR menu_id=@GOPTION+6 OR menu_id=@GOPTION+7 OR menu_id=@GOPTION+8;
DELETE FROM gossip_scripts WHERE id>@GSCRIPT-1 AND id<@GSCRIPT+135;
DELETE FROM npc_text WHERE ID=@NPCTXT OR ID=@NPCTXT+1 OR ID=@NPCTXT+2 OR ID=@NPCTXT+3 OR ID=@NPCTXT+4;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup>=@GOPTION AND SourceGroup<=@GOPTION+6 AND ConditionTypeOrReference=6 AND (ConditionValue1=469 OR ConditionValue1=67);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=@GMENU AND (SourceEntry=@NPCTXT+1 OR SourceEntry=@NPCTXT) AND ConditionTypeOrReference=6 AND (ConditionValue1=469 OR ConditionValue1=67);

-- -----------------------------------------------------------------------------------------------------------------------------
-- # TeleNPC

INSERT INTO creature_template (entry,modelid1,name,IconName,gossip_menu_id,minlevel,maxlevel,Health_mod,Mana_mod,Armor_mod,faction_A,faction_H,npcflag,speed_walk,speed_run,scale,rank,dmg_multiplier,unit_class,unit_flags,type,type_flags,InhabitType,RegenHealth,flags_extra) 
VALUES (@TELENPC,21572,'PDS Portal Master','Directions',@GMENU,71,71,1.56,1.56,1.56,35,35,3,1,1.14286,1.25,1,1,1,2,7,138936390,3,1,2);

-- -----------------------------------------------------------------------------------------------------------------------------
-- # Linking texts to the menus

INSERT INTO gossip_menu (entry, text_id) 
VALUES (@GMENU+4, @NPCTXT+3),
(@GMENU+3, @NPCTXT+2),
(@GMENU+2, @NPCTXT+2),
(@GMENU+1, @NPCTXT+2),
(@GMENU+8, @NPCTXT+4),
(@GMENU+7, @NPCTXT+4),
(@GMENU+6, @NPCTXT+4),
(@GMENU+5, @NPCTXT+4),
(@GMENU, @NPCTXT+1),
(@GMENU, @NPCTXT);

-- -----------------------------------------------------------------------------------------------------------------------------
-- # Gossip and gossip menu conditions

INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ConditionTypeOrReference, ConditionValue1, Comment) 
VALUES (15, @GOPTION, 1, 6, 469, 'Stormwind'),
(15, @GOPTION+5, 2, 6, 469, 'Dun Morogh'),
(15, @GOPTION+5, 3, 6, 67, 'Tirisfal Glades'),
(15, @GOPTION+5, 4, 6, 67, 'Ghostlands'),
(15, @GOPTION+5, 5, 6, 469, 'Loch modan'),
(15, @GOPTION+5, 6, 6, 67, 'Silverpine Forest'),
(15, @GOPTION+5, 7, 6, 469, 'Westfall'),
(15, @GOPTION+5, 8, 6, 469, 'Redridge mountains'),
(15, @GOPTION+5, 9, 6, 469, 'Duskwood'),
(15, @GOPTION+5, 11, 6, 469, 'Wetlands'),
(15, @GOPTION+6, 0, 6, 469, 'Azuremyst Isle'),
(15, @GOPTION+6, 1, 6, 469, 'Teldrassil'),
(15, @GOPTION+6, 2, 6, 67, 'Durotar'),
(15, @GOPTION+6, 3, 6, 67, 'Mulgore'),
(15, @GOPTION+6, 4, 6, 469, 'Bloodmyst Isle'),
(15, @GOPTION+6, 5, 6, 469, 'Darkshore'),
(15, @GOPTION+6, 6, 6, 67, 'The Barrens'),
(15, @GOPTION+5, 1, 6, 67, 'Eversong Woods'),
(15, @GOPTION+5, 0, 6, 469, 'Elwynn Forest'),
(15, @GOPTION+4, 22, 6, 67, 'Zul\'Aman'),
(15, @GOPTION, 2, 6, 67, 'Orgrimmar'),
(15, @GOPTION, 3, 6, 469, 'Darnassus'),
(15, @GOPTION, 4, 6, 469, 'Ironforge'),
(15, @GOPTION, 5, 6, 469, 'Exodar'),
(15, @GOPTION, 6, 6, 67, 'Thunder bluff'),
(15, @GOPTION, 7, 6, 67, 'Undercity'),
(15, @GOPTION, 8, 6, 67, 'Silvermoon city'),
(15, @GOPTION+1, 0, 6, 469, 'Gnomeregan'),
(15, @GOPTION+1, 1, 6, 469, 'The Deadmines'),
(15, @GOPTION+1, 2, 6, 469, 'The Stockade'),
(15, @GOPTION+1, 3, 6, 67, 'Ragefire Chasm'),
(15, @GOPTION+1, 4, 6, 67, 'Razorfen Downs'),
(15, @GOPTION+1, 5, 6, 67, 'Razorfen Kraul'),
(15, @GOPTION+1, 6, 6, 67, 'Scarlet Monastery'),
(15, @GOPTION+1, 7, 6, 67, 'Shadowfang Keep'),
(15, @GOPTION+1, 8, 6, 67, 'Wailing Caverns'),
(15, @GOPTION+6, 9, 6, 67, 'Thousand Needles'),
(14, @GMENU, @NPCTXT+1, 6, 469, 'For the Alliance'),
(14, @GMENU, @NPCTXT, 6, 67, 'For the Horde');

-- -----------------------------------------------------------------------------------------------------------------------------
-- # Gossip options

INSERT INTO gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text) 
VALUES (@GOPTION, 1, 2, 'Stormwind', 1, 1, @GOPTION, 0, @GSCRIPT, 0, 0, 'Are you sure,that you want to go to Stormwind?'),
(@GOPTION, 2, 2, 'Orgrimmar', 1, 1, @GOPTION, 0, @GSCRIPT+1, 0, 0, 'Are you sure,that you want to go to Orgrimmar?'),
(@GOPTION, 3, 2, 'Darnassus', 1, 1, @GOPTION, 0, @GSCRIPT+8, 0, 0, 'Are you sure,that you want to go to Darnassus?'),
(@GOPTION, 4, 2, 'Ironforge', 1, 1, @GOPTION, 0, @GSCRIPT+9, 0, 0, 'Are you sure,that you want to go to Ironforge?'),
(@GOPTION, 5, 2, 'Exodar', 1, 1, @GOPTION, 0, @GSCRIPT+10, 0, 0, 'Are you sure,that you want to go to Exodar?'),
(@GOPTION, 6, 2, 'Thunder bluff', 1, 1, @GOPTION, 0, @GSCRIPT+11, 0, 0, 'Are you sure,that you want to go to Thunder bluff?'),
(@GOPTION, 7, 2, 'Undercity', 1, 1, @GOPTION, 0, @GSCRIPT+12, 0, 0, 'Are you sure,that you want to go to Undercity?'),
(@GOPTION, 8, 2, 'Silvermoon city', 1, 1, @GOPTION, 0, @GSCRIPT+13, 0, 0, 'Are you sure,that you want to go to Silvermoon city?'),
(@GOPTION, 9, 2, 'Dalaran', 1, 1, @GOPTION, 0, @GSCRIPT+5, 0, 0, 'Are you sure,that you want to go to Dalaran?'),
(@GOPTION, 10, 2, 'Shattrath', 1, 1, @GOPTION, 0, @GSCRIPT+3, 0, 0, 'Are you sure,that you want to go to Shattrath?'),
(@GOPTION, 11, 2, 'Booty bay', 1, 1, @GOPTION, 0, @GSCRIPT+2, 0, 0, 'Are you sure,that you want to go to Booty bay?'),
(@GOPTION, 12, 2, 'Gurubashi arena', 1, 1, @GOPTION, 0, @GSCRIPT+6, 0, 0, 'Are you sure,that you want to go to Arena?'),
(@GOPTION, 13, 3, 'Eastern Kingdoms', 1, 1, @GOPTION+5, 0, 0, 0, 0, NULL),
(@GOPTION, 14, 3, 'Kalimdor', 1, 1, @GOPTION+6, 0, 0, 0, 0, NULL),
(@GOPTION, 15, 3, 'Outland', 1, 1, @GOPTION+7, 0, 0, 0, 0, NULL),
(@GOPTION, 16, 3, 'Northrend', 1, 1, @GOPTION+8, 0, 0, 0, 0, NULL),
(@GOPTION, 17, 9, 'Classic Dungeons', 1, 1, @GOPTION+1, 0, 0, 0, 0, NULL),
(@GOPTION, 18, 9, 'BC Dungeons', 1, 1, @GOPTION+2, 0, 0, 0, 0, NULL),
(@GOPTION, 19, 9, 'Wrath Dungeons', 1, 1, @GOPTION+3, 0, 0, 0, 0, NULL),
(@GOPTION, 20, 9, 'Raid Teleports', 1, 1, @GOPTION+4, 0, 0, 0, 0, NULL),
(@GOPTION+1, 0, 2, 'Gnomeregan', 1, 1, 0, 0, @GSCRIPT+14, 0, 0, 'Are you sure,that you want to go to Gnomeregan?'),
(@GOPTION+1, 1, 2, 'The Deadmines', 1, 1, 0, 0, @GSCRIPT+15, 0, 0, 'Are you sure,that you want to go to The Deadmines?'),
(@GOPTION+1, 2, 2, 'The Stockade', 1, 1, 0, 0, @GSCRIPT+16, 0, 0, 'Are you sure,that you want to go to The Stockade?'),
(@GOPTION+1, 3, 2, 'Ragefire Chasm', 1, 1, 0, 0, @GSCRIPT+17, 0, 0, 'Are you sure,that you want to go to Ragefire Chasm?'),
(@GOPTION+1, 4, 2, 'Razorfen Downs', 1, 1, 0, 0, @GSCRIPT+18, 0, 0, 'Are you sure,that you want to go to Razorfen Downs?'),
(@GOPTION+1, 5, 2, 'Razorfen Kraul', 1, 1, 0, 0, @GSCRIPT+19, 0, 0, 'Are you sure,that you want to go to Razorfen Kraul?'),
(@GOPTION+1, 6, 2, 'Scarlet Monastery', 1, 1, 0, 0, @GSCRIPT+20, 0, 0, 'Are you sure,that you want to go to Scarlet Monastery?'),
(@GOPTION+1, 7, 2, 'Shadowfang Keep', 1, 1, 0, 0, @GSCRIPT+21, 0, 0, 'Are you sure,that you want to go to Shadowfang Keep?'),
(@GOPTION+1, 8, 2, 'Wailing Caverns', 1, 1, 0, 0, @GSCRIPT+22, 0, 0, 'Are you sure,that you want to go to Wailing Caverns?'),
(@GOPTION+1, 9, 2, 'Blackfathom Deeps', 1, 1, 0, 0, @GSCRIPT+23, 0, 0, 'Are you sure,that you want to go to Blackfathom Deeps?'),
(@GOPTION+1, 10, 2, 'Blackrock Depths', 1, 1, 0, 0, @GSCRIPT+24, 0, 0, 'Are you sure,that you want to go to Blackrock Depths?'),
(@GOPTION+1, 11, 2, 'Blackrock Spire', 1, 1, 0, 0, @GSCRIPT+25, 0, 0, 'Are you sure,that you want to go to Blackrock Spire?'),
(@GOPTION+1, 12, 2, 'Dire Maul', 1, 1, 0, 0, @GSCRIPT+26, 0, 0, 'Are you sure,that you want to go to Dire Maul?'),
(@GOPTION+1, 13, 2, 'Maraudon', 1, 1, 0, 0, @GSCRIPT+27, 0, 0, 'Are you sure,that you want to go to Maraudon?'),
(@GOPTION+1, 14, 2, 'Scholomance', 1, 1, 0, 0, @GSCRIPT+28, 0, 0, 'Are you sure,that you want to go to Scholomance?'),
(@GOPTION+1, 15, 2, 'Stratholme', 1, 1, 0, 0, @GSCRIPT+29, 0, 0, 'Are you sure,that you want to go to Stratholme?'),
(@GOPTION+1, 16, 2, 'Sunken Temple', 1, 1, 0, 0, @GSCRIPT+30, 0, 0, 'Are you sure,that you want to go to Sunken Temple?'),
(@GOPTION+1, 17, 2, 'Uldaman', 1, 1, 0, 0, @GSCRIPT+31, 0, 0, 'Are you sure,that you want to go to Uldaman?'),
(@GOPTION+1, 18, 2, 'Zul\'Farrak', 1, 1, 0, 0, @GSCRIPT+32, 0, 0, 'Are you sure,that you want to go to Zul\'Farrak?'),
(@GOPTION+1, 19, 7, 'Back..', 1, 1, @GOPTION, 0, 0, 0, 0, NULL),
(@GOPTION+2, 0, 2, 'Auchindoun', 1, 1, 0, 0, @GSCRIPT+33, 0, 0, 'Are you sure,that you want to go to Auchindoun?'),
(@GOPTION+2, 1, 2, 'Caverns of Time', 1, 1, 0, 0, @GSCRIPT+34, 0, 0, 'Are you sure,that you want to go to Caverns of Time?'),
(@GOPTION+2, 2, 2, 'Coilfang Reservoir', 1, 1, 0, 0, @GSCRIPT+35, 0, 0, 'Are you sure,that you want to go to Coilfang Reservoir?'),
(@GOPTION+2, 3, 2, 'Hellfire Citadel', 1, 1, 0, 0, @GSCRIPT+36, 0, 0, 'Are you sure,that you want to go to Hellfire Citadel?'),
(@GOPTION+2, 4, 2, 'Magisters\' Terrace', 1, 1, 0, 0, @GSCRIPT+37, 0, 0, 'Are you sure,that you want to go to Magisters\' Terrace?'),
(@GOPTION+2, 5, 2, 'Tempest Keep', 1, 1, 0, 0, @GSCRIPT+38, 0, 0, 'Are you sure,that you want to go to Tempest Keep?'),
(@GOPTION+2, 6, 7, 'Back..', 1, 1, @GOPTION, 0, 0, 0, 0, NULL),
(@GOPTION+3, 0, 2, 'Azjol-Nerub', 1, 1, 0, 0, @GSCRIPT+39, 0, 0, 'Are you sure,that you want to go to Azjol-Nerub?'),
(@GOPTION+3, 1, 2, 'The Culling of Stratholme', 1, 1, 0, 0, @GSCRIPT+40, 0, 0, 'Are you sure,that you want to go to The Culling of Stratholme?'),
(@GOPTION+3, 2, 2, 'Trial of the Champion', 1, 1, 0, 0, @GSCRIPT+41, 0, 0, 'Are you sure,that you want to go to Trial of the Champion?'),
(@GOPTION+3, 3, 2, 'Drak\'Tharon Keep', 1, 1, 0, 0, @GSCRIPT+42, 0, 0, 'Are you sure,that you want to go to Drak\'Tharon Keep?'),
(@GOPTION+3, 4, 2, 'Gundrak', 1, 1, 0, 0, @GSCRIPT+43, 0, 0, 'Are you sure,that you want to go to Gundrak?'),
(@GOPTION+3, 5, 2, 'Icecrown Citadel Dungeons', 1, 1, 0, 0, @GSCRIPT+44, 0, 0, 'Are you sure,that you want to go to Icecrown Citadel Dungeons?'),
(@GOPTION+3, 6, 2, 'The Nexus Dungeons', 1, 1, 0, 0, @GSCRIPT+45, 0, 0, 'Are you sure,that you want to go to The Nexus Dungeons?'),
(@GOPTION+3, 7, 2, 'The Violet Hold', 1, 1, 0, 0, @GSCRIPT+46, 0, 0, 'Are you sure,that you want to go to The Violet Hold?'),
(@GOPTION+3, 8, 2, 'Halls of Lightning', 1, 1, 0, 0, @GSCRIPT+47, 0, 0, 'Are you sure,that you want to go to Halls of Lightning?'),
(@GOPTION+3, 9, 2, 'Halls of Stone', 1, 1, 0, 0, @GSCRIPT+48, 0, 0, 'Are you sure,that you want to go to Halls of Stone?'),
(@GOPTION+3, 10, 2, 'Utgarde Keep', 1, 1, 0, 0, @GSCRIPT+49, 0, 0, 'Are you sure,that you want to go to Utgarde Keep?'),
(@GOPTION+3, 11, 2, 'Utgarde Pinnacle', 1, 1, 0, 0, @GSCRIPT+50, 0, 0, 'Are you sure,that you want to go to Utgarde Pinnacle?'),
(@GOPTION+3, 12, 7, 'Back..', 1, 1, @GOPTION, 0, 0, 0, 0, NULL),
(@GOPTION+4, 0, 2, 'Black Temple', 1, 1, 0, 0, @GSCRIPT+51, 0, 0, 'Are you sure,that you want to go to Black Temple?'),
(@GOPTION+4, 1, 2, 'Blackwing Lair', 1, 1, 0, 0, @GSCRIPT+52, 0, 0, 'Are you sure,that you want to go to Blackwing Lair?'),
(@GOPTION+4, 2, 2, 'Hyjal Summit', 1, 1, 0, 0, @GSCRIPT+53, 0, 0, 'Are you sure,that you want to go to Hyjal Summit?'),
(@GOPTION+4, 3, 2, 'Serpentshrine Cavern', 1, 1, 0, 0, @GSCRIPT+54, 0, 0, 'Are you sure,that you want to go to Serpentshrine Cavern?'),
(@GOPTION+4, 4, 2, 'Trial of the Crusader', 1, 1, 0, 0, @GSCRIPT+55, 0, 0, 'Are you sure,that you want to go to Trial of the Crusader?'),
(@GOPTION+4, 5, 2, 'Gruul\'s Lair', 1, 1, 0, 0, @GSCRIPT+56, 0, 0, 'Are you sure,that you want to go to Gruul\'s Lair?'),
(@GOPTION+4, 6, 2, 'Magtheridon\'s Lair', 1, 1, 0, 0, @GSCRIPT+57, 0, 0, 'Are you sure,that you want to go to Magtheridon\'s Lair?'),
(@GOPTION+4, 7, 2, 'Icecrown Citadel', 1, 1, 0, 0, @GSCRIPT+58, 0, 0, 'Are you sure,that you want to go to Icecrown Citadel?'),
(@GOPTION+4, 8, 2, 'Karazhan', 1, 1, 0, 0, @GSCRIPT+59, 0, 0, 'Are you sure,that you want to go to Karazhan?'),
(@GOPTION+4, 9, 2, 'Molten Core', 1, 1, 0, 0, @GSCRIPT+60, 0, 0, 'Are you sure,that you want to go to Molten Core?'),
(@GOPTION+4, 10, 2, 'Naxxramas', 1, 1, 0, 0, @GSCRIPT+61, 0, 0, 'Are you sure,that you want to go to Naxxramas?'),
(@GOPTION+4, 11, 2, 'Onyxia\'s Lair', 1, 1, 0, 0, @GSCRIPT+62, 0, 0, 'Are you sure,that you want to go to Onyxia\'s Lair?'),
(@GOPTION+4, 12, 2, 'Ruins of Ahn\'Qiraj', 1, 1, 0, 0, @GSCRIPT+63, 0, 0, 'Are you sure,that you want to go to Ruins of Ahn\'Qiraj?'),
(@GOPTION+4, 13, 2, 'Sunwell Plateau', 1, 1, 0, 0, @GSCRIPT+64, 0, 0, 'Are you sure,that you want to go to Sunwell Plateau?'),
(@GOPTION+4, 14, 2, 'The Eye', 1, 1, 0, 0, @GSCRIPT+65, 0, 0, 'Are you sure,that you want to go to The Eye?'),
(@GOPTION+4, 15, 2, 'Temple of Ahn\'Qiraj', 1, 1, 0, 0, @GSCRIPT+66, 0, 0, 'Are you sure,that you want to go to Temple of Ahn\'Qiraj?'),
(@GOPTION+4, 16, 2, 'The Eye of Eternity', 1, 1, 0, 0, @GSCRIPT+67, 0, 0, 'Are you sure,that you want to go to The Eye of Eternity?'),
(@GOPTION+4, 17, 2, 'The Obsidian Sanctum', 1, 1, 0, 0, @GSCRIPT+68, 0, 0, 'Are you sure,that you want to go to The Obsidian Sanctum?'),
(@GOPTION+4, 18, 2, 'Ulduar', 1, 1, 0, 0, @GSCRIPT+69, 0, 0, 'Are you sure,that you want to go to Ulduar?'),
(@GOPTION+4, 19, 2, 'Vault of Archavon', 1, 1, 0, 0, @GSCRIPT+70, 0, 0, 'Are you sure,that you want to go to Vault of Archavon?'),
(@GOPTION+4, 21, 2, 'Zul\'Gurub', 1, 1, 0, 0, @GSCRIPT+72, 0, 0, 'Are you sure,that you want to go to Zul\'Gurub?'),
(@GOPTION+4, 22, 2, 'Zul\'Aman', 1, 1, 0, 0, @GSCRIPT+73, 0, 0, 'Are you sure,that you want to go to Zul\'Aman?'),
(@GOPTION+4, 23, 7, 'Back..', 1, 1, @GOPTION, 0, 0, 0, 0, NULL),
(@GOPTION+5, 0, 2, 'Elwynn Forest', 1, 1, 0, 0, @GSCRIPT+74, 0, 0, 'Are you sure,that you want to go to Elwynn Forest?'),
(@GOPTION+5, 1, 2, 'Eversong Woods', 1, 1, 0, 0, @GSCRIPT+75, 0, 0, 'Are you sure,that you want to go to Eversong Woods?'),
(@GOPTION+5, 2, 2, 'Dun Morogh', 1, 1, 0, 0, @GSCRIPT+76, 0, 0, 'Are you sure,that you want to go to Dun Morogh?'),
(@GOPTION+5, 3, 2, 'Tirisfal Glades', 1, 1, 0, 0, @GSCRIPT+77, 0, 0, 'Are you sure,that you want to go to Tirisfal Glades?'),
(@GOPTION+5, 4, 2, 'Ghostlands', 1, 1, 0, 0, @GSCRIPT+78, 0, 0, 'Are you sure,that you want to go to Ghostlands?'),
(@GOPTION+5, 5, 2, 'Loch modan', 1, 1, 0, 0, @GSCRIPT+79, 0, 0, 'Are you sure,that you want to go to Loch modan?'),
(@GOPTION+5, 6, 2, 'Silverpine Forest', 1, 1, 0, 0, @GSCRIPT+80, 0, 0, 'Are you sure,that you want to go to Silverpine Forest?'),
(@GOPTION+5, 7, 2, 'Westfall', 1, 1, 0, 0, @GSCRIPT+81, 0, 0, 'Are you sure,that you want to go to Westfall?'),
(@GOPTION+5, 8, 2, 'Redridge mountains', 1, 1, 0, 0, @GSCRIPT+82, 0, 0, 'Are you sure,that you want to go to Redridge mountains?'),
(@GOPTION+5, 9, 2, 'Duskwood', 1, 1, 0, 0, @GSCRIPT+83, 0, 0, 'Are you sure,that you want to go to Duskwood?'),
(@GOPTION+5, 10, 2, 'Hillsbrad Foothills', 1, 1, 0, 0, @GSCRIPT+84, 0, 0, 'Are you sure,that you want to go to Hillsbrad Foothills?'),
(@GOPTION+5, 11, 2, 'Wetlands', 1, 1, 0, 0, @GSCRIPT+85, 0, 0, 'Are you sure,that you want to go to Wetlands?'),
(@GOPTION+5, 12, 2, 'Alterac Mountains', 1, 1, 0, 0, @GSCRIPT+86, 0, 0, 'Are you sure,that you want to go to Alterac Mountains?'),
(@GOPTION+5, 13, 2, 'Arathi Highlands', 1, 1, 0, 0, @GSCRIPT+87, 0, 0, 'Are you sure,that you want to go to Arathi Highlands?'),
(@GOPTION+5, 14, 2, 'Stranglethorn Vale', 1, 1, 0, 0, @GSCRIPT+88, 0, 0, 'Are you sure,that you want to go to Stranglethorn Vale?'),
(@GOPTION+5, 15, 2, 'Badlands', 1, 1, 0, 0, @GSCRIPT+89, 0, 0, 'Are you sure,that you want to go to Badlands?'),
(@GOPTION+5, 16, 2, 'Swamp of Sorrows', 1, 1, 0, 0, @GSCRIPT+90, 0, 0, 'Are you sure,that you want to go to Swamp of Sorrows?'),
(@GOPTION+5, 17, 2, 'The Hinterlands', 1, 1, 0, 0, @GSCRIPT+91, 0, 0, 'Are you sure,that you want to go to The Hinterlands?'),
(@GOPTION+5, 18, 2, 'Searing Gorge', 1, 1, 0, 0, @GSCRIPT+92, 0, 0, 'Are you sure,that you want to go to Searing Gorge?'),
(@GOPTION+5, 19, 2, 'The Blasted Lands', 1, 1, 0, 0, @GSCRIPT+93, 0, 0, 'Are you sure,that you want to go to The Blasted Lands?'),
(@GOPTION+5, 20, 2, 'Burning Steppes', 1, 1, 0, 0, @GSCRIPT+94, 0, 0, 'Are you sure,that you want to go to Burning Steppes?'),
(@GOPTION+5, 21, 2, 'Western Plaguelands', 1, 1, 0, 0, @GSCRIPT+95, 0, 0, 'Are you sure,that you want to go to Western Plaguelands?'),
(@GOPTION+5, 22, 2, 'Eastern Plaguelands', 1, 1, 0, 0, @GSCRIPT+96, 0, 0, 'Are you sure,that you want to go to Eastern Plaguelands?'),
(@GOPTION+5, 23, 2, 'Isle of Quel\'Danas', 1, 1, 0, 0, @GSCRIPT+97, 0, 0, 'Are you sure,that you want to go to Isle of Quel\'Danas?'),
(@GOPTION+5, 24, 7, 'Back..', 1, 1, @GOPTION, 0, 0, 0, 0, NULL),
(@GOPTION+6, 0, 2, 'Azuremyst Isle', 1, 1, 0, 0, @GSCRIPT+98, 0, 0, 'Are you sure,that you want to go to Azuremyst Isle?'),
(@GOPTION+6, 1, 2, 'Teldrassil', 1, 1, 0, 0, @GSCRIPT+99, 0, 0, 'Are you sure,that you want to go to Teldrassil?'),
(@GOPTION+6, 2, 2, 'Durotar', 1, 1, 0, 0, @GSCRIPT+100, 0, 0, 'Are you sure,that you want to go to Durotar?'),
(@GOPTION+6, 3, 2, 'Mulgore', 1, 1, 0, 0, @GSCRIPT+101, 0, 0, 'Are you sure,that you want to go to Mulgore?'),
(@GOPTION+6, 4, 2, 'Bloodmyst Isle', 1, 1, 0, 0, @GSCRIPT+102, 0, 0, 'Are you sure,that you want to go to Bloodmyst Isle?'),
(@GOPTION+6, 5, 2, 'Darkshore', 1, 1, 0, 0, @GSCRIPT+103, 0, 0, 'Are you sure,that you want to go to Darkshore?'),
(@GOPTION+6, 6, 2, 'The Barrens', 1, 1, 0, 0, @GSCRIPT+104, 0, 0, 'Are you sure,that you want to go to The Barrens?'),
(@GOPTION+6, 7, 2, 'Stonetalon Mountains', 1, 1, 0, 0, @GSCRIPT+105, 0, 0, 'Are you sure,that you want to go to Stonetalon Mountains?'),
(@GOPTION+6, 8, 2, 'Ashenvale Forest', 1, 1, 0, 0, @GSCRIPT+106, 0, 0, 'Are you sure,that you want to go to Ashenvale Forest?'),
(@GOPTION+6, 9, 2, 'Thousand Needles', 1, 1, 0, 0, @GSCRIPT+107, 0, 0, 'Are you sure,that you want to go to Thousand Needles?'),
(@GOPTION+6, 10, 2, 'Desolace', 1, 1, 0, 0, @GSCRIPT+108, 0, 0, 'Are you sure,that you want to go to Desolace?'),
(@GOPTION+6, 11, 2, 'Dustwallow Marsh', 1, 1, 0, 0, @GSCRIPT+109, 0, 0, 'Are you sure,that you want to go to Dustwallow Marsh?'),
(@GOPTION+6, 12, 2, 'Feralas', 1, 1, 0, 0, @GSCRIPT+110, 0, 0, 'Are you sure,that you want to go to Feralas?'),
(@GOPTION+6, 13, 2, 'Tanaris Desert', 1, 1, 0, 0, @GSCRIPT+111, 0, 0, 'Are you sure,that you want to go to Tanaris Desert?'),
(@GOPTION+6, 14, 2, 'Azshara', 1, 1, 0, 0, @GSCRIPT+112, 0, 0, 'Are you sure,that you want to go to Azshara?'),
(@GOPTION+6, 15, 2, 'Felwood', 1, 1, 0, 0, @GSCRIPT+113, 0, 0, 'Are you sure,that you want to go to Felwood?'),
(@GOPTION+6, 16, 2, 'Un\'Goro Crater', 1, 1, 0, 0, @GSCRIPT+114, 0, 0, 'Are you sure,that you want to go to Un\'Goro Crater?'),
(@GOPTION+6, 17, 2, 'Silithus', 1, 1, 0, 0, @GSCRIPT+115, 0, 0, 'Are you sure,that you want to go to Silithus?'),
(@GOPTION+6, 18, 2, 'Winterspring', 1, 1, 0, 0, @GSCRIPT+116, 0, 0, 'Are you sure,that you want to go to Winterspring?'),
(@GOPTION+6, 19, 7, 'Back..', 1, 1, @GOPTION, 0, 0, 0, 0, NULL),
(@GOPTION+7, 0, 2, 'Hellfire Peninsula', 1, 1, 0, 0, @GSCRIPT+117, 0, 0, 'Are you sure,that you want to go to Hellfire Peninsula?'),
(@GOPTION+7, 1, 2, 'Zangarmarsh', 1, 1, 0, 0, @GSCRIPT+118, 0, 0, 'Are you sure,that you want to go to Zangarmarsh?'),
(@GOPTION+7, 2, 2, 'Terokkar Forest', 1, 1, 0, 0, @GSCRIPT+119, 0, 0, 'Are you sure,that you want to go to Terokkar Forest?'),
(@GOPTION+7, 3, 2, 'Nagrand', 1, 1, 0, 0, @GSCRIPT+120, 0, 0, 'Are you sure,that you want to go to Nagrand?'),
(@GOPTION+7, 4, 2, 'Blade\'s Edge Mountains', 1, 1, 0, 0, @GSCRIPT+121, 0, 0, 'Are you sure,that you want to go to Blade\'s Edge Mountains?'),
(@GOPTION+7, 5, 2, 'Netherstorm', 1, 1, 0, 0, @GSCRIPT+122, 0, 0, 'Are you sure,that you want to go to Netherstorm?'),
(@GOPTION+7, 6, 2, 'Shadowmoon Valley', 1, 1, 0, 0, @GSCRIPT+123, 0, 0, 'Are you sure,that you want to go to Shadowmoon Valley?'),
(@GOPTION+7, 7, 7, 'Back..', 1, 1, @GOPTION, 0, 0, 0, 0, NULL),
(@GOPTION+8, 0, 2, 'Borean Tundra', 1, 1, 0, 0, @GSCRIPT+124, 0, 0, 'Are you sure,that you want to go to Borean Tundra?'),
(@GOPTION+8, 1, 2, 'Howling Fjord', 1, 1, 0, 0, @GSCRIPT+125, 0, 0, 'Are you sure,that you want to go to Howling Fjord?'),
(@GOPTION+8, 2, 2, 'Dragonblight', 1, 1, 0, 0, @GSCRIPT+126, 0, 0, 'Are you sure,that you want to go to Dragonblight?'),
(@GOPTION+8, 3, 2, 'Grizzly Hills', 1, 1, 0, 0, @GSCRIPT+127, 0, 0, 'Are you sure,that you want to go to Grizzly Hills?'),
(@GOPTION+8, 4, 2, 'Zul\'Drak', 1, 1, 0, 0, @GSCRIPT+128, 0, 0, 'Are you sure,that you want to go to Zul\'Drak?'),
(@GOPTION+8, 5, 2, 'Sholazar Basin', 1, 1, 0, 0, @GSCRIPT+129, 0, 0, 'Are you sure,that you want to go to Sholazar Basin?'),
(@GOPTION+8, 6, 2, 'Crystalsong Forest', 1, 1, 0, 0, @GSCRIPT+130, 0, 0, 'Are you sure,that you want to go to Crystalsong Forest?'),
(@GOPTION+8, 7, 2, 'Storm Peaks', 1, 1, 0, 0, @GSCRIPT+132, 0, 0, 'Are you sure,that you want to go to Storm Peaks?'),
(@GOPTION+8, 8, 2, 'Icecrown', 1, 1, 0, 0, @GSCRIPT+133, 0, 0, 'Are you sure,that you want to go to Icecrown?'),
(@GOPTION+8, 9, 2, 'Wintergrasp', 1, 1, 0, 0, @GSCRIPT+134, 0, 0, 'Are you sure,that you want to go to Wintergrasp?'),
(@GOPTION+8, 10, 7, 'Back..', 1, 1, @GOPTION, 0, 0, 0, 0, NULL);

-- -----------------------------------------------------------------------------------------------------------------------------
-- # Text shown in the menus

INSERT INTO npc_text (ID, text0_0, em0_1) 
VALUES (@NPCTXT+4, '$BWhere would you like to be ported?$B', 0),
(@NPCTXT+3, '$BBe careful with choosing raids,I wont be there if you wipe.$B', 0),
(@NPCTXT+2, '$BUp for some dungeon exploring?$B', 0),
(@NPCTXT+1, '$B For The Alliance!$B', 6),
(@NPCTXT, '$B For the Horde!$B', 6);

-- -----------------------------------------------------------------------------------------------------------------------------
-- # Porting scripts

INSERT INTO gossip_scripts (id, delay, command, datalong, datalong2, dataint, x, y, z, o) 
VALUES (@GSCRIPT, 0, 6, 0, 0, 0, -8842.09, 626.358, 94.0867, 3.61363),
(@GSCRIPT+1, 0, 6, 1, 0, 0, 1601.08, -4378.69, 9.9846, 2.14362),
(@GSCRIPT+2, 0, 6, 0, 0, 0, -14281.9, 552.564, 8.90422, 0.860144),
(@GSCRIPT+3, 0, 6, 530, 0, 0, -1887.62, 5359.09, -12.4279, 4.40435),
(@GSCRIPT+5, 0, 6, 571, 0, 0, 5809.55, 503.975, 657.526, 2.38338),
(@GSCRIPT+6, 0, 6, 0, 0, 0, -13181.8, 339.356, 42.9805, 1.18013),
(@GSCRIPT+8, 0, 6, 1, 0, 0, 9869.91, 2493.58, 1315.88, 2.78897),
(@GSCRIPT+9, 0, 6, 0, 0, 0, -4919.94, -982.083, 501.46, 5.12894),
(@GSCRIPT+10, 0, 6, 530, 0, 0, -3864.92, -11643.7, -137.644, 5.50862),
(@GSCRIPT+11, 0, 6, 1, 0, 0, -1274.45, 71.8601, 128.159, 2.80623),
(@GSCRIPT+12, 0, 6, 0, 0, 0, 1633.75, 240.167, -43.1034, 6.26128),
(@GSCRIPT+13, 0, 6, 530, 0, 0, 9738.28, -7454.19, 13.5605, 0.043914),
(@GSCRIPT+14, 0, 6, 0, 0, 0, -5163.54, 925.423, 257.181, 1.57423),
(@GSCRIPT+15, 0, 6, 0, 0, 0, -11209.6, 1666.54, 24.6974, 1.42053),
(@GSCRIPT+16, 0, 6, 0, 0, 0, -8799.15, 832.718, 97.6348, 6.04085),
(@GSCRIPT+17, 0, 6, 1, 0, 0, 1811.78, -4410.5, -18.4704, 5.20165),
(@GSCRIPT+18, 0, 6, 1, 0, 0, -4657.3, -2519.35, 81.0529, 4.54808),
(@GSCRIPT+19, 0, 6, 1, 0, 0, -4470.28, -1677.77, 81.3925, 1.16302),
(@GSCRIPT+20, 0, 6, 0, 0, 0, 2873.15, -764.523, 160.332, 5.10447),
(@GSCRIPT+21, 0, 6, 0, 0, 0, -234.675, 1561.63, 76.8921, 1.24031),
(@GSCRIPT+22, 0, 6, 1, 0, 0, -731.607, -2218.39, 17.0281, 2.78486),
(@GSCRIPT+23, 0, 6, 1, 0, 0, 4249.99, 740.102, -25.671, 1.34062),
(@GSCRIPT+24, 0, 6, 0, 0, 0, -7179.34, -921.212, 165.821, 5.09599),
(@GSCRIPT+25, 0, 6, 0, 0, 0, -7527.05, -1226.77, 285.732, 5.29626),
(@GSCRIPT+26, 0, 6, 1, 0, 0, -3520.14, 1119.38, 161.025, 4.70454),
(@GSCRIPT+27, 0, 6, 1, 0, 0, -1421.42, 2907.83, 137.415, 1.70718),
(@GSCRIPT+28, 0, 6, 0, 0, 0, 1269.64, -2556.21, 93.6088, 0.620623),
(@GSCRIPT+29, 0, 6, 0, 0, 0, 3352.92, -3379.03, 144.782, 6.25978),
(@GSCRIPT+30, 0, 6, 0, 0, 0, -10177.9, -3994.9, -111.239, 6.01885),
(@GSCRIPT+31, 0, 6, 0, 0, 0, -6071.37, -2955.16, 209.782, 0.015708),
(@GSCRIPT+32, 0, 6, 1, 0, 0, -6801.19, -2893.02, 9.00388, 0.158639),
(@GSCRIPT+33, 0, 6, 530, 0, 0, -3324.49, 4943.45, -101.239, 4.63901),
(@GSCRIPT+34, 0, 6, 1, 0, 0, -8369.65, -4253.11, -204.272, -2.70526),
(@GSCRIPT+35, 0, 6, 530, 0, 0, 738.865, 6865.77, -69.4659, 6.27655),
(@GSCRIPT+36, 0, 6, 530, 0, 0, -347.29, 3089.82, 21.394, 5.68114),
(@GSCRIPT+37, 0, 6, 530, 0, 0, 12884.6, -7317.69, 65.5023, 4.799),
(@GSCRIPT+38, 0, 6, 530, 0, 0, 3100.48, 1536.49, 190.3, 4.62226),
(@GSCRIPT+39, 0, 6, 571, 0, 0, 3707.86, 2150.23, 36.76, 3.22),
(@GSCRIPT+40, 0, 6, 1, 0, 0, -8756.39, -4440.68, -199.489, 4.66289),
(@GSCRIPT+41, 0, 6, 571, 0, 0, 8590.95, 791.792, 558.235, 3.13127),
(@GSCRIPT+42, 0, 6, 571, 0, 0, 4765.59, -2038.24, 229.363, 0.887627),
(@GSCRIPT+43, 0, 6, 571, 0, 0, 6722.44, -4640.67, 450.632, 3.91123),
(@GSCRIPT+44, 0, 6, 571, 0, 0, 5643.16, 2028.81, 798.274, 4.60242),
(@GSCRIPT+45, 0, 6, 571, 0, 0, 3782.89, 6965.23, 105.088, 6.14194),
(@GSCRIPT+46, 0, 6, 571, 0, 0, 5693.08, 502.588, 652.672, 4.0229),
(@GSCRIPT+47, 0, 6, 571, 0, 0, 9136.52, -1311.81, 1066.29, 5.19113),
(@GSCRIPT+48, 0, 6, 571, 0, 0, 8922.12, -1009.16, 1039.56, 1.57044),
(@GSCRIPT+49, 0, 6, 571, 0, 0, 1203.41, -4868.59, 41.2486, 0.283237),
(@GSCRIPT+50, 0, 6, 571, 0, 0, 1267.24, -4857.3, 215.764, 3.22768),
(@GSCRIPT+51, 0, 6, 530, 0, 0, -3649.92, 317.469, 35.2827, 2.94285),
(@GSCRIPT+52, 0, 6, 229, 0, 0, 152.451, -474.881, 116.84, 0.001073),
(@GSCRIPT+53, 0, 6, 1, 0, 0, -8177.89, -4181.23, -167.552, 0.913338),
(@GSCRIPT+54, 0, 6, 530, 0, 0, 797.855, 6865.77, -65.4165, 0.005938),
(@GSCRIPT+55, 0, 6, 571, 0, 0, 8515.61, 714.153, 558.248, 1.57753),
(@GSCRIPT+56, 0, 6, 530, 0, 0, 3530.06, 5104.08, 3.50861, 5.51117),
(@GSCRIPT+57, 0, 6, 530, 0, 0, -336.411, 3130.46, -102.928, 5.20322),
(@GSCRIPT+58, 0, 6, 571, 0, 0, 5855.22, 2102.03, 635.991, 3.57899),
(@GSCRIPT+59, 0, 6, 0, 0, 0, -11118.9, -2010.33, 47.0819, 0.649895),
(@GSCRIPT+60, 0, 6, 230, 0, 0, 1126.64, -459.94, -102.535, 3.46095),
(@GSCRIPT+61, 0, 6, 571, 0, 0, 3668.72, -1262.46, 243.622, 4.785),
(@GSCRIPT+62, 0, 6, 1, 0, 0, -4708.27, -3727.64, 54.5589, 3.72786),
(@GSCRIPT+63, 0, 6, 1, 0, 0, -8409.82, 1499.06, 27.7179, 2.51868),
(@GSCRIPT+64, 0, 6, 530, 0, 0, 12574.1, -6774.81, 15.0904, 3.13788),
(@GSCRIPT+65, 0, 6, 530, 0, 0, 3088.49, 1381.57, 184.863, 4.61973),
(@GSCRIPT+66, 0, 6, 1, 0, 0, -8240.09, 1991.32, 129.072, 0.941603),
(@GSCRIPT+67, 0, 6, 571, 0, 0, 3784.17, 7028.84, 161.258, 5.79993),
(@GSCRIPT+68, 0, 6, 571, 0, 0, 3472.43, 264.923, -120.146, 3.27923),
(@GSCRIPT+69, 0, 6, 571, 0, 0, 9222.88, -1113.59, 1216.12, 6.27549),
(@GSCRIPT+70, 0, 6, 571, 0, 0, 5453.72, 2840.79, 421.28, 0),
(@GSCRIPT+72, 0, 6, 0, 0, 0, -11916.7, -1215.72, 92.289, 4.72454),
(@GSCRIPT+73, 0, 6, 530, 0, 0, 6851.78, -7972.57, 179.242, 4.64691),
(@GSCRIPT+74, 0, 6, 0, 0, 0, -9449.06, 64.8392, 56.3581, 3.07047),
(@GSCRIPT+75, 0, 6, 530, 0, 0, 9024.37, -6682.55, 16.8973, 3.14131),
(@GSCRIPT+76, 0, 6, 0, 0, 0, -5603.76, -482.704, 396.98, 5.23499),
(@GSCRIPT+77, 0, 6, 0, 0, 0, 2274.95, 323.918, 34.1137, 4.24367),
(@GSCRIPT+78, 0, 6, 530, 0, 0, 7595.73, -6819.6, 84.3718, 2.56561),
(@GSCRIPT+79, 0, 6, 0, 0, 0, -5405.85, -2894.15, 341.972, 5.48238),
(@GSCRIPT+80, 0, 6, 0, 0, 0, 505.126, 1504.63, 124.808, 1.77987),
(@GSCRIPT+81, 0, 6, 0, 0, 0, -10684.9, 1033.63, 32.5389, 6.07384),
(@GSCRIPT+82, 0, 6, 0, 0, 0, -9447.8, -2270.85, 71.8224, 0.283853),
(@GSCRIPT+83, 0, 6, 0, 0, 0, -10531.7, -1281.91, 38.8647, 1.56959),
(@GSCRIPT+84, 0, 6, 0, 0, 0, -385.805, -787.954, 54.6655, 1.03926),
(@GSCRIPT+85, 0, 6, 0, 0, 0, -3517.75, -913.401, 8.86625, 2.60705),
(@GSCRIPT+86, 0, 6, 0, 0, 0, 275.049, -652.044, 130.296, 0.502032),
(@GSCRIPT+87, 0, 6, 0, 0, 0, -1581.45, -2704.06, 35.4168, 0.490373),
(@GSCRIPT+88, 0, 6, 0, 0, 0, -11921.7, -59.544, 39.7262, 3.73574),
(@GSCRIPT+89, 0, 6, 0, 0, 0, -6782.56, -3128.14, 240.48, 5.65912),
(@GSCRIPT+90, 0, 6, 0, 0, 0, -10368.6, -2731.3, 21.6537, 5.29238),
(@GSCRIPT+91, 0, 6, 0, 0, 0, 112.406, -3929.74, 136.358, 0.981903),
(@GSCRIPT+92, 0, 6, 0, 0, 0, -6686.33, -1198.55, 240.027, 0.916887),
(@GSCRIPT+93, 0, 6, 0, 0, 0, -11184.7, -3019.31, 7.29238, 3.20542),
(@GSCRIPT+94, 0, 6, 0, 0, 0, -7979.78, -2105.72, 127.919, 5.10148),
(@GSCRIPT+95, 0, 6, 0, 0, 0, 1743.69, -1723.86, 59.6648, 5.23722),
(@GSCRIPT+96, 0, 6, 0, 0, 0, 2280.64, -5275.05, 82.0166, 4.7479),
(@GSCRIPT+97, 0, 6, 530, 0, 0, 12806.5, -6911.11, 41.1156, 2.22935),
(@GSCRIPT+98, 0, 6, 530, 0, 0, -4192.62, -12576.7, 36.7598, 1.62813),
(@GSCRIPT+99, 0, 6, 1, 0, 0, 9889.03, 915.869, 1307.43, 1.9336),
(@GSCRIPT+100, 0, 6, 1, 0, 0, 228.978, -4741.87, 10.1027, 0.416883),
(@GSCRIPT+101, 0, 6, 1, 0, 0, -2473.87, -501.225, -9.42465, 0.6525),
(@GSCRIPT+102, 0, 6, 530, 0, 0, -2095.7, -11841.1, 51.1557, 6.19288),
(@GSCRIPT+103, 0, 6, 1, 0, 0, 6463.25, 683.986, 8.92792, 4.33534),
(@GSCRIPT+104, 0, 6, 1, 0, 0, -575.772, -2652.45, 95.6384, 0.006469),
(@GSCRIPT+105, 0, 6, 1, 0, 0, 1574.89, 1031.57, 137.442, 3.8013),
(@GSCRIPT+106, 0, 6, 1, 0, 0, 1919.77, -2169.68, 94.6729, 6.14177),
(@GSCRIPT+107, 0, 6, 1, 0, 0, -5375.53, -2509.2, -40.432, 2.41885),
(@GSCRIPT+108, 0, 6, 1, 0, 0, -656.056, 1510.12, 88.3746, 3.29553),
(@GSCRIPT+109, 0, 6, 1, 0, 0, -3350.12, -3064.85, 33.0364, 5.12666),
(@GSCRIPT+110, 0, 6, 1, 0, 0, -4808.31, 1040.51, 103.769, 2.90655),
(@GSCRIPT+111, 0, 6, 1, 0, 0, -6940.91, -3725.7, 48.9381, 3.11174),
(@GSCRIPT+112, 0, 6, 1, 0, 0, 3117.12, -4387.97, 91.9059, 5.49897),
(@GSCRIPT+113, 0, 6, 1, 0, 0, 3898.8, -1283.33, 220.519, 6.24307),
(@GSCRIPT+114, 0, 6, 1, 0, 0, -6291.55, -1158.62, -258.138, 0.457099),
(@GSCRIPT+115, 0, 6, 1, 0, 0, -6815.25, 730.015, 40.9483, 2.39066),
(@GSCRIPT+116, 0, 6, 1, 0, 0, 6658.57, -4553.48, 718.019, 5.18088),
(@GSCRIPT+117, 0, 6, 530, 0, 0, -207.335, 2035.92, 96.464, 1.59676),
(@GSCRIPT+118, 0, 6, 530, 0, 0, -220.297, 5378.58, 23.3223, 1.61718),
(@GSCRIPT+119, 0, 6, 530, 0, 0, -2266.23, 4244.73, 1.47728, 3.68426),
(@GSCRIPT+120, 0, 6, 530, 0, 0, -1610.85, 7733.62, -17.2773, 1.33522),
(@GSCRIPT+121, 0, 6, 530, 0, 0, 2029.75, 6232.07, 133.495, 1.30395),
(@GSCRIPT+122, 0, 6, 530, 0, 0, 3271.2, 3811.61, 143.153, 3.44101),
(@GSCRIPT+123, 0, 6, 530, 0, 0, -3681.01, 2350.76, 76.587, 4.25995),
(@GSCRIPT+124, 0, 6, 571, 0, 0, 2954.24, 5379.13, 60.4538, 2.55544),
(@GSCRIPT+125, 0, 6, 571, 0, 0, 682.848, -3978.3, 230.161, 1.54207),
(@GSCRIPT+126, 0, 6, 571, 0, 0, 2678.17, 891.826, 4.37494, 0.101121),
(@GSCRIPT+127, 0, 6, 571, 0, 0, 4017.35, -3403.85, 290, 5.35431),
(@GSCRIPT+128, 0, 6, 571, 0, 0, 5560.23, -3211.66, 371.709, 5.55055),
(@GSCRIPT+129, 0, 6, 571, 0, 0, 5614.67, 5818.86, -69.722, 3.60807),
(@GSCRIPT+130, 0, 6, 571, 0, 0, 5411.17, -966.37, 167.082, 1.57167),
(@GSCRIPT+132, 0, 6, 571, 0, 0, 6120.46, -1013.89, 408.39, 5.12322),
(@GSCRIPT+133, 0, 6, 571, 0, 0, 8323.28, 2763.5, 655.093, 2.87223),
(@GSCRIPT+134, 0, 6, 571, 0, 0, 4522.23, 2828.01, 389.975, 0.215009);

-- -----------------------------------------------------------------------------------------------------------------------------

-- # Spawns for the npc and rune cricles to all cities and a summoning effect for the npc.

-- -----------------------------------------------------------------------------------------------------------------------------
-- # TeleNPC spawns

SET @TELENPC := 300000; -- # Must be the same NPC ID!
DELETE FROM creature WHERE ID = @TELENPC ;
ALTER TABLE creature AUTO_INCREMENT=200000;
INSERT INTO creature (id,map,spawnMask,phaseMask,modelid,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,curhealth,curmana) 
VALUES (@TELENPC,0,1,1,0,-13180.5,342.503,43.1936,4.32977,25,0,13700,6540),
(@TELENPC,530,1,1,22951,-3862.69,-11645.8,-137.629,2.38273,25,0,13700,6540),
(@TELENPC,0,1,1,22951,-4918.48,-985.03,501.451,2.03055,25,0,13700,6540),
(@TELENPC,0,1,1,22951,-8845.09,624.828,94.2999,0.44062,25,0,13700,6540),
(@TELENPC,1,1,1,0,1599.25,-4375.85,10.0872,5.23641,25,0,13700,6540),
(@TELENPC,1,1,1,0,-1277.65,72.9751,128.742,5.95567,25,0,13700,6540),
(@TELENPC,0,1,1,0,1637.21,240.132,-43.1034,3.13147,25,0,13700,6540),
(@TELENPC,530,1,1,0,9741.67,-7454.19,13.5572,3.14231,25,0,13700,6540),
(@TELENPC,571,1,1,0,5807.06,506.244,657.576,5.54461,25,0,13700,6540),
(@TELENPC,1,1,1,22951,9866.83,2494.66,1315.88,5.9462,25,0,13700,6540),
(@TELENPC,0,1,1,0,-14279.8,555.014,8.90011,3.97606,25,0,13700,6540),
(@TELENPC,530,1,1,0,-1888.65,5355.88,-12.4279,1.25883,25,0,13700,6540);

-- -----------------------------------------------------------------------------------------------------------------------------
-- # Rune circle spawns

SET @RUNE := 194394; -- # GO ID
DELETE FROM gameobject WHERE ID=@RUNE and guid>'199999';
ALTER TABLE gameobject AUTO_INCREMENT=200000;
INSERT INTO gameobject (id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation2,rotation3,spawntimesecs,state) 
VALUES (@RUNE,1,1,1,1601.08,-4378.69,9.9846,2.14362,0.878068,0.478536,25,1),
(@RUNE,0,1,1,-14281.9,552.564,8.90382,0.860144,0.416936,0.908936,25,1),
(@RUNE,0,1,1,-8842.09,626.358,94.0868,3.61363,0.972276,-0.233836,25,1),
(@RUNE,0,1,1,-4919.94,-982.083,501.46,2.03055,0.849626,0.527386,25,1),
(@RUNE,1,1,1,9869.91,2493.58,1315.88,5.9462,0.167696,-0.985839,25,1),
(@RUNE,530,1,1,-3864.92,-11643.7,-137.644,2.38273,0.928875,0.370392,25,1),
(@RUNE,530,1,1,-1887.62,5359.09,-12.4279,4.40435,0.758205,0.652017,25,1),
(@RUNE,571,1,1,5809.55,503.975,657.526,5.54461,0.360952,-0.932584,25,1),
(@RUNE,530,1,1,9738.28,-7454.19,13.5605,3.14231,1,-0.000358625,25,1),
(@RUNE,0,1,1,1633.75,240.167,-43.1034,3.13147,0.999987,0.00506132,25,1),
(@RUNE,0,1,1,-13181.8,339.356,42.9805,1.18013,0.556415,0.830904,25,1),
(@RUNE,1,1,1,-1274.45,71.8601,128.159,2.80623,0.985974,0.166898,25,1);

-- -----------------------------------------------------------------------------------------------------------------------------
-- # Summon effect
-- # If you want the npc to *cast* the spell, use these as values: VALUES (@TELENPC,0,0,0,0,0,'30540 0');

DELETE FROM creature_template_addon WHERE Entry = @TELENPC ;
INSERT INTO creature_template_addon (entry,mount,bytes1,bytes2,emote,path_id,auras) 
VALUES (@TELENPC,0,0,0,0,0,'35766 0');

-- -----------------------------------------------------------------------------------------------------------------------------

-- # Portal Master
-- # By Rochet2
-- # Downloaded from http://code.google.com/p/teleportnpcmangostrinity/
-- # Bugs and contact with E-mail: Rochet2@post.com
-- # Start