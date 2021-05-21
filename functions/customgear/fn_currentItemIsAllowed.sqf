#include "component.hpp"

params ["_unit", "_currentItemKey", "_keyOptions"];
// _currentItemKey can be any of CUSTOMGEAR_SUPPORTED_KEYS here (see component.hpp)
// _keyOptions is an array of all custom gear options for the _currentItemKey

// check if currently equipped item is one of the custom gear options
private _currentItem = [_unit, _currentItemKey] call FUNC(getCurrentItem);
if ((toLower _currentItem) in _keyOptions) exitWith {true};

// check if base item of currently equipped item
private _currentItemBase = [_unit, _currentItemKey, true] call FUNC(getCurrentItem);
if ((toLower _currentItemBase) in _keyOptions) exitWith {true};

// check RHS base item (2D/3D/PiP optics) and next item (cyclable optics, e.g. magnifiers) of currently equipped item
if (_currentItemKey in ["primaryWeaponOptics", "secondaryWeaponOptics", "handgunWeaponOptics"]) then {
    private _currentItemRHSBase = [configfile >> "CfgWeapons" >> _currentItem, "rhs_optic_base", _currentItem] call BIS_fnc_returnConfigEntry;
    private _currentItemRHSNext = [configfile >> "CfgWeapons" >> _currentItem, "rhs_accessory_next", _currentItem] call BIS_fnc_returnConfigEntry;

    ((toLower _currentItemRHSBase) in _keyOptions) ||
    ((toLower _currentItemRHSNext) in _keyOptions)

} else {
    false
}
