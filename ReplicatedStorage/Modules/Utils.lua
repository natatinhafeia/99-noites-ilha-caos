-- ReplicatedStorage > Modules > Utils
-- Funções utilitárias

local Utils = {}

function Utils.Round(num, decimals)
	local mult = 10 ^ (decimals or 0)
	return math.floor(num * mult + 0.5) / mult
end

function Utils.FormatTime(seconds)
	local mins = math.floor(seconds / 60)
	local secs = seconds % 60
	return string.format("%02d:%02d", mins, secs)
end

function Utils.GetRandomPosition(radius)
	local angle = math.random() * math.pi * 2
	local x = math.cos(angle) * radius
	local z = math.sin(angle) * radius
	return Vector3.new(x, 5, z)
end

function Utils.Distance(pos1, pos2)
	return (pos1 - pos2).Magnitude
end

function Utils.IsPlayerNearby(player, targetPosition, radius)
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local distance = Utils.Distance(player.Character.HumanoidRootPart.Position, targetPosition)
		return distance <= radius
	end
	return false
end

return Utils