#include "component.hpp"

params [["_unit", objNull], ["_loadoutHash", []], ["_ignoreCurrentLoadout", false]];

private _loadoutOptionsHash = createHashMap;
private _currentLoadout = getUnitLoadout _unit;
private _allowedCategories = _unit getVariable [QGVAR(customGearAllowedCategories), GVAR(customGearAllowedCategories)];

{
    private _key = _x;
    private _value = _loadoutHash get _key;
    if (!isNil "_value" && {_value isEqualType []}) then {_value = _value apply {toLower _x}};

    if (
        !isNil "_value" &&
        {_value isEqualType []} &&
        {count _value > 0} &&
        {
            _ignoreCurrentLoadout ||
            ((toLower ([_unit, _key] call FUNC(getCurrentItem))) in _value) ||
            ((toLower ([_unit, _key, true] call FUNC(getCurrentItem))) in _value)
        }
    ) then {
        _loadoutOptionsHash set [_key, _value];
    };
} forEach ([CUSTOMGEAR_SUPPORTED_KEYS] arrayIntersect _allowedCategories);

_loadoutOptionsHash
