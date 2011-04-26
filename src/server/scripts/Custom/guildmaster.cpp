/* Copyright (C) 2010 PDS-4TC PryDevServer.com
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/* ScriptData

SDName: pryds_guildmaster
SD%Complete: 100
TC%Conversion Complete: 100 by Pryd
SDComment: Allows guild owners to purchase or sell Guild Land ( Houses )
SDCategory: NPC
EndScriptData */

#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "../../shared/Configuration/Config.h"
#ifndef _TRINITY_CORE_CONFIG
# define _TRINITY_CORE_CONFIG  "worldserver.conf"
#endif _TRINITY_CORE_CONFIG

extern WorldDatabaseWorkerPool WorldDatabase;

#define MSG_GOSSIP_TELE          "Teleport to your Guild House"
#define MSG_GOSSIP_BUY           "Buy a Guild House for (1000 gold)"
#define MSG_GOSSIP_SELL          "Sell your Guild House for (500 gold)"
#define MSG_GOSSIP_NEXTPAGE      "Next -->"
#define MSG_INCOMBAT             "You are in combat and cannot be teleported to your Guild House."
#define MSG_NOGUILDHOUSE         "Sadly, your guild does not own a Guild House."
#define MSG_NOFREEGH             "Unfortunately, all Guild Houses are in use."
#define MSG_ALREADYHAVEGH        "Sorry, but you already own a GuildHouse (%s)."
#define MSG_NOTENOUGHMONEY       "You do not have the %u gold required to purchase a Guild House."
#define MSG_GHOCCUPIED           "This Guild House is unavailable for purchase as it is currently in use."
#define MSG_CONGRATULATIONS      "Congratulations! You have successfully purchased a Guild House."
#define MSG_SOLD                 "You have sold your Guild House and have received %u gold."
#define MSG_NOTINGUILD           "You need to be in a guild before you can use a Guild House."

#define CODE_SELL                "SELL"
#define MSG_CODEBOX_SELL         "Type \"" CODE_SELL "\" into the field to confirm that you want to sell your Guild House."

#define OFFSET_GH_ID_TO_ACTION   1500
#define OFFSET_SHOWBUY_FROM      10000

#define ACTION_TELE              1001
#define ACTION_SHOW_BUYLIST      1002  //deprecated. Use (OFFSET_SHOWBUY_FROM + 0) instead
#define ACTION_SELL_GUILDHOUSE   1003

#define ICON_GOSSIP_BALOON       0
#define ICON_GOSSIP_WING         2
#define ICON_GOSSIP_BOOK         3
#define ICON_GOSSIP_WHEEL1       4
#define ICON_GOSSIP_WHEEL2       5
#define ICON_GOSSIP_GOLD         6
#define ICON_GOSSIP_BALOONDOTS   7
#define ICON_GOSSIP_TABARD       8
#define ICON_GOSSIP_XSWORDS      9

#define GHBUY_COST 10000000  //1000 g.
#define GHSELL_COST 5000000       // 500 g

#define GOSSIP_COUNT_MAX         10


class pryds_guildmaster : public CreatureScript
{
    public:

        pryds_guildmaster()
            : CreatureScript("pryds_guildmaster")
        {
        }

        struct pryds_guildmasterAI : public ScriptedAI
        {
	    //*** HANDLED FUNCTION ***
        //This is the constructor, called only once when the Creature is first created
            pryds_guildmasterAI(Creature *c) : ScriptedAI(c) {}   
        }; 


bool isPlayerGuildLeader(Player *player)
{
	return (player->GetRank() == 0) && (player->GetGuildId() != 0);
}

bool getGuildHouseCoords(uint32 guildId, float &x, float &y, float &z, uint32 &map)
{
	if (guildId == 0)
	{
		//if player has no guild
		return false;
	}

	QueryResult result;
	result = WorldDatabase.PQuery("SELECT `x`, `y`, `z`, `map` FROM `guildhouses` WHERE `guildId` = %u", guildId);
	if (result)
	{
		Field *fields = result->Fetch();
		x = fields[0].GetFloat();
		y = fields[1].GetFloat();
		z = fields[2].GetFloat();
		map = fields[3].GetUInt32();
		return true;
	}
	return false;
}

void teleportPlayerToGuildHouse(Player *player, Creature* pCreature)
{
	if (player->GetGuildId() == 0)
	{
		//if player has no guild
		pCreature->MonsterWhisper(MSG_NOTINGUILD, player->GetGUID());
		return;
	}

	if (!player->getAttackers().empty())
	{
		//if player in combat
		pCreature->MonsterSay(MSG_INCOMBAT, LANG_UNIVERSAL, player->GetGUID());
		return;
	}

	float x, y, z;
	uint32 map;

	if (getGuildHouseCoords(player->GetGuildId(), x, y, z, map))
	{
		//teleport player to the specified location
		player->TeleportTo(map, x, y, z, 0.0f);
	}
	else
		pCreature->MonsterWhisper(MSG_NOGUILDHOUSE, player->GetGUID());

}

bool showBuyList(Player *player, Creature* pCreature, uint32 showFromId = 0)
{
	//show not occupied guildhouses

	QueryResult result;
	result = WorldDatabase.PQuery("SELECT `id`, `comment` FROM `guildhouses` WHERE `guildId` = 0 AND `id` > %u ORDER BY `id` ASC LIMIT %u",
		showFromId, GOSSIP_COUNT_MAX);

	if (result)
	{
		uint32 guildhouseId = 0;
		std::string comment = "";
		do
		{

			Field *fields = result->Fetch();

			guildhouseId = fields[0].GetInt32();
			comment = fields[1].GetString();
			
			//send comment as a gossip item
			//transmit guildhouseId in Action variable
			player->ADD_GOSSIP_ITEM(ICON_GOSSIP_TABARD, comment, GOSSIP_SENDER_MAIN,
				guildhouseId + OFFSET_GH_ID_TO_ACTION);

		} while (result->NextRow());

		if (result->GetRowCount() == GOSSIP_COUNT_MAX)
		{
			//assume that we have additional page
			//add link to next GOSSIP_COUNT_MAX items
			player->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOONDOTS, MSG_GOSSIP_NEXTPAGE, GOSSIP_SENDER_MAIN, 
				guildhouseId + OFFSET_SHOWBUY_FROM);
		}

		
		player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pCreature->GetGUID());

		return true;
	} else
	{
		if (showFromId = 0)
		{
			//all guildhouses are occupied
			pCreature->MonsterWhisper(MSG_NOFREEGH, player->GetGUID());
			player->CLOSE_GOSSIP_MENU();
		} else
		{
			//this condition occurs when COUNT(guildhouses) % GOSSIP_COUNT_MAX == 0
			//just show GHs from beginning
			showBuyList(player, pCreature, 0);
		}
	}

	return false;
}

bool isPlayerHasGuildhouse(Player *player, Creature* pCreature, bool whisper = false)
{

	QueryResult result;

	result = WorldDatabase.PQuery("SELECT `comment` FROM `guildhouses` WHERE `guildId` = %u",
		player->GetGuildId());

	if (result)
	{
		if (whisper)
		{
			//whisper to player "already have etc..."
			Field *fields = result->Fetch();
			char msg[100];
			sprintf(msg, MSG_ALREADYHAVEGH, fields[0].GetString());
			pCreature->MonsterWhisper(msg, player->GetGUID());
		}

		return true;
	}
	return false;

}

void buyGuildhouse(Player *player, Creature* pCreature, uint32 guildhouseId)
{
	if (!player->HasEnoughMoney(GHBUY_COST))//(player->GetMoney() < GHBUY_COST)
	{
		//show how much money player need to buy GH (in gold)
		char msg[100];
		sprintf(msg, MSG_NOTENOUGHMONEY, GHBUY_COST / 10000);
		pCreature->MonsterWhisper(msg, player->GetGUID());
		return;
	}

	if (isPlayerHasGuildhouse(player, pCreature, true))
	{
		//player already have GH
		return;
	}

	QueryResult result;

	//check if somebody already occupied this GH
	result = WorldDatabase.PQuery("SELECT `id` FROM `guildhouses` WHERE `id` = %u AND `guildId` <> 0",
		guildhouseId);

	if (result)
	{
		pCreature->MonsterWhisper(MSG_GHOCCUPIED, player->GetGUID());
		return;
	}

	//update DB
	result = WorldDatabase.PQuery("UPDATE `guildhouses` SET `guildId` = %u WHERE `id` = %u",
		player->GetGuildId(), guildhouseId);

	if (result)
		
	player->ModifyMoney(-int32(GHBUY_COST));
	player->ModifyMoney(-(sConfig->GetFloatDefault("pryds_guildhouseGoldCost",0)));
	pCreature->MonsterSay(MSG_CONGRATULATIONS, LANG_UNIVERSAL, player->GetGUID());
	
}

void sellGuildhouse(Player *player, Creature* pCreature)
{
	if (isPlayerHasGuildhouse(player, pCreature))
	{
		QueryResult result;

		result = WorldDatabase.PQuery("UPDATE `guildhouses` SET `guildId` = 0 WHERE `guildId` = %u",
		player->GetGuildId());
		
		if (result)
			
		player->ModifyMoney(-int32(GHSELL_COST));

		//display message e.g. "here your money etc."
		char msg[100];
		sprintf(msg, MSG_SOLD, GHSELL_COST / 10000);
		pCreature->MonsterWhisper(msg, player->GetGUID());
	}
}

CreatureAI* GetAI(Creature* pCreature) const
        {
            return new pryds_guildmasterAI(pCreature);
        }

bool OnGossipHello(Player *player, Creature* pCreature)
{
	player->ADD_GOSSIP_ITEM(ICON_GOSSIP_BALOON, MSG_GOSSIP_TELE, 
		GOSSIP_SENDER_MAIN, ACTION_TELE);

	if (isPlayerGuildLeader(player))
	{
		//show additional menu for guild leader
		player->ADD_GOSSIP_ITEM(ICON_GOSSIP_GOLD, MSG_GOSSIP_BUY,
			GOSSIP_SENDER_MAIN, ACTION_SHOW_BUYLIST);
		if (isPlayerHasGuildhouse(player, pCreature))
		{
			//and additional for guildhouse owner
			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(ICON_GOSSIP_GOLD, MSG_GOSSIP_SELL, GOSSIP_SENDER_MAIN, ACTION_SELL_GUILDHOUSE, MSG_CODEBOX_SELL, 0, true);
		}
	}
	player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, pCreature->GetGUID());
	return true;
}


bool OnGossipSelect(Player *player, Creature* pCreature, uint32 sender, uint32 action)
{
		player->PlayerTalkClass->ClearMenus();            /* 11/05/2010 niteowl57:  For 3.3.5a, fix menu functionality  */
	if (sender != GOSSIP_SENDER_MAIN)
		return false;

	switch (action)
	{
		case ACTION_TELE:
			//teleport player to GH
			player->CLOSE_GOSSIP_MENU();
			teleportPlayerToGuildHouse(player, pCreature);
			break;
		case ACTION_SHOW_BUYLIST:
			//show list of GHs which currently not occupied
			showBuyList(player, pCreature);
			break;
		default:
			if (action > OFFSET_SHOWBUY_FROM)
			{
				showBuyList(player, pCreature, action - OFFSET_SHOWBUY_FROM);
			} else if (action > OFFSET_GH_ID_TO_ACTION)
			{
				//player clicked on buy list
				player->CLOSE_GOSSIP_MENU();
				//get guildhouseId from action
				//guildhouseId = action - OFFSET_GH_ID_TO_ACTION
				buyGuildhouse(player, pCreature, action - OFFSET_GH_ID_TO_ACTION);
			}
			break;
	}
	
	return true;
}

bool OnGossipSelectCode(Player *player, Creature* pCreature,
									  uint32 sender, uint32 action, const char* sCode)
{
    if (sender == GOSSIP_SENDER_MAIN)
    {
        if (action == ACTION_SELL_GUILDHOUSE)
        {
			int i = -1;
			try
			{
				//compare code
				if (strlen(sCode) + 1 == sizeof CODE_SELL)
					i = strcmp(CODE_SELL, sCode);

			} catch(char *str) {sLog->outError(str);}

			if (i == 0)
			{
				//right code
				sellGuildhouse(player, pCreature);
			}
			player->CLOSE_GOSSIP_MENU();
			return true;
		}
	}
	return false;
}

};

void AddSC_pryds_guildmaster()
{
	new pryds_guildmaster();
}
