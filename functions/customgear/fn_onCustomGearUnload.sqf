#include "component.hpp"

params [["_display",displayNull]];

// destroy cam
GVAR(customGearCam) cameraeffect ["terminate", "back"];
camDestroy GVAR(customGearCam);
GVAR(customGearCam) = nil;

// save selected loadout
private _unit = _display getVariable [QGVAR(unit), objNull];
private _loadoutOptionsHash = _display getVariable [QGVAR(loadoutOptionsHash), []];

private _savedCustomGearHash = createHashMap;

{
    private _currentItem = [_unit, _x, true] call FUNC(getCurrentItem);
    if (_currentItem isEqualType "" && {_currentItem != ""}) then {
        _savedCustomGearHash set [_x, toLower _currentItem];
    };
} forEach _loadoutOptionsHash;

_unit setVariable [QGVAR(savedCustomGearHash), _savedCustomGearHash, false];
