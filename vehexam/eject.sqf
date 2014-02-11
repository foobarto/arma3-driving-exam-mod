if(!isServer) then {
	_examiner_pos = _this select 0;
	_exam_veh = _this select 1;
	
        _exam_veh setVelocity [0,0,0];
        player setPos _examiner_pos;
        deleteVehicle _exam_veh;

} else {
        _examinee = _this select 0;
        _args = _this select 1;
        [_args, "vehexam_fnc_eject", _examinee, false] call BIS_fnc_MP;
  
};
