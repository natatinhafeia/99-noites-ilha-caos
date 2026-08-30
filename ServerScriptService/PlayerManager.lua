-- ServerScriptService > PlayerManager
-- Gerencia respawn, dano e eliminação de jogadores

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConfig = require(ReplicatedStorage.Modules.GameConfig)

-- Remote Events
local EventAnnouncement = ReplicatedStorage.RemoteEvents.EventAnnouncement

local spawnLocation = workspace.SpawnPoints.SpawnLocation

local function RespawnPlayer(player)
	if player.Character then
		player.Character:Destroy()
	end
	
	local humanoidRootPart = Instance.new("Part")
	humanoidRootPart.Name = "HumanoidRootPart"
	humanoidRootPart.Shape = Enum.PartType.Ball
	humanoidRootPart.Size = Vector3.new(2, 2, 1)
	humanoidRootPart.CanCollide = true
	
	local humanoid = Instance.new("Humanoid")
	humanoid.Parent = workspace
	humanoid.Parent = humanoidRootPart
	
	humanoidRootPart.CFrame = spawnLocation.CFrame + Vector3.new(0, 3, 0)
	humanoidRootPart.Parent = workspace
	
	local character = humanoidRootPart.Parent
	if character then
		character.Name = player.Name
		player.Character = character
	end
end

local function OnCharacterAdded(character, player)
	-- Adicionar humanoid e scripts
	if not character:FindFirstChild("Humanoid") then
		local humanoid = Instance.new("Humanoid")
		humanoid.Parent = character
	end
	
	-- Detectar morte
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.Died:Connect(function()
		wait(2)
		RespawnPlayer(player)
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		OnCharacterAdded(character, player)
	end)
end)

-- Respawn inicial
for _, player in pairs(Players:GetPlayers()) do
	RespawnPlayer(player)
end