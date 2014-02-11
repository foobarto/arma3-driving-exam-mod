if(!isServer) then {
    hint _this;
} else {
    private ["_target", "_msg"];
    _target = _this select 0;
    _msg = _this select 1;
    [_msg, "vehicleExam_fnc_hint", _target, false] call BIS_fnc_MP;
};