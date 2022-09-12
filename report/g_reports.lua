--[[ //Chaos
~=~=~=~=~=~= ORGANIZED REPORTS FOR TG INFO =~=~=~=~=~=~
Name: The name to show once the report is submitted and in the F2 menu
Staff to send to: The Usergroup ID on the forums that you are sending the report to
Abbreviation: Used in the report identifier for the staff
r, g, b: The color for the report

I used the strings as the values instead of the keys, this way its easier for us to organize. 
{NAME, { Staff to send to }, Abbreviation, r, g, b} ]]

reportTypes = {
 	{"مشكلة مع لاعب", {18, 17, 64, 15, 14}, "PLY", 214, 6, 6, "استعملها اذا كنت ترغب في تقديم ابلاغ ضد لاعب" },
	{"مشكله بيت , محل", {18, 17, 64, 15, 14}, "INT", 255, 126, 0, "اذا كانت لديك مشكلة في بيت او محل استعملها" },
	{"مشكلة اغراض", {18, 17, 64, 15, 14}, "ITM", 255, 126, 0, "اذا كنت تحتاج الى اغراض او عندك مشكلة في غرض استعملها" },
	{"سؤال عام", {30, 18, 17, 64, 15, 14}, "SUP", 70, 200, 30, "اذا كان لديك سؤال استعملها" },
	{"مشاكل سيارات", {30, 18, 17, 64, 15, 14}, "VEH", 255, 126, 0, "اذا كنت تواجه مشكلة في سيارتك غير تصليح استعملها" },
	{"سحب سيارة", {39, 43}, "VCT", 176, 7, 237, "اتعملها لتتكلم مع فريق مسؤولين سيارات" },
	--{"Mapping Issue", {44, 28}, "MAP", 0, 0, 0 }, MAXIME IF YOU EVER WANT TO BRING THIS BACK, UNCOMMENT
	{"مشكله برمجيه", {32}, "ScrT", 148, 126, 12, "اذا كنت تريد تكلم مع فريق مبرمجين" },
}

adminTeams = exports.integration:getAdminStaffNumbers()
auxiliaryTeams = exports.integration:getAuxiliaryStaffNumbers()
SUPPORTER = exports.integration:getSupporterNumber()

function getReportInfo(row, element)
	if not isElement(element) then
		element = nil
	end

	local staff = reportTypes[row][2]
	local players = getElementsByType("player")
	local vcount = 0
	local scount = 0


	for k,v in ipairs(staff) do
		if v == 39 or v == 43 then

			for key, player in ipairs(players) do
				if exports.integration:isPlayerVCTMember(player) or exports.integration:isPlayerVehicleConsultant(player) then
					vcount = vcount + 1
					save = player
				end
			end

			if vcount==0 then
				return false, "There is currently no VCT Members online. Please contact them through skype at :Baiba168 and with message Trinity Gaming Request otherwise you will be ignored"
			elseif vcount==1 and save == element then -- Callback for checking if a aux staff logs out
				return false, "There is currently no VCT Members online. Please contact them through skype at :Baiba168 and with message Trinity Gaming Request otherwise you will be ignored"
			end
		elseif v == 32 then

			for key, player in ipairs(players) do
				if exports.integration:isPlayerScripter(player) then
					scount = scount + 1
					save = player
				end
			end

			if scount==0 then
				return false, "There is currently no members of the Scripting team online. Please contact them through skype at :Baiba168 and with message Trinity Gaming Request otherwise you will be ignored"
			elseif scount==1 and save == element then -- Callback for checking if a aux staff logs out
				return false, "There is currently no members of the Scripting team online. Please contact them through skype at :Baiba168 and with message Trinity Gaming Request otherwise you will be ignored"
			end
		end
	end

	local name = reportTypes[row][1]
	local abrv = reportTypes[row][3]
	local red = reportTypes[row][4]
	local green = reportTypes[row][5]
	local blue = reportTypes[row][6]

	return staff, false, name, abrv, red, green, blue
end

function isSupporterReport(row)
	local staff = reportTypes[row][2]

	for k, v in ipairs(staff) do
		if v == SUPPORTER then
			return true
		end
	end
	return false
end

function isAdminReport(row)
	local staff = reportTypes[row][2]

	for k, v in ipairs(staff) do
		if string.find(adminTeams, v) then
			return true
		end
	end
	return false
end

function isAuxiliaryReport(row)
	local staff = reportTypes[row][2]

	for k, v in ipairs(staff) do
		if string.find(auxiliaryTeams, v) then
			return true
		end
	end
	return false
end

function showExternalReportBox(thePlayer)
	if not thePlayer then return false end
	return (exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer)) and (getElementData(thePlayer, "report_panel_mod") == "2" or getElementData(thePlayer, "report_panel_mod") == "3")
end

function showTopRightReportBox(thePlayer)
	if not thePlayer then return false end
	return (exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer)) and (getElementData(thePlayer, "report_panel_mod") == "1" or getElementData(thePlayer, "report_panel_mod") == "3")
end