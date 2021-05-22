#include "component.hpp"

params ["_unit"];

private _defactionedClassname = "";
{
    _defactionedClassname = [_unit] call _x;
    if (_defactionedClassname != "") exitWith {true};
} forEach [FUNC(VanillaMilitaryDefactionizer), FUNC(VanillaCivDefactionizer)];

if (_defactionedClassname == "") then {
    _defactionedClassname = typeOf _unit;
    WARNING_2("type name of unit %1 cannot be defactionized :( defaulting to classname %2", _unit, _defactionedClassname);    
};

TRACE_2("unit class %1 defactionized to %2", typeOf _unit, _defactionedClassname);

_defactionedClassname
