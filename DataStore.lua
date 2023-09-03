--> Services
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--> DataStore
local GlobalData: GlobalDataStore = DataStoreService:GetDataStore("SimData1", "UserData")
local Cache = {}

--> Data Template
local Template = {
	Clicks = 0,
	Gems = 1000,
	Rebirths = 0,
	Auto = {
		Active = false,
		Duration = 0,
	},
	RebirthButtons = {
		"1",
		"5",
		"10",
	},
	Worlds = {"Home", "Overworld"},
	Areas = {},
	Codes = {},
}

--> Local Functions
local function makeInstance(tbl, parent)
	for i,v in pairs(tbl) do
		if type(v) == "table" then
			local Folder = Instance.new("Folder")
			Folder.Name = i
			Folder.Parent = parent
			makeInstance(v, Folder)
		end
		if type(v) ~= "table" then
			if type(v) == "number" then
				local Ins = Instance.new("NumberValue")
				Ins.Name = i
				Ins.Value = v
				Ins.Parent = parent
			elseif type(v) == "string" then
				local ins = Instance.new("StringValue")
				ins.Name = i
				ins.Value = v
				ins.Parent = parent
			elseif type(v) == "boolean" then
				local ins = Instance.new("BoolValue")
				ins.Name = i
				ins.Value = v
				ins.Parent = parent
			end
		end
	end
end

local function LoadData(player: Player)
	local UserId = player.UserId
	
	local succ, Data = pcall(function()
		return GlobalData:GetAsync(UserId)
	end)
	
	if succ == true then
		if Data ~= nil then
			return Data
		elseif Data == nil then
			if Cache[UserId] == nil then
				return Template
			else
				return Cache[UserId]
			end
		end
	elseif succ == false then
		if Cache[UserId] == nil then
			return Template
		else
			return Cache[UserId]
		end
	end
end

local function MakeLeaderstats(player: Player, DataFolder)
	local leaderstats = Instance.new("Folder")
	local Clicks = Instance.new("NumberValue")
	local Gems = Instance.new("NumberValue")
	local Rebirths = Instance.new("Folder")
	
	Clicks.Name = "Clicks"
	Gems.Name = "Gems"
	Rebirths.Name = "Rebirths"
	leaderstats.Name = "leaderstats"
	
	Clicks.Value = DataFolder:FindFirstChild("Clicks").Value
	Gems.Value = DataFolder:FindFirstChild("Gems").Value
	Rebirths.Value = DataFolder:FindFirstChild("Rebirths").Value
	
	Clicks.Parent = leaderstats
	Gems.Parent = leaderstats
	Rebirths.Parent = leaderstats
	
	return leaderstats
end


local function PlayerAdded(player: Player)
	local Data = LoadData(player)
	
	local DataFolder = Instance.new("Folder")
	DataFolder.Name = "PlayerData"
	DataFolder.Parent = player
	
	makeInstance(Data, DataFolder)
	
	local leaderstats = MakeLeaderstats(player, DataFolder)
	
	leaderstats.Parent = player
end

local function PlayerRemoving(player: Player)
	local DataFolder = player:FindFirstChild("PlayerData")
	local DataTable = {
		Clicks = DataFolder:FindFirstChild("Clicks").Value,
		Gems = DataFolder:FindFirstChild("Gems").Value,
		Rebirths = DataFolder:FindFirstChild("Rebirths").Value,
		Auto = {
			Active = DataFolder:FindFirstChild("Auto"):FindFirstChild("Active").Value,
			Duration = DataFolder:FindFirstChild("Auto"):FindFirstChild("Duration").Value,
		},
		RebirthButtons = {},
		Worlds = {},
		Areas = {},
		Codes = {},
	}
	
	for _, v in pairs(DataFolder:FindFirstChild("RebirthButtons"):GetChildren()) do
		table.insert(DataTable.RebirthButtons, v.Value)
	end
	for _, v in pairs(DataFolder:FindFirstChild("Worlds"):GetChildren()) do
		table.insert(DataTable.Worlds, v.Value)
	end
	for _, v in pairs(DataFolder:FindFirstChild("Areas"):GetChildren()) do
		table.insert(DataTable.Areas, v.Value)
	end
	for _, v in pairs(DataFolder:FindFirstChild("Codes"):GetChildren()) do
		table.insert(DataTable.Codes, v.Value)
	end
	
	local succ, err = pcall(function()
		GlobalData:SetAsync(player.UserId, DataTable)
	end)
	
	Cache[player.UserId] = DataTable
end

game:BindToClose(function()
	for _, p in pairs(Players:GetPlayers()) do
		PlayerRemoving(p)
	end
	for UserId, Data in pairs(Cache) do
		GlobalData:SetAsync(UserId, Data)
	end
end)

Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(PlayerRemoving)
