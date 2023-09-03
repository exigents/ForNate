--> Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

--> Class
local DataHandler = {}

function DataHandler.AddClicks(player: Player, Amount: number)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Clicks = PlayerData:FindFirstChild("Clicks")

	if tonumber(Amount) then
		Clicks.Value += tonumber(Amount)
	end
end

function DataHandler.RemoveClicks(player: Player, Amount: number)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Clicks = PlayerData:FindFirstChild("Clicks")

	if tonumber(Amount) then
		Clicks.Value -= Amount
	end
end

function DataHandler.AddGems(player: Player, Amount: number)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Gems = PlayerData:FindFirstChild("Gems")

	if tonumber(Amount) then
		Gems.Value += tonumber(Amount)
	end
end

function DataHandler.RemoveGems(player: Player, Amount: number)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Gems = PlayerData:FindFirstChild("Gems")

	if tonumber(Amount) then
		Gems.Value -= Amount
	end
end

function DataHandler.AddRebirths(player: Player, Amount: number)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Rebirths = PlayerData:FindFirstChild("Rebirths")

	if tonumber(Amount) then
		Rebirths.Value += tonumber(Amount)
	end
end

function DataHandler.RemoveRebirths(player: Player, Amount: number)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Rebirths = PlayerData:FindFirstChild("Rebirths")

	if tonumber(Amount) then
		Rebirths.Value -= Amount
	end
end

function DataHandler.AddPet(player: Player, PetName: string, level: number, xp: number, PetId: string?)
	local PetInstance = Instance.new("Folder")
	local PetName = Instance.new("StringValue")
	local PetLevel = Instance.new("NumberValue")
	local PetXP = Instance.new("NumberValue")
	
	PetInstance.Name = (PetId ~= nil and PetId) or (PetId == nil and HttpService:GenerateGUID(false))
	PetName.Name = "PetName"
	PetName.Value = PetName
	PetLevel.Name = "Level"
	PetLevel.Value = tonumber(level) or 1
	PetXP.Name = "XP"
	PetXP.Value = tonumber(xp) or 0
	PetLevel.Parent = PetInstance
	PetXP.Parent = PetInstance
	PetName.Parent = PetInstance
	
	PetInstance.Parent = player:FindFirstChild("PlayerData"):FindFirstChild("Pets")
end

function DataHandler.RemovePet(player: Player, PetId: string)
	local PlayerData = player:FindFirstChild("PlayerData")
	local PlayerPets = PlayerData:FindFirstChild("Pets")
	
	if PlayerPets:FindFirstChild(PetId) then
		PlayerPets:FindFirstChild(PetId):Destroy()
	end
end

function DataHandler.AddRebirthButton(player: Player, Button: string)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Buttons = PlayerData:FindFirstChild("RebirthButtons")
	
	if Buttons:FindFirstChild(Button) then return end
	
	local Inst = Instance.new("StringValue")
	Inst.Name = Button
	Inst.Value = Button
	Inst.Parent = Buttons
end

function DataHandler.RemoveRebirthButton(player: Player, Button: string)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Buttons = PlayerData:FindFirstChild("RebirthButtons")
	
	if Buttons:FindFirstChild(Button) then
		Buttons:FindFirstChild(Button):Destroy()
	end
end

function DataHandler.AddWorld(player: Player, World: string)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Worlds = PlayerData:FindFirstChild("Worlds")
	
	if Worlds:FindFirstChild(World) then return end
	
	local Inst = Instance.new("StringValue")
	Inst.Name = World
	Inst.Value = World
	Inst.Parent = Worlds
end

function DataHandler.RemoveWorld(player: Player, World: string)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Worlds = PlayerData:FindFirstChild("Worlds")
	
	if Worlds:FindFirstChild(World) then
		Worlds:FindFirstChild(World):Destroy()
	end
end

function DataHandler.AddArea(player: Player, Area: string)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Areas = PlayerData:FindFirstChild("Areas")
	
	if Areas:FindFirstChild(Area) then return end
	
	local Inst = Instance.new("StringValue")
	Inst.Name = Area
	Inst.Value = Area
	Inst.Parent = Areas
end

function DataHandler.RemoveArea(player: Player, Area: string)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Areas = PlayerData:FindFirstChild("Areas")
	
	if Areas:FindFirstChild(Area) then
		Areas:FindFirstChild(Area):Destroy()
	end
end

function DataHandler.AddCode(player: Player, Code: string)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Codes = PlayerData:FindFirstChild("Codes")
	
	if Codes:FindFirstChild(Code) then return end
	
	local Inst = Instance.new("StringValue")
	
	Inst.Name = Code
	Inst.Value = Code
	Inst.Parent = Codes
end

function DataHandler.RemoveCode(player: Player, Code: string)
	local PlayerData = player:FindFirstChild("PlayerData")
	local Codes = PlayerData:FindFirstChild("Codes")
	
	if Codes:FindFirstChild(Code) then
		Codes:FindFirstChild(Code):Destroy()
	end
end

return DataHandler
