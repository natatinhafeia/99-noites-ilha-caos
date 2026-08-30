-- SETUP AUTOMÁTICO DO JOGO
-- Cole este script na Command Bar do Roblox Studio para instalar tudo automaticamente
-- View > Command Bar (ou Ctrl+Shift+P)

local RS = game:GetService("ReplicatedStorage")
local SSS = game:GetService("ServerScriptService")
local SG = game:GetService("StarterGui")
local SP = game:GetService("StarterPlayer")

print("🎮 Iniciando setup automático de '99 Noites: Ilha do Caos'...")

-- Criar pastas necessárias
local function CreateFolder(parent, name)
	if not parent:FindFirstChild(name) then
		local folder = Instance.new("Folder")
		folder.Name = name
		folder.Parent = parent
		return folder
	else
		return parent:FindFirstChild(name)
	end
end

-- Criar RemoteEvents
local remoteEventsFolder = CreateFolder(RS, "RemoteEvents")
local remoteFunctionFolder = CreateFolder(RS, "RemoteFunction")

local events = {
	"UpdateUI", "ShowRole", "CastVote", "EventAnnouncement",
	"CollectPart", "GameEnd", "VotingResults"
}

for _, eventName in pairs(events) do
	if not remoteEventsFolder:FindFirstChild(eventName) then
		local event = Instance.new("RemoteEvent")
		event.Name = eventName
		event.Parent = remoteEventsFolder
		print("✓ Criado RemoteEvent: " .. eventName)
	end
end

if not remoteFunctionFolder:FindFirstChild("RequestGameState") then
	local func = Instance.new("RemoteFunction")
	func.Name = "RequestGameState"
	func.Parent = remoteFunctionFolder
	print("✓ Criado RemoteFunction: RequestGameState")
end

-- Criar Modules
local modulesFolder = CreateFolder(RS, "Modules")

local modules = {
	GameConfig = true,
	GameState = true,
	Utils = true,
	CurrencySystem = true
}

for moduleName, _ in pairs(modules) do
	if not modulesFolder:FindFirstChild(moduleName) then
		local module = Instance.new("ModuleScript")
		module.Name = moduleName
		module.Parent = modulesFolder
		print("✓ Criado Module: " .. moduleName)
	end
end

-- Criar Workspace folders
local mapFolder = CreateFolder(workspace, "Map")
local spawnPointsFolder = CreateFolder(workspace, "SpawnPoints")
local partSpawnsFolder = CreateFolder(workspace, "PartSpawns")
local gamePartsFolder = CreateFolder(workspace, "GameParts")

print("✓ Pastas do Workspace criadas")

-- Criar SpawnLocation
if not spawnPointsFolder:FindFirstChild("SpawnLocation") then
	local spawn = Instance.new("SpawnLocation")
	spawn.Name = "SpawnLocation"
	spawn.Size = Vector3.new(20, 1, 20)
	spawn.Color = Color3.fromRGB(0, 255, 0)
	spawn.CanCollide = true
	spawn.CFrame = CFrame.new(0, 5, 30)
	spawn.Duration = 0
	spawn.Parent = spawnPointsFolder
	print("✓ SpawnLocation criado")
end

-- Criar Part Spawns
if #partSpawnsFolder:GetChildren() == 0 then
	for i = 1, 8 do
		local spawn = Instance.new("Part")
		spawn.Name = "Spawn" .. i
		spawn.Size = Vector3.new(2, 1, 2)
		spawn.Color = Color3.fromRGB(255, 255, 0)
		spawn.Material = Enum.Material.Neon
		spawn.CanCollide = false
		spawn.Transparency = 0.5
		
		local angle = (i / 8) * math.pi * 2
		local radius = 40
		local x = math.cos(angle) * radius
		local z = math.sin(angle) * radius
		
		spawn.CFrame = CFrame.new(x, 2, z)
		spawn.Parent = partSpawnsFolder
	end
	print("✓ 8 Part Spawns criados")
end

-- Criar boat structure
if not mapFolder:FindFirstChild("BoatHull") then
	local boatPart1 = Instance.new("Part")
	boatPart1.Name = "BoatHull"
	boatPart1.Size = Vector3.new(10, 3, 20)
	boatPart1.Color = Color3.fromRGB(139, 90, 43)
	boatPart1.Material = Enum.Material.Wood
	boatPart1.CFrame = CFrame.new(0, 2, -50)
	boatPart1.Parent = mapFolder
	
	local boatPart2 = Instance.new("Part")
	boatPart2.Name = "BoatMast"
	boatPart2.Size = Vector3.new(1, 15, 1)
	boatPart2.Color = Color3.fromRGB(100, 100, 100)
	boatPart2.Material = Enum.Material.Metal
	boatPart2.CFrame = CFrame.new(0, 10, -50)
	boatPart2.Parent = mapFolder
	
	print("✓ Barco criado")
end

-- Criar ScreenGui
if not SG:FindFirstChild("ScreenGui") then
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ScreenGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = SG
	
	-- InfoPanel
	local infoPanel = Instance.new("Frame")
	infoPanel.Name = "InfoPanel"
	infoPanel.Size = UDim2.new(0.3, 0, 0.2, 0)
	infoPanel.Position = UDim2.new(0, 10, 0, 10)
	infoPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	infoPanel.BorderSizePixel = 0
	infoPanel.Parent = screenGui
	
	local timerLabel = Instance.new("TextLabel")
	timerLabel.Name = "TimerLabel"
	timerLabel.Size = UDim2.new(1, 0, 0.25, 0)
	timerLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	timerLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
	timerLabel.Text = "Tempo: 300s"
	timerLabel.TextSize = 18
	timerLabel.Font = Enum.Font.GothamBold
	timerLabel.Parent = infoPanel
	
	local objectiveLabel = Instance.new("TextLabel")
	objectiveLabel.Name = "ObjectiveLabel"
	objectiveLabel.Size = UDim2.new(1, 0, 0.25, 0)
	objectiveLabel.Position = UDim2.new(0, 0, 0.25, 0)
	objectiveLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	objectiveLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
	objectiveLabel.Text = "Objetivo: Colete as peças"
	objectiveLabel.TextSize = 14
	objectiveLabel.Font = Enum.Font.Gotham
	objectiveLabel.Parent = infoPanel
	
	local partsLabel = Instance.new("TextLabel")
	partsLabel.Name = "PartsCollected"
	partsLabel.Size = UDim2.new(1, 0, 0.25, 0)
	partsLabel.Position = UDim2.new(0, 0, 0.5, 0)
	partsLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	partsLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
	partsLabel.Text = "Peças: 0/8"
	partsLabel.TextSize = 14
	partsLabel.Font = Enum.Font.Gotham
	partsLabel.Parent = infoPanel
	
	local coinLabel = Instance.new("TextLabel")
	coinLabel.Name = "CoinDisplay"
	coinLabel.Size = UDim2.new(1, 0, 0.25, 0)
	coinLabel.Position = UDim2.new(0, 0, 0.75, 0)
	coinLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	coinLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	coinLabel.Text = "Moedas: 0"
	coinLabel.TextSize = 14
	coinLabel.Font = Enum.Font.Gotham
	coinLabel.Parent = infoPanel
	
	-- RolePanel
	local rolePanel = Instance.new("Frame")
	rolePanel.Name = "RolePanel"
	rolePanel.Size = UDim2.new(0.4, 0, 0.15, 0)
	rolePanel.Position = UDim2.new(0.3, 0, 0.4, 0)
	rolePanel.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
	rolePanel.Visible = false
	rolePanel.Parent = screenGui
	
	local roleLabel = Instance.new("TextLabel")
	roleLabel.Name = "TextLabel"
	roleLabel.Size = UDim2.new(1, 0, 1, 0)
	roleLabel.BackgroundTransparency = 1
	roleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	roleLabel.Text = "Você é um SOBREVIVENTE"
	roleLabel.TextSize = 24
	roleLabel.Font = Enum.Font.GothamBold
	roleLabel.Parent = rolePanel
	
	-- EventAnnouncement
	local eventAnnounce = Instance.new("TextLabel")
	eventAnnounce.Name = "EventAnnouncement"
	eventAnnounce.Size = UDim2.new(1, 0, 0.1, 0)
	eventAnnounce.Position = UDim2.new(0, 0, 0.45, 0)
	eventAnnounce.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
	eventAnnounce.TextColor3 = Color3.fromRGB(255, 100, 100)
	eventAnnounce.Text = "Evento: Tempestade!"
	eventAnnounce.TextSize = 20
	eventAnnounce.Font = Enum.Font.GothamBold
	eventAnnounce.Visible = false
	eventAnnounce.Parent = screenGui
	
	-- GameEndScreen
	local gameEndScreen = Instance.new("Frame")
	gameEndScreen.Name = "GameEndScreen"
	gameEndScreen.Size = UDim2.new(0.5, 0, 0.3, 0)
	gameEndScreen.Position = UDim2.new(0.25, 0, 0.35, 0)
	gameEndScreen.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	gameEndScreen.Visible = false
	gameEndScreen.Parent = screenGui
	
	local resultLabel = Instance.new("TextLabel")
	resultLabel.Name = "ResultLabel"
	resultLabel.Size = UDim2.new(1, 0, 0.5, 0)
	resultLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	resultLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	resultLabel.Text = "RESULTADO"
	resultLabel.TextSize = 28
	resultLabel.Font = Enum.Font.GothamBold
	resultLabel.Parent = gameEndScreen
	
	local reasonLabel = Instance.new("TextLabel")
	reasonLabel.Name = "ReasonLabel"
	reasonLabel.Size = UDim2.new(1, 0, 0.5, 0)
	reasonLabel.Position = UDim2.new(0, 0, 0.5, 0)
	reasonLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	reasonLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
	reasonLabel.Text = "Motivo: Teste"
	reasonLabel.TextSize = 16
	reasonLabel.Font = Enum.Font.Gotham
	reasonLabel.Parent = gameEndScreen
	
	print("✓ ScreenGui criada com todos os elementos")
end

print("\n✅ SETUP COMPLETO!")
print("\nPróximos passos:")
print("1. Copie os scripts Lua do repositório para os arquivos correspondentes")
print("2. Clique em Run (F5) para testar o jogo")
print("3. Abra 2-3 abas para testar multiplayer")
print("\nRepositório: https://github.com/natatinhafeia/99-noites-ilha-caos")
