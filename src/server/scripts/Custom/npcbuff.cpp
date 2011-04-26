#include "ScriptPCH.h"
#include "../../shared/Configuration/Config.h"
#ifndef _TRINITY_CORE_CONFIG
# define _TRINITY_CORE_CONFIG  "worldserver.conf"
#endif _TRINITY_CORE_CONFIG

class pryds_buffer : public CreatureScript
{
    public:

        pryds_buffer()
            : CreatureScript("pryds_buffer")
        {
        }

        struct pryds_bufferAI : public ScriptedAI
        {
	    //*** HANDLED FUNCTION ***
        //This is the constructor, called only once when the Creature is first created
            pryds_bufferAI(Creature *c) : ScriptedAI(c) {}   
        }; 


bool OnGossipHello(Player* player, Creature* pCreature)
{
	//Config sConfig;
	if(!sConfig->SetSource(_TRINITY_CORE_CONFIG))
		sLog->outError("TScript: Unable to open configuration file");

	if(sConfig->GetBoolDefault("pryds_buffer.OnlyGMs", false)) // If pryds_buffer.OnlyGMs is enabled in trinitycore.conf
		if (player->GetSession()->GetSecurity() == SEC_PLAYER)
		{
			pCreature->MonsterWhisper("Sorry, I can only Buff game masters.", player->GetGUID());
			return true;
		}

	bool EnableSmallBuff = sConfig->GetBoolDefault("pryds_buffer.EnableSmallBuff", true);
	bool EnableGreatBuff = sConfig->GetBoolDefault("pryds_buffer.EnableGreatBuff", true);
	bool EnableGMBuff = sConfig->GetBoolDefault("pryds_buffer.EnableGMBuff", true);
	bool EnablePlayerTools = sConfig->GetBoolDefault("pryds_buffer.EnablePlayerTools", true);
	bool EnableResSickness = sConfig->GetBoolDefault("pryds_buffer.EnableRemoveResSickness", true);
	bool EnableGivemeGold = sConfig->GetBoolDefault("pryds_buffer.EnableGivemeGold", false);

	player->PlayerTalkClass->ClearMenus();    /* 11/05/2010 niteowl57:  For 3.3.5a, fix menu functionality  */
	// Main Menu for Alliance
    if (player->GetTeam() == ALLIANCE)
	{
	// Check config if "Small  Buff " is enabled or not
	if(EnableSmallBuff)
		player->ADD_GOSSIP_ITEM( 7, "Small Buff ->"              , GOSSIP_SENDER_MAIN, 1000);
	// Check config if "Great Buff" is enabled or not
	if(EnableGreatBuff)
		player->ADD_GOSSIP_ITEM( 7, "Great Buff ->"              , GOSSIP_SENDER_MAIN, 2000);
	// Check config if "GM Buff" is enabled or not
	if(EnableGMBuff)
		player->ADD_GOSSIP_ITEM( 7, "GM Buff ->"                 , GOSSIP_SENDER_MAIN, 3000);
	// Check config if "Player Tools" is enabled or not
	if(EnablePlayerTools)
		player->ADD_GOSSIP_ITEM( 7, "Player Tools ->"            , GOSSIP_SENDER_MAIN, 4000);
	}
	else // Main Menu for Horde
	{
	// Check config if "Small  Buff " is enabled or not
	if(EnableSmallBuff)
		player->ADD_GOSSIP_ITEM( 7, "Small Buff ->"              , GOSSIP_SENDER_MAIN, 1000);
	// Check config if "Great Buff" is enabled or not
	if(EnableGreatBuff)
		player->ADD_GOSSIP_ITEM( 7, "Great Buff ->"              , GOSSIP_SENDER_MAIN, 2000);
	// Check config if "GM Buff" is enabled or not
	if(EnableGMBuff)
		player->ADD_GOSSIP_ITEM( 7, "GM Buff ->"                 , GOSSIP_SENDER_MAIN, 3000);
	// Check config if "Player Tools" is enabled or not
	if(EnablePlayerTools)
		player->ADD_GOSSIP_ITEM( 7, "Player Tools ->"            , GOSSIP_SENDER_MAIN, 4000);
	}

	// Check config file if "Remove res sickness" option is enabled or not
	if(EnableResSickness)
		player->ADD_GOSSIP_ITEM( 10, "Remove Resurrect Sickness" , GOSSIP_SENDER_MAIN, 5000);

    player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());

return true;
}

void SendDefaultMenu_pryds_buffer(Player *player, Creature* pCreature, uint32 uiAction)
{

// Not allow in combat
if (player->isInCombat())
{
    player->CLOSE_GOSSIP_MENU();
    pCreature->MonsterSay("You are in combat!", LANG_UNIVERSAL, NULL);
	return;
}

//Config sConfig;
if(!sConfig->SetSource(_TRINITY_CORE_CONFIG))
		sLog->outError("TScript: Unable to open configuration file");
	bool EnableSmallBuff = sConfig->GetBoolDefault("pryds_buffer.EnableSmallBuff", true);
	bool EnableGreatBuff = sConfig->GetBoolDefault("pryds_buffer.EnableGreatBuff", true);
	bool EnableGMBuff = sConfig->GetBoolDefault("pryds_buffer.EnableGMBuff", true);
	bool EnablePlayerTools = sConfig->GetBoolDefault("pryds_buffer.EnablePlayerTools", true);
	bool EnableResSickness = sConfig->GetBoolDefault("pryds_buffer.EnableRemoveResSickness", true);
	bool EnableGivemeGold = sConfig->GetBoolDefault("pryds_buffer.EnableGivemeGold", false);

//Money Check
if (player->GetMoney() < (sConfig->GetFloatDefault("BuffGoldCost",0)))
{
    player->CLOSE_GOSSIP_MENU();
    pCreature->MonsterWhisper("You don't have enough money.", player->GetGUID());
	return;
}

switch(uiAction)
{

case 1000: //Small  Buff
		player->ADD_GOSSIP_ITEM( 5, "Buff me Mark of the Wild"                , GOSSIP_SENDER_MAIN, 1001);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Thorns"                          , GOSSIP_SENDER_MAIN, 1005);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Amplify Magic"                   , GOSSIP_SENDER_MAIN, 1010);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Arcane Intellect"                , GOSSIP_SENDER_MAIN, 1015);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Dalaran Intellect"               , GOSSIP_SENDER_MAIN, 1020);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Dampen Magic"                    , GOSSIP_SENDER_MAIN, 1025);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Blessing of Kings"               , GOSSIP_SENDER_MAIN, 1030);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Blessing of Might"               , GOSSIP_SENDER_MAIN, 1035);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Blessing of Wisdom"              , GOSSIP_SENDER_MAIN, 1040);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Divine Spirit"                   , GOSSIP_SENDER_MAIN, 1045);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Power Word: Fortitude"           , GOSSIP_SENDER_MAIN, 1050);
    	player->ADD_GOSSIP_ITEM( 5, "Buff me Shadow Protection"               , GOSSIP_SENDER_MAIN, 1055);
		player->ADD_GOSSIP_ITEM( 7, "<- Main Menu"                            , GOSSIP_SENDER_MAIN, 5005);

	player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
break;

case 2000: //Great Buff
		player->ADD_GOSSIP_ITEM( 5, "Buff me Gift of the Wild"                , GOSSIP_SENDER_MAIN, 2001);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Arcane Brilliance"               , GOSSIP_SENDER_MAIN, 2005);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Dalaran Brilliance"              , GOSSIP_SENDER_MAIN, 2010);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Kings"       , GOSSIP_SENDER_MAIN, 2015);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Might"       , GOSSIP_SENDER_MAIN, 2020);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Sanctuary"   , GOSSIP_SENDER_MAIN, 2025);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Greater Blessing of Wisdom"      , GOSSIP_SENDER_MAIN, 2030);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Prayer of Fortitude"             , GOSSIP_SENDER_MAIN, 2035);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Prayer of Shadow Protection"     , GOSSIP_SENDER_MAIN, 2040);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Prayer of Spirit"                , GOSSIP_SENDER_MAIN, 2045);
		player->ADD_GOSSIP_ITEM( 7, "<- Main Menu"                            , GOSSIP_SENDER_MAIN, 5005);

	player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
break;

case 3000: //GM  Buff
		player->ADD_GOSSIP_ITEM( 5, "Buff me Agamaggan's Agility"             , GOSSIP_SENDER_MAIN, 3001);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Agamaggan's Strength"            , GOSSIP_SENDER_MAIN, 3005);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Armor Magic"                     , GOSSIP_SENDER_MAIN, 3010);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Armor Penetration"               , GOSSIP_SENDER_MAIN, 3015);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Increased Stamina"               , GOSSIP_SENDER_MAIN, 3020);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Razorhide"                       , GOSSIP_SENDER_MAIN, 3025);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Rising Spirit"                   , GOSSIP_SENDER_MAIN, 3030);
		player->ADD_GOSSIP_ITEM( 5, "Buff me Spirit of the Wind"              , GOSSIP_SENDER_MAIN, 3035);
    	player->ADD_GOSSIP_ITEM( 5, "Buff me Wisdom of Agamaggan"             , GOSSIP_SENDER_MAIN, 3040);
		player->ADD_GOSSIP_ITEM( 7, "<- Main Menu"                            , GOSSIP_SENDER_MAIN, 5005);

	player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
break;

case 4000: //Player Tools
	// Check config if "Give me Gold" is enabled or not
	if(EnableGivemeGold)
		player->ADD_GOSSIP_ITEM( 5, "Give me Gold"                            , GOSSIP_SENDER_MAIN, 4001);
		player->ADD_GOSSIP_ITEM( 5, "Give me Soul Shards"                     , GOSSIP_SENDER_MAIN, 4005);
		player->ADD_GOSSIP_ITEM( 5, "Heal me Please"                          , GOSSIP_SENDER_MAIN, 4010);
		player->ADD_GOSSIP_ITEM( 5, "Heal me and party members Please"        , GOSSIP_SENDER_MAIN, 4015);
		player->ADD_GOSSIP_ITEM( 5, "Conjure Refreshment"                     , GOSSIP_SENDER_MAIN, 4020);
		player->ADD_GOSSIP_ITEM( 5, "Conjure Mana Gem"                        , GOSSIP_SENDER_MAIN, 4025);
		player->ADD_GOSSIP_ITEM( 7, "<- Main Menu"                            , GOSSIP_SENDER_MAIN, 5005);

	player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
break;

case 5005: //Back To Main Menu
	// Main Menu for Alliance
    if (player->GetTeam() == ALLIANCE)
	{
	// Check config if "Small  Buff " is enabled or not
	if(EnableSmallBuff)
		player->ADD_GOSSIP_ITEM( 7, "Small Buff ->"              , GOSSIP_SENDER_MAIN, 1000);
	// Check config if "Great Buff" is enabled or not
	if(EnableGreatBuff)
		player->ADD_GOSSIP_ITEM( 7, "Great Buff ->"              , GOSSIP_SENDER_MAIN, 2000);
	// Check config if "GM Buff" is enabled or not
	if(EnableGMBuff)
		player->ADD_GOSSIP_ITEM( 7, "GM Buff ->"                 , GOSSIP_SENDER_MAIN, 3000);
	// Check config if "Player Tools" is enabled or not
	if(EnablePlayerTools)
		player->ADD_GOSSIP_ITEM( 7, "Player Tools ->"            , GOSSIP_SENDER_MAIN, 4000);
	}
	else // Main Menu for Horde
	{
	// Check config if "Small  Buff " is enabled or not
	if(EnableSmallBuff)
		player->ADD_GOSSIP_ITEM( 7, "Small Buff ->"              , GOSSIP_SENDER_MAIN, 1000);
	// Check config if "Great Buff" is enabled or not
	if(EnableGreatBuff)
		player->ADD_GOSSIP_ITEM( 7, "Great Buff ->"              , GOSSIP_SENDER_MAIN, 2000);
	// Check config if "GM Buff" is enabled or not
	if(EnableGMBuff)
		player->ADD_GOSSIP_ITEM( 7, "GM Buff ->"                 , GOSSIP_SENDER_MAIN, 3000);
	// Check config if "Player Tools" is enabled or not
	if(EnablePlayerTools)
		player->ADD_GOSSIP_ITEM( 7, "Player Tools ->"            , GOSSIP_SENDER_MAIN, 4000);
	}

	// Check if Ress Sickness option is enabled in scriptdev2.conf
	if(EnableResSickness)
		player->ADD_GOSSIP_ITEM( 10, "Remove Resurrect Sickness" , GOSSIP_SENDER_MAIN, 5000);

	player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
break;

//////////////////////////////////////////////////Small Buff///////////////////////////////////////////////////////////////

case 1001: // Buff me Mark of the Wild
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,48469,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 1005: // Buff me Thorns
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,53307,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 1010: // Buff me Amplify Magic
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,43017,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 1015: // Buff me Arcane Intellect
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,42995,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 1020: // Buff me Dalaran Intellect
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,61024,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 1025: // Buff me Dampen Magic
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,43015,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 1030: // Buff me Blessing of Kings
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,20217,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 1035: // Buff me Blessing of Might
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,48932,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 1040: // Buff me Blessing of Wisdom
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,48936,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 1045: // Buff me Divine Spirit
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,48073,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 1050: // Buff me Power Word: Fortitude
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,48161,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 1055: // Buff me Shadow Protection
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,48169,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

//////////////////////////////////////////////////Great Buff///////////////////////////////////////////////////////////////

case 2001: // Buff me Gift of the Wild
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,48470,true);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 2005: // Buff me Arcane Brilliance
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,43002,true);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 2010: // Buff me Dalaran Brilliance
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,61316,true);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 2015: // Buff me Greater Blessing of Kings
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,25898,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 2020: // Buff me Greater Blessing of Might
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,48934,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 2025: // Buff me Greater Blessing of Sanctuary
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,25899,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 2030: // Buff me Greater Blessing of Wisdom
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,48938,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 2035: // Buff me Prayer of Fortitude
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,48162,true);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 2040: // Buff me Prayer of Shadow Protection
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,48170,true);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 2045: // Buff me Prayer of Spirit
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,48074,true);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

//////////////////////////////////////////////////GM Buff///////////////////////////////////////////////////////////////

case 3001: // Buff me Agamaggan's Agility
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,17013,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 3005: // Buff me Agamaggan's Strength
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,16612,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 3010: // Buff me Armor Magic
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,58453,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 3015: // Buff me Armor Penetration
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,34106,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 3020: // Buff me Increased Stamina
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,25661,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 3025: // Buff me Razorhide
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,16610,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 3030: // Buff me Rising Spirit
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,10767,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 3035: // Buff me Spirit of the Wind
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,16618,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 3040: // Buff me Wisdom of Agamaggan
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,7764,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

//////////////////////////////////////////////////Player Tools///////////////////////////////////////////////////////////////

case 4001://Give me Gold
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,46642,false); // 5000 gold
break;

case 4005://Give me Soul Shards
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,24827,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 4010: // Heal me please
    player->CLOSE_GOSSIP_MENU();
    pCreature->CastSpell(player,38588,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 4015: // Heal me and party members Please
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,53251,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 4020: // Conjure Refreshment
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,42956,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

case 4025: // Conjure Mana Gem
    player->CLOSE_GOSSIP_MENU();
    player->CastSpell(player,42985,false);
    player->ModifyMoney(-(sConfig->GetFloatDefault("BuffGoldCost",0)));
break;

//case 5000://Remove Res Sickness
//	if(!player->HasAura(SPELL_RESURRECTION_SICKNESS_15007,0))
//	{
//		pCreature->MonsterWhisper("You don't have resurrection sickness.", player->GetGUID());
//		OnGossipHello(player, pCreature);
//		return;
//	}
//
//	pCreature->CastSpell(player,38588,false); // Healing effect
//	player->RemoveAurasDueToSpell(SPELL_RESURRECTION_SICKNESS_15007,0);
//	player->CLOSE_GOSSIP_MENU();
//break;

 player->CLOSE_GOSSIP_MENU();

} // end of switch
} //end of function



bool OnGossipSelect(Player *player, Creature* pCreature, uint32 uiSender, uint32 uiAction)
{
	// Main menu
	player->PlayerTalkClass->ClearMenus();            /* 11/05/2010 niteowl57:  For 3.3.5a, fix menu functionality  */
	if (uiSender == GOSSIP_SENDER_MAIN)
	SendDefaultMenu_pryds_buffer(player, pCreature, uiAction);

return true;
}

};

void AddSC_pryds_buffer()
{
    
    new pryds_buffer();
}