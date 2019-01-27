/*
	Function: Dukes_fnc_HeavyLift
	Author: Duke with Grumpy Old Man helping fix the array problem
	Limits third person use to vehicles only.

	Arguments(s):
	None

	Return Value:
	None

	Example:
	// initPlayerLocal.sqf
	call Dukes_fnc_limitThirdPerson;
__________________________________________________________________*/
TAG_fnc_handleSlingMass = {
	params ["_chopper"];
	_chopper addEventHandler ["RopeAttach",{
		params ["_chopper", "_rope", "_slingLoad"];
		_massArray = [["B_Quadbike_01_F",50],["B_T_Boat_Transport_01_F",100]];//quadbike will have 50 mass, boat will have 100 during slingloaded state
		_vehClasses = _massArray apply {_x#0};
		_vehMasses = _massArray apply {_x#1};
		_index = _vehClasses find typeOf _slingLoad;
		_slingLoaded = _slingLoad getVariable ["TAG_fnc_slingLoaded",false];//this is needed because EH fires for every attached rope, so you prevent overwriting the actual mass with the replacement mass
		if (_index > -1 AND !_slingLoaded) then {
			_slingLoad setVariable ["TAG_fnc_slingLoaded",true];
			_slingLoad setVariable ["TAG_fnc_oldMass",getMass _slingLoad];
			_slingLoad setMass _vehMasses#_index;
		};
	}];
	_chopper addEventHandler ["RopeBreak",{
		params ["_chopper", "_rope", "_slingLoad"];
		_oldMass = _slingLoad getVariable ["TAG_fnc_oldMass",200];//200 will be used as a default value
		_slingLoad setMass _oldMass;
	}];
	true
};
_handleMass = [chopper] call TAG_fnc_handleSlingMass;
//to test on quadbike named test:
onEachFrame {hintSilent format ["Current Mass:%1\nStored Mass: %2",getMass test,test getVariable ["TAG_fnc_oldMass",-1]]};
