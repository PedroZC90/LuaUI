local T, C, L = Tukui:unpack()

----------------------------------------------------------------
-- Development (write anything here)
----------------------------------------------------------------
local Enable = true
if (not Enable) then return end

local Options = {
    ["showSolo"] = true,
    ["iconSize"] = 16,
}

local playerGUID = UnitGUID("player")

local CombatLogHandler = function(self)
    local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID,
    spellName, spellSchool, amount, overkill, school, resisted, blocked,
    absorbed, critical, glancing, crushing = CombatLogGetCurrentEventInfo()

    T.Print(eventType, sourceName, destName, spellName .. "[" .. spellID .. "]")
end

local OnEvent = function(self, event, ...)
    if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
        CombatLogHandler(self)
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", OnEvent)