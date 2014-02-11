

if (!isServer) exitWith {};

_exam_type = _this select 0;
_examiner_marker = _this select 1;
_examiner_pos = getMarkerPos _examiner_marker;
_examiner_side = _this select 2;
_examiner_model = _this select 3;
_exam_vehicle = _this select 4;
_exam_vehicle_dir = _this select 5;
_exam_timeout = _this select 6;
_checkpoint_radius = _this select 7;


[_exam_type, "examinee", objNull] call vehexam_fnc_set;
[_exam_type, "checkpoints", []] call vehexam_fnc_set;
[_exam_type, "triggers", []] call vehexam_fnc_set;
[_exam_type, "veh", objNull] call vehexam_fnc_set;
[_exam_type, "current_checkpoint", 0] call vehexam_fnc_set;

_examiner = leader ([_examiner_pos, _examiner_side, [_examiner_model]] call BIS_fnc_spawnGroup);
_examiner allowDamage false;
//_examiner addAction ["Exam Rules",{[_this select 1, "Get in the vehicle and do a loop before time runs out."] call sendVehicleExamHint;}];
//_examiner addAction ["Begin Exam", "vehicle_exam_begin.sqf", [_exam_type, _exam_vehicle, _exam_timeout, _exam_vehicle_dir, _examiner_pos, _checkpoint_radius]];
/*
[
    _examiner, 
    ["Exam Rules", '{hint "Get in the vehicle and do a loop before time runs out";}']
] call vehicleExamAddGlobalAction;
*/

[
    _examiner, 
    [
        "Begin Exam",
        "call vehexam_fnc_begin;",
        [_exam_type, _exam_vehicle, _exam_timeout, _exam_vehicle_dir, _examiner_pos, _checkpoint_radius]
    ],
    true, true
] call vehexam_fnc_addAction;

_add_checkpoint = { 
    private ["_checkpoints", "_tr", "_marker", "_examinee"];
    _marker = _this;    

    _tr = createTrigger ["EmptyDetector", _marker];
    _tr setTriggerActivation["ANY", "PRESENT", true];
    _tr setTriggerArea [_checkpoint_radius, _checkpoint_radius, 0, true];
    _tr setTriggerStatements [
        "this",
        format ["
                _examinee = [""%1"", ""examinee""] call vehexam_fnc_get;         
                if( (vehicle _examinee) in thislist ) then {
                    _checkpoints = [""%1"", ""checkpoints""] call vehexam_fnc_get;
                    _current_idx = [""%1"", ""current_checkpoint""] call vehexam_fnc_get;
                    if((count _checkpoints) > _current_idx) then {
                        _current = _checkpoints select _current_idx;                                  
                        if( str _current == str thistrigger) then {                            
                            _next_idx = _current_idx +1;
                            [""%1"", ""current_checkpoint"", _next_idx] call vehexam_fnc_set;    
                            [_examinee, ('Checkpoint '+ str (_current_idx +1) + '/' +  str (count _checkpoints))] call vehexam_fnc_hint;                    
                        };        
                    };            
                };
            ",
            _exam_type
        ],
        format ["
         _checkpoints = [""%1"", ""checkpoints""] call vehexam_fnc_get;
         _current_idx = [""%1"", ""current_checkpoint""] call vehexam_fnc_get;
         if ((count _checkpoints) <= (_current_idx+1)) then {            
            [""%1"", %2, 'You have passed!'] call vehexam_fnc_finish;
         };
         ", _exam_type, _examiner_pos]
    ];
    _tr setTriggerText "checkpoint";
    _checkpoints = [_exam_type, "checkpoints"] call vehexam_fnc_get;
    _checkpoints = _checkpoints + [_tr];
    [_exam_type, "checkpoints", _checkpoints] call vehexam_fnc_set;  
};

_add_more_checkpoints = true;
for [{_i=1}, {_add_more_checkpoints}, {_i=_i+1}] do {
    _next = getMarkerPos format ["%1%2", _exam_type, _i];
    _add_more_checkpoints = str (_next) != str [0,0,0];
    if(_add_more_checkpoints) then {
        _next call _add_checkpoint;         
    };
};  

vehicle_exam_begin_flag = [];
"vehicle_exam_begin_flag" addPublicVariableEventHandler {
    (_this select 1) call vehexam_fnc_begin;
};


vehicle_exam_finish_flag = [];
"vehicle_exam_finish_flag" addPublicVariableEventHandler {
    (_this select 1) call vehexam_fnc_finish;
};