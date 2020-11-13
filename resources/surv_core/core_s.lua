
gmPrefix = "SURVIVAL"
setGameType("Survival ALPHA")
localChatRadius = 32
defaultSurvivorSkin = {male=1,female=12}--alapértelmezett SKIN ID (akkor van használatban, ha a játékos nem visel semmilyen ruházatot)

realTime = getRealTime()
setMinuteDuration(60000)
setTime(realTime["hour"], realTime["minute"])

inventorySizeX = 16
inventorySizeY = 6

inventories = {} --az öszzes inventory tárolására
inventoryMatrixes = {} --az öszzes inventory matrix tárolására
backpackObjects = {} --az öszzes backpack object tárolására
defaultGenders = {} --az öszzes gender flag tárolására (true = férfi, false = nő)

defaultPlayerInventory = { --alapértelmezett PLAYER inventory
		equippedBackpack = "item_coyote_backpack_green",
		equippedPrimary = "none",
		equippedSecondary = "none",
		equippedMelee = "none",
		equippedThrowable = "none",
		usedClothes = "none",
		items = {
			{
				id = "item_civil_clothes",
				posX = 1,
				posY = 1
			},
			{
				id = "item_survivor_clothes",
				posX = 15,
				posY = 2
			},
			{
				id = "item_desert_camo_clothes",
				posX = 3,
				posY = 1
			}
		}
	}

defaultPedInventory = { --alapértelmezett PED inventory
		equippedBackpack = "none",
		equippedPrimary = "none",
		equippedSecondary = "none",
		equippedMelee = "none",
		equippedThrowable = "none",
		usedClothes = "none",
		items = {}
	}
	
defaultVehicleInventory = { --alapértelmezett VEHICLE inventory
		items = {}
	}

items = {
	item_civil_clothes = {
								friendlyName = "Civilian clothes",
								sizeX = 2,
								sizeY = 2
							},
	item_survivor_clothes = {
								friendlyName = "Survivor clothes",
								sizeX = 2,
								sizeY = 2
							},
	item_forest_camo_clothes = {
								friendlyName = "Forest camo clothes",
								sizeX = 2,
								sizeY = 2
							},
	item_desert_camo_clothes = {
								friendlyName = "Desert camo clothes",
								sizeX = 5,
								sizeY = 5
							},
	item_coyote_backpack_green = {
								friendlyName = "Coyote backpack",
								sizeX = 2,
								sizeY = 2
							},
	item_coyote_backpack_tan = {
								friendlyName = "Coyote backpack",
								sizeX = 2,
								sizeY = 2
							},
	item_alice_backpack = {
								friendlyName = "Alice backpack",
								sizeX = 2,
								sizeY = 2
							},
	item_assault_backpack = {
								friendlyName = "Assault backpack",
								sizeX = 2,
								sizeY = 2
							},
	item_army_backpack = {
								friendlyName = "Army backpack",
								sizeX = 2,
								sizeY = 2
							},
	item_czech_backpack = {
								friendlyName = "Czech backpack",
								sizeX = 2,
								sizeY = 2
							},
	item_ghillie_backpack = {
								friendlyName = "Ghillie backpack",
								sizeX = 2,
								sizeY = 2
							},
	item_legendary_backpack = {
								friendlyName = "Legendary backpack",
								sizeX = 2,
								sizeY = 2
							},
	item_tourist_backpack = {
								friendlyName = "Tourist backpack",
								sizeX = 2,
								sizeY = 2
							}
	}

clothesSkinIDs = { --ruházatok skin ID megfelelője
	none = nil,
	item_civil_clothes = 2,
	item_survivor_clothes = 4,
	item_forest_camo_clothes = 5,
	item_desert_camo_clothes = 6
}

backpackIncreaseSizeY = { --különböző hátizsákok méretei sorokban megadva
	none = 0, --DO NOT REMOVE
	item_coyote_backpack_green = 12,
	item_coyote_backpack_tan = 12,
	item_alice_backpack = 12,
	item_assault_backpack = 6,
	item_army_backpack = 14,
	item_czech_backpack = 15,
	item_ghillie_backpack = 16,
	item_legendary_backpack = 20,
	item_tourist_backpack = 12
}

backpackModels = {
	item_coyote_backpack_tan = {
		modelID = 1252,
		xPosOffset = 0,
		yPosOffset = -0.15,
		zPosOffset = 0.1,
		xRotOffset = 0,
		yRotOffset = 0,
		zRotOffset = 0
	},
	item_coyote_backpack_green = {
		modelID = 1550,
		xPosOffset = 0,
		yPosOffset = -0.15,
		zPosOffset = 0.1,
		xRotOffset = 0,
		yRotOffset = 0,
		zRotOffset = 0
	},
	item_alice_backpack = {
		modelID = 1248,
		xPosOffset = 0,
		yPosOffset = 0,
		zPosOffset = 0,
		xRotOffset = 0,
		yRotOffset = 0,
		zRotOffset = 0
	},
	item_army_backpack = {
		modelID = 2114,
		xPosOffset = 0,
		yPosOffset = 0,
		zPosOffset = 0,
		xRotOffset = 0,
		yRotOffset = 0,
		zRotOffset = 0
	},
	item_czech_backpack = {
		modelID = 1254,
		xPosOffset = 0,
		yPosOffset = 0,
		zPosOffset = 0,
		xRotOffset = 0,
		yRotOffset = 0,
		zRotOffset = 0
	},
	item_ghillie_backpack = {
		modelID = 1575,
		xPosOffset = 0,
		yPosOffset = 0,
		zPosOffset = 0,
		xRotOffset = 0,
		yRotOffset = 0,
		zRotOffset = 0
	},
	item_legendary_backpack = {
		modelID = 1239,
		xPosOffset = 0,
		yPosOffset = 0,
		zPosOffset = 0,
		xRotOffset = 0,
		yRotOffset = 0,
		zRotOffset = 0
	},
	item_assault_backpack = {
		modelID = 3026,
		xPosOffset = 0,
		yPosOffset = 0,
		zPosOffset = 0,
		xRotOffset = 0,
		yRotOffset = 0,
		zRotOffset = 0
	},
	item_tourist_backpack = {
		modelID = 1598,
		xPosOffset = 0,
		yPosOffset = 0,
		zPosOffset = 0,
		xRotOffset = 0,
		yRotOffset = 0,
		zRotOffset = 0
	},
}

--engedélyezi azon fegyverekre is a mozgás közbeni lövést, melyekre az STD (weapon skill 500) kategóriában az nem engedélyezett
for _, weapon in pairs({23,24,25,27,29,30,31,33,34}) do
	setWeaponProperty(weapon, "std", "flag_move_and_shoot", true)
end
--módosítja néhány fegyver esetén, a célzás közbeni sebességet
setWeaponProperty(23, "std", "move_speed", 1.6) --silenced
setWeaponProperty(24, "std", "move_speed", 1.55) --deagle
setWeaponProperty(29, "std", "move_speed", 1.5) --MP5
setWeaponProperty(30, "std", "move_speed", 1.3) --AK47
setWeaponProperty(31, "std", "move_speed", 1.3) --M4

--elindít minden szükséges resourcet
addEventHandler("onResourceStart", resourceRoot, function()
		outputChatBox(" ")
		outputChatBox("LAUNCHING SURVIVAL GAMEMODE", root, 0, 255, 0)
		for i, res in pairs(getResources()) do
			if getResourceOrganizationalPath(res) == "[[SURVIVAL_GAMEMODE]]" and res ~= resource then
				outputChatBox("#FFFFFFStarting #FFFF00"..getResourceName(res).."#FFFFFF resource", root, 255, 255, 255, true)
				if startResource(res) then
					outputChatBox("success", root, 0, 255, 0)
				else
					outputChatBox("failed", root, 255, 0, 0)
				end
			end
		end
		db = exports.db:getDB() --ADATBÁZIS
		if getFPSLimit() > 60 then
			outputServerLog("FPS limit is greater than 60 (currently set to "..getFPSLimit().."). It is recommended to test the ability of moving while aiming at the desired FPS to make sure it works correctly. [GTA SA BUG]")
		end
	end
)


--leállít minden kapcsolódó resourcet
addEventHandler("onResourceStop", resourceRoot, function()
		outputChatBox(" ")
		outputChatBox("STOPPING SURVIVAL GAMEMODE", root, 255, 0, 0)
		for i, res in pairs(getResources()) do
			if getResourceOrganizationalPath(res) == "[[SURVIVAL_GAMEMODE]]" and res ~= resource then
				stopResource(res)
				outputChatBox("#FFFFFFStopping #FFFF00"..getResourceName(res).."#FFFFFF resource", root, 255, 255, 255, true)
			end
		end
	end
)

--SEND ITEMS ARRAY
addEvent("requestPreDefinedVariables", true)
addEventHandler("requestPreDefinedVariables", resourceRoot, function()
		triggerClientEvent(client, "onResponsePreDefinedVariables", resourceRoot, items, backpackIncreaseSizeY, inventorySizeX, inventorySizeY)
	end
)

--SAVE/UPDATE DATAS
function savePlayerStats(player)
	local posX, posY, posZ = getElementPosition(player)
	local _, _, rotZ = getElementRotation(player)
	dbExec(db, "UPDATE accounts SET "..
		"savedHealth=?,"..
		"savedMoney=?,"..
		"savedPosX=?,"..
		"savedPosY=?,"..
		"savedPosZ=?,"..
		"savedRotZ=?,"..
		"spawnTime=FROM_UNIXTIME(?-7200)"..
		"WHERE ID = ?",
		getElementHealth(player),
		getPlayerMoney(player),
		posX,
		posY,
		posZ,
		rotZ,
		getElementData(player, "surv_spawn_time"),
		getElementData(player, "acc_id")
	)
end


function setAccountFlagInDB(acc_id, flagName, value)
	dbExec(db, "UPDATE accounts SET ??=? WHERE ID=?", flagName, value, acc_id)
end


--USEFUL FUNCTIONS
function table.copy(tab, recursive)
    local ret = {}
    for key, value in pairs(tab) do
        if (type(value) == "table") and recursive then ret[key] = table.copy(value)
        else ret[key] = value end
    end
    return ret
end

function zeroPrefix(value, size)
	value = tostring(value)
	for i=1, size-#value do
		value = "0"..value
	end
	return value
end

function removeHex (text, digits)
    assert (type (text) == "string", "Bad argument 1 @ removeHex [String expected, got "..tostring(text).."]")
    assert (digits == nil or (type (digits) == "number" and digits > 0), "Bad argument 2 @ removeHex [Number greater than zero expected, got "..tostring (digits).."]")
    return string.gsub (text, "#"..(digits and string.rep("%x", digits) or "%x+"), "")
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
    
    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
    
    timestamp = timestamp - 3600
    if datetime.isdst then timestamp = timestamp - 3600 end
    
    return timestamp
end

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

--CHANGE NICK HANDLER
--megakadályozza a név váltást, kivéve ha az script által történik
addEventHandler("onPlayerChangeNick", root, function(_, _, changedByUser)
		if changedByUser then
			cancelEvent()
		end
	end
)


--JOIN HANDLER
addEventHandler("onPlayerJoin", root, function()
		setPlayerName(source, removeHex(getPlayerName(source)))
		outputChatBox("#00FF00["..gmPrefix.."] #FFFF00"..getPlayerName(source).." #FFFFFFjoined to the server.", root, 255, 255, 255, true)
		setPedFightingStyle(source, 5) --fighting style
		for i=69, 79 do --weapon skills
			setPedStat(source, i, 500) --DO NOT CHANGE
		end
		setPlayerNametagShowing(source, false)
	end
)


--QUIT HANDLER
addEventHandler("onPlayerQuit", root, function(quitType)
		outputChatBox("#00FF00["..gmPrefix.."] #FFFF00"..getPlayerName(source).." #FFFFFFleft the game. #888888["..quitType.."]", root, 255, 255, 255, true)
		if getElementData(source, "acc_id") then
			savePlayerStats(source)
			saveInventory(source)
			if inventories[source] then
				destroyInventory(source)
			end
			if not isPedDead(source) and getTimestamp() - getElementData(source, "surv_spawn_time") >= 120 then
				setAccountFlagInDB(getElementData(source, "acc_id"), "forceSpawnNew", 0)
			end
		end
	end
)


--LOGIN HANDLER
addEventHandler("onPlayerLogin", root, function(_, currentAcc)
		outputConsole(getPlayerName(source).." logged in to account "..getAccountName(currentAcc))
		local query = dbQuery(db, "SELECT ID, TIMESTAMPDIFF(SECOND , '1970-01-01 00:00:00', spawnTime) AS spawnTime, savedHealth, savedMoney, savedPosX, savedPosY, savedPosZ, savedRotZ, defaultGender, forceSpawnNew, inventory FROM accounts WHERE name = ?", getAccountName(currentAcc))
		local result = dbPoll(query, -1)[1]
		setElementData(source, "acc_id", getAccountID(currentAcc))
		local spawnTimeTemp = result["spawnTime"] or 0
		setElementData(source, "surv_spawn_time", spawnTimeTemp)
		setPlayerMoney(source, result["savedMoney"])
		
		local localChatCol = createColSphere(0, 0, 0, localChatRadius)
		setElementParent(localChatCol, source)
		attachElements(localChatCol, source)
		setElementData(source, "local_chat_col", localChatCol)
		
		defaultGenders[source] = result["defaultGender"]
		
		if result["forceSpawnNew"] == 1 then
			spawnPlayerNew(source)
		else
			spawnPlayerContinue(source, result["inventory"], result["savedHealth"], result["savedPosX"], result["savedPosY"], result["savedPosZ"], result["savedRotZ"])
		end
	end
)


--LOGOUT HANDLER
addEventHandler("onPlayerLogout", root, function()
		cancelEvent()
		outputChatBox("Logging out is not possible in survival gamemode!", source, 255, 0, 0)
	end
)



--SPAWN FUNCTIONS / HANDLERS
function spawnPlayerNew(player, posX, posY)
	posX = posX or math.random(-1800, 1800)
	posY = posY or math.random(-1800, 1800)
	createInventory(player)
	spawnPlayer(player, posX, posY, 600, 0, clothesSkinIDs[inventories[player]["usedClothes"]] or defaultSurvivorSkin[defaultGenders[player]])
	giveWeapon(player, 46, 1, true)
	setCameraTarget(player, player)
	fadeCamera(player, true, 0.5)
	setElementData(player, "surv_spawn_time", getTimestamp())
	outputChatBox("#FFFFFFYou have to stay alive at least #cc84002 #FFFFFFminutes after respawn to save your status.", player, 255, 0, 0, true)
	triggerClientEvent(player, "onClientForcedNewSpawn", root)
end

function spawnPlayerContinue(player, invJSON, savedHealth, posX, posY, posZ, rotZ)
	createInventory(player, invJSON)
	spawnPlayer(player, posX, posY, posZ, rotZ, clothesSkinIDs[inventories[player]["usedClothes"]] or defaultSurvivorSkin[defaultGenders[player]])
	setElementHealth(player, savedHealth)
	setCameraTarget(player, player)
	fadeCamera(player, true, 0.5)
end

addEvent("onPlayerClaimRespawn", true)
addEventHandler("onPlayerClaimRespawn", root, function()
		spawnPlayerNew(client)
	end
)

--WASTED HANDLER
addEventHandler("onPlayerWasted", root, function(totalAmmo, killer, killerWeapon, bodyPart)
		outputChatBox(getPlayerName(source).." died", root, 255, 0, 0)
		local posX, posY, posZ = getElementPosition(source)
		local _, _, rotZ = getElementRotation(source)
		setElementFrozen(source, true)
		setElementPosition(source, 0, 0, -50)
		local ped = createPed(getElementModel(source), posX, posY, posZ, rotZ, true)
		setElementHealth(ped, 0)
		setCameraMatrix(source, posX, posY, posZ+2, posX, posY, posZ, rotZ, 180)
		if bodyPart == 9 then
			setPedHeadless(ped, true)
		end
		if killerWeapon == 37 or killerWeapon == 16 or killerWeapon == 18 then
			setPedOnFire(ped, true)
			setTimer(function()
					setPedOnFire(ped, false)
				end, 10000, 1
			)
		end
		
		copyInventory(source, ped)
		destroyInventory(source)
		setAccountFlagInDB(getElementData(source, "acc_id"), "forceSpawnNew", 1)
		
		setElementData(ped, "surv_corpse_name", getPlayerName(source))
		setElementData(ped, "surv_loot_marker", true)
		
		local marker = createMarker(0, 0, -75, "corona", 1, 255, 255, 255, 50)
		attachElements(marker, ped, 0, 0, -0.25)
		setElementParent(marker, ped)
		
		setTimer(function() --bizonyos idő után lefagyasztja a ped-et és kikapcsolja a sync-et a jobb teljesítmény érdekében
				setElementFrozen(ped, true)
				setElementSyncer(ped, false)
			end, 10000, 1
		)
	end
)

--INVENTORY FUNCTIONS
function calculateInventoryMatrix(invOwner)
	local matrix = {}
	for i=1, inventorySizeY + backpackIncreaseSizeY[inventories[invOwner]["equippedBackpack"]] do
		local tempArray = {}
		for j=1, inventorySizeX do
			tempArray[j] = 0
		end
		matrix[i] = tempArray
	end
	local x,y
	for i, item in pairs(inventories[invOwner]["items"]) do
		for y=item["posY"], item["posY"] + items[item["id"]]["sizeY"] - 1 do
			for x=item["posX"], item["posX"] + items[item["id"]]["sizeX"] - 1 do
				if matrix[y][x] == 0 then
					matrix[y][x] = i
				else
					if getElementType(invOwner) == "player" then
						outputChatBox("WARNING: "..item["id"].." has been removed from your inventory due to colission in your inventory matrix. Contact the developer if you would like to get your item back.", invOwner, 255, 0, 0)
					end
					outputDebugString("[INVENTORY] InvMatrix colission captured at X: "..x.." Y: "..y.." Removing "..item["id"].." from array and recalculating recursively. InvOwner element's type is"..getElementType(invOwner))
					inventories[invOwner]["items"][i] = nil
					return calculateInventoryMatrix(invOwner)
				end
			end
		end
	end
	return matrix
end


function updateInventoryMatrix(invOwner, itemIndex, updateTo)
	for y=inventories[invOwner]["items"][itemIndex]["posY"], inventories[invOwner]["items"][itemIndex]["posY"] + items[inventories[invOwner]["items"][itemIndex]["id"]]["sizeY"] - 1, 1 do
		for x=inventories[invOwner]["items"][itemIndex]["posX"], inventories[invOwner]["items"][itemIndex]["posX"] + items[inventories[invOwner]["items"][itemIndex]["id"]]["sizeX"] - 1, 1 do
			inventoryMatrixes[invOwner][y][x] = updateTo
		end
	end
end

function doesItemFitsToInventoryPos(invOwner, itemID, checkX, checkY)
	if checkY <= inventorySizeY and checkY + items[itemID]["sizeY"] -1 > inventorySizeY then --checking inventory divider
		return false
	end
	for y=checkY, checkY + items[itemID]["sizeY"] - 1, 1 do
		for x=checkX, checkX + items[itemID]["sizeX"] - 1, 1 do
			if not inventoryMatrixes[invOwner][y] or inventoryMatrixes[invOwner][y][x] ~= 0 then
				return false
			end
		end
	end
	return true
end

--szabad pozíciót keres az itemnek az inventoryban, ha talál azonnal viszzaadja annak koordinátáit tömbben, ha nem talál, false értéket ad viszza
function findFitPosForItemInInventory(invOwner, itemID)
	for y, xArray in pairs(inventoryMatrixes[invOwner]) do
		for x, _ in pairs(xArray) do
			if doesItemFitsToInventoryPos(invOwner, itemID, x, y) then
				return {fitX = x, fitY = y}
			end
		end
	end
	return false
end

--item elvétel az adott inventoryból, siker esetén true-t ad viszza, egyébként false-t
function removeItemFromInventory(invOwner, itemIndex)
	if not inventories[invOwner]["items"][itemIndex] then
		return false
	end
	local itemID = inventories[invOwner]["items"][itemIndex]["id"]
	updateInventoryMatrix(invOwner, itemIndex, 0)
	inventories[invOwner]["items"][itemIndex] = nil
	
	triggerClientEvent("onClientItemRemovedFromInventory", invOwner, itemID, itemIndex)
	
	return true
end

--item adás az adott inventorynak, siker esetén viszzaadja az indexet (insertIndex), ha nem fér el, vagy egyéb hiba adódik, úgy false-t ad viszza
--a koordináta opcionális, amennyiben nincs megadva, úgy keres egy szabad helyet az inventoryban
--int invOwner, string itemID, [int insertX, int insertY]
function addItemToInventory(invOwner, itemID, insertX, insertY)
	if not items[itemID] then
		outputDebugString("[INVENTORY] Failed to give item. Invalid item ID -> "..itemID)
	end

	if insertX and insertY then
		if not doesItemFitsToInventoryPos(invOwner, itemID, insertX, insertY) then
			return false
		end
	else
		local fitPos = findFitPosForItemInInventory(invOwner, itemID)
		
		if not fitPos then --ha nincs hely
			return false
		end
		
		insertX, insertY = fitPos["fitX"], fitPos["fitY"]
	end
	
	local itemTemp = {}
	local insertIndex
	itemTemp["id"] = itemID
	itemTemp["posX"] = insertX
	itemTemp["posY"] = insertY
	
	--megnézi, hogy van-e szabad index 
	for i=1, #inventories[invOwner]["items"] do
		if not inventories[invOwner]["items"][i] then
			insertIndex = i
			break
		end
	end
	
	--ha van szabad index, beilleszti oda, egyébként a tömb végére
	insertIndex = insertIndex or #inventories[invOwner]["items"] + 1
	
	inventories[invOwner]["items"][insertIndex] = itemTemp
	updateInventoryMatrix(invOwner, insertIndex, insertIndex)
	
	triggerClientEvent("onClientItemAddedToInventory", invOwner, itemTemp, insertIndex)
	
	return insertIndex
end


--létrehoz egy inventory tömböt és beilleszti az inventories tömbbe
function createInventory(owner, invJSON) --owner (player/tent/veh), [invJSON (ha meg van adva a JSON objektum, felülírja az alapértelmezett inventoryt)]
	if not isElement(owner) then
		return false
	end
	
	local elementType = getElementType(owner)
	if not inventories[owner] then
		if not invJSON then
			if elementType == "player" then
				inventories[owner] = table.copy(defaultPlayerInventory, true)
			elseif elementType == "ped" then
				inventories[owner] = table.copy(defaultPedInventory, true)
			elseif elementType == "vehicle" then
				inventories[owner] = table.copy(defaultVehicleInventory, true)
			else
				outputDebugString("[INVENTORY] Failed to create inventory. Default inventory is not set for "..elementType.." type elements. Can be skipped using the invJSON parameter.")
				return false
			end
		else
			inventories[owner] = fromJSON(invJSON)

			--FIX: replace keys to indexes (because **sometimes but not each time** after converting it to JSON, number type indexes become string type keys)
			if not inventories[owner]["items"][1] then --checking if array is number type indexed (JSON only hold indexes when there is a gap in the array)
				for i, item in pairs(inventories[owner]["items"]) do
					inventories[owner]["items"][tonumber(i)] = table.copy(item, true) --creates number type indexed item
					if type(i) == "string" then
						inventories[owner]["items"][i] = nil --deletes item with string type key
					end
				end
			end
		end
		backpackObject(owner, inventories[owner]["equippedBackpack"])
		inventoryMatrixes[owner] = calculateInventoryMatrix(owner)
		triggerClientEvent("onClientInventoryCreated", owner, inventories[owner], inventoryMatrixes[owner])
	else
		outputDebugString("[INVENTORY] Failed to create inventory. Given "..elementType.." element already owns an inventory.")
		return false
	end
end

--törli az inventory-t (nem kiüríti!), siker esetén true értéket ad viszza, ha nem létezik az inventory, úgy false-t
function destroyInventory(owner)
	if not inventories[owner] then
		outputDebugString("[INVENTORY] Failed to destroy inventory. Given element has no inventory.")
		return false
	end
	backpackObject(owner, "none") --destroys backpack object
	inventories[owner] = nil
	inventoryMatrixes[owner] = nil
	triggerClientEvent("onClientInventoryDestroyed", owner)
	return true
end

function copyInventory(copy, paste)
	inventories[paste] = table.copy(inventories[copy])
	inventoryMatrixes[paste] = table.copy(inventoryMatrixes[copy])
	backpackObject(paste, inventories[copy]["equippedBackpack"])
end

function saveInventory(owner)
	local elementType = getElementType(owner)
	
	if elementType == "player" then
		if inventories[owner] then
			dbExec(db, "UPDATE accounts SET inventory = ? WHERE ID = ?", toJSON(inventories[owner]), getElementData(owner, "acc_id"))
		else
			dbExec(db, "UPDATE accounts SET inventory = NULL WHERE ID = ?", getElementData(owner, "acc_id"))
		end
	end
end

--true értéket ad viszza, ha a hátizsák készen áll a levételre / cserére (elegendő a hely, megfelelően ki van ürítve, stb.), egyébként false értéket ad viszza
function isBackpackReadyToChange(invOwner, newBackpackItemID)
	for y=inventorySizeY + backpackIncreaseSizeY[newBackpackItemID] + 1, #inventoryMatrixes[invOwner] do
		for x=1, inventorySizeX do
			if inventoryMatrixes[invOwner][y][x] ~= 0 then
				return false
			end
		end
	end
	return true
end

--beállítja az adott inventory jelenlegi hátizsákját, létrehozza a modelt és hozzácsatolja a gerinchez, itemID='none' esetén leveszi a hátizsákot
--csak player/ped!
function inventoryEquipBackpack(invOwner, itemID, playAnim)
	if not isBackpackReadyToChange(invOwner, itemID) then
		return false
	end
	playAnim = playAnim or false
	
	if playAnim then
		setPedAnimation(invOwner, "bomber", "bom_plant", -1, false, false, false, false)
	end
	
	if itemID == "none" then
		if backpackObjects[invOwner] then
			backpackObject(invOwner, "none")
		end
		
		inventories[invOwner]["equippedBackpack"] = "none"
		inventoryMatrixes[invOwner] = calculateInventoryMatrix(invOwner)
		triggerClientEvent("onClientBackpackChanged", invOwner, inventories[invOwner], inventoryMatrixes[invOwner])
		return true
	end
	
	
	inventories[invOwner]["equippedBackpack"] = itemID
	inventoryMatrixes[invOwner] = calculateInventoryMatrix(invOwner)

	--backpack object
	backpackObject(invOwner, itemID)
	
	triggerClientEvent("onClientBackpackChanged", invOwner, inventories[invOwner], inventoryMatrixes[invOwner])
	return true
end

--az itemID-nak megfelelő objectet csatol a játékoshoz/ped-hez
function backpackObject(invOwner, itemID)
	if backpackObjects[invOwner] then --törli a korábbi objectet, ha létezett
		destroyElement(backpackObjects[invOwner])
		backpackObjects[invOwner] = nil
	end
	if itemID == "none" then --none esetén nem kell új object
		return
	end
	
	backpackObjects[invOwner] = createObject(backpackModels[itemID]["modelID"], 0, 0, -50)
	exports.bone_attach:attachElementToBone(backpackObjects[invOwner], invOwner, 3,
		backpackModels[itemID]["xPosOffset"],
		backpackModels[itemID]["yPosOffset"],
		backpackModels[itemID]["zPosOffset"],
		backpackModels[itemID]["xRotOffset"],
		backpackModels[itemID]["yRotOffset"],
		backpackModels[itemID]["zRotOffset"]
	)
end

addEvent("requestRemoteInventory", true)
addEventHandler("requestRemoteInventory", root, function()
		triggerClientEvent(client, "onResponseRemoteInventory", source, inventories[source], inventoryMatrixes[source])
	end
)

--LOCAL CHAT
function localChat(player, msg)
	local localChatCol = getElementData(player, "local_chat_col")
	for i, targetPlayer in pairs(getElementsWithinColShape(localChatCol, "player")) do
		outputChatBox("#DEB887[LOCAL] #FEFFB5"..getPlayerName(player)..": #FFFFFF"..msg, targetPlayer, 255, 255, 255, true)
	end
end

addEventHandler("onPlayerChat", root, function(msg, msgType)
		if msgType == 0 then --localChat
			cancelEvent()
			if isGuestAccount(getPlayerAccount(source)) then
				outputChatBox("You must to be logged in to use chat.", source, 255, 0, 0)
				return
			end
			localChat(source, msg)
		end
	end
)


--COMMANDS
addCommandHandler("suicide", function(playerSource)
		killPed(playerSource)
	end
)

addCommandHandler("respawn", function(playerSource, _, posX, posY) --/respawn [x] [y]
		if isPedDead(playerSource) then
			outputChatBox("Can not respawn while you are dead.", playerSource, 255, 0, 0)
			return
		end
		destroyInventory(playerSource)
		spawnPlayerNew(playerSource, posX, posY)
	end
)

--listázza az itemeket és kiírja azok indexeit
addCommandHandler("inv", function(playerSource, _, targetName)
		local target = getPlayerFromPartialName(targetName)
		if targetName then
			if not target then
				outputChatBox("Player "..targetName.."not found.", playerSource, 255, 0, 0)
				return
			end
		else
			target = playerSource
		end
		if not inventories[target] then
			outputChatBox("Player has no inventory yet!", playerSource, 255, 0, 0)
			return
		end
		outputChatBox("Open the console to see the result.", playerSource, 255, 255, 255)
		outputConsole("LIST OF ITEMS OF PLAYER: "..getPlayerName(target), playerSource)
		for i, item in pairs(inventories[target]["items"]) do
			outputConsole("INDEX: "..i.."   ITEM: "..items[item["id"]]["friendlyName"], playerSource)
		end
	end
)

--kiírja a consoleba az inventory táblát olvasható formátumban
addCommandHandler("invfull", function(playerSource, _, targetName)
		local target = getPlayerFromPartialName(targetName)
		if targetName then
			if not target then
				outputChatBox("Player "..targetName.."not found.", playerSource, 255, 0, 0)
				return
			end
		else
			target = playerSource
		end
		if not inventories[target] then
			outputChatBox("Player has no inventory yet!", playerSource, 255, 0, 0)
			return
		end
		outputChatBox("Open the console to see the result.", playerSource, 255, 255, 255)
		outputConsole("INVENTORY OF PLAYER: "..getPlayerName(target), playerSource)
		outputConsole(inspect(inventories[target]), playerSource)
	end
)

--kiírja a consoleba az inventory mátrixát, amiből kivehető, hogy az itemek hol foglalnak helyet az inventoryban
addCommandHandler("invmatrix", function(playerSource, _, targetName)
		local target = getPlayerFromPartialName(targetName)
		if targetName then
			if not target then
				outputChatBox("Player "..targetName.."not found.", playerSource, 255, 0, 0)
				return
			end
		else
			target = playerSource
		end
		if not inventories[target] then
			outputChatBox("Player has no inventory yet!", playerSource, 255, 0, 0)
			return
		end
		outputChatBox("Open the console to see the result.", playerSource, 255, 255, 255)
		outputConsole("INVENTORY MATRIX OF PLAYER: "..getPlayerName(target), playerSource)
		for i, rowArray in pairs(inventoryMatrixes[target]) do
			local row = ""
			for j, value in pairs(rowArray) do
				row = row..zeroPrefix(value, 3).."  "
			end
			outputConsole(row, playerSource)
		end
	end
)

addCommandHandler("takeitem", function(playerSource, commandName, targetName, itemIndex)
		if itemIndex == nil then
			outputChatBox("Wrong syntax! #FFFFFFCorrect syntax is #BBBBBB/"..commandName.." [player] [item_index]", playerSource, 255, 0, 0, true)
			return
		end
		itemIndex = tonumber(itemIndex)
		if not itemIndex then
			outputChatBox("Wrong input! #FFFFFFItem index must be a number!", playerSource, 255, 0, 0, true)
		end
		local target = getPlayerFromPartialName(targetName)
		if not target then
			outputChatBox("Player "..targetName.." not found.", playerSource, 255, 0, 0)
			return
		end
		if not inventories[target] then
			outputChatBox("Player has no inventory yet!", playerSource, 255, 0, 0)
			return
		end
		if removeItemFromInventory(target, itemIndex) then
			outputChatBox("Item was taken from #FFFFFF"..getPlayerName(target).." #BBBBBB[index: "..itemIndex.."]", playerSource, 0, 255, 0, true)
			outputChatBox(getPlayerName(playerSource).." removed an item from your inventory. #BBBBBB[index: "..itemIndex.."]", target, 255, 255, 255, true)
			outputServerLog("[TAKEITEM] "..getPlayerName(playerSource).." removed an item at index "..itemIndex.." from "..getPlayerName(target).."'s inventory.")
		else
			outputChatBox("There is no item in players inventory with index #FFFFFF"..itemIndex, playerSource, 255, 0, 0, true)
		end
	end
)

addCommandHandler("giveitem", function(playerSource, commandName, targetName, itemID)
		if itemID == nil then
			outputChatBox("Wrong syntax! #FFFFFFCorrect syntax is #BBBBBB/"..commandName.." [player] [item_id]", playerSource, 255, 0, 0, true)
			return
		end
		
		if not items[itemID] then
			outputChatBox("Invalid item ID #AAAAAA-> #FFFFFF"..itemID, playerSource, 255, 0, 0, true)
		end
		local target = getPlayerFromPartialName(targetName)
		if not target then
			outputChatBox("Player "..targetName.." not found.", playerSource, 255, 0, 0)
			return
		end
		if not inventories[target] then
			outputChatBox("Player has no inventory yet!", playerSource, 255, 0, 0)
			return
		end
		if addItemToInventory(target, itemID) then
			outputChatBox("Item was given to #FFFFFF"..getPlayerName(target).." #BBBBBB["..items[itemID]["friendlyName"].."]", playerSource, 0, 255, 0, true)
			outputChatBox(getPlayerName(playerSource).." inserted an item to your inventory. #BBBBBB["..items[itemID]["friendlyName"].."]", target, 255, 255, 255, true)
			outputServerLog("[GIVEITEM] "..getPlayerName(playerSource).." added "..itemID.." to "..getPlayerName(target).."'s inventory.")
		else
			outputChatBox("There is not enough space in players inventory!", playerSource, 255, 0, 0)
		end
	end
)

addCommandHandler("setbackpack", function(playerSource, commandName, targetName, itemID)
		if itemID == nil then
			outputChatBox("Wrong syntax! #FFFFFFCorrect syntax is #BBBBBB/"..commandName.." [player] [backpack_item_id]", playerSource, 255, 0, 0, true)
			return
		end
		
		local target = getPlayerFromPartialName(targetName)
		if not target then
			outputChatBox("Player "..targetName.." not found.", playerSource, 255, 0, 0)
			return
		end
		if not inventories[target] then
			outputChatBox("Player has no inventory yet!", playerSource, 255, 0, 0)
			return
		end
		
		if itemID == inventories[target]["equippedBackpack"] then
			outputChatBox("The same type of backpack is already equipped by this player.", playerSource, 255, 0, 0)
			return
		end
		
		if backpackIncreaseSizeY[itemID] then
			if inventoryEquipBackpack(target, itemID) then
				outputChatBox(getPlayerName(target).."#BBBBBB's backpack was set to #0000FF"..itemID.."", playerSource, 255, 255, 255, true)
				outputChatBox(getPlayerName(playerSource).." #BBBBBBset your backpack to #0000FF"..itemID, target, 255, 255, 255, true)
				outputServerLog("[GIVEITEM] "..getPlayerName(target).."'s backpack was set to "..itemID.." by "..getPlayerName(playerSource))
			else
				outputChatBox("There are too many items in player's backpack which has larger capacity.", playerSource, 255, 0, 0)
			end
		else
			outputChatBox("Invalid backpack ID!", playerSource, 255, 0, 0)
		end
	end
)

addCommandHandler("GlobalChat", function(playerSource, _, ...)
		if isGuestAccount(getPlayerAccount(playerSource)) then
			outputChatBox("You must to be logged in to use GlobalChat.", playerSource, 255, 0, 0)
			return
		end
		if isPlayerMuted(playerSource) then
			outputChatBox("You are muted!", playerSource, 255, 0, 0)
			return
		end
		local msg = table.concat({...}, " ")
		outputChatBox("#FF5733[GLOBAL] #FEFFB5"..getPlayerName(playerSource)..": #FFFFFF"..msg, root, 255, 255, 255, true)
	end
)



