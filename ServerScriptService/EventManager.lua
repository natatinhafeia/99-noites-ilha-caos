-- ServerScriptService > EventManager
-- Gerencia eventos aleatórios durante a rodada

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local GameConfig = require(ReplicatedStorage.Modules.GameConfig)
local GameState = require(ReplicatedStorage.Modules.GameState)
local EventAnnouncement = ReplicatedStorage.RemoteEvents.EventAnnouncement

local eventActive = false
local eventTimers = {}

local events = {
	{
		Name = "Tempestade",
		Description = "Uma tempestade terrível surge! Visibilidade reduzida.",
		Duration = 15,
		Effect = function()
			EventAnnouncement:FireAllClients("Tempestade", "Tempestade chegando! Visibilidade reduzida.")
			
			-- Criar efeito de neblina
			local atmosphere = Workspace.Atmosphere
			if atmosphere then
				atmosphere.Density = 0.3
			end
			
			wait(15)
			
			if atmosphere then
				atmosphere.Density = 0.1
			end
		end
	},
	{
		Name = "Meteoro",
		Description = "Chuva de meteoros! Cuidado onde pisa.",
		Duration = 10,
		Effect = function()
			EventAnnouncement:FireAllClients("Meteoro", "Meteoros caindo do céu! Desvie!")
			
			for i = 1, 10 do
				local meteor = Instance.new("Part")
				meteor.Name = "Meteor"
				meteor.Shape = Enum.PartType.Ball
				meteor.Size = Vector3.new(1, 1, 1)
				meteor.Color = Color3.fromRGB(200, 100, 0)
				
				local randomX = math.random(-50, 50)
				local randomZ = math.random(-50, 50)
				meteor.CFrame = CFrame.new(randomX, 50, randomZ)
				meteor.Parent = Workspace
				
				local velocity = Instance.new("BodyVelocity")
				velocity.Velocity = Vector3.new(0, -20, 0)
				velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				velocity.Parent = meteor
				
				game:GetService("Debris"):AddItem(meteor, 3)
				
				wait(0.3)
			end
		end
	},
	{
		Name = "Apagão",
		Description = "A eletricidade falha! Escuridão total.",
		Duration = 8,
		Effect = function()
			EventAnnouncement:FireAllClients("Apagão", "Luzes apagadas! Confusão absoluta.")
			
			local lighting = game:GetService("Lighting")
			local originalBrightness = lighting.Brightness
			lighting.Brightness = 0.2
			
			wait(8)
			
			lighting.Brightness = originalBrightness
		end
	},
	{
		Name = "Terremoto",
		Description = "O chão tremendo! Tudo se move.",
		Duration = 5,
		Effect = function()
			EventAnnouncement:FireAllClients("Terremoto", "Terremoto! Equilibre-se!")
			
			for i = 1, 20 do
				local terrain = Workspace.Terrain
				if terrain then
					local parts = Workspace:GetChildren()
					for _, part in pairs(parts) do
						if part:IsA("BasePart") then
							part.CFrame = part.CFrame * CFrame.new(math.random(-1, 1)/10, 0, math.random(-1, 1)/10)
						end
					end
				end
				wait(0.1)
			end
		end
	},
	{
		Name = "Invasão de Criaturas",
		Description = "Criaturas estranhas aparecem!",
		Duration = 12,
		Effect = function()
			EventAnnouncement:FireAllClients("Invasão", "Criaturas aparecem! Corram!")
			
			-- Criar blocos como criaturas
			for i = 1, 5 do
				local creature = Instance.new("Part")
				creature.Name = "Creature"
				creature.Size = Vector3.new(1.5, 2, 1)
				creature.Color = Color3.fromRGB(100, 0, 100)
				creature.CanCollide = true
				
				local randomX = math.random(-40, 40)
				local randomZ = math.random(-40, 40)
				creature.CFrame = CFrame.new(randomX, 5, randomZ)
				creature.Parent = Workspace
				
				game:GetService("Debris"):AddItem(creature, 12)
				
				wait(0.2)
			end
		end
	}
}

-- Executar evento aleatório
local function TriggerRandomEvent()
	if eventActive or not GameState.IsGameActive() then
		return
	end
	
	eventActive = true
	local randomEvent = events[math.random(1, #events)]
	
	if randomEvent.Effect then
		pcall(function()
			randomEvent.Effect()
		end)
	end
	
	eventActive = false
end

-- Loop de eventos
spawn(function()
	while true do
		wait(GameConfig.EVENT_INTERVAL)
		
		if GameState.IsGameActive() then
			TriggerRandomEvent()
		end
	end
end)