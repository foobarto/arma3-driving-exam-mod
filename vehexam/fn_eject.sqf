if(!isServer) exitWith {};
_examinee = _this select 0;
_args = _this select 1;
[_args, "vehexam_fnc_ejectClient", _examinee, false] call BIS_fnc_MP;

