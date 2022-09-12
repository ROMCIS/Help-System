DGS = exports.dgs
local localPlayer = getLocalPlayer()

FontLabel = DGS:dgsCreateFont( "info/Samim-Bold.ttf", 13 )
FontButton = DGS:dgsCreateFont( "info/Samim-Bold.ttf", 11 )
FontMemo = DGS:dgsCreateFont( "info/Samim-Bold.ttf", 19 )
FontCheck = DGS:dgsCreateFont( "info/Samim-Bold.ttf", 15 )
local WindowRect = DGS:dgsCreateRoundRect({{0,false},{0,false},{15,false},{15,false}},tocolor(80,80,80,200))
local WindowLine = DGS:dgsCreateRoundRect({{15,false},{15,false},{0,false},{0,false}},tocolor(0,0,0,255))
local MemoRect = DGS:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(0,0,0,180))
ButtonRect = DGS:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(0, 0, 0, 255))
window = DGS:dgsCreateImage(0.32, 0.23, 0.37, 0.55,WindowRect,true,false)
windowLine = DGS:dgsCreateImage(0.32, 0.20, 0.37, 0.03,WindowLine,true,false)
LebalPanelName = DGS:dgsCreateLabel(0.25, 0.20, 0.24, 0.03, "- Arab Night || REPORT PANEL || BY MR.ROMCIS -", true, windowLine)   

LogoTop = DGS:dgsCreateImage(0.76, 0.02, 0.17, 0.21, "KingAbdullahII.png", true, window)  
Reason = DGS:dgsCreateMemo(0.03, 0.08, 0.67, 0.75, "", true, window)
ApplyButton = DGS:dgsCreateButton(0.03, 0.87, 0.67, 0.08, "تقديم البلاغ", true, window)
LebalSupporter = DGS:dgsCreateLabel(0.71, 0.37, 0.27, 0.08, "", true, window)    
LebalReportPanel = DGS:dgsCreateLabel(0.03, 0.02, 0.24, 0.03, ": معلومات البلاغ", true, window)   
OptionID1 = DGS:dgsCreateCheckBox(0.73, 0.22, 0.25, 0.06, " -   ( مشكلة مع لاعب )", false, true, window)
OptionID2 = DGS:dgsCreateCheckBox(0.73, 0.30, 0.25, 0.06, " -   ( مشكلة في انترو )", false, true, window)
OptionID3 = DGS:dgsCreateCheckBox(0.73, 0.38, 0.25, 0.06, " -   ( مشكلة في ايتم )", false, true, window)
OptionID4 = DGS:dgsCreateCheckBox(0.73, 0.46, 0.25, 0.06, " -   ( سؤال عام )", false, true, window)
OptionID5 = DGS:dgsCreateCheckBox(0.73, 0.54, 0.25, 0.06, " -   ( مشكلة في سيارة )", false, true, window)
OptionID6 = DGS:dgsCreateCheckBox(0.73, 0.62, 0.25, 0.06, " -   ( مشكلة في ماب )", false, true, window)
OptionID7 = DGS:dgsCreateCheckBox(0.73, 0.70, 0.25, 0.06, " -   ( مشكلة فريمات )", false, true, window)
OptionID8 = DGS:dgsCreateCheckBox(0.73, 0.78, 0.25, 0.06, " -   ( مشكلة برمجية )", false, true, window)
DGS:dgsSetVisible( window, false)
DGS:dgsSetVisible( windowLine, false)
showCursor ( false )
DGS:dgsSetProperty(Reason,"bgImage",MemoRect)
DGS:dgsSetFont(Reason, FontMemo)
DGS:dgsSetFont(OptionID1, FontCheck)
DGS:dgsSetFont(OptionID2, FontCheck)
DGS:dgsSetFont(OptionID3, FontCheck)
DGS:dgsSetFont(OptionID4, FontCheck)
DGS:dgsSetFont(OptionID5, FontCheck)
DGS:dgsSetFont(OptionID6, FontCheck)
DGS:dgsSetFont(OptionID7, FontCheck)
DGS:dgsSetFont(OptionID8, FontCheck)
DGS:dgsSetFont(LebalReportPanel, FontLabel)
DGS:dgsSetFont(LebalPanelName, FontLabel)
DGS:dgsSetFont(ApplyButton, FontButton)
DGS:dgsSetProperty(ApplyButton,"image",{ButtonRect,ButtonRect,ButtonRect}) 
DGS:dgsRoundRectSetColorOverwritten(ButtonRect,false)
DGS:dgsSetProperty(ApplyButton ,"color",{tocolor(0, 0, 0, 255), tocolor(0, 255, 0, 255), tocolor(0, 0, 0, 255)})

bindKey( "F2", "down",
	function( )
        if (DGS:dgsGetVisible ( window ) == false ) and (DGS:dgsGetVisible ( windowLine ) == false ) then
	DGS:dgsSetVisible( window, true)
	DGS:dgsSetVisible( windowLine, true)
	showCursor ( true )
        DGS:dgsSetInputMode("no_binds_when_editing")
else
	DGS:dgsSetVisible( window, false)
	DGS:dgsSetVisible( windowLine, false)
	showCursor ( false )
        DGS:dgsSetInputMode("allow_binds")
	end
	end
)

addEventHandler ( "onDgsMouseClick", root, 
function ( button, state )
reason = DGS:dgsGetText(Reason)
if button == "left" and state == "down" then
if source == ApplyButton then
local reportnum = getElementData(getLocalPlayer(), "reportNum")
if reportnum then 

triggerEvent("ve.notify", getLocalPlayer(), "Report System", "error", "" .. reportnum .. " : انت تمتلك ريبورت بالفعل . أيدي", 10)
else 
if not ( DGS:dgsCheckBoxGetSelected(OptionID1) or DGS:dgsCheckBoxGetSelected(OptionID2) or DGS:dgsCheckBoxGetSelected(OptionID3) or DGS:dgsCheckBoxGetSelected(OptionID4) or DGS:dgsCheckBoxGetSelected(OptionID5) or DGS:dgsCheckBoxGetSelected(OptionID6) or DGS:dgsCheckBoxGetSelected(OptionID7) or DGS:dgsCheckBoxGetSelected(OptionID8) ) then
triggerEvent("ve.notify", getLocalPlayer(), "Report System", "info", "فضلا يجب اختيار نوع المشكلة", 10)	
return
end
if ( reason == "" ) then
triggerEvent("ve.notify", getLocalPlayer(), "Report System", "error", "فضلا أدخل السبب ليتم ارساله للادارة", 10)
			return
		end
if DGS:dgsCheckBoxGetSelected(OptionID1) then
triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), reason, 1)
triggerEvent("ve.notify", getLocalPlayer(), "Report System", "success", "تم أرسال الطلب بنجاح المرجو الانتضار", 10)
			return
		end
if DGS:dgsCheckBoxGetSelected(OptionID2) then
triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), reason, 2)
triggerEvent("ve.notify", getLocalPlayer(), "Report System", "success", "تم أرسال الطلب بنجاح المرجو الانتضار", 10)
			return
		end
if DGS:dgsCheckBoxGetSelected(OptionID3) then
triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), reason, 3)
triggerEvent("ve.notify", getLocalPlayer(), "Report System", "success", "تم أرسال الطلب بنجاح المرجو الانتضار", 10)
			return
		end
if DGS:dgsCheckBoxGetSelected(OptionID4) then
triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), reason, 4)
triggerEvent("ve.notify", getLocalPlayer(), "Report System", "success", "تم أرسال الطلب بنجاح المرجو الانتضار", 10)
			return
		end
if DGS:dgsCheckBoxGetSelected(OptionID5) then
triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), reason, 5)
triggerEvent("ve.notify", getLocalPlayer(), "Report System", "success", "تم أرسال الطلب بنجاح المرجو الانتضار", 10)
			return
		end
if DGS:dgsCheckBoxGetSelected(OptionID6) then
triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), reason, 6)
triggerEvent("ve.notify", getLocalPlayer(), "Report System", "success", "تم أرسال الطلب بنجاح المرجو الانتضار", 10)
			return
		end
if DGS:dgsCheckBoxGetSelected(OptionID7) then
triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), reason, 7)
triggerEvent("ve.notify", getLocalPlayer(), "Report System", "success", "تم أرسال الطلب بنجاح المرجو الانتضار", 10)
			return
		end
if DGS:dgsCheckBoxGetSelected(OptionID8) then
triggerServerEvent("clientSendReport", getLocalPlayer(), getLocalPlayer(), reason, 8)
triggerEvent("ve.notify", getLocalPlayer(), "Report System", "success", "تم أرسال الطلب بنجاح المرجو الانتضار", 10)
		end
end
end
end
end)

addEventHandler("onDgsMouseClick",root,
function ( button, state )
	if button == "left" and state == "down" then
if source == OptionID1 then
if DGS:dgsCheckBoxGetSelected(source) then
DGS:dgsCheckBoxSetSelected(OptionID2,false)
DGS:dgsCheckBoxSetSelected(OptionID3,false)
DGS:dgsCheckBoxSetSelected(OptionID4,false)
DGS:dgsCheckBoxSetSelected(OptionID5,false)
DGS:dgsCheckBoxSetSelected(OptionID6,false)
DGS:dgsCheckBoxSetSelected(OptionID7,false)
DGS:dgsCheckBoxSetSelected(OptionID8,false)
end
elseif source == OptionID2 then 
if DGS:dgsCheckBoxGetSelected(source) then
DGS:dgsCheckBoxSetSelected(OptionID1,false)
DGS:dgsCheckBoxSetSelected(OptionID3,false)
DGS:dgsCheckBoxSetSelected(OptionID4,false)
DGS:dgsCheckBoxSetSelected(OptionID5,false)
DGS:dgsCheckBoxSetSelected(OptionID6,false)
DGS:dgsCheckBoxSetSelected(OptionID7,false)
DGS:dgsCheckBoxSetSelected(OptionID8,false)
end
elseif source == OptionID3 then 
if DGS:dgsCheckBoxGetSelected(source) then
DGS:dgsCheckBoxSetSelected(OptionID1,false)
DGS:dgsCheckBoxSetSelected(OptionID2,false)
DGS:dgsCheckBoxSetSelected(OptionID4,false)
DGS:dgsCheckBoxSetSelected(OptionID5,false)
DGS:dgsCheckBoxSetSelected(OptionID6,false)
DGS:dgsCheckBoxSetSelected(OptionID7,false)
DGS:dgsCheckBoxSetSelected(OptionID8,false)
end
elseif source == OptionID4 then 
if DGS:dgsCheckBoxGetSelected(source) then
DGS:dgsCheckBoxSetSelected(OptionID1,false)
DGS:dgsCheckBoxSetSelected(OptionID2,false)
DGS:dgsCheckBoxSetSelected(OptionID3,false)
DGS:dgsCheckBoxSetSelected(OptionID5,false)
DGS:dgsCheckBoxSetSelected(OptionID6,false)
DGS:dgsCheckBoxSetSelected(OptionID7,false)
DGS:dgsCheckBoxSetSelected(OptionID8,false)
end
elseif source == OptionID5 then 
if DGS:dgsCheckBoxGetSelected(source) then
DGS:dgsCheckBoxSetSelected(OptionID1,false)
DGS:dgsCheckBoxSetSelected(OptionID2,false)
DGS:dgsCheckBoxSetSelected(OptionID4,false)
DGS:dgsCheckBoxSetSelected(OptionID3,false)
DGS:dgsCheckBoxSetSelected(OptionID6,false)
DGS:dgsCheckBoxSetSelected(OptionID7,false)
DGS:dgsCheckBoxSetSelected(OptionID8,false)
end
elseif source == OptionID6 then 
if DGS:dgsCheckBoxGetSelected(source) then
DGS:dgsCheckBoxSetSelected(OptionID1,false)
DGS:dgsCheckBoxSetSelected(OptionID2,false)
DGS:dgsCheckBoxSetSelected(OptionID4,false)
DGS:dgsCheckBoxSetSelected(OptionID5,false)
DGS:dgsCheckBoxSetSelected(OptionID3,false)
DGS:dgsCheckBoxSetSelected(OptionID7,false)
DGS:dgsCheckBoxSetSelected(OptionID8,false)
end
elseif source == OptionID7 then 
if DGS:dgsCheckBoxGetSelected(source) then
DGS:dgsCheckBoxSetSelected(OptionID1,false)
DGS:dgsCheckBoxSetSelected(OptionID2,false)
DGS:dgsCheckBoxSetSelected(OptionID4,false)
DGS:dgsCheckBoxSetSelected(OptionID5,false)
DGS:dgsCheckBoxSetSelected(OptionID6,false)
DGS:dgsCheckBoxSetSelected(OptionID3,false)
DGS:dgsCheckBoxSetSelected(OptionID8,false)
end
elseif source == OptionID8 then 
if DGS:dgsCheckBoxGetSelected(source) then
DGS:dgsCheckBoxSetSelected(OptionID1,false)
DGS:dgsCheckBoxSetSelected(OptionID2,false)
DGS:dgsCheckBoxSetSelected(OptionID4,false)
DGS:dgsCheckBoxSetSelected(OptionID5,false)
DGS:dgsCheckBoxSetSelected(OptionID6,false)
DGS:dgsCheckBoxSetSelected(OptionID7,false)
DGS:dgsCheckBoxSetSelected(OptionID3,false)
end
end
end
end)

addEventHandler ("onDgsMouseEnter", root,
function ( )
if source == OptionID1 then
DGS:dgsSetProperty(OptionID1,"textColor", tocolor(255, 0, 0, 255))
elseif source == OptionID2 then
DGS:dgsSetProperty(OptionID2,"textColor", tocolor(255, 0, 0, 255))
elseif source == OptionID3 then
DGS:dgsSetProperty(OptionID3,"textColor", tocolor(255, 0, 0, 255))
elseif source == OptionID4 then
DGS:dgsSetProperty(OptionID4,"textColor", tocolor(255, 0, 0, 255))
elseif source == OptionID5 then
DGS:dgsSetProperty(OptionID5,"textColor", tocolor(255, 0, 0, 255))
elseif source == OptionID6 then
DGS:dgsSetProperty(OptionID6,"textColor", tocolor(255, 0, 0, 255))
elseif source == OptionID7 then
DGS:dgsSetProperty(OptionID7,"textColor", tocolor(255, 0, 0, 255))
elseif source == OptionID8 then
DGS:dgsSetProperty(OptionID8,"textColor", tocolor(255, 0, 0, 255))
end
end)

addEventHandler ("onDgsMouseLeave", root,
function ( )
if source == OptionID1 then
DGS:dgsSetProperty(OptionID1,"textColor", tocolor(255, 255, 255, 255))
elseif source == OptionID2 then
DGS:dgsSetProperty(OptionID2,"textColor", tocolor(255, 255, 255, 255))
elseif source == OptionID3 then
DGS:dgsSetProperty(OptionID3,"textColor", tocolor(255, 255, 255, 255))
elseif source == OptionID4 then
DGS:dgsSetProperty(OptionID4,"textColor", tocolor(255, 255, 255, 255))
elseif source == OptionID5 then
DGS:dgsSetProperty(OptionID5,"textColor", tocolor(255, 255, 255, 255))
elseif source == OptionID6 then
DGS:dgsSetProperty(OptionID6,"textColor", tocolor(255, 255, 255, 255))
elseif source == OptionID7 then
DGS:dgsSetProperty(OptionID7,"textColor", tocolor(255, 255, 255, 255))
elseif source == OptionID8 then
DGS:dgsSetProperty(OptionID8,"textColor", tocolor(255, 255, 255, 255))
end
end)