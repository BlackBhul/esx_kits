ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx_clean:usatoPannoPulito')
AddEventHandler('esx_clean:usatoPannoPulito', function()
  local playerPed = PlayerPedId()
  local veh, distance = ESX.Game.GetClosestVehicle(GetEntityCoords(playerPed))
  if distance <= Config.Distance then
    if GetVehicleDirtLevel(veh) > 0.0 then
      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
      Citizen.CreateThread(function()
        Citizen.Wait(Config.CleaningTime * 1000)
        
        SetVehicleDirtLevel(veh, 0.0)

        TriggerServerEvent('esx_clean:itemHandler', 'remove', Config.CleanedRagName, 1)
        TriggerServerEvent('esx_clean:itemHandler', 'add', Config.DirtyRagName, 1)

        ESX.ShowNotification(_U('pulito_veicolo'))

        ClearPedTasksImmediately(playerPed)
      end)
    else
      ESX.ShowNotification(_U('veicolo_non_sporco'))
    end
  else
    ESX.ShowNotification(_U('vicino_veicolo'))
  end
end)

RegisterNetEvent('esx_clean:usatoPannoSporco')
AddEventHandler('esx_clean:usatoPannoSporco', function()
  local playerPed = PlayerPedId()
  local veh, distance = ESX.Game.GetClosestVehicle(GetEntityCoords(playerPed))
  if distance <= Config.Distance then
      local puliziaVeh = GetVehicleDirtLevel(veh)
      if puliziaVeh > 0.0 then
        TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
        Citizen.CreateThread(function()
          Citizen.Wait(Config.CleaningTime * 1000)

          if puliziaVeh <= 7.5 then
            SetVehicleDirtLevel(veh, 0.0)
          else
            SetVehicleDirtLevel(veh, puliziaVeh-7.5)
          end
    
          TriggerServerEvent('esx_clean:itemHandler', 'remove', Config.DirtyRagName, 1)
    
          ESX.ShowNotification(_U('pulito_veicolo_sporco'))

          ClearPedTasksImmediately(playerPed)
        end)
      else
        ESX.ShowNotification(_U('veicolo_non_sporco'))
      end
  else
    ESX.ShowNotification(_U('vicino_veicolo'))
  end
end)

RegisterNetEvent('esx_clean:usatoKitRiparazione')
AddEventHandler('esx_clean:usatoKitRiparazione', function()
  local playerPed = PlayerPedId()
  local veh, distance = ESX.Game.GetClosestVehicle(GetEntityCoords(playerPed))
  if distance <= Config.Distance then
    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
    Citizen.CreateThread(function()
      Citizen.Wait(Config.RepairingTime * 1000)

      SetVehicleFixed(veh)

      TriggerServerEvent('esx_clean:itemHandler', 'remove', Config.RepairKitName, 1)

      ESX.ShowNotification(_U('veicolo_riparato'))

      ClearPedTasksImmediately(playerPed)
    end)
  else
    ESX.ShowNotification(_U('vicino_veicolo'))
  end
end)
