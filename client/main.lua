ESX = nil
YGTBase = {}

-- local YGTBase = exports['ygt-base']:GetYGTBaseObject()
exports('GetYGTBaseObject', function()
    return YGTBase
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(200)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(1)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('ygt:setJob')
AddEventHandler('ygt:setJob', function(job)
    ESX.PlayerData.job = job
end)

local ygt = 0

Citizen.CreateThread(function()
	while true do
		ygt = ygt + 1
		print(ygt)
		Citizen.Wait(200)
	end
end)

local infoOn = false
local coordsText = ""
local headingText = ""
local modelText = ""

Citizen.CreateThread(function()
    while true do
        local pause = 250
        if infoOn then
            pause = 5
            local player = PlayerPedId()
            if IsPlayerFreeAiming(PlayerId()) then
                local entity = getEntity(PlayerId())
                local coords = GetEntityCoords(entity)
                local heading = GetEntityHeading(entity)
                local model = GetEntityModel(entity)
                coordsText = coords
                headingText = heading
                modelText = model
            end
            DrawInfos("Coordinates: " .. coordsText .. "\nHeading: " .. headingText .. "\nHash: " .. modelText)
        end
        Citizen.Wait(pause)
    end
end)

function getEntity(player)
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)
    return entity
end

function DrawInfos(text)
    SetTextColour(255, 255, 255, 255)
    SetTextFont(1)
    SetTextScale(0.4, 0.4)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(false)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(50, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.015, 0.71)
end

function ToggleInfos()
    infoOn = not infoOn
end

RegisterCommand("idgun", function()
    ToggleInfos()
end)

local citizen = false

RegisterNetEvent('ygt-base:setPlayerArmour')
AddEventHandler('ygt-base:setPlayerArmour', function(armour)
    Citizen.Wait(10000)
    SetPedArmour(PlayerPedId(), tonumber(armour))
    citizen = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if citizen == true then
            TriggerServerEvent('ygt-base:refreshCurrentArmour', GetPedArmour(PlayerPedId()))
            Citizen.Wait(60000)
        end
    end
end)