if(!isServer) then {
    private ["_obj", "_args"];

    waitUntil {alive player};     

    _obj = _this select 0;
    _args = _this select 1;    
    if(isNull _obj) then {
        hint "Hey obj not found!";
    } else {
        _obj addAction _args;
    };
} else {
    private ["_player", "_obj", "_args", "_global"];
    _player = _this select 0;
    _obj = _this select 1;
    _args = _this select 2;
    _global = _this select 3;
    if (isNull "_global") then { _global = false };
    [[_obj, _args], "vehexam_fnc_addAction", _player, _global] call BIS_fnc_MP;

}