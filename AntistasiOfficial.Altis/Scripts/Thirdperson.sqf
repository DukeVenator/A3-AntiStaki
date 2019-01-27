/*
	Function: HALs_fnc_limitThirdPerson
	Author: HallyG
	Limits third person use to vehicles only.

	Arguments(s):
	None

	Return Value:
	None

	Example:
	// initPlayerLocal.sqf
	call HALs_fnc_limitThirdPerson;
__________________________________________________________________*/
if (!hasInterface) exitWith {};
if (!isNil "HALs_tp_cameraView") exitWith {};

HALs_tp_cameraView = cameraView;
HALs_tp_oldVehicle = vehicle player;

addMissionEventHandler ["EachFrame", {
	if (inputAction "PersonView" > 0 || !(cameraView isEqualTo HALs_tp_cameraView) || !(vehicle player isEqualTo HALs_tp_oldVehicle)) then {
		if (cameraOn isEqualTo vehicle player) then {
			if (isNull objectParent player) then {
				if (cameraView isEqualTo "EXTERNAL") then {
					player switchCamera "INTERNAL";
				};
			};
		};
	};

	HALs_tp_cameraView = cameraView;
	HALs_tp_oldVehicle =  vehicle player;
}];
