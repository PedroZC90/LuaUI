local T, C, L = Tukui:unpack()
local ActionBars = T.ActionBars
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

local ceil = math.ceil

----------------------------------------------------------------
-- ActionBar3
----------------------------------------------------------------
local baseCreateBar3 = ActionBars.CreateBar3

function ActionBars:CreateBar3()
    -- first, we call the base function
    baseCreateBar3(self)

    -- second, we edit it
    if (not C.ActionBars.BottomRightBar) then return end

    local ActionBar3 = ActionBars.Bars.Bar3

    local MultiBarBottomRight = MultiBarBottomRight
    local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ButtonsPerRow = C.ActionBars.Bar3ButtonsPerRow
	local NumButtons = C.ActionBars.Bar3NumButtons
	
	if NumButtons <= ButtonsPerRow then
		ButtonsPerRow = NumButtons
	end
	
    local NumRow = ceil(NumButtons / ButtonsPerRow)
    local Width = (Size * ButtonsPerRow) + (Spacing * (ButtonsPerRow + 1)) + 2
	local Height = (Size * NumRow) + (Spacing * (NumRow + 1)) + 2
    
    ActionBar3:ClearAllPoints()
    ActionBar3:SetPoint("TOP", UIParent, "TOP", 0, -C.Lua.ScreenMargin)
    ActionBar3:SetWidth(Width)
	ActionBar3:SetHeight(Height)

    if (C.ActionBars.ShowBackdrop) then
        ActionBar3:SetBackdropTransparent()
        ActionBar3.Shadow:Kill()
    end

    local NumPerRows = ButtonsPerRow
	local NextRowButtonAnchor = _G["MultiBarBottomRightButton1"]

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomRightButton"..i]
		local PreviousButton = _G["MultiBarBottomRightButton"..i-1]
		
		Button:SetSize(Size, Size)
		Button:ClearAllPoints()
		Button:SetAttribute("showgrid", 1)
		Button:ShowGrid(ACTION_BUTTON_SHOW_GRID_REASON_EVENT)

		ActionBars:SkinButton(Button)
		
		if (i <= NumButtons) then
			if (i == 1) then
				Button:SetPoint("TOPLEFT", ActionBar3, "TOPLEFT", Spacing + 1, -Spacing -1)
			elseif (i == NumPerRows + 1) then
				Button:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -Spacing)

				NumPerRows = NumPerRows + ButtonsPerRow
				NextRowButtonAnchor = _G["MultiBarBottomRightButton"..i]
			else
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
			end
		else
			Button:SetPoint("TOP", UIParent, "TOP", 0, 200)
		end
	end
end
