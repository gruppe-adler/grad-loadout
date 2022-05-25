#include "component.hpp"

params ["_loadoutHierarchy"];

private _mergedLoadout = createHashMap;

{
    private _currentLevel = _x;

    {
        if (_x in _currentLevel) then {
            _newValue = _currentLevel get _x;
            _mergedLoadout set [_x, _newValue];
        };
    } forEach [
        "uniform",
        "vest",
        "backpack",
        "primaryWeapon",
        "primaryWeaponMagazine",
        "primaryWeaponMuzzle",
        "primaryWeaponOptics",
        "primaryWeaponPointer",
        "primaryWeaponUnderbarrel",
        "primaryWeaponUnderbarrelMagazine",
        "secondaryWeapon",
        "secondaryWeaponMagazine",
        "secondaryWeaponMuzzle",
        "secondaryWeaponOptics",
        "secondaryWeaponPointer",
        "secondaryWeaponUnderbarrel",
        "secondaryWeaponUnderbarrelMagazine",
        "handgunWeapon",
        "handgunWeaponMagazine",
        "handgunWeaponMuzzle",
        "handgunWeaponOptics",
        "handgunWeaponPointer",
        "handgunWeaponUnderbarrel",
        "handgunWeaponUnderbarrelMagazine",
        "headgear",
        "goggles",
        "nvgoggles",
        "binoculars",
        "map",
        "gps",
        "compass",
        "watch",
        "radio"
    ];

    // add* values must be appended
    {
        if (_x in _currentLevel) then {
            _oldValue = _mergedLoadout get _x;
            if (isNil "_oldValue") then {
                _oldValue = [];
            };
            _addValue = _currentLevel get _x;
            _mergedLoadout set [_x, _oldValue + _addValue];
        };
    } forEach [
        "addItemsToUniform",
        "addItemsToVest",
        "addItemsToBackpack"
    ];

} forEach _loadoutHierarchy;

_mergedLoadout
