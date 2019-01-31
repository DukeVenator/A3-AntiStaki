_uid = getplayerUID player;
_commandList = ["xxxxx","xxxxx","xxxxxx"];
if (_uid in _commandList) then {
  hint format  ["%1 is in the staff roster\n ID = %2",(name player),_uid];
  this addAction ["Do something","folder/scriptName.sqf",[],0,false,false,"","(_this distance MHQNamedObject) < 20"];
};
