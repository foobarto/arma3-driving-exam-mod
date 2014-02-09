
_exam_type = _this select 0;
_examiner_pos = _this select 1;
_examinee = [_exam_type, "examinee"] call getVehExamData;
_exam_veh = [_exam_type, "veh"] call getVehExamData;

_exam_veh setVelocity [0,0,0];
if(!isNull _exam_veh) then {
	deleteVehicle _exam_veh;
	[_exam_type, "veh", objNull] call setVehExamData;	
};

_examinee setPos _examiner_pos;

_triggers = [_exam_type, "triggers"] call getVehExamData;
{
	deleteVehicle _x;
} forEach (_triggers);
[_exam_type, "triggers", []] call setVehExamData;

[_examinee, "Better luck next time."] call sendVehicleExamHint;
[_exam_type, "examinee", objNull] call setVehExamData;
