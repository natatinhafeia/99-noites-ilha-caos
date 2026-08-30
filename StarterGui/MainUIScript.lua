-- StarterGui > ScreenGui > MainUIScript (LocalScript)
-- Interface principal do jogo

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remote Events
local UpdateUI = ReplicatedStorage.RemoteEvents.UpdateUI
local ShowRole = ReplicatedStorage.RemoteEvents.ShowRole
local EventAnnouncement = ReplicatedStorage.RemoteEvents.EventAnnouncement
local GameEnd = ReplicatedStorage.RemoteEvents.GameEnd
local CastVote = ReplicatedStorage.RemoteEvents.CastVote
local RequestGameState = ReplicatedStorage.RemoteFunction.RequestGameState

-- UI Elements
local screenGui = playerGui:WaitForChild("ScreenGui")
local infoPanel = screenGui:WaitForChild("InfoPanel")
local timerLabel = infoPanel:WaitForChild("TimerLabel")
local partsLabel = infoPanel:WaitForChild("PartsCollected")
local coinLabel = infoPanel:WaitForChild("CoinDisplay")
local objectiveLabel = infoPanel:WaitForChild("ObjectiveLabel")
local rolePanel = screenGui:WaitForChild("RolePanel")
local eventAnnouncement = screenGui:WaitForChild("EventAnnouncement")
local votingPanel = screenGui:WaitForChild("VotingPanel")
local gameEndScreen = screenGui:WaitForChild("GameEndScreen")

local currentRole = "Survivor"
local partsCaught = 0

-- Atualizar UI
UpdateUI.OnClientEvent:Connect(function(action, value)
	if action == "Timer" then
		timerLabel.Text = "Tempo: " .. value .. "s"
	elseif action == "PartsCollected" then
		partsCaught = value
		partsLabel.Text = "Peças: " .. value .. "/8"
	elseif action == "Coins" then
		coinLabel.Text = "Moedas: " .. value
	end
end)

-- Mostrar papel secreto
ShowRole.OnClientEvent:Connect(function(role, chaosAgentName)
	currentRole = role
	
	if role == "ChaosAgent" then
		rolePanel.TextLabel.Text = "Você é o AGENTE DO CAOS!"
		rolePanel.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		rolePanel.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
		objectiveLabel.Text = "Objetivo: Sabote o grupo sem ser descoberto!"
	else
		rolePanel.TextLabel.Text = "Você é um SOBREVIVENTE"
		rolePanel.TextLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
		rolePanel.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
		objectiveLabel.Text = "Objetivo: Colete todas as 8 peças e conserte o barco!"
	end
	
	rolePanel.Visible = true
	wait(5)
	rolePanel.Visible = false
end)

-- Anunciar eventos
EventAnnouncement.OnClientEvent:Connect(function(eventType, description)
	eventAnnouncement.Text = description
	eventAnnouncement.Visible = true
	
	wait(3)
	eventAnnouncement.Visible = false
end)

-- Tela de fim de jogo
GameEnd.OnClientEvent:Connect(function(winner, reason, playersData)
	gameEndScreen.Visible = true
	
	local resultText = "RESULTADO: "
	if winner == "Survivors" then
		resultText = resultText .. "SOBREVIVENTES VENCERAM!"
	else
		resultText = resultText .. "AGENTE DO CAOS VENCEU!"
	end
	
	gameEndScreen.ResultLabel.Text = resultText
	gameEndScreen.ReasonLabel.Text = "Motivo: " .. reason
end)

-- Iniciar pedido de estado do jogo
spawn(function()
	while true do
		wait(2)
		pcall(function()
			local state = RequestGameState:InvokeServer()
			if state then
				coinLabel.Text = "Moedas: " .. state.Coins
			end
		end)
	end
end)