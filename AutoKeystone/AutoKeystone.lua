local OnShow = function()
	local ID

	for Bag = 0, NUM_BAG_SLOTS do
		for Slot = 1, GetContainerNumSlots(Bag) do
			ID = GetContainerItemID(Bag, Slot)

			if (ID and ID == 180653) then
				return UseContainerItem(Bag, Slot)
			end
		end
	end
end

local OnEvent = function(self, event, addon)
	if (addon ~= "Blizzard_ChallengesUI") then
		return
	end

	if ChallengesKeystoneFrame then
		local Frame = ChallengesKeystoneFrame

		Frame:HookScript("OnShow", OnShow)

		if (not Frame:IsMovable()) then
			Frame:SetMovable(true)
			Frame:RegisterForDrag("LeftButton")
			Frame:SetClampedToScreen(true)
			Frame:SetScript("OnDragStart", Frame.StartMoving)
			Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)
		end

		self:UnregisterEvent(event)
		self:SetScript("OnEvent", nil)
	end
end

local AutoKeystone = CreateFrame("Frame")
AutoKeystone:RegisterEvent("ADDON_LOADED")
AutoKeystone:SetScript("OnEvent", OnEvent)