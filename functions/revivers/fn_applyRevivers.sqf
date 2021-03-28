#include "component.hpp"

params [["_loadoutHash", []], ["_unit", objNull]];

{
    _oldValue = _y;
    _revivers = [_x] call FUNC(GetRevivers);
    {
        _y = [_y, _unit] call _x;
    } forEach _revivers;

    TRACE_2("revivers: replaced %1 with %2", _oldValue, _y);

    _loadoutHash set [_x, _y];
} forEach _loadoutHash;

_loadoutHash
