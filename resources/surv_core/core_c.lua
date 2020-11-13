
setDevelopmentMode(true)

x, y = guiGetScreenSize()

fontScaleMultiplier = x/1920
font32_28_days_later = dxCreateFont("fonts/28_days_later.ttf", 32 * fontScaleMultiplier)
font32_keepcalm = dxCreateFont("fonts/keepcalm.ttf", 32 * fontScaleMultiplier)


setBlurLevel(6)

setAmbientSoundEnabled("gunfire", false)

setWorldSoundEnabled(20, false) --speech 0
setWorldSoundEnabled(21, false) --speech 1
setWorldSoundEnabled(22, false) --speech 2
setWorldSoundEnabled(23, false) --speech 3
setWorldSoundEnabled(24, false) --speech 4

setTrafficLightsLocked(true)
setTrafficLightState(9)

toggleControl("action", false) --prevents attack while opening the inventory
guiSetInputMode("no_binds_when_editing")
setPlayerHudComponentVisible("all", false)

--USEFUL FUNCTIONS
function table.copy(tab, recursive)
    local ret = {}
    for key, value in pairs(tab) do
        if (type(value) == "table") and recursive then ret[key] = table.copy(value)
        else ret[key] = value end
    end
    return ret
end

function math.round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function zeroPrefix(value, size)
	value = tostring(value)
	for i=1, size-#value do
		value = "0"..value
	end
	return value
end

function zeroFill(num)
	if tonumber(num) > 9 then
		return num
	end
	return "0"..num
end

--WASTED/RESPAWN handlers
local wastedBlurBox, wastedMsg, wastedRespawnLabel, deathSelfSound, newSpawnMsgDelayTimer

function respawnKeyHandler()
	unbindKey("space", "down", respawnKeyHandler)
	removeEventHandler("onClientRender", root, drawWastedMsg)
	triggerServerEvent("onPlayerClaimRespawn", root)
	exports.blur_box:destroyBlurBox(wastedBlurBox)
	showChat(true)
	if getSoundPosition(deathSelfSound) ~= getSoundLength(deathSelfSound) then
		stopSound(deathSelfSound)
	end
	wastedMsg = nil
	wastedRespawnLabel = nil
	setTimer(function() --késleltetés BUG miatt
		setCameraShakeLevel(0)
		end, 1000, 1
	)
end


function drawWastedMsg()
	dxDrawText(wastedMsg, 0, 0, x, y/2, nil, 3, "pricedown", "center", "center", false, true, true)
	dxDrawText(wastedRespawnLabel, 0, y/2, x, y, nil, 1, font32_28_days_later, "center", "center", false, true, true)
end


addEventHandler("onClientPlayerWasted", localPlayer, function(killer, weapon)
		setCameraShakeLevel(25)
		exports.blur_box:setBlurIntensity(3.5)
		wastedBlurBox = exports.blur_box:createBlurBox(0, 0, x, y, 255, 50, 50, 255, false)
		showChat(false)
		deathSelfSound = playSound("sounds/death_self.mp3")
		if not killer then
			wastedMsg = "You died"
		elseif killer == localPlayer then
			wastedMsg = "You killed yourself"
		elseif getElementType(killer) == "player" then
			wastedMsg = getPlayerName(killer).." killed you with "..getWeaponNameFromID(weapon)
		elseif getElementType(killer) == "vehicle" then
			local tempPlayerName = getVehicleController(killer)
			if not tempPlayerName then
				tempPlayerName = "someone"
			else
				tempPlayerName = getPlayerName(tempPlayerName)
			end
			wastedMsg = tempPlayerName.." hit you by "..getVehicleName(killer)
		end
		wastedRespawnLabel = 5
		addEventHandler("onClientRender", root, drawWastedMsg)
		setTimer(function()
				wastedRespawnLabel = wastedRespawnLabel-1
			end, 1000, 4
		)
		setTimer(function()
				bindKey("space", "down", respawnKeyHandler)
				wastedRespawnLabel = "press SPACE to respawn"
			end, 5050, 1
		)
		if isTimer(newSpawnMsgDelayTimer) then
			killTimer(newSpawnMsgDelayTimer)
		end
	end
)


addEvent("onClientForcedNewSpawn", true)
addEventHandler("onClientForcedNewSpawn", resourceRoot, function()
		newSpawnMsgDelayTimer = setTimer(function()
				outputChatBox("You were alive for 2 minutes. #00FF00Now your status will be saved on disconnect.", 255, 255, 255, true)
			end, 120000, 1
		)
	end
)

--lekéri a szerverről az items tömböt és elmenti egy globális változóba, így kliens oldalon is elérhető lesz
addEvent("onResponsePreDefinedVariables", true)
addEventHandler("onResponsePreDefinedVariables", resourceRoot, function(response_items, response_backpackIncreaseSizeY, response_inventorySizeX, response_inventorySizeY)
		items = response_items
		backpackIncreaseSizeY = response_backpackIncreaseSizeY
		inventorySizeX = response_inventorySizeX
		inventorySizeY = response_inventorySizeY
		
		prepareDrawVariables()
	end
)
triggerServerEvent("requestPreDefinedVariables", resourceRoot)

--INVENTORY SYSTEM [client side]
local localInventory, localInventoryMatrix, localInventoryImageMatrix

function updateInventoryMatrix(theInv, theInvMatrix, itemIndex, updateTo)
	for yIndex=theInv["items"][itemIndex]["posY"], theInv["items"][itemIndex]["posY"] + items[theInv["items"][itemIndex]["id"]]["sizeY"] - 1, 1 do
		for xIndex=theInv["items"][itemIndex]["posX"], theInv["items"][itemIndex]["posX"] + items[theInv["items"][itemIndex]["id"]]["sizeX"] - 1, 1 do
			theInvMatrix[yIndex][xIndex] = updateTo
		end
	end
end

function calculateInventoryImageMatrix(theInv, theInvMatrix)
	local tempArray = {}
	
	--empty matrix
	for matY=1, #theInvMatrix do
		tempArray[matY] = {}
	end
	
	for itemIndex, itemArray in pairs(theInv["items"]) do
		local v=0
		for matY=itemArray["posY"], itemArray["posY"]+items[itemArray["id"]]["sizeY"]-1 do
			local u=0
			for matX=itemArray["posX"], itemArray["posX"]+items[itemArray["id"]]["sizeX"]-1 do
				local relativeSize = math.round((64/draw.invUnitSize)*draw.invUnitSize)
				tempArray[matY][matX] ={id = itemArray["id"],
										u = relativeSize*u,
										v = relativeSize*v,
										uSize = relativeSize,
										vSize = relativeSize,
										itemTopLeftX = matX - u,
										itemTopLeftY = matY - v
									}
				u = u +1
			end
			v = v +1
		end
	end
	
	return tempArray
end

addEvent("onClientInventoryCreated", true)
-- EVENT: onClientInventoryCreated
-- source: the element that owns the inventory
-- parameter 1: the created inventory array
-- parameter 1: the created inventory matrix
addEventHandler("onClientInventoryCreated", localPlayer, function(inv, invMatrix)
		localInventory = inv
		localInventoryMatrix = invMatrix
		localInventoryImageMatrix = calculateInventoryImageMatrix(localInventory, localInventoryMatrix)
	end
)

addEvent("onClientInventoryDestroyed", true)
-- EVENT: onClientInventoryDestroyed
-- source: the element that owned the inventory
addEventHandler("onClientInventoryDestroyed", localPlayer, function()
		localInventory = nil
		localInventoryMatrix = nil
		localInventoryImageMatrix = nil
	end
)

addEvent("onClientItemAddedToInventory", true)
-- EVENT: onClientItemAddedToInventory
-- source: the element that owns the inventory
-- parameter 1: item's array containing datas (pos, id, etc.) that was added
-- parameter 2: index at which the item was inserted
addEventHandler("onClientItemAddedToInventory", localPlayer, function(item, insertIndex)
		localInventory["items"][insertIndex] = item
		updateInventoryMatrix(localInventory, localInventoryMatrix, insertIndex, insertIndex)
		localInventoryImageMatrix = calculateInventoryImageMatrix(localInventory, localInventoryMatrix)
	end
)

addEvent("onClientItemRemovedFromInventory", true)
-- EVENT: onClientItemRemovedFromInventory
-- source: the element that owns the inventory
-- parameter 1: item's ID that was removed
-- parameter 2: index at which the item was removed
addEventHandler("onClientItemRemovedFromInventory", localPlayer, function(itemID, removeIndex)		
		updateInventoryMatrix(localInventory, localInventoryMatrix, removeIndex, 0)
		localInventory["items"][removeIndex] = nil
		localInventoryImageMatrix = calculateInventoryImageMatrix(localInventory, localInventoryMatrix)
	end
)

addEvent("onClientBackpackChanged", true)
-- EVENT: onClientBackpackChanged
-- source: the element that owns the inventory
-- parameter 1: new inventory
-- parameter 2: new inventory matrix
addEventHandler("onClientBackpackChanged", localPlayer, function(newInv, newInvMatrix)
		if isInvOpened then
			closeInventory()
		end
		localInventory = newInv
		localInventoryMatrix = newInvMatrix
		outputChatBox("Your inventory's backpack was changed!", 240, 240, 240)
		localInventoryImageMatrix = calculateInventoryImageMatrix(localInventory, localInventoryMatrix)
	end
)

function prepareDrawVariables()
	draw = {
		localInvStartX = x*0.6,
		invWidth = x*0.4,
		invGap = x*0.01,
		invGapDouble = (x*0.01)*2,
		invColor = tocolor(0, 0, 0, 100),
		invUnitSize = (x*0.4-(x*0.01)*2)/inventorySizeX,
		invUnitColor = tocolor(192, 192, 192, 40),
		invUnitDarkColor = tocolor(0, 0, 0, 50),
		invUnitDarkerColor = tocolor(0, 0, 0, 100),
		lineColor = tocolor(0, 0, 0, 225),
		invHeaderHeight = (x*0.4)/inventorySizeX*4,
		invHeaderWidth = x*0.4-(x*0.01)*2,
		invBodyHeight = y-(x*0.4)/inventorySizeX*4-(x*0.4-(x*0.01)*2)/inventorySizeX,
		localInvBodyStartX = x*0.6+x*0.01,
		localInvBodyEndX = x-x*0.01,
		remoteInvBodyEndX = x*0.4-x*0.01,
		invBodyWidth = x*0.4-(x*0.01)*2,
		localBodyScrollbarStartX = x-x*0.01*0.8,
		remoteBodyScrollbarStartX = x*0.01*0.2,
		invBodyScrollbarWidth = x*0.01*0.6,
		invMaxDrawRows = math.ceil((y-(x*0.4)/inventorySizeX*4-(x*0.4-(x*0.01)*2)/inventorySizeX) / ((x*0.4-(x*0.01)*2)/inventorySizeX)),
		invDividerLineWidth = math.ceil((x*0.4-(x*0.01)*2)/inventorySizeX*0.12),
		invLocalTotalNumRows = 0, --minden nyitás előtt kap majd értéket
		invRemoteTotalNumRows = 0, --minden nyitás előtt kap majd értéket
		localScrollBlockHeight = 0, --minden nyitás előtt kap majd értéket
		remoteScrollBlockHeight = 0, --minden nyitás előtt kap majd értéket
		localScrollValue = 0, --nyitáskor és görgetéskor változik az értéke
		remoteScrollValue = 0, --nyitáskor és görgetéskor változik az értéke
		localScrollBlockStartY = 0, --nyitáskor és görgetéskor változik az értéke
		remoteScrollBlockStartY = 0, --nyitáskor és görgetéskor változik az értéke
		invLocalDividerLineY = 0, --nyitáskor és görgetéskor változik az értéke
		invRemoteDividerLineY = 0, --nyitáskor és görgetéskor változik az értéke
		invEquipBlocks = {
							{blockLabel="Primary", 		invKey="equippedPrimary"},
							{blockLabel="Secondary", 	invKey="equippedSecondary"},
							{blockLabel="Melee", 		invKey="equippedMelee"},
							{blockLabel="Throwable", 	invKey="equippedThrowable"},
							{blockLabel="Clothes", 		invKey="usedClothes"},
							{blockLabel="Backpack", 	invKey="equippedBackpack"}
						},
		invEquipBlockWidth = (x*0.4-(x*0.01)*2)/6, --elosztva az equip elemek számával
		invEquipBlockColor = tocolor(20, 20, 20, 80),
		invEquipBlockLabelColor = tocolor(150, 150, 150, 150),
		invEquipBlockItemColor = tocolor(220, 220, 220, 150)
	}
	
	itemTextures = {} --Az item képekből textúrákat készít, ezzel is optimalizálva az inventory renderelését
	for itemID, _ in pairs(items) do
		itemTextures[itemID] = dxCreateTexture("images/items/"..itemID..".png")
	end
	
	outputConsole("Draw parameters")
	for key, value in pairs(draw) do
		if type(value) == "number" then
			value = math.round(value)
			outputConsole(key..": "..value)
		end
	end
end


function dxDrawInventory()
	--DRAW LOCAL INVENTORY
	--background
	dxDrawRectangle(draw.localInvStartX, 0, draw.invWidth, y, draw.invColor, true)
	--scrollbar
	if draw.invLocalTotalNumRows > draw.invMaxDrawRows then
		dxDrawRectangle(draw.localBodyScrollbarStartX, draw.invHeaderHeight, draw.invBodyScrollbarWidth, draw.invBodyHeight, draw.invColor, true)
		dxDrawRectangle(draw.localBodyScrollbarStartX, draw.localScrollBlockStartY, draw.invBodyScrollbarWidth, draw.localScrollBlockHeight, draw.lineColor, true)
	end
	--equip blocks
	for i, block in pairs(draw.invEquipBlocks) do
		dxDrawRectangle(draw.localInvBodyStartX+(i-1)*draw.invEquipBlockWidth, draw.invGap, draw.invEquipBlockWidth, draw.invHeaderHeight-draw.invGapDouble, draw.invEquipBlockColor, true)
		dxDrawText(block["blockLabel"], draw.localInvBodyStartX+(i-1)*draw.invEquipBlockWidth, draw.invGap, draw.localInvBodyStartX+draw.invEquipBlockWidth*i, draw.invHeaderHeight/2, draw.invEquipBlockLabelColor, 0.45, font32_keepcalm, "center", "center", true, true, true)
		local tempTxt
		if items[localInventory[block["invKey"]]] then
			tempTxt = items[localInventory[block["invKey"]]]["friendlyName"]
		else
			tempTxt = "empty"
		end
		dxDrawText(tempTxt, draw.localInvBodyStartX+(i-1)*draw.invEquipBlockWidth, draw.invHeaderHeight/2, draw.localInvBodyStartX+draw.invEquipBlockWidth*i, draw.invHeaderHeight-draw.invGap, draw.invEquipBlockItemColor, 0.4, font32_keepcalm, "center", "center", true, true, true)
	end
	--equip block lines
	for i=1, 5 do
		dxDrawLine(draw.localInvBodyStartX+i*draw.invEquipBlockWidth, draw.invGap, draw.localInvBodyStartX+i*draw.invEquipBlockWidth, draw.invHeaderHeight-draw.invGap, draw.lineColor, 1, true)
	end
	--item grid
	for unitY=1, draw.invLocalTotalNumRows - draw.localScrollValue do
		if unitY > draw.invMaxDrawRows then
			break
		end
		for unitX=1, inventorySizeX do	
			if localInventoryImageMatrix[unitY + draw.localScrollValue][unitX] then
				if localInventoryMatrix[unitY][unitX] ~= invHoldTargetIndex then --alapértelmezett
					dxDrawRectangle(draw.localInvBodyStartX+(unitX-1)*draw.invUnitSize+1, draw.invHeaderHeight+(unitY-1)*draw.invUnitSize+1, draw.invUnitSize-2, draw.invUnitSize-2, draw.invUnitDarkerColor, true)
					dxDrawImageSection(draw.localInvBodyStartX+(unitX-1)*draw.invUnitSize,
						draw.invHeaderHeight+(unitY-1)*draw.invUnitSize,
						draw.invUnitSize,
						draw.invUnitSize,
						localInventoryImageMatrix[unitY + draw.localScrollValue][unitX]["u"],
						localInventoryImageMatrix[unitY + draw.localScrollValue][unitX]["v"],
						localInventoryImageMatrix[unitY + draw.localScrollValue][unitX]["uSize"],
						localInventoryImageMatrix[unitY + draw.localScrollValue][unitX]["vSize"],
						itemTextures[localInventoryImageMatrix[unitY + draw.localScrollValue][unitX]["id"]],
						0, 0, 0, nil, true
					)
				else --ha épp az adott itemet mozgatja a felhasználó
					dxDrawRectangle(draw.localInvBodyStartX+(unitX-1)*draw.invUnitSize+1, draw.invHeaderHeight+(unitY-1)*draw.invUnitSize+1, draw.invUnitSize-2, draw.invUnitSize-2, draw.invUnitDarkColor, true)
					dxDrawImageSection(draw.localInvBodyStartX+(unitX-1)*draw.invUnitSize,
						draw.invHeaderHeight+(unitY-1)*draw.invUnitSize,
						draw.invUnitSize,
						draw.invUnitSize,
						localInventoryImageMatrix[unitY + draw.localScrollValue][unitX]["u"],
						localInventoryImageMatrix[unitY + draw.localScrollValue][unitX]["v"],
						localInventoryImageMatrix[unitY + draw.localScrollValue][unitX]["uSize"],
						localInventoryImageMatrix[unitY + draw.localScrollValue][unitX]["vSize"],
						itemTextures[localInventoryImageMatrix[unitY + draw.localScrollValue][unitX]["id"]],
						0, 0, 0, tocolor(255, 255, 255, 128), true
					)
				end
			else
				dxDrawRectangle(draw.localInvBodyStartX+(unitX-1)*draw.invUnitSize+1, draw.invHeaderHeight+(unitY-1)*draw.invUnitSize+1, draw.invUnitSize-2, draw.invUnitSize-2, draw.invUnitColor, true)
			end
		end
	end
	--currently moving item
	if invHoldTargetIndex then
		local cursorX, cursorY = getCursorPosition()
		local currentTarget = getInventoryTargetFromScreenPos(cursorX*x, cursorY*y)
		--DRAW MOVING ITEM
	end
	--divider line
	if draw.invLocalTotalNumRows > inventorySizeY and draw.localScrollValue <= inventorySizeY and draw.localScrollValue + draw.invMaxDrawRows >= inventorySizeY then
		dxDrawLine(draw.localInvBodyStartX, draw.invLocalDividerLineY, draw.localInvBodyEndX, draw.invLocalDividerLineY, draw.lineColor, draw.invDividerLineWidth, true)
	end
	
	--DRAW REMOTE INVENTORY (if set)
	if remoteInventory then
		--background
		dxDrawRectangle(0, 0, draw.invWidth, y, draw.invColor, true)
		--scrollbar
		if draw.invRemoteTotalNumRows > draw.invMaxDrawRows then
			dxDrawRectangle(draw.remoteBodyScrollbarStartX, draw.invHeaderHeight, draw.invBodyScrollbarWidth, draw.invBodyHeight, draw.invColor, true)
			dxDrawRectangle(draw.remoteBodyScrollbarStartX, draw.remoteScrollBlockStartY, draw.invBodyScrollbarWidth, draw.remoteScrollBlockHeight, draw.lineColor, true)
		end
		--equip blocks
		for i, block in pairs(draw.invEquipBlocks) do
			dxDrawRectangle(draw.invGap+(i-1)*draw.invEquipBlockWidth, draw.invGap, draw.invEquipBlockWidth, draw.invHeaderHeight-draw.invGapDouble, draw.invEquipBlockColor, true)
			dxDrawText(block["blockLabel"], draw.invGap+(i-1)*draw.invEquipBlockWidth, draw.invGap, draw.invGap+draw.invEquipBlockWidth*i, draw.invHeaderHeight/2, draw.invEquipBlockLabelColor, 0.45, font32_keepcalm, "center", "center", true, true, true)
			local tempTxt
			if items[localInventory[block["invKey"]]] then
				tempTxt = items[localInventory[block["invKey"]]]["friendlyName"]
			else
				tempTxt = "empty"
			end
			dxDrawText(tempTxt, draw.invGap+(i-1)*draw.invEquipBlockWidth, draw.invHeaderHeight/2, draw.invGap+draw.invEquipBlockWidth*i, draw.invHeaderHeight-draw.invGap, draw.invEquipBlockItemColor, 0.4, font32_keepcalm, "center", "center", true, true, true)
		end
		--equip block lines
		for i=1, 5 do
			dxDrawLine(draw.invGap+i*draw.invEquipBlockWidth, draw.invGap, draw.invGap+i*draw.invEquipBlockWidth, draw.invHeaderHeight-draw.invGap, draw.lineColor, 1, true)
		end
		--item grid
		for unitY=1, draw.invRemoteTotalNumRows - draw.remoteScrollValue do
			if unitY > draw.invMaxDrawRows then
				break
			end
			for unitX=1, inventorySizeX do	
				if remoteInventoryImageMatrix[unitY + draw.remoteScrollValue][unitX] then
					dxDrawRectangle(draw.invGap+(unitX-1)*draw.invUnitSize+1, draw.invHeaderHeight+(unitY-1)*draw.invUnitSize+1, draw.invUnitSize-2, draw.invUnitSize-2, draw.invUnitDarkerColor, true)
					dxDrawImageSection(draw.invGap+(unitX-1)*draw.invUnitSize,
						draw.invHeaderHeight+(unitY-1)*draw.invUnitSize,
						draw.invUnitSize,
						draw.invUnitSize,
						remoteInventoryImageMatrix[unitY + draw.remoteScrollValue][unitX]["u"],
						remoteInventoryImageMatrix[unitY + draw.remoteScrollValue][unitX]["v"],
						remoteInventoryImageMatrix[unitY + draw.remoteScrollValue][unitX]["uSize"],
						remoteInventoryImageMatrix[unitY + draw.remoteScrollValue][unitX]["vSize"],
						itemTextures[remoteInventoryImageMatrix[unitY + draw.remoteScrollValue][unitX]["id"]],
						0, 0, 0, nil, true
					)
				else
					dxDrawRectangle(draw.invGap+(unitX-1)*draw.invUnitSize+1, draw.invHeaderHeight+(unitY-1)*draw.invUnitSize+1, draw.invUnitSize-2, draw.invUnitSize-2, draw.invUnitColor, true)
				end
			end
		end
		--divider line
		if draw.invRemoteTotalNumRows > inventorySizeY and draw.remoteScrollValue <= inventorySizeY and draw.remoteScrollValue + draw.invMaxDrawRows >= inventorySizeY then
			dxDrawLine(draw.invGap, draw.invRemoteDividerLineY, draw.remoteInvBodyEndX, draw.invRemoteDividerLineY, draw.lineColor, draw.invDividerLineWidth, true)
		end
	end
end

isInvOpened = false
isInvOpenEnabled = true

function openInventory()
	isInvOpened = true
	showChat(false)
	showCursor(true)
	exports.blur_box:setBlurIntensity(2.5)
	invBlurBox = exports.blur_box:createBlurBox(0, 0, x, y, 200, 200, 200, 255, true)
	exports.blur_box:setScreenResolutionMultiplier(invBlurBox, 0.1, 0.1)
	setCursorPosition(x/2, y/2)
	
	localInvGradient = guiCreateStaticImage(x*0.5, 0, x*0.1, y, "images/ui/inv_gradient_local.png", false)
	draw.invLocalTotalNumRows = inventorySizeY + backpackIncreaseSizeY[localInventory["equippedBackpack"]]
	draw.localScrollBlockHeight = draw.invBodyHeight * (draw.invMaxDrawRows / draw.invLocalTotalNumRows)
	draw.localScrollBlockStartY = draw.invHeaderHeight
	draw.localScrollValue = 0
	draw.invLocalDividerLineY = draw.invHeaderHeight + (inventorySizeY - draw.localScrollValue) * draw.invUnitSize -2
	
	if remoteInventory then
		remoteInvGradient = guiCreateStaticImage(x*0.4, 0, x*0.1, y, "images/ui/inv_gradient_remote.png", false)
		draw.invRemoteTotalNumRows = inventorySizeY + backpackIncreaseSizeY[remoteInventory["equippedBackpack"]]
		draw.remoteScrollBlockHeight = draw.invBodyHeight * (draw.invMaxDrawRows / draw.invRemoteTotalNumRows)
		draw.remoteScrollBlockStartY = draw.invHeaderHeight
		draw.remoteScrollValue = 0
		draw.invRemoteDividerLineY = draw.invHeaderHeight + (inventorySizeY - draw.remoteScrollValue) * draw.invUnitSize -2
	end
	
	addEventHandler("onClientRender", root, dxDrawInventory)
	if draw.invLocalTotalNumRows > draw.invMaxDrawRows or (remoteInventory and draw.invRemoteTotalNumRows > draw.invMaxDrawRows) then
		bindKey("mouse_wheel_up", "both", invScrollUp)
		bindKey("mouse_wheel_down", "both", invScrollDown)
	end
	bindKey("mouse1", "down", invMouseHoldHandler)
	bindKey("mouse1", "up", invMouseReleaseHandler)
	invOpenSound = playSound("sounds/inv_open.mp3")
end

function closeInventory()
	showChat(true)
	showCursor(false)
	exports.blur_box:destroyBlurBox(invBlurBox)
	destroyElement(localInvGradient)
	if isElement(remoteInvGradient) then
		destroyElement(remoteInvGradient)
	end
	removeEventHandler("onClientRender", root, dxDrawInventory)
	if draw.invLocalTotalNumRows > draw.invMaxDrawRows or (remoteInventory and draw.invRemoteTotalNumRows > draw.invMaxDrawRows) then
		unbindKey("mouse_wheel_up", "both", invScrollUp)
		unbindKey("mouse_wheel_down", "both", invScrollDown)
		localScrollBlockStartY = draw.invHeaderHeight
	end
	unbindKey("mouse1", "down", invMouseHoldHandler)
	unbindKey("mouse1", "up", invMouseReleaseHandler)
	if invOpenSound and getSoundPosition(invOpenSound) ~= getSoundLength(invOpenSound) then
		stopSound(invOpenSound)
	end
	playSound("sounds/inv_close.mp3")
	setTimer(function()
			isInvOpenEnabled = true
		end, 750, 1
	)
	isInvOpened = false
end

function invScrollUp()
	local cursorX = getCursorPosition()*x
	if not remoteInventory or cursorX >= x/2 then --local scroll
		if draw.localScrollValue == 0 or draw.invLocalTotalNumRows <= draw.invMaxDrawRows then
			return
		end
		draw.localScrollValue = draw.localScrollValue - 1
		draw.localScrollBlockStartY = draw.invHeaderHeight + draw.localScrollValue * ((draw.invBodyHeight) / draw.invLocalTotalNumRows)
		draw.invLocalDividerLineY = draw.invHeaderHeight + (inventorySizeY - draw.localScrollValue) * draw.invUnitSize -2
	else --remote scroll
		if draw.remoteScrollValue == 0 or draw.invRemoteTotalNumRows <= draw.invMaxDrawRows then
			return
		end
		draw.remoteScrollValue = draw.remoteScrollValue - 1
		draw.remoteScrollBlockStartY = draw.invHeaderHeight + draw.remoteScrollValue * ((draw.invBodyHeight) / draw.invRemoteTotalNumRows)
		draw.invRemoteDividerLineY = draw.invHeaderHeight + (inventorySizeY - draw.remoteScrollValue) * draw.invUnitSize -2
	end
end

function invScrollDown()
	local cursorX = getCursorPosition()*x
	if not remoteInventory or cursorX >= x/2 then --local scroll
		if draw.localScrollValue == draw.invLocalTotalNumRows - draw.invMaxDrawRows or draw.invLocalTotalNumRows <= draw.invMaxDrawRows then
			return
		end
		draw.localScrollValue = draw.localScrollValue + 1
		draw.localScrollBlockStartY = draw.invHeaderHeight + draw.localScrollValue * ((draw.invBodyHeight) / draw.invLocalTotalNumRows)
		draw.invLocalDividerLineY = draw.invHeaderHeight + (inventorySizeY - draw.localScrollValue) * draw.invUnitSize -2
	else --remote scroll
		if draw.remoteScrollValue == draw.invRemoteTotalNumRows - draw.invMaxDrawRows or draw.invRemoteTotalNumRows <= draw.invMaxDrawRows then
			return
		end
		draw.remoteScrollValue = draw.remoteScrollValue + 1
		draw.remoteScrollBlockStartY = draw.invHeaderHeight + draw.remoteScrollValue * ((draw.invBodyHeight) / draw.invRemoteTotalNumRows)
		draw.invRemoteDividerLineY = draw.invHeaderHeight + (inventorySizeY - draw.remoteScrollValue) * draw.invUnitSize -2
	end
end

function invMouseHoldHandler()
	local cursorX, cursorY = getCursorPosition()
	invHoldTarget = getInventoryTargetFromScreenPos(cursorX*x, cursorY*y)
	outputConsole(inspect(invHoldTarget))
	if invHoldTarget["area"] == "local" then --LOCAL
		if invHoldTarget["target_type"] == "matrix_pos" then
			if localInventoryMatrix[invHoldTarget["matY"]][invHoldTarget["matX"]] == 0 then
				return --nincs mit mozgatni
			end
			playSoundFrontEnd(40)
			invHoldTargetIndex = localInventoryMatrix[invHoldTarget["matY"]][invHoldTarget["matX"]]
		elseif invHoldTarget["target_type"] == "equip_slot" then
			
		end
	elseif invHoldTarget["area"] == "remote" then --REMOTE
		if invHoldTarget["target_type"] == "matrix_pos" then
			invHoldTargetIndex = localInventoryMatrix[invHoldTarget["matY"]][invHoldTarget["matX"]]
		elseif invHoldTarget["target_type"] == "equip_slot" then
			
		end
	elseif invHoldTarget["area"] == "drop" then --DROP
		
	end
end

function invMouseReleaseHandler()
	local cursorX, cursorY = getCursorPosition()
	local invReleaseTarget = getInventoryTargetFromScreenPos(cursorX*x, cursorY*y)
	outputConsole(inspect(invReleaseTarget))
	if invReleaseTarget["area"] == "local" then --LOCAL
		if invReleaseTarget["target_type"] == "matrix_pos" then
			
		elseif invReleaseTarget["target_type"] == "equip_slot" then
			
		end
	elseif invReleaseTarget["area"] == "remote" then --REMOTE
		if invReleaseTarget["target_type"] == "matrix_pos" then
			
		elseif invReleaseTarget["target_type"] == "equip_slot" then
			
		end
	elseif invReleaseTarget["area"] == "drop" then --DROP
		
	end
	invHoldTarget = nil
	invHoldTargetIndex = nil
end

--viszza ad egy tömböt ami tartalmazza az inventory target paramétereit, ha az adott screenX és screenY koordinátákon nincs target, akkor nil értéket ad viszza
function getInventoryTargetFromScreenPos(screenX, screenY)
	local targetArray = {}	
	--LOCAL INV SIDE
	if screenX >= draw.localInvBodyStartX and screenX <= draw.localInvBodyStartX + draw.invBodyWidth then
		targetArray["area"] = "local"
		local tempNumRows
		if draw.invLocalTotalNumRows > draw.invMaxDrawRows then
			tempNumRows = draw.invMaxDrawRows
		else
			tempNumRows = draw.invLocalTotalNumRows
		end
		if screenY >= draw.invHeaderHeight and screenY <= draw.invHeaderHeight + draw.invUnitSize*tempNumRows then --ITEM GRID
			targetArray["target_type"] = "matrix_pos"
			targetArray["matX"] = math.ceil((screenX - draw.localInvBodyStartX) / draw.invUnitSize)
			targetArray["matY"] = math.ceil((screenY - draw.invHeaderHeight) / draw.invUnitSize) + draw.localScrollValue
		elseif screenY >= draw.invGap and screenY <= draw.invHeaderHeight - draw.invGap then --EQUIP BLOCKS
			targetArray["target_type"] = "equip_slot"
			targetArray["slot_name"] = draw.invEquipBlocks[math.ceil((screenX - draw.localInvBodyStartX) / draw.invEquipBlockWidth)]["invKey"]
		else
			return
		end
	--REMOTE INV SIDE
	elseif remoteInventory and screenX <= draw.remoteInvBodyEndX then
		targetArray["area"] = "remote"
		local tempNumRows
		if draw.invRemoteTotalNumRows > draw.invMaxDrawRows then
			tempNumRows = draw.invMaxDrawRows
		else
			tempNumRows = draw.invRemoteTotalNumRows
		end
		if screenY >= draw.invHeaderHeight and screenY <= draw.invHeaderHeight + draw.invUnitSize*tempNumRows then --ITEM GRID
			targetArray["target_type"] = "matrix_pos"
			targetArray["matX"] = math.ceil((screenX - draw.invGap) / draw.invUnitSize)
			targetArray["matY"] = math.ceil((screenY - draw.invHeaderHeight) / draw.invUnitSize) + draw.remoteScrollValue
		elseif screenY >= draw.invGap and screenY <= draw.invHeaderHeight - draw.invGap then --EQUIP BLOCKS
			targetArray["target_type"] = "equip_slot"
			targetArray["slot_name"] = draw.invEquipBlocks[math.ceil((screenX - draw.invGap) / draw.invEquipBlockWidth)]["invKey"]
		else
			return
		end
	--DROP AREA
	elseif (screenX > draw.remoteInvBodyEndX or not remoteInventory) and screenX < draw.localInvBodyStartX then
		outputChatBox("DROP AREA")
		targetArray["area"] = "drop"
	else
		return
	end
	return targetArray
end

--REMOTE INVENTORY
--mindig csak 1 remoteInventory lehet! (az inventory-t megnyitva az jelenik meg a bal oldalon)
--a szerver által küldött inventory és annak mátrixa a 'remoteInventory' és 'remoteInventoryMatrix' globális változókban van tárolva
--destroyRemoteInventory függvény törli a változók értékeit és törli az eseménykezelőket
--a 'remoteInventoryOwner' változó már a szerver felé küldött request előtt értéket kap, mivel a válasz késik és ezzel kiküszöbölhető a többszörös request (pl. újabb marker-be ütközés esetén)
addEvent("onResponseRemoteInventory", true)
addEventHandler("onResponseRemoteInventory", resourceRoot, function(inv, invMatrix)		
		if remoteInventoryOwner == source then
			remoteInventory = inv
			remoteInventoryMatrix = invMatrix
			remoteInventoryImageMatrix = calculateInventoryImageMatrix(inv, invMatrix)
			
			addEventHandler("onClientInventoryDestroyed", source, remoteInventoryDestroyed)
			addEventHandler("onClientBackpackChanged", source, remoteInventoryBackpackChanged)
			addEventHandler("onClientItemAddedToInventory", source, remoteInventoryItemAdded)
			addEventHandler("onClientItemRemovedFromInventory", source, remoteInventoryItemRemoved)
			
			if isInvOpened then --ha már meg volt nyitva az inventory (pl. megnyitotta és utánna ment közel egy remoteInvel rendelkező elem markeréhez
				remoteInvGradient = guiCreateStaticImage(x*0.4, 0, x*0.1, y, "images/ui/inv_gradient_remote.png", false)
				draw.invRemoteTotalNumRows = inventorySizeY + backpackIncreaseSizeY[remoteInventory["equippedBackpack"]]
				draw.remoteScrollBlockHeight = draw.invBodyHeight * (draw.invMaxDrawRows / draw.invRemoteTotalNumRows)
				draw.remoteScrollBlockStartY = draw.invHeaderHeight
				draw.remoteScrollValue = 0
				draw.invRemoteDividerLineY = draw.invHeaderHeight + (inventorySizeY - draw.remoteScrollValue) * draw.invUnitSize -2
			end
		end
	end
)

function requestRemoteInventory(invOwner)
	remoteInventoryOwner = invOwner
	triggerServerEvent("requestRemoteInventory", invOwner)
end

function destroyRemoteInventory()
	if remoteInventory then
		removeEventHandler("onClientInventoryDestroyed", remoteInventoryOwner, remoteInventoryDestroyed)
		removeEventHandler("onClientBackpackChanged", remoteInventoryOwner, remoteInventoryBackpackChanged)
		removeEventHandler("onClientItemAddedToInventory", remoteInventoryOwner, remoteInventoryItemAdded)
		removeEventHandler("onClientItemRemovedFromInventory", remoteInventoryOwner, remoteInventoryItemRemoved)
		remoteInventory = nil
		remoteInventoryMatrix = nil
		if isInvOpened then
			destroyElement(remoteInvGradient)
		end
	end
	remoteInventoryOwner = nil
end

function remoteInventoryDestroyed() --event handler
	destroyRemoteInventory()
end

function remoteInventoryBackpackChanged(newInv, newInvMatrix) --event handler
	if isInvOpened then
		closeInventory()
	end
	remoteInventory = newInv
	remoteInventoryMatrix = newInvMatrix
	outputChatBox("Remote inventory's backpack was changed!", 240, 240, 240)
	remoteInventoryImageMatrix = calculateInventoryImageMatrix(remoteInventory, remoteInventoryMatrix)
end

function remoteInventoryItemAdded(item, insertIndex) --event handler
	remoteInventory["items"][insertIndex] = item
	updateInventoryMatrix(remoteInventory, remoteInventoryMatrix, insertIndex, insertIndex)
	remoteInventoryImageMatrix = calculateInventoryImageMatrix(remoteInventory, remoteInventoryMatrix)
end

function remoteInventoryItemRemoved() --event handler
	updateInventoryMatrix(remoteInventory, localInventoryMatrix, removeIndex, 0)
	remoteInventory["items"][removeIndex] = nil
	remoteInventoryImageMatrix = calculateInventoryImageMatrix(remoteInventory, remoteInventoryMatrix)
end


--MARKER HIT HANDLER
addEventHandler("onClientMarkerHit", root, function(player, matchingDimension)
		if player == localPlayer and matchingDimension then
			--NO VEHICLE
			if not isPedInVehicle(localPlayer) then
				--LOOT HANDLER (ENTER LOOTABLE AREA)
				if getElementData(source, "surv_loot_marker") then
					local ped = getElementParent(source)
					if not remoteInventoryOwner then
						outputChatBox(getElementData(ped, "surv_corpse_name"), 0, 255, 0)
						requestRemoteInventory(ped)
					else
						tempNextLootOwner = ped
						outputChatBox("tempNextLootOwner set", 0, 255, 0)
					end
				end
			end
		end
	end
)

addEventHandler("onClientMarkerLeave", root, function(player, matchingDimension)
		if player == localPlayer and matchingDimension then
			--LOOT HANDLER (LEAVE LOOTABLE AREA)
			if getElementData(source, "surv_loot_marker") then 
				local ped = getElementParent(source)
				if ped == remoteInventoryOwner then
					outputChatBox(getElementData(source, "surv_corpse_name"), 255, 0, 0)
					destroyRemoteInventory()
					if tempNextLootOwner then
						if tempNextLootOwner ~= ped then
							requestRemoteInventory(tempNextLootOwner)
							outputChatBox("tempNextLootOwner requested")
						end
						tempNextLootOwner = nil
						outputChatBox("tempNextLootOwner unset", 255, 0, 0)
					end
				elseif ped == tempNextLootOwner then
					tempNextLootOwner = nil
					outputChatBox("tempNextLootOwner unset", 255, 0, 0)
				end
			end
		end
	end
)

--COMMANDS
addCommandHandler("getpos", function()
		local posX, posY, posZ = getElementPosition(localPlayer)
		outputConsole("Position [x y z]:   "..posX.."   "..posY.."   "..posZ)
	end
)

addCommandHandler("getrot", function()
		local rotX, rotY, rotZ = getElementRotation(localPlayer)
		outputConsole("Rotation [x y z]:   "..rotX.."   "..rotY.."   "..rotZ)
	end
)

addCommandHandler("spawntime", function()
		local time = getRealTime(getElementData(localPlayer, "surv_spawn_time"))
		outputChatBox("#d2d296You spawned at#FFFFFF "..zeroFill(time["hour"])..":"..zeroFill(time["minute"]).." #d2d296on#FFFFFF "..(time["year"]+1900).."."..zeroFill(time["month"]+1).."."..time["monthday"], 210, 210, 150, true)
	end
)

addCommandHandler("items", function()
		outputChatBox("Open the console to see the result.", 255, 255, 255)
		outputConsole("LIST OF ITEMS:")
		for id, _ in pairs(items) do
			outputConsole("  "..id)
		end
	end
)


--LOCALINV/REMOTEINV PARANCSOK: FEJLESZTÉS IDEJÉRE!
addCommandHandler("localinv", function()
		outputConsole("LOCAL INVENTORY:")
		outputConsole(inspect(localInventory))
	end
)

addCommandHandler("remoteinv", function()
		outputConsole("REMOTE INVENTORY:")
		outputConsole(inspect(remoteInventory))
	end
)

addCommandHandler("localinvmatrix", function()
		if not localInventoryMatrix then
			outputChatBox("Local inventory matrix doesn't exist.", 255, 0, 0)
			return
		end
		outputConsole("LOCAL INVENTORY MATRIX:")
		for i, rowArray in pairs(localInventoryMatrix) do
			local row = ""
			for j, value in pairs(rowArray) do
				row = row..zeroPrefix(value, 3).."  "
			end
			outputConsole(row)
		end
	end
)

addCommandHandler("remoteinvmatrix", function()
		if not remoteInventoryMatrix then
			outputChatBox("Remote inventory matrix doesn't exist.", 255, 0, 0)
			return
		end
		outputConsole("REMOTE INVENTORY MATRIX:")
		for i, rowArray in pairs(remoteInventoryMatrix) do
			local row = ""
			for j, value in pairs(rowArray) do
				row = row..zeroPrefix(value, 3).."  "
			end
			outputConsole(row)
		end
	end
)


--BINDS
bindKey("b", "down", "chatbox", "GlobalChat")

bindKey("tab", "both", function(_, keyState)
		if not localInventory then
			return
		end
		if isInvOpened and keyState == "up" then
			closeInventory()
		elseif keyState == "down" then
			if not isInvOpenEnabled then
				return
			end
			openInventory()
			isInvOpenEnabled = false
		end
	end
)





