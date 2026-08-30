-- StarterPlayer > StarterCharacterScripts > CharacterHandler
-- Gerencia o personagem do jogador

local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Velocidade de movimento
humanoid.WalkSpeed = 16
humanoid.JumpPower = 50

-- Anti-exploit: validar movimento
local lastPosition = rootPart.Position
local maxTeleportDistance = 50 -- máximo de distância por frame

game:GetService("RunService").Heartbeat:Connect(function()
	local currentPosition = rootPart.Position
	local distance = (currentPosition - lastPosition).Magnitude
	
	if distance > maxTeleportDistance then
		-- Possível exploit de teleporte
		rootPart.CFrame = CFrame.new(lastPosition)
		print("Teleporte suspeito detectado e revertido!")
	end
	
	lastPosition = currentPosition
end)

-- Detectar morte
humanoid.Died:Connect(function()
	print(character.Name .. " morreu!")
end)