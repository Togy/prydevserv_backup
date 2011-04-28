
//  Posted by kjanko @ http://forum.trinitycore.org/topic/28829-killstreak-pvp-system/
//  Updated By {VAS} KalCorp to 1.01


#include "ScriptPCH.h"
#include "Configuration/Config.h"
#include "ScriptMgr.h"
#include "string.h"

float version = 1.01f;
std::string PVP_System_Streaks = "";
uint32 PVP_System_Last_Streak = 50;
int PVP_System_LoseToken = 0;
int PVP_System_AnyPlace = 0;
int PVP_System_BattleGounds = 1;
int PVP_System_SamePlayer = 1;
int PVP_System_AddToken = 0;
std::string PVP_System_Color = "cffFF8000";


struct SystemInfo
{
    uint32 KillStreak;
    uint32 LastGUIDKill;
};

static std::map<uint32, SystemInfo> KillingStreak;

class PVP_System_Streaks_WorldScript : public WorldScript
{
    public:
        PVP_System_Streaks_WorldScript() : WorldScript("PVP_System_Streaks_WorldScript") {}


	void SetInitialWorldSettings()
	{
		//Needs VAS-Hooks v1.01+ to work

		sLog->outString("----------------------------------------------------");
		sLog->outString("  Powered by PVP System Streaks v%4.2f ",version); 
		sLog->outString("----------------------------------------------------");

		PVP_System_Streaks = sConfig->GetStringDefault("PVP.System.Streaks", "5,10,20,30,40,50");
		PVP_System_Last_Streak = sConfig->GetIntDefault("PVP_System.Last.Streak", 50);
		PVP_System_LoseToken = sConfig->GetIntDefault("PVP.System.LoseToken", 0);
		PVP_System_AnyPlace = sConfig->GetIntDefault("PVP.System.AnyPlace", 0);
		PVP_System_BattleGounds = sConfig->GetIntDefault("PVP.System.BattleGounds", 1);
		PVP_System_Color = sConfig->GetStringDefault("PVP.System.Color", "cffFF8000");
		PVP_System_SamePlayer = sConfig->GetIntDefault("PVP.System.SamePlayer", 1);
		PVP_System_AddToken = sConfig->GetIntDefault("PVP.System.AddToken", 1);

		sLog->outString("  PVP.System.Streaks = %s", PVP_System_Streaks);
		sLog->outString("  PVP.System.Last.Streak = %u", PVP_System_Last_Streak);
		sLog->outString("  PVP.System.AnyPlace = %u", PVP_System_AnyPlace);
		sLog->outString("  PVP.System.BattleGounds = %u", PVP_System_BattleGounds);
		sLog->outString("  PVP.System.SamePlayer = %u", PVP_System_SamePlayer);
		sLog->outString("  PVP.System.AddToken = %u", PVP_System_AddToken);
		sLog->outString("  PVP.System.LoseToken = %u", PVP_System_LoseToken);
		sLog->outString("  PVP.System.Color = %s", PVP_System_Color.c_str());

		sLog->outString("  Contributors: kjanko, Rusfighter, KalCorp");

		sLog->outString("----------------------------------------------------\n");
	}
};

class PVP_System_Streaks_PlayerScript : public PlayerScript
{
    public:
        PVP_System_Streaks_PlayerScript() : PlayerScript("PVP_System_Streaks_PlayerScript") {}

	void OnPVPKill(Player *pKiller, Player *pVictim)
	{
		uint32 kGUID; 
		uint32 vGUID;
		kGUID = pKiller->GetGUID();
		vGUID = pVictim->GetGUID(); 
		char msg[500];

		sLog->outString("PVP_System_Streaks_PlayerScript started");

		if (PVP_System_AnyPlace != 0)
			if ((!pKiller->GetMap()->IsBattleground()) && PVP_System_BattleGounds != 1)
				return;

		if(kGUID == vGUID)
			return;
                
		if(KillingStreak[kGUID].LastGUIDKill == vGUID)
			if (PVP_System_SamePlayer !=1 )
				return;

                
		KillingStreak[kGUID].KillStreak++;
		KillingStreak[vGUID].KillStreak = 0;
		KillingStreak[kGUID].LastGUIDKill = vGUID;
		KillingStreak[vGUID].LastGUIDKill = 0;

		if (PVP_System_AddToken == 1)
			pKiller->AddItem(29434, 1);

		if (PVP_System_LoseToken == 1)
			pVictim->DestroyItemCount(29434,1,true,false);


 
		if ( CheckString(PVP_System_Streaks,KillingStreak[kGUID].KillStreak) )
		{
			sprintf(msg, "|%s[PvP System]: %s killed %s and is on a %u Killing Streak! |r",PVP_System_Color.c_str(), pKiller->GetName(), pVictim->GetName(),KillingStreak[kGUID].KillStreak);
			sWorld->SendWorldText(LANG_SYSTEMMESSAGE, msg);
			pKiller->AddItem(29434, int(KillingStreak[kGUID].KillStreak/2));
			if (KillingStreak[kGUID].KillStreak >= PVP_System_Last_Streak)
				KillingStreak[kGUID].KillStreak = 0;
		}
	}

	bool CheckString(std::string IDString,int CurrentID)
	{
        std::string temp_str;
        std::stringstream map_ss;
		map_ss.str(IDString);
        while (std::getline(map_ss, temp_str, ','))
        {
			std::stringstream ss2(temp_str);
			int temp_num = -1;
			ss2 >> temp_num;
			if (temp_num >= 0)
			{
				if (temp_num == CurrentID)
						return true;
				}
		}
		return false;
	}

	void OnLogin(Player *Player)
	{

		PVP_System_Streaks = sConfig->GetStringDefault("PVP.System.Streaks", "5,10,20,30,40,50");
		PVP_System_Last_Streak = sConfig->GetIntDefault("PVP_System.Last.Streak", 50);
		PVP_System_LoseToken = sConfig->GetIntDefault("PVP.System.LoseToken", 0);
		PVP_System_AnyPlace = sConfig->GetIntDefault("PVP.System.AnyPlace", 0);
		PVP_System_BattleGounds = sConfig->GetIntDefault("PVP.System.BattleGounds", 1);
		PVP_System_Color = sConfig->GetStringDefault("PVP.System.Color", "cffFF8000");
		PVP_System_SamePlayer = sConfig->GetIntDefault("PVP.System.SamePlayer", 1);
		PVP_System_AddToken = sConfig->GetIntDefault("PVP.System.AddToken", 1);

		ChatHandler chH = ChatHandler(Player);
		chH.PSendSysMessage("\n|%s----------------------------------------------------|r",PVP_System_Color.c_str());
		chH.PSendSysMessage("|%s  Powered by {VAS} PVP System Streaks v%4.2f |r",PVP_System_Color.c_str(),version);
		chH.PSendSysMessage("|%s----------------------------------------------------|r \n",PVP_System_Color.c_str());
		chH.PSendSysMessage("|%s  PVP.System.Streaks = %s|r",PVP_System_Color.c_str(), PVP_System_Streaks);
		chH.PSendSysMessage("|%s  PVP.System.Last.Streak = %u|r",PVP_System_Color.c_str(), PVP_System_Last_Streak);
		chH.PSendSysMessage("|%s  PVP.System.AnyPlace = %u|r",PVP_System_Color.c_str(), PVP_System_AnyPlace);
		chH.PSendSysMessage("|%s  PVP.System.BattleGounds = %u|r",PVP_System_Color.c_str(), PVP_System_BattleGounds);
		chH.PSendSysMessage("|%s----------------------------------------------------|r \n",PVP_System_Color.c_str());
	}

};


void AddSC_PVP_System()
{
    new PVP_System_Streaks_PlayerScript;
	new PVP_System_Streaks_WorldScript;
}