

playableUnits join grpnull;

if(!isNull player) then {
	[player] join grpNull;

	_pos = getMarkerPos "player_spawn";
	player setPos _pos;
	
    player addMPEventHandler ["MPrespawn", format ["(_this select 0) setPos %1; (_this select 1) destroyVehicle;", _pos]];
        // todo: disconnect - move NPC back to the 'island' ;)

};


[
	"car_license_exam",  // type of exam and also prefix for checkpoints, ie. car_license_exam1, car_license_exam2, etc
	4, // checkpoint radius
	"!isOnRoad position _veh || (damage _veh) > 0.1", // bad driving check
	false, // success callback in form of [function, arguments]
	false // failure callback in form of [function, arguments]
] spawn vehexam_fnc_setup;

