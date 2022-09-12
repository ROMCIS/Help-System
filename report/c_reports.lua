wReportMain, bClose, lStatus, lVehTheft, lPropBreak, lPapForgery, lVehTheftStatus, lPropBreakStatus, lPapForgeryStatus, bVehTheft, bPropBreak, bPapForgery, bHelp, lPlayerName, tPlayerName, lNameCheck, lReport, tReport, lLengthCheck, bSubmitReport = nil

function resourceStart()
	--bindKey("F2", "down", toggleReport)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), resourceStart)

function toggleReport()
	--executeCommandHandler("report")
	if wHelp then
		guiSetInputEnabled(false)
		showCursor(false)
		destroyElement(wHelp)
		wHelp = nil
	end
end

function checkBinds()
	if ( exports.integration:isPlayerTrialAdmin(getLocalPlayer()) or getElementData( getLocalPlayer(), "account:gmlevel" )  ) then
		if getBoundKeys("ar") or getBoundKeys("acceptreport") then
			--outputChatBox("You had keys bound to accept reports. Please delete these binds.", 255, 0, 0)
			triggerServerEvent("arBind", getLocalPlayer())
		end
	end
end
setTimer(checkBinds, 60000, 0)

local function scale(w)
	local width, height = guiGetSize(w, false)
	local screenx, screeny = guiGetScreenSize()
	local minwidth = math.min(700, screenx)
	if width < minwidth then
		guiSetSize(w, minwidth, height / width * minwidth, false)
		local width, height = guiGetSize(w, false)
		guiSetPosition(w, (screenx - width) / 2, (screeny - height) / 2, false)
	end
end

function toggleVehTheft()
	if exports.integration:isPlayerTrialAdmin(getLocalPlayer()) then
		local status = getElementData(resourceRoot, "vehtheft")
		if status == "Opened" then
			guiSetText(lVehTheftStatus, "مغلق")
			guiLabelSetColor(lVehTheftStatus, 255, 0, 0)
			setElementData(resourceRoot, "vehtheft", "On hold")
			triggerServerEvent("toggleStatus", localPlayer, localPlayer, "Vehicle Theft", tostring(status))
		elseif status == "On hold" then
			guiSetText(lVehTheftStatus, "مفتوح")
			guiLabelSetColor(lVehTheftStatus, 0, 255, 0)
			setElementData(resourceRoot, "vehtheft", "Opened")
			triggerServerEvent("toggleStatus", localPlayer, localPlayer, "Vehicle Theft", tostring(status))
		end
	end
end

function togglePropBreak()
	if exports.integration:isPlayerTrialAdmin(getLocalPlayer()) then
		local status = getElementData(resourceRoot, "propbreak")
		if status == "Opened" then
			guiSetText(lPropBreakStatus, "مغلق")
			guiLabelSetColor(lPropBreakStatus, 255, 0, 0)
			setElementData(resourceRoot, "propbreak", "On hold")
			triggerServerEvent("toggleStatus", localPlayer, localPlayer, "Property Break-in", tostring(status))
		elseif status == "On hold" then
			guiSetText(lPropBreakStatus, "مفتوح")
			guiLabelSetColor(lPropBreakStatus, 0, 255, 0)
			setElementData(resourceRoot, "propbreak", "Opened")
			triggerServerEvent("toggleStatus", localPlayer, localPlayer, "Property Break-in", tostring(status))
		end
	end
end

function togglePaperForg()
	if exports.integration:isPlayerTrialAdmin(getLocalPlayer()) then
		local status = getElementData(resourceRoot, "papforg")		
		if status == "Opened" then
			guiSetText(lPapForgeryStatus, "مغلق")
			guiLabelSetColor(lPapForgeryStatus, 255, 0, 0)
			setElementData(resourceRoot, "papforg", "On hold")
			triggerServerEvent("toggleStatus", localPlayer, localPlayer, "Paper Forgery", tostring(status))
		elseif status == "On hold" then
			guiSetText(lPapForgeryStatus, "مفتوح")
			guiLabelSetColor(lPapForgeryStatus, 0, 255, 0)
			setElementData(resourceRoot, "papforg", "Opened")
			triggerServerEvent("toggleStatus", localPlayer, localPlayer, "Paper Forgery", tostring(status))
		end
	end
end

-- Love, Ultra <3 x3 x3 x3
function showReportMainUI()
	local logged = getElementData(getLocalPlayer(), "loggedin")
	if (logged==1) then
		if (wReportMain==nil)  then
			reportedPlayer = nil
			wReportMain = guiCreateWindow(0.29, 0.17, 0.45, 0.61, "لوحه البلاغات والمساعده - Report System", true)
			scale(wReportMain)
 
			hubtabs = guiCreateTabPanel(0.04, 0.07, 0.92, 0.87, true, wReportMain)
 	
			reportpanel = guiCreateTab("قسم الابلاغ", hubtabs)
 	
			lReportType = guiCreateLabel(0.06, 0.05, 0.30, 0.03, "نوع الابلاغ (ضع نوع المناسب)", true, reportpanel)
			cReportType = guiCreateComboBox(0.06, 0.11, 0.30, 0.26, "نوع الابلاغ", true, reportpanel)
			for key, value in ipairs(reportTypes) do
				guiComboBoxAddItem(cReportType, value[1])
			end
			addEventHandler("onClientGUIComboBoxAccepted", cReportType, canISubmit)
			addEventHandler("onClientGUIComboBoxAccepted", cReportType, function()
				local selected = guiComboBoxGetSelected(cReportType)+1
				guiLabelSetHorizontalAlign( lReportType, "center", true)
				guiSetText(lReportType, reportTypes[selected][7])
				end)

			guiSetInputEnabled(true)
			tReport = guiCreateMemo(0.07, 0.47, 0.85, 0.32, "", true, reportpanel)
			addEventHandler("onClientGUIChanged", tReport, canISubmit)

			lReport = guiCreateLabel(0.38, 0.42, 0.22, 0.03, "~=== محتويات الابلاغ ===~", true, reportpanel)
			guiLabelSetHorizontalAlign(lReport, "center")
			guiSetFont(lReport, "default-bold-small")
			guiSetFont(lPlayerName, "default-bold-small")

			lPlayerName = guiCreateLabel(0.06, 0.22, 0.30, 0.03, ":الاعب المبلغ ضده (اختياري)", true, reportpanel)

			tPlayerName = guiCreateMemo(0.06, 0.28, 0.36, 0.06, "رقم الاعب او اسمه", true, reportpanel)
			addEventHandler("onClientGUIChanged", tReport, canISubmit)

			lNameCheck = guiCreateLabel(48, 197, 278, 17, "انت تبلغ لنفسك", false, reportpanel)
			guiSetFont(lNameCheck, "default-bold-small")
			guiLabelSetColor(lNameCheck, 0, 255, 0)
			addEventHandler("onClientGUIChanged", tPlayerName, checkNameExists)

			lLengthCheck = guiCreateLabel(0.07, 0.81, 0.53, 0.03, "الطول: " .. string.len(tostring(guiGetText(tReport)))-1 .. "/150 حرف.", true, reportpanel)
			guiLabelSetColor(lLengthCheck, 0, 255, 0)
			guiSetFont(lLengthCheck, "default-bold-small")

			bSubmitReport = guiCreateButton(0.37, 0.88, 0.26, 0.08, "تقديم الإبلاغ", true, reportpanel)
			guiSetProperty(bSubmitReport, "NormalTextColour", "FFAAAAAA")
			addEventHandler("onClientGUIClick", bSubmitReport, submitReport)
			guiSetEnabled(bSubmitReport, false)

			specials = guiCreateGridList(0.49, 0.03, 0.47, 0.21, true, reportpanel)

			guiGridListAddColumn(specials, "سرقة السيارات", 0.3)
			guiGridListAddColumn(specials, "دخول بناية او سطو", 0.3)
			guiGridListAddColumn(specials, "تزوير الاوراق", 0.3)

			if vehTheftStatus == "مفتوح" then guiLabelSetColor(lVehTheftStatus, 0, 255, 0) end
			if vehTheftStatus == "مغلق" then guiLabelSetColor(lVehTheftStatus, 255, 0, 0) end

			if propBreakStatus == "مفتوح" then guiLabelSetColor(lPropBreakStatus, 0, 255, 0) end
			if propBreakStatus == "مغلق" then guiLabelSetColor(lPropBreakStatus, 255, 0, 0) end

			if papForgeStatus == "مفتوح" then guiLabelSetColor(lPapForgeryStatus, 0, 255, 0) end
			if papForgeStatus == "مغلق" then guiLabelSetColor(lPapForgeryStatus, 255, 0, 0) end

			local canEditStatus = exports.integration:isPlayerTrialAdmin(getLocalPlayer())

			if canEditStatus then
				bVehTheft = guiCreateButton(0.04, 0.59, 0.23, 0.19, "فتح/غلق", true, specials)
				guiSetProperty(bVehTheft, "NormalTextColour", "FFAAAAAA")
				bPropBreak = guiCreateButton(0.34, 0.59, 0.23, 0.19, "فتح/غلق", true, specials)
				guiSetProperty(bPropBreak, "NormalTextColour", "FFAAAAAA")
				bPapForgery = guiCreateButton(0.64, 0.59, 0.23, 0.19, "فتح/غلق", true, specials)
				guiSetProperty(bPapForgery, "NormalTextColour", "FFAAAAAA")

				addEventHandler("onClientGUIClick", bVehTheft, toggleVehTheft, false)
				addEventHandler("onClientGUIClick", bPropBreak, togglePropBreak, false)
				addEventHandler("onClientGUIClick", bPapForgery, togglePaperForg, false)
			end

			local vehTheftStatus = getElementData(resourceRoot, "vehtheft")
			local propBreakStatus = getElementData(resourceRoot, "propbreak")
			local papForgeStatus = getElementData(resourceRoot, "papforg")

			lVehTheftStatus = guiCreateLabel(0.04, 0.32, 0.23, 0.14, vehTheftStatus, true, specials)
			lPropBreakStatus = guiCreateLabel(0.34, 0.33, 0.24, 0.13, propBreakStatus, true, specials)
			lPapForgeryStatus = guiCreateLabel(0.63, 0.33, 0.24, 0.13, papForgeStatus, true, specials)
 
 
			rules = guiCreateTab("اهداف الخادم", hubtabs)
 
			mrules = guiCreateMemo(0.03, 0.05, 0.93, 0.89, "اولا نرحب بكل الاعضاء الجدد, كنقطة بداية السيرفر هدفه هو الحياة الواقعية كل شيء نستطيع فعله في الواقعية نستطيع ان نفعله هنا ايضا  و ايضا هدفنا ربط بين الناس", true, rules)
			guiMemoSetReadOnly(mrules, true)
 
			explained = guiCreateTab("مفهوم الرولي بلاي", hubtabs)
	 
			mexplained = guiCreateMemo(0.03, 0.05, 0.93, 0.88, "فهوم الرولي بلاي في الحقيقة هو عيش واقع افتراضي لكن مثل الحياة الواقعية, و هناك كثير من المفاهيم منها  ميتا كامينك ميتا كامينك تتمثل في الخلط بين المعلومات داخل اللعبة و خارجها", true, explained)
			guiMemoSetReadOnly(mexplained, true)
 
			overview = guiCreateTab("اوامر الرولي بلاي المهمة", hubtabs)
 
			moverview = guiCreateMemo(0.03, 0.05, 0.93, 0.88, "و هي تستعمل لوصف الاشياء المحيطة بكم    /do ثانياً  /me و هي للتعبير عن حركة او اي فعل مثل  يجلس على الكرسي و ينظر الى الشخص /me نبدء ب (/me & /do) اوامر المهمة هي", true, overview)
			guiMemoSetReadOnly(moverview, true)
			bClose = guiCreateButton(0.04, 0.95, 0.92, 0.04, "غلق", true, wReportMain)
			guiSetProperty(bClose, "NormalTextColour", "FFAAAAAA")
			addEventHandler("onClientGUIClick", bClose, clickCloseButton)
			blurbox = exports.blur_box:createBlurBox(0, 0, 100000, 100000, 255, 255, 255, 255, blurbox)
			exports.blur_box:setBlurIntensity(2)
		elseif (wReportMain~=nil) then
			exports.blur_box:destroyBlurBox(blurbox)
			guiSetVisible(wReportMain, false)
			destroyElement(wReportMain)

			wReportMain, bClose, lStatus, lVehTheft, lPropBreak, lPapForgery, lVehTheftStatus, lPropBreakStatus, lPapForgeryStatus, bVehTheft, bPropBreak, bPapForgery, bHelp, lPlayerName, tPlayerName, lNameCheck, lReport, tReport, lLengthCheck, bSubmitReport = nil
			guiSetInputEnabled(false)
			showCursor(false)
		end
	end
end
addCommandHandler("report", showReportMainUI)

function submitReport(button, state)
	if (source==bSubmitReport) and (button=="left") and (state=="up") then

		if (wReportMain~=nil) then
			destroyElement(wReportMain)
			exports.blur_box:destroyBlurBox(blurbox)
		end

		if (wHelp) then
			destroyElement(wHelp)
			exports.blur_box:destroyBlurBox(blurbox)
		end

		wReportMain, bClose, lStatus, lVehTheft, lPropBreak, lPapForgery, lVehTheftStatus, lPropBreakStatus, lPapForgeryStatus, bVehTheft, bPropBreak, bPapForgery, bHelp, lPlayerName, tPlayerName, lNameCheck, lReport, tReport, lLengthCheck, bSubmitReport = nil
		guiSetInputEnabled(false)
		showCursor(false)
		exports.blur_box:destroyBlurBox(blurbox)
	end
end

function checkReportLength(theEditBox)
	guiSetText(lLengthCheck, "Length: " .. string.len(tostring(guiGetText(tReport)))-1 .. "/150 Characters.")

	if (tonumber(string.len(tostring(guiGetText(tReport))))-1>150) then
		guiLabelSetColor(lLengthCheck, 255, 0, 0)
		return false
	elseif (tonumber(string.len(tostring(guiGetText(tReport))))-1<3) then
		guiLabelSetColor(lLengthCheck, 255, 0, 0)
		return false
	elseif (tonumber(string.len(tostring(guiGetText(tReport))))-1>130) then
		guiLabelSetColor(lLengthCheck, 255, 255, 0)
		return true
	else
		guiLabelSetColor(lLengthCheck,0, 255, 0)
		return true
	end
end

function checkType(theGUI)
	local selected = guiComboBoxGetSelected(cReportType)+1 -- +1 to relate to the table for later

	if not selected or selected == 0 then
		return false
	else
		return true
	end
end

function canISubmit()
	local rType = checkType()
	local rReportLength = checkReportLength()
	--[[local adminreport = getElementData(getLocalPlayer(), "adminreport")
	local gmreport = getElementData(getLocalPlayer(), "gmreport")]]
	local reportnum = getElementData(getLocalPlayer(), "reportNum")
	if rType and rReportLength then
		if reportnum then
			guiSetText(wReportMain, "Your report ID #" .. (reportnum).. " is still pending. Please wait or /er before submitting another.")
		else
			guiSetEnabled(bSubmitReport, true)
		end
	else
		guiSetEnabled(bSubmitReport, false)
	end
end

function checkNameExists(theEditBox)
	local found = nil
	local count = 0


	local text = guiGetText(theEditBox)
	if text and #text > 0 then
		local players = getElementsByType("player")
		if tonumber(text) then
			local id = tonumber(text)
			for key, value in ipairs(players) do
				if getElementData(value, "playerid") == id then
					found = value
					count = 1
					break
				end
			end
		else
			for key, value in ipairs(players) do
				local username = string.lower(tostring(getPlayerName(value)))
				if string.find(username, string.lower(text)) then
					count = count + 1
					found = value
					break
				end
			end
		end
	end

	if (count>1) then
		guiSetText(lNameCheck, "Multiple Found - Will take yourself to submit.")
		guiLabelSetColor(lNameCheck, 255, 255, 0)
	elseif (count==1) then
		guiSetText(lNameCheck, "الاعب موجود: " .. getPlayerName(found) .. " (ID #" .. getElementData(found, "playerid") .. ")")
		guiLabelSetColor(lNameCheck, 0, 255, 0)
		reportedPlayer = found
	elseif (count==0) then
		guiSetText(lNameCheck, "الاعب غير موجود - ابلغ على نفسك لتقديم")
		guiLabelSetColor(lNameCheck, 255, 0, 0)
	end
end

-- Close button
function clickCloseButton(button, state)
	if (source==bClose) and (button=="left") and (state=="up") then
		if (wReportMain~=nil) then
			destroyElement(wReportMain)
			exports.blur_box:destroyBlurBox(blurbox)
		end

		if (wHelp) then
			destroyElement(wHelp)
			exports.blur_box:destroyBlurBox(blurbox)
		end

		wReportMain, bClose, lStatus, lVehTheft, lPropBreak, lPapForgery, lVehTheftStatus, lPropBreakStatus, lPapForgeryStatus, bVehTheft, bPropBreak, bPapForgery, bHelp, lPlayerName, tPlayerName, lNameCheck, lReport, tReport, lLengthCheck, bSubmitReport = nil
		guiSetInputEnabled(false)
		showCursor(false)
	elseif (source==bHelp) and (button=="left") and (state=="up") then
		if (wReportMain~=nil) then
			destroyElement(wReportMain)
		end

		wReportMain, bClose, lStatus, lVehTheft, lPropBreak, lPapForgery, lVehTheftStatus, lPropBreakStatus, lPapForgeryStatus, bVehTheft, bPropBreak, bPapForgery, bHelp, lPlayerName, tPlayerName, lNameCheck, lReport, tReport, lLengthCheck, bSubmitReport = nil
		guiSetInputEnabled(false)
		showCursor(false)

		triggerEvent("viewF1Help", getLocalPlayer())
	end
end

function onOpenCheck(playerID)
	executeCommandHandler ( "check", tostring(playerID) )
end
addEvent("report:onOpenCheck", true)
addEventHandler("report:onOpenCheck", getRootElement(), onOpenCheck)