RegisterNetEvent("sn:3dme")
AddEventHandler("sn:3dme", function(text, source)
    local playerId = GetPlayerFromServerId(source)
    local isDisplaying = true
    Citizen.CreateThread(function()
        while isDisplaying do
            Citizen.Wait(0)
            local htmlString = ""
            local sourceCoords = GetEntityCoords(GetPlayerPed(playerId))
            local nearCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist2(sourceCoords, nearCoords)
            if distance < 25.0 then
                local onScreen, xxx, yyy =
                    GetHudScreenPositionFromWorldPosition(
                        sourceCoords.x + Config.CoordsX,
                        sourceCoords.y + Config.CoordsY,
                        sourceCoords.z + Config.CoordsZ)
                htmlString =
                    htmlString ..
                    '<span style="position: absolute; left: ' ..
                    xxx * 100 ..
                    "%;top: " .. yyy * 100 .. '%;"><div class="me-container"><div</div><div class="text-container">' .. text .. "</div></div></span>"
            end
            if lasthtmlString ~= htmlString then
                SendNUIMessage({
                    toggle = true,
                    html = htmlString
                })
                lasthtmlString = htmlString
            end
        end
        if isDisplaying == false then
            SendNUIMessage({toggle = false})
        end
    end)
    Citizen.CreateThread(function()
        Citizen.Wait(Config.Duration)
        isDisplaying = false
        SendNUIMessage({toggle = false})
    end)
end)