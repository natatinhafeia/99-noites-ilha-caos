-- ServerScriptService > VotingSystem
-- Sistema de votação para acusar Agente do Caos

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CastVote = ReplicatedStorage.RemoteEvents.CastVote
local VotingResults = ReplicatedStorage.RemoteEvents.VotingResults
local GameConfig = require(ReplicatedStorage.Modules.GameConfig)

local votes = {}
local votingActive = false

-- Iniciar votação
local function StartVoting()
	votingActive = true
	votes = {}
	
	-- Resetar votos
	for _, player in pairs(Players:GetPlayers()) do
		votes[player.UserId] = nil
	end
	
	print("[VotingSystem] Votação iniciada!")
	
	wait(GameConfig.VOTING_DURATION)
	
	EndVoting()
end

-- Terminar votação
function EndVoting()
	votingActive = false
	
	-- Contar votos
	local voteCount = {}
	for userId, votedFor in pairs(votes) do
		if votedFor then
			voteCount[votedFor] = (voteCount[votedFor] or 0) + 1
		end
	end
	
	-- Encontrar voto máximo
	local maxVotes = 0
	local mostVoted = nil
	
	for userId, count in pairs(voteCount) do
		if count > maxVotes then
			maxVotes = count
			mostVoted = userId
		end
	end
	
	-- Enviar resultados
	if mostVoted then
		VotingResults:FireAllClients(mostVoted, maxVotes)
	else
		VotingResults:FireAllClients(nil, 0)
	end
	
	print("[VotingSystem] Votação encerrada. Voto máximo: " .. tostring(maxVotes))
end

-- Processar voto
CastVote.OnServerEvent:Connect(function(player, votedForUserId)
	if votingActive and not votes[player.UserId] then
		votes[player.UserId] = votedForUserId
		print("[VotingSystem] " .. player.Name .. " votou em alguém")
	end
end)

-- Iniciar votação a cada intervalo
spawn(function()
	while true do
		wait(GameConfig.VOTING_INTERVAL)
		if not votingActive then
			StartVoting()
		end
	end
end)