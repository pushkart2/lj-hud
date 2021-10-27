isLoggedIn = true
local health = 100
local hunger = 100
local thirst = 100
local level = 100
local stress = 0
local oxygen = 100
local seatbeltOn = false
local harnessOn = false
local bleedingPercentage = 0
local level = 0

-- default new version of qbcore
if Config.Version == "new" then
    QBCore = exports['qb-core']:GetCoreObject()
    print('[lj-hud] NEWER OB-CORE VERSION LOADED')
elseif Config.Version == "old" then
    local QBCore = nil
    Citizen.CreateThread(function()
        while QBCore == nil do
            TriggerEvent("QBCore:GetObject", function(obj)QBCore = obj end)
            print('[lj-hud] OLDER QB-CORE VERSION LOADED')
            Citizen.Wait(200)
        end
    end)
end

-- player ui
Citizen.CreateThread(function()
    while true do 
        Wait(500)
        if isLoggedIn and QBCore ~= nil then
            QBCore.Functions.GetPlayerData(function(PlayerData)
                if PlayerData ~= nil and PlayerData.money ~= nil then

                    -- cash 
                    CashAmount = PlayerData.money["cash"]

                    -- health
                    health = PlayerData.metadata["health"]

                    -- hunger
                    hunger = PlayerData.metadata["hunger"]
                    if hunger < 0 then 
                        hunger = 0 
                    end

                    -- thirst 
                    thirst = PlayerData.metadata["thirst"]
                    if thirst < 0 then 
                        thirst = 0 
                    end

                    -- stress
                    stress = PlayerData.metadata["stress"]
                    if stress < 0 then 
                        stress = 0 
                    end

                end   
            end)
                -- stamina
                if Config.ShowStamina == true then
                    if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
                        if IsPedSprinting(PlayerPedId()) or IsPedRunning(PlayerPedId()) then
                            oxygen = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
                            end
                        end
                    else
                end
                
                -- oxygen
                if Config.ShowOxygen == true then
                    if IsEntityInWater(PlayerPedId()) then
                        oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
                    end
                end

                -- talking and proximity status
                local level = 0
                if LocalPlayer.state["proximity"] ~= nil then
                    level = LocalPlayer.state["proximity"].distance
                end

                if level == 1 then 
                    talking = 33
                elseif level == 2.3 then 
                    talking = 66
                elseif level == 5.0 then 
                    talking = 100 
                end

                local speaking = NetworkIsPlayerTalking(PlayerId())

                -- radio status
                local radio = LocalPlayer.state['radioChannel']

                -- speed value
                if Config.SpeedValue == "mph" then
                    SpeedValue = 2.236936
                elseif Config.SpeedValue == "kmh" then
                    SpeedValue = 3.6
                end

                -- speed
                local speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * SpeedValue

                -- altitude
                local altitude = GetEntityCoords(PlayerPedId()).z * 0.5              
            
                -- fuel
                local fuel = exports['LegacyFuel']:GetFuel(GetVehiclePedIsIn(PlayerPedId(), false))

                -- engine
                local engine = (GetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId()))/10)

                SendNUIMessage ({
                    action = "hudtick",
                    show = IsPauseMenuActive(),
                    health = GetEntityHealth(PlayerPedId()),
                    armor = GetPedArmour(PlayerPedId()),
                    speaking = speaking,
                    talking = talking,
                    radio = radio,
                    hunger = hunger,
                    thirst = thirst,
                    oxygen = oxygen,
                    stress = stress,
                    engine = engine,
                    seatbelt = seatbeltOn,
                    harness = harnessOn,
                    speed = math.ceil(speed),
                    altitude = math.ceil(altitude),
                    fuel = fuel,
                    on = on,
                    nivel = nivel,
                    activo = activo,
                    devmode = devmode,
                    cinematicmode = cinematicmode,		
                })

            end
        end
    end)

-- carui
Citizen.CreateThread(function() 
    while true do
        Wait(500)
        if isLoggedIn and QBCore ~= nil then
            -- aircraft check
            if IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
                DisplayRadar(true)
                SendNUIMessage({ action = "aircraft", show = true, })
            else
                DisplayRadar(false)
                SendNUIMessage({ action = "aircraft", show = false, })
            end
            
            -- car check
            if IsPedInAnyVehicle(PlayerPedId(), false) and isLoggedIn then
                DisplayRadar(true)
                SendNUIMessage({ action = "car", show = true, })
            else
                DisplayRadar(false)
                SendNUIMessage({ action = "car", show = false, })
                SendNUIMessage({ action = "seatbelt", seatbelt = seatbeltOn, })
                SendNUIMessage({ action = "cruise", cruise = cruiseOn, })
                seatbeltOn = false 
                cruiseOn = false
                nivel = 0
                engine = 0
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if isLoggedIn and QBCore ~= nil then

            -- low fuel alert
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                if exports['LegacyFuel']:GetFuel(GetVehiclePedIsIn(PlayerPedId(), false)) <= 20 then -- At 20% Fuel Left
                    TriggerServerEvent("InteractSound_SV:PlayOnSource", "pager", 0.10)
                    TriggerEvent('QBCore:Notify', "Low Fuel!", "error")
                    Wait(60000) -- repeats every 1 min until empty
                end

            end
        end
            Citizen.Wait(20000)
    end
end)

-- circle map
if Config.ShowMap == "circle" then
    Citizen.CreateThread(function()
        RequestStreamedTextureDict("circlemap", false)
        while not HasStreamedTextureDictLoaded("circlemap") do
            Wait(500)
        end
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
        SetMinimapClipType(1)

        -- -0.0100 = nav symbol and icons left 
        -- 0.180 = nav symbol and icons stretched
        -- 0.258 = nav symbol and icons raised up
        SetMinimapComponentPosition("minimap", "L", "B", -0.0100, -0.030, 0.180, 0.258)

        -- icons within map
        SetMinimapComponentPosition("minimap_mask", "L", "B", 0.200, 0.0, 0.065, 0.20)

        -- -0.00 = map pulled left
        -- 0.015 = map raised up
        -- 0.252 = map stretched
        -- 0.338 = map shorten
        SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.00, 0.015, 0.252, 0.338)
        SetBlipAlpha(GetNorthRadarBlip(), 0)
        SetMinimapClipType(1)
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Wait(500)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(1)
end) 
        local pauseActive = false

    Citizen.CreateThread(function()
        while true do
        Wait(500)
        local player = PlayerPedId()
        SetRadarZoom(1000)
        SetRadarBigmapEnabled(false, false)
        local isPMA = IsPauseMenuActive()
            if isPMA and not pauseActive or IsRadarHidden() then 
                pauseActive = true 
                SendNUIMessage ({ action = "hideCircleUI" })
                uiHidden = true
            elseif not isPMA and pauseActive then
                pauseActive = false
                SendNUIMessage ({ action = "displayCircleUI" })
                SendNUIMessage({ action = "hide", type = street })
                uiHidden = false
            end
                Wait(500)
        end
    end)

-- square map
elseif Config.ShowMap == "square" then

Citizen.CreateThread(function()
	RequestStreamedTextureDict("squaremap", false)
	while not HasStreamedTextureDictLoaded("squaremap") do
		Wait(500)
	end

    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
    AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
	SetMinimapClipType(0)

    -- 0.0 = nav symbol and icons left 
    -- 0.1638 = nav symbol and icons stretched
    -- 0.236 = nav symbol and icons raised up
    SetMinimapComponentPosition("minimap", "L", "B", 0.0, -0.047, 0.1638, 0.236)

    -- icons within map
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.2, 0.0, 0.065, 0.20)

    -- -0.01 = map pulled left
    -- 0.025 = map raised up
    -- 0.262 = map stretched
    -- 0.351 = map shorten
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.01, 0.025, 0.262, 0.351)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetMinimapClipType(0)
    DisplayRadar(0)
    SetRadarBigmapEnabled(true, false)
    Wait(500)
    SetRadarBigmapEnabled(false, false)
    DisplayRadar(1)
end)

Citizen.CreateThread(function()
    while true do
        Wait(500)
        local player = PlayerPedId()
        SetRadarZoom(1000)
        SetRadarBigmapEnabled(false, false)
        local isPMA = IsPauseMenuActive()
        if isPMA and not pauseActive or IsRadarHidden() then 
            pauseActive = true 
            SendNUIMessage({ action = "hideSquareUI" })
            SendNUIMessage({ action = "hide", type = street })
            uiHidden = true
        elseif not isPMA and pauseActive then
            pauseActive = false
            SendNUIMessage({ action = "displaySquareUI" })
            uiHidden = false
        end
            Wait(500)
        end
    end)
end

-- cinematic mode
CinematicHeight = 0.2 -- height for black bars
CinematicModeOn = false
w = 0

function CinematicShow(bool)
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    if bool then
        for i = CinematicHeight, 0, -1.0 do
            Wait(10)
            w = i
        end 
    else
        for i = 0, CinematicHeight, 1.0 do 
            Wait(10)
            w = i
        end
    end
end 

Citizen.CreateThread(function()
    minimap = RequestScaleformMovie("minimap")
    if not HasScaleformMovieLoaded(minimap) then
        RequestScaleformMovie(minimap)
        while not HasScaleformMovieLoaded(minimap) do 
            Wait(1)
        end
    end

    while true do
        Citizen.Wait(1)
        if w > 0 then
            BlackBars()
            DisplayRadar(0)
        end
    end
end)

function BlackBars()
    DrawRect(0.0, 0.0, 2.0, w, 0, 0, 0, 255)
    DrawRect(0.0, 1.0, 2.0, w, 0, 0, 0, 255)
end
