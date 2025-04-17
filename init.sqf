if (isServer) then {
    // Wait for at least one HC to connect (up to 30 seconds)
    private _timeout = time + 30;
    waitUntil {
        sleep 1;
        private _hc1 = missionNamespace getVariable ["HC1", objNull];
        private _hc2 = missionNamespace getVariable ["HC2", objNull];
        private _hc3 = missionNamespace getVariable ["HC3", objNull];
        private _hc4 = missionNamespace getVariable ["HC4", objNull];
        private _hc5 = missionNamespace getVariable ["HC5", objNull];
        (!isNull _hc1 || !isNull _hc2 || !isNull _hc3 || !isNull _hc4 || !isNull _hc5) || time > _timeout
    };

    // Start the loop to assign AI to HCs
    [] spawn {
        while {true} do {
            [] execVM "assignAItoHC.sqf";
            sleep 10;
        };
    };
};