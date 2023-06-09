local numerot = {
	["U"] = 303,
	["1008"] = 212, --HOME
	["PAGEUP"] = 10,
}

function naytaId(paalla, nappain)
	Citizen.CreateThread(function()
		local headIds = { }
		local omanumero = numerot[nappain]

		print(omanumero)
		print(nappain)
		print(paalla)
		for id = 0, 255, 1 do
			if NetworkIsPlayerActive( id ) then 
				local ped = GetPlayerPed( id )
				if ped ~= nil and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(ped)) < Config.drawDistance) and HasEntityClearLosToEntity(GetPlayerPed(-1),  ped,  17) then
					if GetPlayerServerId(id) ~= nil then
						headIds[id] = CreateFakeMpGamerTag(ped, tostring(GetPlayerServerId(id)), false, false, "", false )
						if paalla then
							if IsControlPressed(0, omanumero) then
								SetMpGamerTagVisibility(headIds[id], false, true)  --laittaa päälle
							end
						else 
							SetMpGamerTagVisibility(headIds[id], false, false) --laittaa pois
						end
					end
				end
			end
		end
	end)
end

local keybind = lib.addKeybind({
    name = 'idpaa',
    description = 'Näytä pelaajan id',
    defaultKey = 'PAGEUP',
    onPressed = function(self)
        naytaId(true, self.currentKey)
    end,
    onReleased = function(self)
        naytaId(false, self.currentKey)
    end,
})