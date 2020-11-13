
db = exports.db:getDB()

addEvent("onClientAttemptLogin", true)
addEvent("onClientAttemptRegister", true)

addEventHandler("onClientAttemptLogin", resourceRoot, function(username, password)
		if logIn(client, getAccount(username), password) then
			outputChatBox("LOGGED IN", client, 0, 255, 0)
			triggerClientEvent(client, "hideLoginPanel", resourceRoot)
			dbExec(db, "UPDATE accounts SET lastPlayerName=?, lastIP=?, lastSerial=? WHERE name = ?", getPlayerName(client), getPlayerIP(client), getPlayerSerial(client), username)
		else
			outputChatBox("FAILED TO LOGIN", client, 255, 0, 0)
		end
	end
)

addEventHandler("onClientAttemptRegister", resourceRoot, function(username, password)
		local acc = addAccount(username, password)
		if acc then
			outputChatBox("REGISTERED", client, 0, 255, 0)
			dbExec(db, "INSERT INTO accounts (ID, name, lastPlayerName, lastIP) VALUES (?,?,?,?)", getAccountID(acc), username, getPlayerName(client), getAccountIP(acc))
		else
			outputChatBox("FAILED TO REGISTER", client, 255, 0, 0)
		end
	end
)

