local ResetStress = false
local dev = false

-- default new version of qbcore
if Config.Version == "new" then
    QBCore = exports['qb-core']:GetCoreObject()

elseif Config.Version == "old" then
    local QBCore = nil
    Citizen.CreateThread(function()
        while QBCore == nil do
            TriggerEvent("QBCore:GetObject", function(obj)QBCore = obj end)
            Citizen.Wait(200)
        end
    end)
end


-- /cash command
QBCore.Commands.Add("cash", "Check cash", {}, false, function(source, args)
	TriggerClientEvent('hud:client:ShowMoney', source, "cash")
end)

-- /bank command
QBCore.Commands.Add("bank", "Check bank balance", {}, false, function(source, args)
    local player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('QBCore:Notify', source, 'Bank $' ..comma_value(player.PlayerData.money['bank']))
end)

-- /dev command
QBCore.Commands.Add("dev", "Enable/Disable developer Mode", {}, false, function(source, args)
    if QBCore.Functions.HasPermission(source, 'admin') then
	    TriggerClientEvent("qb-admin:client:ToggleDevmode", source)
    else
        TriggerClientEvent('QBCore:Notify', source, 'No Access To This Command ', 'error')
    end
end)

-- /cinematic command
QBCore.Commands.Add("cinematic", "Enable/Disable cinematic mode", {}, false, function(source, args)
    TriggerClientEvent("hud:client:ToggleCinematic", source)
end)

-- stress
RegisterServerEvent("hud:Server:UpdateStress")
AddEventHandler('hud:Server:UpdateStress', function(StressGain)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] + StressGain
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
		TriggerClientEvent("hud:client:update:stress", src, newStress)
	end
end)

RegisterServerEvent('hud:server:gain:stress')
AddEventHandler('hud:server:gain:stress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] + amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
        TriggerClientEvent("hud:client:update:stress", src, newStress)
        TriggerClientEvent('QBCore:Notify', src, "Getting stressed", "error")
	end
end)

RegisterServerEvent('hud:server:RelieveStress')
AddEventHandler('hud:server:RelieveStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] - amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
        TriggerClientEvent("hud:client:update:stress", src, newStress)
        TriggerClientEvent('QBCore:Notify', src, "Stress relieved")
	end
end)

RegisterServerEvent('hud:server:remove:stress')
AddEventHandler('hud:server:remove:stress', function(Amount)
    local Player = QBCore.Functions.GetPlayer(source)
    local NewStress = nil
    if Player ~= nil then
      NewStress = Player.PlayerData.metadata["stress"] - Amount
      if NewStress <= 0 then NewStress = 0 end
      if NewStress > 105 then NewStress = 100 end
      Player.Functions.SetMetaData("stress", NewStress)
      TriggerClientEvent("hud:client:update:stress", Player.PlayerData.source, NewStress)
    end
end)

function comma_value(amount)
    local formatted = amount
    while true do  
      formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
      if (k==0) then
        break
      end
    end
    return formatted
  end
