

[
	"car_license_exam",  // type of exam and also prefix for checkpoints, ie. car_license_exam1, car_license_exam2, etc
	"car_examiner1",  // marker name for the NPC examiner
	civilian, // NPC side
	"C_man_w_worker_F", // NPC model
	"C_Offroad_01_F", // exam vehicle
	80, // exam vehicle spawn direction
	50, // max time to finish exam
	4  // checkpoint size
] spawnVM vehexam_fnc_setup;

playableGroup join grpNull;

if(!isNull player) then {
	player setPos (getMarkerPos "player_spawn");
        player addEventHandler ["respawn", {
               player setPos (getMarkerPos, "player_spawn");
        }];
        // todo: disconnect - move NPC back to the 'island' ;)
};
