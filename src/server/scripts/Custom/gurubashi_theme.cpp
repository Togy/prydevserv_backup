//converted to new script system by marcus
//made originaly by ??
#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "DatabaseEnv.h"
#include <cstring>
#include <stdio.h>
#include <time.h>

#define OFFSET_THEME 10000

class npc_gurubashi_theme : public CreatureScript
{
        public:
                npc_gurubashi_theme()
                        : CreatureScript("npc_gurubashi_theme")
                {
                }

                bool GetLastThemeTime()
                {
                        QueryResult result;
                        result = WorldDatabase.PQuery("SELECT `time` FROM `gurubashi_lastspawned`");

                        if (result)
                        {
                                Field *fields = result->Fetch();
                                return fields[0].GetInt32();
                        }
                        else return 0;
                }
                
                bool OnGossipHello(Player *player, Creature *_Creature)
                {
                        if (GetLastThemeTime() + 600 <= time (NULL))
                        {
                                QueryResult result;
                                result = WorldDatabase.PQuery("SELECT `id`, `name` FROM `gurubashi_themes`");
                                if (result)
                                {
                                        do
                                        {
                                                Field *fields = result->Fetch();
                                                player->ADD_GOSSIP_ITEM(4, fields[1].GetString(), GOSSIP_SENDER_MAIN, OFFSET_THEME + fields[0].GetInt32());
                                        }
                                        while (result->NextRow());
                                }
                        }
                        else
                        {
                                char msg[100];
                                int time2 = GetLastThemeTime() + 600 - time (NULL);
                                if (time2 < 60)
                                        sprintf(msg, "Next change possible in less than minute.");
                                else
                                        sprintf(msg, "Next change possible in %u minute/s.", time2 / 60);
                                        player->ADD_GOSSIP_ITEM(0, msg, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                        }
                        player->ADD_GOSSIP_ITEM(0, "Good bye", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                        player->SEND_GOSSIP_MENU(1,_Creature->GetGUID());
                        return true;
                }

                bool OnGossipSelect(Player *player, Creature *_Creature, uint32 sender, uint32 action)
                {
                        if (action > OFFSET_THEME)
                        {
                                QueryResult result;
                                result = WorldDatabase.PQuery("DELETE FROM `gurubashi_lastspawned`");
                                result = WorldDatabase.PQuery("INSERT INTO `gurubashi_lastspawned` VALUES (%u)", time (NULL));
                                result = WorldDatabase.PQuery("SELECT `x`, `y`, `z`, `o`, `entry` FROM `gurubashi_spawns` WHERE `theme` = %u", action - OFFSET_THEME);
                                if (result)
                                {
                                        _Creature->MonsterSay("Spawning gameobjects..", LANG_UNIVERSAL, player->GetGUID());
                                        do
                                        {
                                                Field *fields = result->Fetch();
                                                _Creature->SummonGameObject(fields[4].GetInt32(), fields[0].GetFloat(), fields[1].GetFloat(), fields[2].GetFloat(), fields[3].GetFloat(), 0, 0, 0, 0, -600);
                                        }
                                        while (result->NextRow());
                                }
                                else
                                {
                                        _Creature->MonsterSay("No gameobjects found.", LANG_UNIVERSAL, player->GetGUID());
                                }
                                player->PlayerTalkClass->CloseGossip();
                        }
                        else
                        {
                                switch (action)
                                {
                                        case GOSSIP_ACTION_INFO_DEF + 1:
                                                player->PlayerTalkClass->CloseGossip();
                                        break;
                                        case GOSSIP_ACTION_INFO_DEF + 2:
                                                OnGossipHello(player, _Creature);
                                        break;
                                }
                        }
                        return true;
                }
};

void AddSC_npc_gurubashi_theme()
{
        new npc_gurubashi_theme();
}