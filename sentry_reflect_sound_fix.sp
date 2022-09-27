#pragma newdecls required
#pragma semicolon 1

#include <sourcemod>
#include <sdktools>

public Plugin myinfo = 
{
	name = "Sentry Reflect Sound Fix",
	author = "brokenphilip",
	description = "Fixes the flamethrower looping sound bug when reflecting sentry rockets",
	version = "1.0",
	url = "https://github.com/brokenphilip/sentry_reflect_sound_fix"
};

public void OnPluginStart()
{
	AddTempEntHook("TFExplosion", TEHook_TFExplosion);
}

public Action TEHook_TFExplosion(const char[] te_name, const int[] players, int numClients, float delay)
{
	switch (TE_ReadNum("m_nDefID"))
	{
		// The following weapons have a custom SPECIAL1 sound:
		// 40   - Backburner
		// 215  - Degreaser
		// 594  - Phlogistinator (if it could airblast)
		// 741  - Rainblower
		// 1146 - Festive Backburner
		// If found, change to 21 (Flame Thrower), since it doesn't have a custom SPECIAL1 sound

		case 40, 215, 594, 741, 1146: TE_WriteNum("m_nDefID", 21);
	}

	return Plugin_Continue;
}
