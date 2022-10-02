ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Setup Menu
function OpenMenu()
    local Elements = {
        {label = "Giubbotto Leggero "..Config.Prezzi.leggero.."$", name = "giubbo_leggero", value = Config.Prezzi.leggero},
        {label = "Giubbotto Pesante "..Config.Prezzi.pesante.."$", name = "giubbo_pesante", value = Config.Prezzi.pesante},
    }
      
    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "Giubbo_Menu", {
        title = "Menu Giubbotto",
        align = 'top-left',
        elements = Elements
    }, function(data,menu)
        if data.current.name == "giubbo_leggero" then
            TriggerServerEvent('bl_giubbotti:pagamento', { money = data.current.value, value = 50 })
            menu.close()
        elseif data.current.name == "giubbo_pesante" then
            TriggerServerEvent('bl_giubbotti:pagamento', { money = data.current.value, value = 100 })
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

-- Set giubbo
RegisterNetEvent('bl_giubbotti:setGiubbo', function(data)
    SetPedArmour(PlayerPedId(), data.value)
end)

-- Display Marker
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)

		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Blips) do
			if (v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per aprire il menù!')
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Press E
RegisterCommand('interagisci_blip', function()
    local coords = GetEntityCoords(PlayerPedId())

    for k,v in pairs(Config.Blips) do
        if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
            OpenMenu()
        end
    end
end)
RegisterKeyMapping('interagisci_blip', 'Interagisci con un blip', 'keyboard', 'E')