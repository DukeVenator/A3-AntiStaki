/*
	Function: Dukes_fnc_limitThirdPerson
	Author: Duke with HallyG help
	Limits third person use to vehicles only.

	Arguments(s):
	None

	Return Value:
	None

	Example:
	// initPlayerLocal.sqf
	call Dukes_fnc_limitThirdPerson;
__________________________________________________________________*/
if (!hasInterface) exitWith {};
if (!isNil "Dukes_tp_cameraView") exitWith {};

Dukes_tp_cameraView = cameraView;
Dukes_tp_oldVehicle = vehicle player;

addMissionEventHandler ["EachFrame", {
	if (inputAction "PersonView" > 0 || !(cameraView isEqualTo Dukes_tp_cameraView) || !(vehicle player isEqualTo Dukes_tp_oldVehicle)) then {
		if (cameraOn isEqualTo vehicle player) then {
			if (isNull objectParent player) then {
				if (cameraView isEqualTo "EXTERNAL") then {
					player switchCamera "INTERNAL";
				};
			};
		};
	};

	Dukes_tp_cameraView = cameraView;
	Dukes_tp_oldVehicle =  vehicle player;
}];
