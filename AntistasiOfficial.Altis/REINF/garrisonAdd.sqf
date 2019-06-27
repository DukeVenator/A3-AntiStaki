private ["_hr","_resourcesFIA","_kind","_cost","_marker","_garrison","_position","_unit","_group","_veh","_pos","_goOut"];

_hr = server getVariable "hr";

if (_hr < 1) exitWith {hint "You lack of HR to make a new recruitment"};

_resourcesFIA = server getVariable "resourcesFIA";

_kind = _this select 0;

_cost = server getVariable _kind;
_goOut = false;

if (_kind == guer_sol_HMG) then
	{
	_cost = _cost + ([guer_stat_MGH] call vehiclePrice);
	};

if (_cost > _resourcesFIA) exitWith {hint format ["You do not have enough money for this kind of unit (%1 € needed)",_cost]};

_marker = [markers,posicionGarr] call BIS_fnc_nearestPosition;
_position = getMarkerPos _marker;
_check = false;

{
	if (((side _x == side_red) or (side _x == side_green)) and (_x distance _position < safeDistance_garrison) and (not(captive _x))) then {
		_check = true;
	};
} forEach allUnits;

if (_check) exitWith {Hint format ["You cannot Recruit Garrison Units with enemies near the zone(%1m).",safeDistance_garrison]};
// garrions unit near the hq need more time because of the spawning system
if (closeMarkersUpdating > 0) 
	exitWith {
		hint format ["Adding units in zones that are already active will require more time to deploy. 10 seconds per unit.\n\nPlease try again in %1 seconds.",closeMarkersUpdating]
	};

[-1,-_cost] remoteExec ["resourcesFIA",2];
_garrison = garrison getVariable [_marker,[]];
_garrison = _garrison + [_kind];
garrison setVariable [_marker,_garrison,true];
[_marker] call AS_fnc_markerUpdate;
hint format ["Soldier recruited.%1",[_marker] call AS_fnc_getGarrisonInfo];

if (spawner getVariable _marker) then
{
	closeMarkersUpdating = 10;
	_forced = false;
	if (_marker in forcedSpawn) then {forcedSpawn = forcedSpawn - [_marker]; publicVariable "forcedSpawn"; _forced = true};
	[_marker] remoteExec ["tempMoveMrk",2];
	[_marker,_forced] spawn
	{
		private ["_marker","_forced"];
		_marker = _this select 0;
		_forced = _this select 1;
		while {closeMarkersUpdating > 1} do
		{
			sleep 1;
			closeMarkersUpdating = closeMarkersUpdating - 1;
		};
		
		waitUntil {getMarkerPos _marker distance [0,0,0] > 10};
		closeMarkersUpdating = 0;
	};
	if (_forced) then {
		forcedSpawn pushBackUnique _marker; 
		publicVariable "forcedSpawn"
	};
};