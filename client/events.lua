local dev = false

-- events
RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    isLoggedIn = true
    Wait(100)
    TriggerEvent("hud:client:ChangeCircle")
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload")
AddEventHandler("QBCore:Client:OnPlayerUnload", function()
    isLoggedIn = false
    SendNUIMessage({ action = "hudtick", show = true, })
    DisplayRadar(0)
    SendNUIMessage ({ action = "hideCircleUI" })
    SendNUIMessage ({ action = "hideSquareUI" })
end)

RegisterNetEvent("hud:client:UpdateNeeds")
AddEventHandler("hud:client:UpdateNeeds", function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

RegisterNetEvent('hud:client:UpdateStress')
AddEventHandler('hud:client:UpdateStress', function(newStress)
    stress = newStress
end)

RegisterNetEvent("hud:client:EngineHealth")
AddEventHandler("hud:client:EngineHealth", function(newEngine)
    engine = newEngine
end)

RegisterNetEvent("seatbelt:client:ToggleSeatbelt")
AddEventHandler("seatbelt:client:ToggleSeatbelt", function(toggle)
    if toggle == nil then
        seatbeltOn = not seatbeltOn
        SendNUIMessage({
            action = "seatbelt",
            seatbelt = seatbeltOn,
        })
    else
        seatbeltOn = toggle
        SendNUIMessage({
            action = "seatbelt",
            seatbelt = toggle,
        })
    end
end)

RegisterNetEvent("seatbelt:client:ToggleHarness")
AddEventHandler("seatbelt:client:ToggleHarness", function(toggle)
    if toggle == nil then
        harnessOn = not harnessOn
        SendNUIMessage({
            action = "harness",
            harness = harnessOn,
        })
    else
        seatbeltOn = toggle
        SendNUIMessage({
            action = "harness",
            harness = toggle,
        })
    end
end)

RegisterNetEvent('hud:client:UpdateNitrous')
AddEventHandler('hud:client:UpdateNitrous', function(toggle, level, IsActive)
    on = toggle
    nivel = level
    activo = IsActive
end)

RegisterNetEvent("hud:client:ShowMoney")
AddEventHandler("hud:client:ShowMoney", function(type)
    QBCore.Functions.GetPlayerData(function(PlayerData)
        CashAmount = PlayerData.money["cash"]
    end)
    TriggerEvent("hud:client:SetMoney")
    SendNUIMessage({
        action = "show",
        cash = cashAmount,
        bank = bankAmount,
        type = type,
    })
end)

RegisterNetEvent("hud:client:SetMoney")
AddEventHandler("hud:client:SetMoney", function()
   QBCore.Functions.GetPlayerData(function(PlayerData)
       if PlayerData ~= nil and PlayerData.money ~= nil then
           cashAmount = PlayerData.money["cash"]
           bankAmount = PlayerData.money["bank"]
       end
   end)
end)

RegisterNetEvent("hud:client:ShowMoney")
AddEventHandler("hud:client:ShowMoney", function(type)
   TriggerEvent("hud:client:SetMoney")
   SendNUIMessage({
       action = "show",
       cash = cashAmount,
       bank = bankAmount,
       type = type,
   })
end)

RegisterNetEvent("hud:client:OnMoneyChange")
AddEventHandler("hud:client:OnMoneyChange", function(type, amount, isMinus)
   QBCore.Functions.GetPlayerData(function(PlayerData)
       cashAmount = PlayerData.money["cash"]
       bankAmount = PlayerData.money["bank"]
   end)
       SendNUIMessage({
           action = "update",
           cash = cashAmount,
           bank = bankAmount,
           amount = amount,
           minus = isMinus,
           type = type,
       })
end)

RegisterNetEvent("qb-admin:client:ToggleDevmode")
AddEventHandler("qb-admin:client:ToggleDevmode", function()
    devmode = not devmode
end)

RegisterNetEvent("hud:client:ToggleCinematic")
AddEventHandler("hud:client:ToggleCinematic", function()
    cinematicmode = not cinematicmode
    if CinematicModeOn == true then
        CinematicShow(false)
        CinematicModeOn = false
        TriggerEvent('QBCore:Notify', 'Cinematic mode off!', 'error')
    elseif CinematicModeOn == false then
        CinematicShow(true)
        CinematicModeOn = true
        TriggerEvent('QBCore:Notify', 'Cinematic mode on!')
    end
end)

-- circle map
RegisterNetEvent("hud:client:ChangeCircle")
AddEventHandler("hud:client:ChangeCircle", function()
    RequestStreamedTextureDict("circlemap", false)
        if not HasStreamedTextureDictLoaded("circlemap") then
            Wait(500)
        end
            TriggerEvent('QBCore:Notify', 'Circle map loading...')
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
            Wait(500)
            SendNUIMessage ({ action = "displayCircleUI" })
            Wait(1200)
            TriggerEvent('QBCore:Notify', 'Circle map loaded!')
end) 
            local pauseActive = false

-- square map
RegisterNetEvent("hud:client:ChangeSquare")
AddEventHandler("hud:client:ChangeSquare", function()
    RequestStreamedTextureDict("squaremap", false)
        if not HasStreamedTextureDictLoaded("squaremap") then
            Wait(500)
        end
            TriggerEvent('QBCore:Notify', 'Square map loading...')
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
            Wait(500)
            SendNUIMessage ({ action = "displaySquareUI" })
            Wait(1200)
            TriggerEvent('QBCore:Notify', 'Square map loaded!')
end)
            local pauseActive = false

Citizen.CreateThread(function()
    while true do
        Wait(500)
        local player = PlayerPedId()
        SetRadarZoom(1000)
        SetRadarBigmapEnabled(false, false)
    end
end)
