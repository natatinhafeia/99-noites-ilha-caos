-- StarterPlayer > StarterPlayerScripts > PlayerHandler
-- Script principal do lado do cliente

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remotes
local CollectPart = ReplicatedStorage.RemoteEvents.CollectPart

-- Efeito de coleta de peça
CollectPart.OnClientEvent:Connect(function(partNumber)
	local character = player.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		-- Efeito visual
		local effect = Instance.new("Part")
		effect.Shape = Enum.PartType.Ball
		effect.Size = Vector3.new(2, 2, 2)
		effect.Color = Color3.fromRGB(255, 200, 0)
		effect.CanCollide = false
		effect.CFrame = character.HumanoidRootPart.CFrame
		effect.Parent = workspace
		
		-- Animação de desaparecimento
		for i = 1, 20 do
			effect.Transparency = i / 20
			effect.Size = effect.Size * 0.95
			wait(0.05)
		end
		
		effect:Destroy()
		
		-- Som
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://12221967"
		sound.Volume = 0.5
		sound.Parent = character.HumanoidRootPart
		sound:Play()
		game:GetService("Debris"):AddItem(sound, 2)
	end
end)

print("PlayerHandler iniciado para: " .. player.Name)