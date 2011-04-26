/* Copyright (C) 2010 PDS-4TC PryDevServer.com
 * Copyright (C) 2006 - 2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
SDName: item_custom_summon
SD%Complete: 100
TC%Conversion Complete: 100 by Pryd
SDComment: Summon multiple NPCs
SDCategory: Items
EndScriptData */

#include "ScriptPCH.h"

// Must declare identifiers
class ItemUse_item_custom_summon : public ItemScript

// Must open main construct
{
    public:

        ItemUse_item_custom_summon()
        // Will be the actual scriptname placed on the item
            : ItemScript("item_custom_summon")
        {
        }
	// Be sure to use OnUse, not ItemUse otherwise you will declare it twice
	bool OnUse(Player* pPlayer, Item* pItem, const SpellCastTargets &pTargets)

	{
  // Do not allow player to use item while in combat, flight, or dead
	if ((pPlayer->isInCombat()) || (pPlayer->isInFlight()) || (pPlayer->isDead()))
	{
      pPlayer->SendEquipError(EQUIP_ERR_NOT_IN_COMBAT, pItem, NULL);
        return false;
	}
	if (pPlayer->IsMounted()) // Is player mounted
	{
      pPlayer->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, pItem, NULL);
        return true;
	}
	{
	// Summons NPCs to the player at distances that can be set furthermore additional npcs could be spawned.
	// TeleNPC
      pPlayer->SummonCreature(99001,pPlayer->GetPositionX()+4 ,pPlayer->GetPositionY(), pPlayer->GetPositionZ(), 0,TEMPSUMMON_TIMED_DESPAWN,120000);
    // Musical JukeBox  
      pPlayer->SummonCreature(300001,pPlayer->GetPositionX() ,pPlayer->GetPositionY()+2, pPlayer->GetPositionZ(), 0,TEMPSUMMON_TIMED_DESPAWN,120000);
    // Pryds Old World Flying Hover Vehicle with spells   
      pPlayer->SummonCreature(99005,pPlayer->GetPositionX() ,pPlayer->GetPositionY(), pPlayer->GetPositionZ()+2, 0,TEMPSUMMON_TIMED_DESPAWN,120000);
    // Guild House Master  
	  pPlayer->SummonCreature(13,pPlayer->GetPositionX()+2 ,pPlayer->GetPositionY(), pPlayer->GetPositionZ(), 0,TEMPSUMMON_TIMED_DESPAWN,120000);
	//  Field Repair Bot
	  pPlayer->SummonCreature(24780,pPlayer->GetPositionX() ,pPlayer->GetPositionY()+4, pPlayer->GetPositionZ(), 0,TEMPSUMMON_TIMED_DESPAWN,120000);
	}
        return false;
	}

	// Make sure wrap your main define
};

// Always use new standards such as GoHello_ ItemUse_ AT_ etc, function links to the scriptname hence ItemUse=function and item_custom_summon=scriptname

void AddSC_item_custom_summon()

{
    new ItemUse_item_custom_summon();
}
