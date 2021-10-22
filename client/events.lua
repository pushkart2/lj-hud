local dev = false

-- events
RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    isLoggedIn = true
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload")
AddEventHandler("QBCore:Client:OnPlayerUnload", function()
    isLoggedIn = false
    SendNUIMessage({
        action = "hudtick",
        show = true,
    })
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
