![LJ HUD](https://user-images.githubusercontent.com/91661118/135770194-10ecce10-ea99-42eb-ab52-0d5cf137b2e9.png)

# lj-hud used with QBCore Framework
Join my Discord laboratory for updates, support, and special early testing!
<br>
https://discord.gg/HH6uTcBfew

Remade and improved off an earlier existing qb-hud and given permission from the original developer. Runs at ~ 0.01 to 0.02 ms if you have more optimization suggestions feel free to reach out

## MAKE SURE YOU REMEMBER:
1. FULLY RESTART YOUR FIVEM CLIENT IF YOUR SERVER CRASHES OR YOU'VE LEFT THE GAME. PMA-VOICE WILL NOT GRAB YOUR PROXIMITY CORRECTLY AND WILL BREAK MY HUD IF NOT!
2. HAVE PMA-VOICE (ONESYNC ENABLED)
3. HAVE lj-hud ENSURED LOWER THAN ANY OF THE DEPENDENCIES LISTED ABOVE
4. THIS DOES NOT COME WITH A COMPASS YOU CAN USE YOUR OWN OR GRAB lj-compass

# My Compass
* Compass was made standalone to reduce (ms) on hud https://github.com/loljoshie/lj-compass

![lj-compass](https://user-images.githubusercontent.com/91661118/138012961-163ec6b3-7885-4df6-84a5-efd84aeac696.png)

# Dependencies
* [qbcore framework](https://github.com/qbcore-framework)
* [pma-voice](https://github.com/AvarianKnight/pma-voice)
* [qb-radio](https://github.com/qbcore-framework/qb-radio)
* [LegacyFuel](https://github.com/qbcore-framework/qb-radio)

# Key Features
* Cinematic Mode (fully hides hud)
* Nitro when actived icon turns light red
* When dead heath radial turns red
* Dev mode radial when permission to do so (if you want dev mode working must follow instructions below)
* Headset icon appears when connected to radio channel
* Voice proximity and radio proximity highlighted
* Radial icons realign
* Seat belt equipped icon indicator
* Oxygen
* Stamina
* Engine health orange and red icon indicator
* Fuel low alert
* Fuel gauge color changes
* Harness equipped icon indicator
* Minimap square and circle (found in .config)
* Minimap white borders
#

# Previews
### ms
![ms](https://user-images.githubusercontent.com/91661118/138173313-ee99c35c-3a6a-4a7d-a708-4c2bb82ca59f.png)
### configurations found in lj-hud/config.lua and lj-hud/html/js/config.js
![configs](https://user-images.githubusercontent.com/91661118/138173317-9325ae10-4256-4e3a-9c1e-19aa508d7013.png)
### circle or square map
![map](https://user-images.githubusercontent.com/91661118/138173410-1f1a274e-dc68-4303-b2da-6e4caaf40352.png)
#
### all radial options
![all circles](https://user-images.githubusercontent.com/91661118/138173368-f0877166-0fb4-4d4f-b234-181f9c0801e3.png)
### cinematic mode
![cinematicmode](https://user-images.githubusercontent.com/91661118/138581857-f040cccd-459a-4951-a5d7-4b483586090f.png)
### nopixel engine
![np engine](https://user-images.githubusercontent.com/91661118/138173441-fb115fc3-71fc-437c-aad5-3901bcb60992.png)
### new engine
![new engine](https://user-images.githubusercontent.com/91661118/138173461-6bf8ea1d-654a-41c9-9a02-79df77c2b48b.png)
### oxygen
![oxygen](https://user-images.githubusercontent.com/91661118/138173474-63b4f76a-c0c3-4271-b8ad-1b154d2f569a.png)
### radio headset
![radio headset](https://user-images.githubusercontent.com/91661118/138173491-28bbfdff-38cb-4152-9cd1-de8541be6d93.png)
### active radio
![radio active](https://user-images.githubusercontent.com/91661118/138176927-7f325665-d343-4386-a448-66469554ad42.png)
### nitro
![nitro](https://user-images.githubusercontent.com/91661118/138173530-52173b66-cd49-4cd8-9369-b48ebdd5c296.png)
### active nitro
![nitro active](https://user-images.githubusercontent.com/91661118/138173537-989333a9-4ef4-4dfb-9687-12a16a151fa2.png)
#


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

# Find qb-smallresources / client / seatbelt.lua find this comment "-- Events" and replace with this snippet up to comment "-- Export"
```
-- Events

RegisterNetEvent('seatbelt:client:UseHarness') -- On Item Use (registered server side)
AddEventHandler('seatbelt:client:UseHarness', function(ItemData)
    local ped = PlayerPedId()
    local inveh = IsPedInAnyVehicle(ped, false)
    local class = GetVehicleClass(GetVehiclePedIsUsing(ped))
    if inveh and class ~= 8 and class ~= 13 and class ~= 14 then
        if not harnessOn then
            LocalPlayer.state:set("inv_busy", true, true)
            QBCore.Functions.Progressbar("harness_equip", "Attaching Race Harness", 5000, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                LocalPlayer.state:set("inv_busy", false, true)
                ToggleHarness()
                TriggerServerEvent('equip:harness', ItemData)
            end)
            harnessHp = ItemData.info.uses
            harnessData = ItemData
        else
            LocalPlayer.state:set("inv_busy", true, true)
            QBCore.Functions.Progressbar("harness_equip", "Removing Race Harness", 5000, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                LocalPlayer.state:set("inv_busy", false, true)
                ToggleHarness()
            end)
        end
    else
        QBCore.Functions.Notify('You\'re not in a car.', 'error')
    end
end)

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
        TriggerEvent("seatbelt:client:ToggleHarness")
        TriggerEvent('QBCore:Notify', "Race harness off!", "error")
    else
        harnessOn = true
        TriggerEvent("seatbelt:client:ToggleHarness")
        TriggerEvent('QBCore:Notify', "Race harness on!")
    end
end

function ResetHandBrake()
    if handbrake > 0 then
        handbrake = handbrake - 1
    end
end

-- Export
```

# Installation

* Download lj-hud put it anywhere in the [resources] directory.
* Add the following code to your server.cfg
```
ensure lj-hud 
```

# Change Logs

### 3.0
* Added "Dynamic" show status feature
* Added new javascript .config
* Added colored maps rather than GTA defaults
* Added option to switch between newer or older versions of QBCore
* Added when dead health color changes
* Added oxygen when underwater
* Added stamina when sprinting or running
* Added nitro active color
* Added more configuration
* Added new engine
* Added speed values
* Added bank command
* Cleaned all files and added more informational context
* More optimization

### 2.0
* Added radio highlight color
* Added radio icon when connected to channel
* Added dev mode used either from admin menu or in-game command
* Fixed nitrous radial showing without being installed
* More optimization

### 1.0
* Initial release

# Future Updates
* In-game menu
* Cooldown radial option for minigames
* Battery radial option for radio
* More optimization shit

# Issues and Suggestions
Please use the GitHub issues system to report issues or make suggestions, when making suggestion, please keep [Suggestion] in the title to make it clear that it is a suggestion.
