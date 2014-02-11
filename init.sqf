

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
	"car_examiner1",  // marker name for the NPC examiner
	civilian, // NPC side
	"C_man_w_worker_F", // NPC model
	"C_Offroad_01_F", // exam vehicle
	80, // exam vehicle spawn direction
	50, // max time to finish exam
	4,  // checkpoint size    
	false, // success callback in form of [function, arguments]
	false // failure callback in form of [function, arguments]
] spawn vehexam_fnc_setup;

