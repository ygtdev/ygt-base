YGTBase.Functions = {}

-- YGTBase.Functions.ScreenBlur(true)
function YGTBase.Functions.ScreenBlur(blur)
    if blur then
        TriggerScreenblurFadeIn(0)
    else
        TriggerScreenblurFadeOut(0)
    end
end

-- YGTBase.Functions.GetPlayerJob()
function YGTBase.Functions.GetPlayerData()
    return ESX.PlayerData
end

-- YGTBase.Functions.GiveItem(itemname, amount, slot)
function YGTBase.Functions.GiveItem(itemname, amount, slot)
    TriggerServerEvent("ygt-base:giveitem", itemname, amount, slot)
end

-- YGTBase.Functions.RemoveItem(itemname, amount, slot)
function YGTBase.Functions.RemoveItem(itemname, amount, slot)
    TriggerServerEvent("ygt-base:removeitem", itemname, amount, slot)
end

-- YGTBase.Functions.SendAlert("error", "Deneme")
function YGTBase.Functions.SendAlert(type, text)
    exports["mythic_notify"]:SendAlert(type, text)
end

-- YGTBase.Functions.DistanceCheck(vector3(2371.60, 3080.20, 48.1529), 5)
function YGTBase.Functions.DistanceCheck(coords, dist)
    local pPed = PlayerPedId()
    local pCoords = GetEntityCoords(pPed)
    local distance = #(pCoords - coords)

    if distance <= dist then
        return true
    else
        return false
    end
end

-- YGTBase.Functions.SpawnVehicle("drafter", vector3(63.0418, -1122.8, 29.3266), 359.47)
function YGTBase.Functions.SpawnVehicle(vehname, coords, heading)
    ESX.Game.SpawnVehicle(vehname, coords, heading, function(vehicle)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    end)
end

-- YGTBase.Functions.GetPlayerDead()
function YGTBase.Functions.GetPlayerDead()
    return exports['esx_ambulancejob']:GetDeath()
end

function YGTBase.Functions.AddStatus(statustype, addtime)
    status = true
    type = statustype
    lasttime = addtime
end

function YGTBase.Functions.StopStatus()
    status = false
    type = false
    time = 0
    lasttime = 0
end

-- YGTBase.Functions.DrawText(-232.36, -915.07, 32.3107 + 0.5, "[E] - Nüfus Müdürlügü")
function YGTBase.Functions.DrawText(x, y, z, text)
	SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 250
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- YGTBase.Functions.CreatePed("a_m_y_smartcaspat_01", -308.14, -1003.3, 3.60232, 96.49)
function YGTBase.Functions.CreatePed(pedname, x, y, z, heading)
    RequestModel(GetHashKey(pedname))
    while not HasModelLoaded(GetHashKey(pedname)) do
        Wait(1)
    end
    npc = CreatePed(1, GetHashKey(pedname), x, y, z, heading, false, true)
    SetPedCombatAttributes(npc, 46, true)
    SetPedFleeAttributes(npc, 0, 0)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetEntityAsMissionEntity(npc, true, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
end