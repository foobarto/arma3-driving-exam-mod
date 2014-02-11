if(!isServer) exitWith {};

private ["_player", "_obj", "_args", "_global"];        
_obj = _this select 0;
_args = _this select 1;
_player = true; 
_global = true;
if ( (count _this) > 2) then { _player = _this select 2; _global = false;};    
[[_obj, _args], "vehexam_fnc_addActionClient", _player, _global] call BIS_fnc_MP;
