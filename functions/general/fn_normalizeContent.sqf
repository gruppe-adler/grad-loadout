#include "component.hpp"

// normalize magazines in content.
// input: ["stanag_foo", "stanag_blub", "handgrenade", "something_else"]
// output: [["stanag_foo", 2], ["handgrenade", 1],  "something_else"]

params ["_contentFromConfig"];

private _hashIncr = {
    params ["_hash","_key"];

    private _value = 1;
    if (_key in _hash) then {
        _value = _value + (_hash get _key);
    };
    _hash set [_key, _value];
};

private _magazines = createHashMap;
private _contentForLoadout = [];

{
    if ((typeName _x) == "ARRAY") then {
        if (isClass (configFile >> "CfgWeapons" >> (_x select 0))) then {
            _x params ["_weapon", "_muzzle", "_pointer", "_optics", "_magazine", "_underbarrelMagazine", "_underbarrel"];

            if (!(_magazine isEqualTo "") && isNumber (configFile >> "CfgMagazines" >> _magazine >> "count")) then {
                _magazine = [_magazine, (getNumber (configFile >> "CfgMagazines" >> _magazine >> "count"))];
            };
            if (!(_underbarrelMagazine isEqualTo "") && isNumber (configFile >> "CfgMagazines" >> _underbarrelMagazine >> "count")) then {
                _underbarrelMagazine = [_underbarrelMagazine, (getNumber (configFile >> "CfgMagazines" >> _underbarrelMagazine >> "count"))];
            };
            _contentForLoadout pushBack [[_weapon, _muzzle, _pointer, _optics, _magazine, _underbarrelMagazine, _underbarrel], 1];
        };
    } else {
        [_magazines, _x] call _hashIncr;
    };
} forEach _contentFromConfig;

{
    _className = _x;

    if (_className isKindOf ["CA_Magazine", configFile >> "CfgMagazines"]) then {
        _contentForLoadout pushBack [_x, _y, 1];
    } else {
        _contentForLoadout pushBack [_x, _y];
    };
} forEach _magazines;

_contentForLoadout
