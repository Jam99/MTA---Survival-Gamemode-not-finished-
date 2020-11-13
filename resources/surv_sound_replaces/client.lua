--sound replaces by Jam


--key should be equal with 'type_<EXPLOSION_TYPE>' [more info at https://wiki.multitheftauto.com/wiki/OnClientExplosion]
--path is relative to 'sounds/explosion' directory
--snd: string [sound file]
--maxDist: int [max distance]
--closeCallEnabled: bool [if set to true: player will hear close call sound effect if the explosion is close enought]
local explosionSounds = { 
					type_0 = {snd="explosion1.wav", 	maxDist=150,	closeCallEnabled=true},
					type_1 = {snd="molotov.wav", 		maxDist=50, 	closeCallEnabled=false},
					type_2 = {snd="explosion2.wav", 	maxDist=220, 	closeCallEnabled=true},
					type_3 = {snd="explosion2.wav", 	maxDist=220, 	closeCallEnabled=false},
					type_4 = {snd="explosion3.wav", 	maxDist=200, 	closeCallEnabled=true},
					type_5 = {snd="explosion3.wav", 	maxDist=200, 	closeCallEnabled=true},
					type_6 = {snd="explosion3.wav", 	maxDist=200, 	closeCallEnabled=true},
					type_7 = {snd="explosion3.wav", 	maxDist=250, 	closeCallEnabled=true},
					type_8 = {snd="explosion1.wav", 	maxDist=140, 	closeCallEnabled=true},
					type_9 = {snd="explosion2.wav", 	maxDist=130, 	closeCallEnabled=true},
					type_10 = {snd="explosion1.wav", 	maxDist=200, 	closeCallEnabled=true},
					type_11 = {snd="explosion2.wav", 	maxDist=100, 	closeCallEnabled=false},
					type_12 = {snd="explosion2.wav", 	maxDist=80, 	closeCallEnabled=false}
				}
		
		
--index should be equal with WEAPON ID [more info at https://wiki.multitheftauto.com/wiki/Weapons]
--path is relative to 'sounds/weapon' directory
--snd: string [sound file]
--maxDist: int [max distance]
local weaponSounds = {}
weaponSounds[22] = {snd="pistol.wav",	maxDist=140}
weaponSounds[23] = {snd="silenced.wav",	maxDist=40}
weaponSounds[24] = {snd="deagle.wav",	maxDist=155}
weaponSounds[25] = {snd="shotgun.wav",	maxDist=180}
weaponSounds[26] = {snd="sawedoff.wav",	maxDist=160}
weaponSounds[27] = {snd="combatsh.wav",	maxDist=160}
weaponSounds[28] = {snd="uzi.wav",		maxDist=145}
weaponSounds[29] = {snd="mp5.wav",		maxDist=145}
weaponSounds[32] = {snd="tec-9.wav",	maxDist=145}
weaponSounds[30] = {snd="ak.wav",		maxDist=160}
weaponSounds[31] = {snd="m4.wav",		maxDist=140}
weaponSounds[33] = {snd="rifle.wav",	maxDist=180}
weaponSounds[34] = {snd="sniper.wav",	maxDist=200}

--disables default weapon sounds
--after an update it's recommended to check sounds using the 'showsound' command
local disableSounds = {} --indexes are groups of world sounds
disableSounds[4] = {1, 2, 3, 4} --explosion sound indexes
disableSounds[5] = {3, 4, 5, 33, 53, 6, 7, 8, 31, 32, 52, 76, 74, 24, 2, 1, 73, 21, 22, 23, 29, 30, 17, 18, 0, 26, 27, 55} --weapon sound indexes


for group, indexArray in pairs(disableSounds) do
	for _, soundIndex in pairs(indexArray) do
		setWorldSoundEnabled(group, soundIndex, false)
	end
end

disableSounds = nil


addEventHandler("onClientExplosion", root, function(posX, posY, posZ, explosionType)
		setSoundMaxDistance(playSound3D("sounds/explosion/"..explosionSounds["type_"..explosionType]["snd"], posX, posY, posZ), explosionSounds["type_"..explosionType]["maxDist"])
		if explosionSounds["type_"..explosionType]["closeCallEnabled"] and not isPedInVehicle(localPlayer) then
			local playerX, playerY, playerZ = getElementPosition(localPlayer)
			if getDistanceBetweenPoints3D(playerX, playerY, playerZ, posX, posY, posZ) < 6 then
				if not closeCallSnd or getSoundPosition(closeCallSnd) == getSoundLength(closeCallSnd) then
					closeCallSnd = playSound("sounds/explosion/close_call.wav")
				end
			end
		end
	end
)

function weaponFireHandler(weapon, _, _, _, _, _, _, startX, startY, startZ)
	local snd = playSound3D("sounds/weapon/"..weaponSounds[weapon]["snd"], startX, startY, startZ)
	setSoundMaxDistance(snd, weaponSounds[weapon]["maxDist"])
	attachElements(snd, source)
end
addEventHandler("onClientPlayerWeaponFire", root, weaponFireHandler)






