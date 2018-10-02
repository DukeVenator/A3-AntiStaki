SwimFastScriptHandle = [] spawn {
  while {true} do {
    if (underwater player) then {
      player setAnimSpeedCoef 3;
    } else {
      overLand = !(position player isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);
      gradAngle = [getPos player, getDir player] call BIS_fnc_terrainGradAngle;
      if (overLand && gradAngle >= 30) then {
        player setAnimSpeedCoef 3;
      } else {
        player setAnimSpeedCoef 1;
      };

      if ( !isNull(findDisplay 312) ) then {
        {
          {_x addCuratorEditableObjects [allUnits,true];_x addCuratorEditableObjects [vehicles,true];
          } forEach allCurators;
        } remoteExec ["bis_fnc_call", 2];
      };
    };

    sleep 0.50; 
  };
};
