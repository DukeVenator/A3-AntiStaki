//check if punishment is enabled
private _choiceTK = "AS_param_TkPenalty" call BIS_fnc_getParamValue;
if (_choiceTK == 0) exitWith{};

private ["_timer","_unit","_timeout","_punish"];
if (isDedicated) exitWith {};

if (!isMultiplayer) exitWith {};

_unit = _this select 0;
_timeout = _this select 1;

if (player!= _unit) exitWith {};

_punish = _unit getVariable ["punish",0];
_punish = _punish + _timeout;

disableUserInput true;
player removeMagazines (primaryWeapon player);
removeAllItemsWithMagazines player;
player removeMagazines (secondaryWeapon player);
player removeWeaponGlobal (primaryWeapon player);
player removeWeaponGlobal (secondaryWeapon player);
player setPosASL [0,0,0];

hint "Being an asshole is not welcome in this community!";
sleep 5;
hint "This is a COOP game and you are welcome to do so";
sleep 5;
hint "If you are bored, I think there is a new episode on SpongeBob Square Pants today";
sleep 5;
_timer = _punish;
while {_timer > 0} do
	{
	hint format ["Now watch the sights for the following %1 seconds.\n\nPlease be thankful this is a game. In reality you could be sentenced to death by a firing squad, Now face the music!.", _timer];
	sleep 1;
	_timer = _timer -1;
	};
hint "Enough then";
disableUserInput false;
player setdamage 1;
player setpos getMarkerPos guer_respawn;
player setVariable ["punish",_punish,true];
