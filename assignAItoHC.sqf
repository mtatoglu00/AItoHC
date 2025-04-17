/*
	Title: Assign AI to Headless Clients
	Author: mtatoglu00 (Gandalf)
	Version: 0.1
	
	Description:
    		Assigns and balances AI units to an available headless client
	
	License:
		Copyright � 2025 Mete Tatoglu. All rights reserved.
		Except where otherwise noted, this work is licensed under CC BY 4.0,
		available for reference at <http://creativecommons.org/licenses/by/4.0/>.
*/

if (!isServer) exitWith {};

// Get headless clients
private _hc1 = missionNamespace getVariable ["HC1", objNull];
private _hc2 = missionNamespace getVariable ["HC2", objNull];
private _hc3 = missionNamespace getVariable ["HC3", objNull];
private _hcArray = [];

if (!isNull _hc1) then { _hcArray pushBack _hc1; };
if (!isNull _hc2) then { _hcArray pushBack _hc2; };
if (!isNull _hc3) then { _hcArray pushBack _hc3; };

// Exit if no HCs are available
if (count _hcArray == 0) exitWith {
    diag_log "No headless clients available to assign AI.";
};

// Select HC with fewest units
private _selectedHC = _hcArray select 0;
if (count _hcArray > 1) then {
    private _hcCounts = [];
    {
        private _hcOwner = owner _x; // Get the owner ID of the HC
        private _unitCount = count (allUnits select {groupOwner (group _x) == _hcOwner});
        _hcCounts pushBack [_unitCount, _x];
    } forEach _hcArray;
    _hcCounts sort true; // Sort by unit count (ascending)
    _selectedHC = (_hcCounts select 0) select 1; // HC with fewest units
    diag_log format ["HC Selection - HC1 Units: %1, HC2 Units: %2, HC3 Units: %3, Selected HC: %4",
        count (allUnits select {groupOwner (group _x) == owner _hc1}),
        count (allUnits select {groupOwner (group _x) == owner _hc2}),
        count (allUnits select {groupOwner (group _x) == owner _hc3}),
        _selectedHC
    ];
};

// Find all AI units and assign to HC
{
    if (!isPlayer _x && {side _x != civilian} && {local _x} && {!(_x getVariable ["assignedToHC", false])}) then {
        private _group = group _x;
        _group setGroupOwner (owner _selectedHC);
        _x setVariable ["assignedToHC", true]; // Mark as assigned
        private _isLocalToHC = !local _x;
        diag_log format [
            "AI unit %1 (Group: %2) assigned to HC %3 (Owner ID: %4). Local to HC: %5",
            _x, 
            _group, 
            _selectedHC, 
            owner _selectedHC, 
            _isLocalToHC
        ];
    };
} forEach allUnits;
