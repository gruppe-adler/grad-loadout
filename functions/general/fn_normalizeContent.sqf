// normalize magazines in content.
// input: ["stanag_foo", "stanag_blub", "handgrenade", "something_else"]
// output: [["stanag_foo", 2], ["handgrenade", 1],  "something_else"]

params ["_contentFromConfig"];

private _CBA_fnc_hashIncr = {
   params ["_hash","_key"];

    _value = 1;
    if ([_hash, _key] call CBA_fnc_hashHasKey) then {
        _value = _value + ([_hash, _key] call CBA_fnc_hashGet);
    };
    [_hash, _key, _value] call CBA_fnc_hashSet;
};

private _checkIfWeaponFits = {
   params ["_backpackClass", "_weapon"];

   if (isNil "_backpackClass") exitWith {false};
   private _backpack = _backpackClass createVehicle [0,0,-1000];

   private _result = _backpack backpackSpaceFor _weapon;
   deleteVehicle _backpack;

   _result
};

private _items = [] call CBA_fnc_hashCreate;
private _contentForLoadout = [];
private _backpackClass = [5, 0] call CBA_fnc_hashGet;

{
    [_items, _x] call _CBA_fnc_hashIncr;
} forEach _contentFromConfig;

[
    _items,
    {
        _className = _key;

        switch (true) do {
            case (_className isKindOf ["CA_Magazine", configFile >> "CfgMagazines"]) : {_contentForLoadout pushBack [_key, _value, 1];};
            case (_className isKindOf (configFile >> "CfgWeapons") : {
               _value params ["_weapon", "_muzzle", "_pointer", "_optics", "_magazine", "_underbarrelMagazine", "_underbarrel"];

               if ([_backpackClass, _weapon] call _checkIfWeaponFits) then {
                  if (!(_magazine isEqualTo "") && isNumber (configFile >> _magazine >> "count")) then {
                     _magazine = [_magazine, (getNumber (configFile >> _magazine >> "count"))];
                  };
                  if (!(_underbarrelMagazine isEqualTo "") && isNumber (configFile >> _underbarrelMagazine >> "count")) then {
                     _underbarrelMagazine = [_underbarrelMagazine, (getNumber (configFile >> _underbarrelMagazine >> "count"))];
                  };
                  _contentForLoadout pushBack [_key, [_weapon, _muzzle, _pointer, _optics, _magazine, _underbarrelMagazine, _underbarrel]];
               };
            };
            default : {_contentForLoadout pushBack [_key, _value];};
         };
    }
] call CBA_fnc_hashEachPair;

_contentForLoadout
