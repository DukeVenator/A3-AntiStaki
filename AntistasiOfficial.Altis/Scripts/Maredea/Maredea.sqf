_uid = getplayerUID player;
_maredea = ["xxxxxx"];
if (_uid in _maredea) then {
  hint format  ["%1 is in the Club\n ID = %2",(name player),_uid];
  this addAction ["Suit Mode","Scripts/Mardea/MaredeaSuit.sqf",[],0,false,false,"","(_this distance cajaVeh) < 20"];
};
