ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx-qalle-hunting:reward')
AddEventHandler('esx-qalle-hunting:reward', function(Weight)
    local xPlayer = ESX.GetPlayerFromId(source)

    if Weight >= 1 then
        xPlayer.addInventoryItem('viande', 1)
    elseif Weight >= 9 then
        xPlayer.addInventoryItem('viande', 2)
    elseif Weight >= 15 then
        xPlayer.addInventoryItem('viande', 3)
    end

    xPlayer.addInventoryItem('cuir', math.random(1, 4))
        
end)

RegisterServerEvent('esx-qalle-hunting:sell')
AddEventHandler('esx-qalle-hunting:sell', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    local MeatPrice = 125
    local LeatherPrice = 25

    local MeatQuantity = xPlayer.getInventoryItem('viande').count
    local LeatherQuantity = xPlayer.getInventoryItem('cuir').count

    if MeatQuantity > 0 or LeatherQuantity > 0 then
        xPlayer.addMoney(MeatQuantity * MeatPrice)
        xPlayer.addMoney(LeatherQuantity * LeatherPrice)

        xPlayer.removeInventoryItem('viande', MeatQuantity)
        xPlayer.removeInventoryItem('cuir', LeatherQuantity)
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez vendu ' .. LeatherQuantity + MeatQuantity .. ' et gagné $' .. LeatherPrice * LeatherQuantity + MeatPrice * MeatQuantity)
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Tu as plus rien à vendre...')
    end
        
end)

function sendNotification(xsource, message, messageType, messageTimeout)
    TriggerClientEvent('notification', xsource, message)
end
