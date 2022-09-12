local sx, sy = guiGetScreenSize()
local mySX, mySY = 1920, 1080

local dgsElements = {};
local animationTime = 600
local dgsFont;
local dgsFontBold;

function isCameraOnPlayer()
	local vehicle = getPedOccupiedVehicle(getLocalPlayer())
	if vehicle then
		return getCameraTarget( ) == vehicle
	else
		return getCameraTarget( ) == getLocalPlayer()
	end
end

function dgsCreateFonts() -- عندما يقوم العضو بفتح اللوحه، يتم صنع الخطوط
    local mul = ((sx + sy) / 2) / ( (1920 + 1080) / 2);
    local scale = math.min(mul*16.5, 16.5);
    local scaleBold = math.min(mul*15, 15);

    dgsFont = exports.dgs:dgsCreateFont("sst_arabic.ttf", scale, false, "cleartype") -- Normal
    dgsFontBold = exports.dgs:dgsCreateFont("sst_arabic.ttf", scaleBold, true, "cleartype") -- Bold
end 

function dgsDestroyFonts() -- عندما يقوم العضو بإغلاق اللوحة، يتم تدمير الخطوط، وذلك لتقليل الضغط على جهاز اللاعب
    destroyElement(dgsFontBold)
    destroyElement(dgsFontBold)

    dgsFont = nil;
    dgsFontBold = nil
end 

romcisCreateButton = function(x, y, rx, ry, info, relative, prent)
    local mainButtonRound = exports.dgs:dgsCreateRoundRect({{10,false},{10,false},{10,false},{10,false}}, false, tocolor(32,33,40, 255), nil, nil, nil);
    exports.dgs:dgsRoundRectSetColorOverwritten(mainButtonRound,false);
    dgsElements.vButtons = exports.dgs:dgsCreateButton(x, y, rx, ry, info, relative, prent, 0xFFFFFFFF, 1, 1, nil, nil, nil, tocolor(8, 244, 0,255), tocolor(8, 244, 0,255), tocolor(8, 244, 0,0))
    exports.dgs:dgsSetFont(dgsElements.vButtons, dgsFontBold)
    exports.dgs:dgsSetProperty(dgsElements.vButtons,"image",{mainButtonRound,mainButtonRound,mainButtonRound})
    exports.dgs:dgsSetProperty(dgsElements.vButtons ,"color",{tocolor(1, 76, 185), tocolor(8, 244, 0, 100), tocolor(32,33,40, 255)})
    return dgsElements.vButtons
end

function MainSys()
    dgsElements = {};
    dgsCreateFonts()

    local multiplier = Vector2(sx / 1920, sy / 1080);
    local width, height = (multiplier.x * 800), (multiplier.y * 500);
    local mainRound = exports.dgs:dgsCreateRoundRect({{10,false},{10,false},{0,false},{0,false}}, false, tocolor(32,33,40, 255), nil, nil, nil);
    exports.dgs:dgsRoundRectSetColorOverwritten(mainRound,false);

    --dgsElements.window = exports.dgs:dgsCreateImage((sx / 2) - (width / 2), (sy / 2) - (height / 2), width, height, mainRound, false);
    --exports.dgs:dgsSetAlpha(dgsElements.window, 0);
    --exports.dgs:dgsAlphaTo(dgsElements.window, 1, 'OutQuad', animationTime);

    dgsElements.window = exports.dgs:dgsCreateWindow((sx / 2) - (width / 2), (sy / 2) - (height / 2), width, height, "- En[K]sAr . || ArabNight", false,nil,nil,nil,tocolor(32,33,40, 255),nil,tocolor(32,33,40, 255),nil,true);
    exports.dgs:dgsWindowSetSizable(dgsElements.window, false);
    exports.dgs:dgsWindowSetMovable(dgsElements.window, false);
    exports.dgs:dgsSetAlpha(dgsElements.window, 0);
    exports.dgs:dgsAlphaTo(dgsElements.window, 1, 'OutQuad', animationTime);
    exports.dgs:dgsSetFont(dgsElements.window, dgsFont)

    dgsElements.scroll_main = exports.dgs:dgsCreateScrollPane(0.01, 0.04, 0.40, 0.88, true, dgsElements.window)
    exports.dgs:dgsSetProperty(dgsElements.scroll_main,"scrollBarThick",0)

    dgsElements.romcisSetting = romcisCreateButton(0.15, 0.04, 0.70, 0.09, "إستبدال الشخصية", true, dgsElements.scroll_main)
    dgsElements.romcisSetting1 = romcisCreateButton(0.15, 0.18, 0.70, 0.09, "معلومات الشخصية", true, dgsElements.scroll_main)
    dgsElements.romcisSetting2 = romcisCreateButton(0.15, 0.32, 0.70, 0.09, "ربط الحساب مع الديسكورد", true, dgsElements.scroll_main)
    dgsElements.romcisSetting3 = romcisCreateButton(0.15, 0.46, 0.70, 0.09, "الاعدادات العامة", true, dgsElements.scroll_main)
    dgsElements.romcisSetting4 = romcisCreateButton(0.15, 0.60, 0.70, 0.09, "أعدادات الحساب", true, dgsElements.scroll_main)
    dgsElements.romcisSetting5 = romcisCreateButton(0.15, 0.74, 0.70, 0.09, "مميزات الجي سي", true, dgsElements.scroll_main)
    dgsElements.romcisSetting6 = romcisCreateButton(0.15, 0.88, 0.70, 0.09, "القوانين والمساعدة", true, dgsElements.scroll_main)
    dgsElements.romcisSetting7 = romcisCreateButton(0.15, 1.02, 0.70, 0.09, "مسؤول الموظفين", true, dgsElements.scroll_main)
    dgsElements.romcisSetting8 = romcisCreateButton(0.15, 1.16, 0.70, 0.09, "مسؤول البيوت", true, dgsElements.scroll_main)
    dgsElements.romcisSetting9 = romcisCreateButton(0.15, 1.30, 0.70, 0.09, "مسؤول التطبيق", true, dgsElements.scroll_main)
    dgsElements.romcisSetting10 = romcisCreateButton(0.15, 1.44, 0.70, 0.09, "مسؤول السيارات", true, dgsElements.scroll_main)
    dgsElements.romcisSetting11 = romcisCreateButton(0.15, 1.58, 0.70, 0.09, "رسالة يومية", true, dgsElements.scroll_main)
    dgsElements.romcisSetting12 = romcisCreateButton(0.15, 1.72, 0.70, 0.09, "- تسجيل خروج -", true, dgsElements.scroll_main)
    dgsElements.dot_1 = exports.dgs:dgsCreateImage(0.39, 0.04, 0.004, 0.88, ":admin/client/images/dot.png", true, dgsElements.window)
    dgsElements.label_1 = exports.dgs:dgsCreateLabel(0.57, 0.12, 0.30, 0.05, "شبكة عرب نايت || نظام الشكاوي", true, dgsElements.window)
    exports.dgs:dgsSetFont(dgsElements.label_1, dgsFont)
    dgsElements.label_2 = exports.dgs:dgsCreateLabel(0.46, 0.19, 0.30, 0.05, "نتمنى منك يا عزيزي اللعب الاتزام بالواقعية و عدم طلب المساعدات", true, dgsElements.window)
    exports.dgs:dgsSetFont(dgsElements.label_2, dgsFont)
    dgsElements.label_3 = exports.dgs:dgsCreateLabel(0.51, 0.26, 0.30, 0.05, "التي تخرق قواعد العب الواقعي كمثال طلب الادمنية", true, dgsElements.window)
    exports.dgs:dgsSetFont(dgsElements.label_3, dgsFont)
    dgsElements.label_4 = exports.dgs:dgsCreateLabel(0.55, 0.33, 0.30, 0.05, "لتعبئة البنزين او طلب النقل و ما شابه هذا", true, dgsElements.window)
    exports.dgs:dgsSetFont(dgsElements.label_4, dgsFont)


    dgsElements.scroll_main2 = exports.dgs:dgsCreateScrollPane(0.44, 0.45, 0.51, 0.44, true, dgsElements.window)
    exports.dgs:dgsSetProperty(dgsElements.scroll_main2,"scrollBarThick",0)
    dgsElements.report_Maps = romcisCreateButton(0.15, 0.07, 0.70, 0.13, "مشكلة بيوت/انتروهات", true, dgsElements.scroll_main2)
    dgsElements.report_WithPlayer = romcisCreateButton(0.15, 0.27, 0.70, 0.13, "مشكلة مع لاعب آخر", true, dgsElements.scroll_main2)
    dgsElements.report_IDK = romcisCreateButton(0.15, 0.48, 0.70, 0.13, "استفسار عام", true, dgsElements.scroll_main2)
    dgsElements.report_DEV = romcisCreateButton(0.15, 0.77, 0.70, 0.13, "مشكلة برمجية", true, dgsElements.scroll_main2)
    dgsElements.label_5 = exports.dgs:dgsCreateLabel(0.42, 1.02, 0.10, 0.13, "MR.ROMCIS", true, dgsElements.scroll_main2)
    exports.dgs:dgsSetFont(dgsElements.label_5, dgsFont)

    addEventHandler('onDgsMouseClickUp', dgsElements.report_Maps, reportMaps, false)
    addEventHandler('onDgsMouseClickUp', dgsElements.report_WithPlayer, reportWithPlayer, false)
    addEventHandler('onDgsMouseClickUp', dgsElements.report_IDK, reportIDK, false)
    addEventHandler('onDgsMouseClickUp', dgsElements.report_DEV, reportDEV, false)
end 

function reportWithPlayer(button, state)
    if button == 'left' and state == 'up' then 
        if dgsElements.window then 
            local reportnum = getElementData(getLocalPlayer(), "reportNum")
            if reportnum then
            outputChatBox( "#" .. reportnum .. "انت تمتلك ريبورت بالفعل . أيدي : ", 255 , 0 , 0)
            else
            triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), "مشكلة مع لاعب", 1)
            end 
        end 
    end 
end 

function reportMaps(button, state)
    if button == 'left' and state == 'up' then 
        if dgsElements.window then 
            local reportnum = getElementData(getLocalPlayer(), "reportNum")
            if reportnum then
            outputChatBox( "#" .. reportnum .. "انت تمتلك ريبورت بالفعل . أيدي : ", 255 , 0 , 0)
            else
            triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), "مشكلة في بيوت / انتروهات", 2)
            end 
        end 
    end 
end 

function reportIDK(button, state)
    if button == 'left' and state == 'up' then 
        if dgsElements.window then 
            local reportnum = getElementData(getLocalPlayer(), "reportNum")
            if reportnum then
            outputChatBox( "#" .. reportnum .. "انت تمتلك ريبورت بالفعل . أيدي : ", 255 , 0 , 0)
            else
            triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), "سؤال عام", 4)
            end 
        end 
    end 
end 

function reportDEV(button, state)
    if button == 'left' and state == 'up' then 
        if dgsElements.window then 
            local reportnum = getElementData(getLocalPlayer(), "reportNum")
            if reportnum then
            outputChatBox( "#" .. reportnum .. "انت تمتلك ريبورت بالفعل . أيدي : ", 255 , 0 , 0)
            else
            triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), " مشكلة برمجية ", 10)
            end 
        end 
    end 
end 

addEventHandler ( "onDgsMouseClick", root, function ( button, state )
if button == "left" and state == "down" then
if source == dgsElements.romcisSetting then
triggerEvent("accounts:logout", getLocalPlayer())
romcis_closemenu()
elseif source == dgsElements.romcisSetting1 then
triggerServerEvent("showStats", localPlayer,localPlayer)
romcis_closemenu()
elseif source == dgsElements.romcisSetting2 then
executeCommandHandler("link")
romcis_closemenu()
elseif source == dgsElements.romcisSetting3 then
romcis_closemenu()
triggerEvent("accounts:settings:fetchSettings", getLocalPlayer())
elseif source == dgsElements.romcisSetting4 then
romcis_closemenu()
elseif source == dgsElements.romcisSetting5 then
triggerServerEvent("donation-system:GUI:open", localPlayer)
romcis_closemenu()
elseif source == dgsElements.romcisSetting6 then
triggerEvent("romcis:openCarWindow", getLocalPlayer())
romcis_closemenu()
elseif source == dgsElements.romcisSetting7 then
executeCommandHandler("staffs")
romcis_closemenu()
elseif source == dgsElements.romcisSetting8 then
triggerServerEvent("interiorManager:openit", localPlayer, localPlayer)
romcis_closemenu()
elseif source == dgsElements.romcisSetting9 then
executeCommandHandler("apps")
romcis_closemenu()
elseif source == dgsElements.romcisSetting10 then	
triggerServerEvent("vehlib:sendLibraryToClient", localPlayer)
romcis_closemenu()
elseif source == dgsElements.romcisSetting11 then	
executeCommandHandler("motd")
romcis_closemenu()
elseif source == dgsElements.romcisSetting12 then
fadeCamera ( false, 2, 0,0,0 )
setTimer(function()
triggerServerEvent("accounts:settings:reconnectPlayer", localPlayer)
romcis_closemenu()
end, 2000,1)
end
end
end)

bindKey("F1","down",function()
	if getElementData(getLocalPlayer(), "exclusiveGUI") or not isCameraOnPlayer() then
		return
		end
		if (getElementData(localPlayer, "loggedin") == 1) then 
			if dgsElements.window and isElement(dgsElements.window) then 
				destroyElement(dgsElements.window)
				destroyElement(dgsElements)
				showCursor ( false )
			else 
	
				if ( getElementData( localPlayer, "loggedin" ) == 1 ) then 
					MainSys()
					showCursor(true)
				end
	
			end 
		end 
end 
) 

function romcis_closemenu()
	showCursor(false)
	if dgsElements.window then
		destroyElement(dgsElements.window)
		dgsElements.window = nil
	end
	setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
end