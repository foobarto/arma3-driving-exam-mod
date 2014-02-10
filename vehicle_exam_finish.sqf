if (!isServer) then {
	vehicle_exam_finish_flag = _this;
	publicVariableServer "vehicle_exam_finish_flag";
} else {

	_exam_type = _this select 0;
	_examiner_pos = _this select 1;
	_msg = _this select 2;
	_callback = _this select 3;	// [function, args]

	_examinee = [_exam_type, "examinee"] call getVehExamData;
	_exam_veh = [_exam_type, "veh"] call getVehExamData;
	
	[[_exam_veh, _examiner_pos], "vehicleExam_fnc_stopVehicle", _examinee, false] call BIS_fnc_MP;
	[_examiner_pos, "BIS_fnc_setPos", _examinee, false] call BIS_fnc_MP;
		
	[_exam_type, "veh", objNull] call setVehExamData;	

	_triggers = [_exam_type, "triggers"] call getVehExamData;
	{
		deleteVehicle _x;
	} forEach (_triggers);
	[_exam_type, "triggers", []] call setVehExamData;

	[_exam_type, "examinee", objNull] call setVehExamData;

	[_examinee, _msg] call sendVehicleExamHint;

	if(!isNil "_callback") then {
		(_callback select 1) spawn (_callback select 0);
	};

};