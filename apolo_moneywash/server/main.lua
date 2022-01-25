local QBCore = exports['qb-core']:GetCoreObject()

local ItemList = {
    ["markedbills"] = "markedbills"
}

RegisterServerEvent('apolo_moneywash:server:getmoney')
AddEventHandler('apolo_moneywash:server:getmoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local markedbills = Player.Functions.GetItemByName('markedbills')

    if Player.PlayerData.items ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if markedbills ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    if Player.PlayerData.items[k].name == "markedbills" and Player.PlayerData.items[k].amount >= 1 then 
                        local amount = Player.PlayerData.items[k].amount
						TriggerClientEvent('QBCore:Notify', src, "You washed "..Player.PlayerData.items[k].amount.." Marked Money!")
                        Player.Functions.RemoveItem("markedbills", Player.PlayerData.items[k].amount)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['markedbills'], "remove")
                        Player.Functions.AddMoney("cash", amount)
                        break
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You do not have marked money", 'error')
                        break
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You do not have marked money", 'error')
                break

            end
        end
    end
end)

RegisterServerEvent('apolo_moneywash:server:checkmoney')
AddEventHandler('apolo_moneywash:server:checkmoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local markedbills = Player.Functions.GetItemByName('markedbills')

    if Player.PlayerData.items ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if markedbills ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    if Player.PlayerData.items[k].name == "markedbills" and Player.PlayerData.items[k].amount >= 1 then 
                        local amount = Player.PlayerData.items[k].amount
					    TriggerClientEvent("apolo_moneywash:client:WashProggress", src)
                        break
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You do not have marked money", 'error')
                        break
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You do not have marked money", 'error')
                break

            end
        end
    end
end)

