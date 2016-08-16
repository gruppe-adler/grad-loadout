private ["_configPath", "_missionStart", "_sidePath", "_getSidePath", "_rolePath", "_namePath", "_typePath"];

_configPath = missionConfigFile >> "Loadouts";
_missionStart = if ( !isNil { _this select 0 } && { _this select 0 == "postInit" }) then { true } else { false };

// Make sure that only local player is considered as target on respawn.
// This is because AI don't respawn, and we especially don't want to have local AI go through an entire loadout loop again, everytime the player respawns that the AI belongs to.
_units = [];
if( !_missionStart ) then {
	_units pushBack player;
} else {
	{
		if ( local _x ) then {
			_units pushBack _x;
		};
	} forEach allUnits;
};

_getSidePath = {
    _configPath >> "Side" >> _this;
};

{
	// General --------------------------------------------------------------------------------------
	// Every single unit
    _loadoutHierarchy = [];

	if (isClass (_configPath >> "AllUnits")) then {
        _loadoutHierarchy pushBack ([_configPath >> "AllUnits"] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	// All AI units
	if( !isPlayer _x && { isClass ( _configPath >> "AllAi" )}) then {
        _loadoutHierarchy pushBack ([_configPath >> "AllAi"] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	// All players
	if( isPlayer _x && { isClass ( _configPath >> "AllPlayers" )}) then {
        _loadoutHierarchy pushBack ([_configPath >> "AllPlayers"] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	// General sides --------------------------------------------------------------------------------

    _sidePath = "Blufor" call _getSidePath;
	if( side _x == blufor && { isClass (_sidePath)}) then {
        _loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

    _sidePath = "Opfor" call _getSidePath;
	if( side _x == opfor && { isClass (_sidePath)}) then {
        _loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

    _sidePath = "Independent" call _getSidePath;
	if( side _x == independent && { isClass (_sidePath)}) then {
        _loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	// All civilian units
    _sidePath = "Civilian" call _getSidePath;
	if( side _x == civilian && { isClass (_sidePath)}) then {
        _loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	// AI sides -------------------------------------------------------------------------------------
	if( side _x == blufor && { !isPlayer _x } && { isClass (_sidePath)}) then {
        _sidePath = "BluforAi" call _getSidePath;
		_loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	_sidePath = "OpforAi" call _getSidePath;
	if( side _x == opfor && { !isPlayer _x } && { isClass (_sidePath)}) then {
		_loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	_sidePath = "IndependentAi" call _getSidePath;
	if( side _x == independent && { !isPlayer _x } && { isClass (_sidePath)}) then {
		_loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	_sidePath = "CivilianAi" call _getSidePath;
	if( side _x == civilian && { !isPlayer _x } && { isClass (_sidePath)}) then {
		_loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	// Player sides ---------------------------------------------------------------------------------
	_sidePath = "BluforPlayers" call _getSidePath;
	if( side _x == blufor && { isPlayer _x } && { isClass (_sidePath)}) then {
		_loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	_sidePath = "OpforPlayers" call _getSidePath;
	if( side _x == opfor && { isPlayer _x } && { isClass (_sidePath)}) then {
		_loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	_sidePath = "IndependentPlayers" call _getSidePath;
	if( side _x == independent && { isPlayer _x } && { isClass (_sidePath)}) then {
		_loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	_sidePath = "CivilianPlayers" call _getSidePath;
	if( side _x == civilian && { isPlayer _x } && { isClass (_sidePath)}) then {
		_loadoutHierarchy pushBack ([_sidePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

	// Class & Unique -------------------------------------------------------------------------------
	// Class based loadouts
    _typePath = _configPath >> "Type" >> typeof _x;
	if( isClass (_typePath)) then {
		_loadoutHierarchy pushBack ([_typePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

    // Name based loadouts
    _str = str _x splitString "_" select 0;
    _namePath = _configPath >> "Name" >> _str;
    if( isClass (_namePath)) then {
      _loadoutHierarchy pushBack ([_namePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
    };

    // Roledescription based loadouts
	_role = [roleDescription _x] call BIS_fnc_filterString;
    _rolePath = _configPath >> "Role" >> _role;
	if( isClass (_rolePath)) then {
		_loadoutHierarchy pushBack ([_rolePath] call A3G_Loadout_fnc_ExtractLoadoutFromConfig);
	};

    _actualLoadout = [_loadoutHierarchy] call A3G_Loadout_fnc_mergeLoadoutHierarchy;

    [_actualLoadout, _x] call A3G_Loadout_fnc_doLoadout;

} forEach _units;
