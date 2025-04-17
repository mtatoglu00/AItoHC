Paste everything under the line into the ingame debug console to check if the AI gets assigned to the headless clients:

----------------------------------------------------------------------------------------------------

private _aiUnits = allUnits select {!isPlayer _x && side _x != civilian};
private _serverUnits = _aiUnits select {groupOwner (group _x) == 2};
private _serverUnitsCount = count _serverUnits;
private _hc1Units = {groupOwner (group _x) == owner HC1} count _aiUnits;
private _hc2Units = {groupOwner (group _x) == owner HC2} count _aiUnits;
private _hc3Units = {groupOwner (group _x) == owner HC3} count _aiUnits;
private _hc4Units = {groupOwner (group _x) == owner HC4} count _aiUnits;
private _hc5Units = {groupOwner (group _x) == owner HC5} count _aiUnits;
private _totalAI = count _aiUnits;
private _message = format [
    "Total AI Units: %1 | Server: %2 | HC1: %3 | HC2: %4 | HC3: %5 | HC4: %6 | HC5: %7",
    _totalAI,
    _serverUnitsCount,
    _hc1Units,
    _hc2Units,
    _hc3Units,
    _hc4Units,
    _hc5Units
];
[_message] remoteExec ["systemChat", -2]; // Broadcast to all clients
diag_log _message;
if (_serverUnitsCount > 0) then {
    {
        diag_log format ["Server-controlled unit: %1, Group: %2, Side: %3, Type: %4", _x, group _x, side _x, typeOf _x];
    } forEach _serverUnits;
};
_message; // Return only the summary for debug console output