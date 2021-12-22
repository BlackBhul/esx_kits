ESX.RegisterUsableItem(Config.CleanedRagName, function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_clean:usatoPannoPulito', source)
	
end)

ESX.RegisterUsableItem(Config.DirtyRagName, function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_clean:usatoPannoSporco', source)
end)

ESX.RegisterUsableItem(Config.RepairKitName, function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_clean:usatoKitRiparazione', source)
end)

RegisterServerEvent('esx_clean:itemHandler')
AddEventHandler('esx_clean:itemHandler', function(azione, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if azione == 'add' then
		xPlayer.addInventoryItem(item, count)
	elseif azione == 'remove' then
		xPlayer.removeInventoryItem(item, count)
	end
end)