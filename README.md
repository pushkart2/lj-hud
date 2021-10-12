![LJ HUD](https://user-images.githubusercontent.com/91661118/135770194-10ecce10-ea99-42eb-ab52-0d5cf137b2e9.png)

# lj-hud used with QBCore Framework

My qb-hud edit. Before you drone on about Pepe-HUD similarites, yes, there is parts of it in here. However, I've already gotten permission from the original developer.
I don't fucking care for drama. Shut up and use it or don't idc.

Runs at ~ 0.06 to 0.08 ms if you have more optimization suggestions feel free to reach out

# Credits
* Credit for compass/street names goes to [compass](https://github.com/thelindat/compass)

# Dependencies
* [qbcore framework](https://github.com/qbcore-framework)
* [pma-voice](https://github.com/AvarianKnight/pma-voice)
* [qb-radio](https://github.com/qbcore-framework/qb-radio)

# Key Features
* Dev mode radial when permission to do so (if you want dev mode working must follow instructions below)
* Headset icon appears when connected to radio channel
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

# Previews
![FiveM - Test built with QBCore Framework by JericoFx   Kakarot   Hamy! 2021-10-11 8_13_22 PM (2)](https://user-images.githubusercontent.com/91661118/136879945-637be92a-fff5-42d6-b83d-44329a1e4bc3.png)
![FiveM - Test Server built with QBCore Framework by JericoFx   Kakarot   Hamy! 2021-10-04 6_33_47 PM](https://user-images.githubusercontent.com/91661118/135943380-a020a2b7-05c1-4b7c-8faa-5a6c1014301d.png)

https://user-images.githubusercontent.com/91661118/136880256-6749151f-ca3a-4748-a912-7a9440dd356b.mp4

## https://streamable.com/ccuikq

# Find qb-adminmenu / client.lua and find this part
```
local banlength = nil
local showCoords = false
local vehicleDevMode = false
local banreason = 'Unknown'
local kickreason = 'Unknown'

local menu = MenuV:CreateMenu(false, 'Admin Menu', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test')
local menu2 = MenuV:CreateMenu(false, 'Admin Options', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test1')
local menu4 = MenuV:CreateMenu(false, 'Online Players', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test3')
local menu5 = MenuV:CreateMenu(false, 'Manage Server', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test4')
local menu6 = MenuV:CreateMenu(false, 'Available Weather Options', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test5')
local menu7 = MenuV:CreateMenu(false, 'Dealer List', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test6')
local menu8 = MenuV:CreateMenu(false, 'Ban', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test7')
local menu9 = MenuV:CreateMenu(false, 'Kick', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test8')
local menu10 = MenuV:CreateMenu(false, 'Permissions', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test9')
local menu11 = MenuV:CreateMenu(false, 'Developer Options', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test10')
local menu12 = MenuV:CreateMenu(false, 'Vehicle Options', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test11')
local menu13 = MenuV:CreateMenu(false, 'Vehicle Categories', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test12')
local menu14 = MenuV:CreateMenu(false, 'Vehicle Models', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test13')
```

# Make a new space under then copy and paste this snippet 
### (you can also do /dev in-game if you have rank "admin" or higher)

```
local devmode = false

local menu_buttondev = menu11:AddCheckbox({
    icon = '⚫',
    label = 'Dev Mode',
    value = menu2,
    description = 'Enable/Disable Developer Mode'
})

menu_buttondev:On('change', function(item, newValue, oldValue)
    devmode = not devmode
    TriggerEvent('qb-admin:client:ToggleDevmode')
    if devmode then
        while devmode do
            Citizen.Wait(200)
            SetPlayerInvincible(PlayerId(), true)
        end
            SetPlayerInvincible(PlayerId(), false)
    end
end)
```

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

### 1.1.1
* Added radio highlight color
* Added radio icon when connected to channel
* Added dev mode used either from admin menu or in-game command
* Fixed nitrous radial showing without being installed
* More optimization

### 1.1.0
* Initial release

# Future Updates
* In-game menu
* Cooldown radial option for minigames
* Battery radial option for radio
* More optimization shit

# Issues and Suggestions
Please use the GitHub issues system to report issues or make suggestions, when making suggestion, please keep [Suggestion] in the title to make it clear that it is a suggestion.
