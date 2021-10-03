![LJ HUD](https://user-images.githubusercontent.com/91661118/135770194-10ecce10-ea99-42eb-ab52-0d5cf137b2e9.png)

# lj-hud used with QBCore Framework

My qb-hud edit. Before you drone on about Pepe-HUD similarites, yes, there is parts of it in here. However, I've already gotten permission from the original developer.
I don't fucking care for drama. Shut up and use it or don't idc.

Runs at ~ 0.06 to 0.08 ms if you have more optimization suggestions feel free to reach out

# Credits
* Credit for compass/street names goes to [compass](https://github.com/thelindat/compass)

# Dependencies
* [qbcore framework](https://github.com/qbcore-framework)

# Key Features
* Voice proximity and radio proximity highlighted
* Radial icons realign
* Seat belt equipped icon indicator
* Engine health orange and red icon indicator
* Fuel low alert
* Fuel gauge color changes
* Harness equipped icon indicator
* Minimap square and circle (found in .config)
* Minimap white borders
* Compass/street names styled like NP 3.0
#

![20210930033055_1](https://user-images.githubusercontent.com/91661118/135427015-e21adb75-4525-4c65-8d95-b6ad9fe2c6e4.jpg)
![20210930033344_1](https://user-images.githubusercontent.com/91661118/135427463-39d9c332-46e8-476a-ac49-c579c9318143.jpg)

# Find qb-smallresources / client / seatbelt.lua and replace with this
```
-- Functions

function ToggleSeatbelt()
    if seatbeltOn then
        seatbeltOn = false
        TriggerEvent("seatbelt:client:ToggleSeatbelt")
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "carunbuckle", 0.25)
        TriggerEvent('QBCore:Notify', "Seat belt unbuckled!", "error")
    else
        seatbeltOn = true
        TriggerEvent("seatbelt:client:ToggleSeatbelt")
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "carbuckle", 0.25)
        TriggerEvent('QBCore:Notify', "Seat belt buckled!")
    end
end

function ToggleHarness()
    if harnessOn then
        harnessOn = false
        ToggleSeatbelt()
    else
        harnessOn = true
        ToggleSeatbelt()
    end
end
```

# Installation

* Download lj-hud put it anywhere in the [resources] directory.
* Add the following code to your server.cfg
```
ensure lj-hud 
```

# Change Logs
### 1.1.0
* Initial release

# Future Shit
* Dev radial displayed if you have permissions required 
* In-game menu 
* Radio icon appears when connected to radio channel
* Cooldown radial option
* Battery radial option
* More optimization shit

# Issues and Suggestions
Please use the GitHub issues system to report issues or make suggestions, when making suggestion, please keep [Suggestion] in the title to make it clear that it is a suggestion.
