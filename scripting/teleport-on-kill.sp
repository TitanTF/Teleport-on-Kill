#include <sdktools>

public Plugin myinfo = 
{
	name = "Teleport on Kill",
	author = "myst",
	description = "Teleport to your victim's position when you kill them.",
	version = "1.0",
	url = "https://titan.tf"
}

public void OnPluginStart() {
	HookEvent("player_death", Event_PlayerDeath);
}

public Action Event_PlayerDeath(Handle hEvent, const char[] sEventName, bool bDontBroadcast)
{
	int iVictim = GetClientOfUserId(GetEventInt(hEvent, "userid"));
	int iAttacker = GetClientOfUserId(GetEventInt(hEvent, "attacker"));
	
	if (IsValidClient(iVictim) && IsValidClient(iAttacker))
	{
		float vPos[3];
		GetClientAbsOrigin(iVictim, vPos);
		
		float vAng[3];
		GetEntPropVector(iVictim, Prop_Data, "m_angRotation", vAng);
		
		TeleportEntity(iAttacker, vPos, vAng, NULL_VECTOR);
	}
}

stock bool IsValidClient(int iClient, bool bReplay = true)
{
	if (iClient <= 0 || iClient > MaxClients || !IsClientInGame(iClient))
		return false;
	if (bReplay && (IsClientSourceTV(iClient) || IsClientReplay(iClient)))
		return false;
	return true;
}