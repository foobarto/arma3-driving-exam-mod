

[
	"car_license_exam",  // type of exam and also prefix for checkpoints, ie. car_license_exam1, car_license_exam2, etc
	"car_examiner1",  // marker name for the NPC examiner
	civilian, // NPC side
	"C_man_w_worker_F", // NPC model
	"C_Offroad_01_F", // exam vehicle
	80, // exam vehicle spawn direction
	50, // max time to finish exam
	6  // checkpoint size
] execVM "vehicle_exam.sqf";
