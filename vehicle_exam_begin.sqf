
if(!isServer) then {
	vehicle_exam_begin_flag = _this;
	publicVariableServer "vehicle_exam_begin_flag";
} else {
	private ["_exam_type", "_exam_vehicle", "_exam_timeout", "_exam_vehicle_dir", "_examinee", "_examiner_pos"];

	_exam_type = _this select 3 select 0;
	_exam_vehicle = _this select 3 select 1;
	_exam_timeout = _this select 3 select 2; 
	_exam_vehicle_dir = _this select 3 select 3;
	_checkpoint_radius = _this select 3 select 4;
	_examiner_pos = _this select 3 select 4;
	_examinee = _this select 1;

	switch ([_exam_type, "examinee"] call getVehExamData) do {
		case objNull:
		{			
			private ["_exam_veh", "_timeout", "_bad_driving", "_add_more_checkpoints"];
			_exam_veh = createVehicle [_exam_vehicle, getMarkerPos (format ["%1_spawn", _exam_type]), [], 0, "NONE"];
			_exam_veh lock true;
			_exam_veh setDir _exam_vehicle_dir;
			[
				_examinee, 
				_exam_veh, 
				["Cancel Exam", (format ["[""%1"", %2, 'Giving up eh?'] call vehicleExam_fnc_finish;", _exam_type, _examiner_pos]), [], 0, true, true, "GetOut"]
			] call vehicleExamAddAction;
			
			_examinee action ["GetInDriver", _exam_veh]; // this works on dedicated server
			_examinee moveInDriver _exam_veh;  // this works locally

			[_exam_type, "veh", _exam_veh] call setVehExamData;
			[_exam_type, "examinee", _examinee] call setVehExamData;
			[_examinee, "Good luck!"] call sendVehicleExamHint;
			
			_timeout = createTrigger ["EmptyDetector", [0,0,0]];
			_timeout setTriggerTimeout [_exam_timeout, _exam_timeout, _exam_timeout, false];
			_timeout setTriggerStatements [
				"true", 
				format ["
					[""%1"", %2, 'You have to be quicker than that!'] call vehicleExam_fnc_finish;
					", _exam_type, _examiner_pos
				],
				""
			];
			_bad_driving = createTrigger ["EmptyDetector", [0,0,0]];
			_bad_driving setTriggerStatements [
				format ["_veh = [""%1"", ""veh""] call getVehExamData; !isOnRoad position _veh || (damage _veh) > 0.1", _exam_type],
				format ["
						[""%1"", %2, ""You won't pass being reckless like that!""] call vehicleExam_fnc_finish;
						_examinee = [%1, ""examinee""] call getVehExamData;
					", 
					_exam_type, _examiner_pos
				],
				""
			];
			[_exam_type, "triggers", [_timeout, _bad_driving]] call setVehExamData;								
			[_exam_type, "current_checkpoint", 0] call setVehExamData;
		};

		default
		{
			[_examinee, "Sorry but someone else is doing the exam right now..."] call sendVehicleExamHint;
		};
	};
};