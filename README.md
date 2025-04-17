Supports up to 5 headless clients

Setup:

1. Copy the assignAItoHC.sqf into your mission directory
2. Paste the content of the init.sqf on top of your existing init.sqf code
3. Place up to 3 Headless clients in your mission editor and name them: HC1,HC2,HC3
   - Really important: The headless clients must be set as playable!

Debugging:

To check if the script is working you can check your servers console output or .rpt file. You can also check the script in real time by pasting the code from Debugging.md into your ingame debug console.

1. Login as admin (#login adminpassword)
2. Press ESC and paste the content of the Debugging script into the input field
3. Press SERVER EXEC. Now you should see how the AI load is distributed over all headless clients

To check your server FPS you can use the monitor function.

1. Open the chat
2. Type #monitor [delay] e.g. #monitor 10
