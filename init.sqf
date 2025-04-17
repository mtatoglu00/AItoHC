if (isServer) then {
    // Wait for at least one HC to connect (up to 30 seconds)
    private _timeout = time + 30;
    waitUntil {
        sleep 1;
        private _hc1 = missionNamespace getVariable ["HC1", objNull];
        private _hc2 = missionNamespace getVariable ["HC2", objNull];
        private _hc3 = missionNamespace getVariable ["HC3", objNull];
        (!isNull _hc1 || !isNull _hc2 || !isNull _hc3) || time > _timeout
    };

    // Start the loop to assign AI to HCs
    [] spawn {
        while {true} do {
            [] execVM "assignAItoHC.sqf";
            sleep 5;
        };
    };
};