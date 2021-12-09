ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("ygt-base:giveitem")
AddEventHandler("ygt-base:giveitem", function(itemname, amount, slot)
    local xPlayer = ESX.GetPlayerFromId(source)

    if slot ~= nil then
        xPlayer.addInventoryItem(itemname, amount, slot)
    else
        xPlayer.addInventoryItem(itemname, amount)
    end
end)

RegisterServerEvent("ygt-base:removeitem")
AddEventHandler("ygt-base:removeitem", function(itemname, amount, slot)
    local xPlayer = ESX.GetPlayerFromId(source)

    if slot ~= nil then
        xPlayer.removeInventoryItem(itemname, amount, slot)
    else
        xPlayer.removeInventoryItem(itemname, amount)
    end
end)

ESX.RegisterServerCallback("ygt:pData", function (source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier},
	function (user)
		if (user[1] ~= nil) then
            cb (user[1])
		end
	end)
end)

ESX.RegisterServerCallback("ygt-base:getOnlinePoliceCount",function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local Players = ESX.GetPlayers()
	local policeOnline = 0
	for i = 1, #Players do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "sheriff" then
			policeOnline = policeOnline + 1
		end
	end

    cb(policeOnline)
end)

AddEventHandler('esx:playerLoaded', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    exports.ghmattimysql:scalar("SELECT armour FROM users WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.getIdentifier()
        }, function(data)
        if (data ~= nil) then
            TriggerClientEvent('ygt-base:setPlayerArmour', source, data)
        end
    end)
end)

RegisterServerEvent('ygt-base:refreshCurrentArmour')
AddEventHandler('ygt-base:refreshCurrentArmour', function(updateArmour)
    local xPlayer = ESX.GetPlayerFromId(source)
    exports.ghmattimysql:execute("UPDATE users SET armour = @armour WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.getIdentifier(),
        ['@armour'] = tonumber(updateArmour)
    })
end)