
x, y = guiGetScreenSize()

showCursor(true)

window = guiCreateWindow(0.4, 0.4, 0.2, 0.2, "DEVELOPMENT LOGIN PANEL", true)
input_username = guiCreateEdit(0.1, 0.2, 0.8, 0.15, "", true, window)
input_pw = guiCreateEdit(0.1, 0.4, 0.8, 0.15, "", true, window)
btn_login = guiCreateButton(0.2, 0.67, 0.28, 0.2, "LOGIN", true, window)
btn_register = guiCreateButton(0.52, 0.67, 0.28, 0.2, "REGISTER", true, window)

addEventHandler("onClientGUIClick", btn_login, function()
		triggerServerEvent("onClientAttemptLogin", resourceRoot, guiGetText(input_username), guiGetText(input_pw))
	end, false
)

addEventHandler("onClientGUIClick", btn_register, function()
		triggerServerEvent("onClientAttemptRegister", resourceRoot, guiGetText(input_username), guiGetText(input_pw))
		
	end, false
)

addEvent("hideLoginPanel", true)
addEventHandler("hideLoginPanel", resourceRoot, function()
		destroyElement(window)
		showCursor(false)
	end
)
