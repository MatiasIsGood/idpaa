function naytaId(paalla)
	Citizen.CreateThread(function()
		local headIds = { }
		print(paalla)
		for id = 0, 255, 1 do
			if NetworkIsPlayerActive( id ) then 
				local ped = GetPlayerPed( id )
				if ped ~= nil and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(ped)) < Config.drawDistance) and HasEntityClearLosToEntity(GetPlayerPed(-1),  ped,  17) then
					if GetPlayerServerId(id) ~= nil then
						headIds[id] = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, tostring(GetPlayerServerId(id)), false, false, "", false )
						if paalla then
							N_0x63bb75abedc1f6a0(headIds[id], false, true)
						else 
							N_0x63bb75abedc1f6a0(headIds[id], false, false)
						end
					end
				end
			end
		end
	end)
end

RegisterCommand('+idpaa', function()
	naytaId(true)
end)

RegisterCommand('-idpaa', function()  --ei tarvita ainakaan nyt koska tää defaulttaa heti 20ms takas pois päältä
	naytaId(false)
end)

RegisterKeyMapping('+idpaa', 'IDPaa', 'keyboard', 'PAGEUP')