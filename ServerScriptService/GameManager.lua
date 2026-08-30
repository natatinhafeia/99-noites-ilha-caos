-- ServerScriptService > GameManager
-- Script principal que controla todo o jogo

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Modules
local GameConfig = require(ReplicatedStorage.Modules.GameConfig)
local GameState = require(ReplicatedStorage.Modules.GameState)
local Utils = require(ReplicatedStorage.Modules.Utils)
local CurrencySystem = require(ReplicatedStorage.Modules.CurrencySystem)

-- Remote Events
local UpdateUI = ReplicatedStorage.RemoteEvents.UpdateUI
local ShowRole = ReplicatedStorage.RemoteEvents.ShowRole
local EventAnnouncement = ReplicatedStorage.RemoteEvents.EventAnnouncement
local GameEnd = ReplicatedStorage.RemoteEvents.GameEnd
local CollectPart = ReplicatedStorage.RemoteEvents.CollectPart
local RequestGameState = ReplicatedStorage.RemoteFunction.RequestGameState

-- Variables
local gameActive = false
local currentRound = 0
local chaosAgent = nil
local collectedParts = {}
local playersData = {}

-- Inicializar sistema de moedas para novo jogador
local function InitializePlayerData(player)
	if not playersData[player.UserId] then
		playersData[player.UserId] = {
			UserId = player.UserId,
			Name = player.Name,
			Coins = 0,
			Wins = 0,
			Level = 1,
			Role = "Survivor",
			Voted = false,
			IsAlive = true,
		}
	end
	CurrencySystem.InitializePlayer(player)
end

-- Escolher Agente do Caos aleatoriamente
local function SelectChaosAgent()
	local activePlayers = {}
	for _, player in pairs(Players:GetPlayers()) do
		if playersData[player.UserId] and playersData[player.UserId].IsAlive then
			table.insert(activePlayers, player)
		end
	end
	
	if #activePlayers > 0 then
		chaosAgent = activePlayers[math.random(1, #activePlayers)]
		playersData[chaosAgent.UserId].Role = "ChaosAgent"
		return chaosAgent
	end
	return nil
end

-- Resetar dados de jogadores
local function ResetPlayersForRound()
	for userId, data in pairs(playersData) do
		data.Role = "Survivor"
		data.Voted = false
		data.IsAlive = true
	end
	collectedParts = {}
	chaosAgent = nil
end

-- Distribuir peças no mapa
local function SpawnParts()
	local partSpawns = workspace.PartSpawns:GetChildren()
	local gameParts = workspace.GameParts
	
	-- Limpar partes antigas
	for _, part in pairs(gameParts:GetChildren()) do
		part:Destroy()
	end
	
	for i = 1, GameConfig.PARTS_TO_COLLECT do
		if i <= #partSpawns then
			local spawn = partSpawns[i]
			local part = Instance.new("Part")
			part.Name = "BoatPart_" .. i
			part.Shape = Enum.PartType.Ball
			part.Size = Vector3.new(0.6, 0.6, 0.6)
			part.Color = Color3.fromRGB(255, 200, 0)
			part.Material = Enum.Material.Neon
			part.CanCollide = true
			part.CFrame = spawn.CFrame + Vector3.new(0, 2, 0)
			part.Parent = gameParts
			
			-- Touch event para coletar
			local touched = false
			part.Touched:Connect(function(hit)
				if not touched and gameActive then
					local character = hit.Parent
					local player = Players:GetPlayerFromCharacter(character)
					if player then
						touched = true
						table.insert(collectedParts, i)
						CollectPart:FireClient(player, i)
						part:Destroy()
						
						-- Atualizar UI para todos
						UpdateUI:FireAllClients("PartsCollected", #collectedParts)
						
						-- Verificar se todos os objetos foram coletados
						if #collectedParts >= GameConfig.PARTS_TO_COLLECT then
							TriggerGameEnd("SurvivorsWin")
						end
					end
				end
			end)
		end
	end
end

-- Iniciar rodada
local function StartRound()
	if #Players:GetPlayers() < GameConfig.MIN_PLAYERS then
		return
	end
	
	currentRound = currentRound + 1
	gameActive = false
	
	ResetPlayersForRound()
	SelectChaosAgent()
	SpawnParts()
	
	-- Revelar role secretamente para cada jogador
	for _, player in pairs(Players:GetPlayers()) do
		local role = playersData[player.UserId].Role
		local agentName = nil
		if role == "ChaosAgent" then
			agentName = chaosAgent.Name
		end
		ShowRole:FireClient(player, role, agentName)
	end
	
	-- Contar regressivamente
	for countdown = GameConfig.COUNTDOWN_TIME, 1, -1 do
		UpdateUI:FireAllClients("Timer", countdown)
		wait(1)
	end
	
	gameActive = true
	GameState.SetGameActive(true)
	UpdateUI:FireAllClients("Timer", GameConfig.ROUND_DURATION)
	
	-- Duração da rodada
	for remaining = GameConfig.ROUND_DURATION, 1, -1 do
		UpdateUI:FireAllClients("Timer", remaining)
		wait(1)
	end
	
	-- Tempo expirou
	TriggerGameEnd("TimeExpired")
end

-- Terminar jogo
function TriggerGameEnd(reason)
	gameActive = false
	GameState.SetGameActive(false)
	
	local survivors = {}
	local winner = nil
	
	if reason == "SurvivorsWin" then
		-- Sobreviventes venceram (coletaram todas as peças)
		for userId, data in pairs(playersData) do
			if data.Role == "Survivor" then
				table.insert(survivors, userId)
				data.Wins = data.Wins + 1
				CurrencySystem.AddCoins(userId, GameConfig.SURVIVOR_REWARD)
			end
		end
		winner = "Survivors"
	elseif reason == "ChaosAgentWins" or reason == "TimeExpired" then
		-- Agente do Caos venceu (tempo expirou ou sabotou)
		if chaosAgent then
			playersData[chaosAgent.UserId].Wins = playersData[chaosAgent.UserId].Wins + 1
			CurrencySystem.AddCoins(chaosAgent.UserId, GameConfig.CHAOS_AGENT_REWARD)
		end
		winner = "ChaosAgent"
	elseif reason == "ChaosAgentEliminated" then
		-- Sobreviventes descobriram o Agente do Caos
		for userId, data in pairs(playersData) do
			if data.Role == "Survivor" then
				table.insert(survivors, userId)
				data.Wins = data.Wins + 1
				CurrencySystem.AddCoins(userId, GameConfig.SURVIVOR_REWARD + 50)
			end
		end
		winner = "Survivors"
	end
	
	-- Notificar todos os jogadores
	GameEnd:FireAllClients(winner, reason, playersData)
	
	wait(GameConfig.RESULTS_DISPLAY_TIME)
	
	-- Preparar próxima rodada
	wait(2)
	StartRound()
end

-- Quando um jogador entra
local function OnPlayerAdded(player)
	InitializePlayerData(player)
	
	-- Enviar estado do jogo quando solicitar
	RequestGameState.OnServerInvoke = function()
		return {
			GameActive = gameActive,
			CurrentRound = currentRound,
			Coins = playersData[player.UserId].Coins,
			Wins = playersData[player.UserId].Wins,
			Level = playersData[player.UserId].Level,
			PartCollected = #collectedParts,
		}
	end
	
	print("Jogador adicionado: " .. player.Name)
end

-- Quando um jogador sai
local function OnPlayerRemoving(player)
	if playersData[player.UserId] then
		playersData[player.UserId] = nil
	end
	
	-- Se era o Agente do Caos, os sobreviventes vencem
	if chaosAgent == player and gameActive then
		TriggerGameEnd("ChaosAgentEliminated")
	end
	
	print("Jogador removido: " .. player.Name)
end

-- Conectar eventos
Players.PlayerAdded:Connect(OnPlayerAdded)
Players.PlayerRemoving:Connect(OnPlayerRemoving)

-- Iniciar primeira rodada quando há jogadores suficientes
while true do
	wait(2)
	if #Players:GetPlayers() >= GameConfig.MIN_PLAYERS and not gameActive then
		StartRound()
	end
end
