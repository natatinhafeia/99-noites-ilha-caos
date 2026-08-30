-- ReplicatedStorage > Modules > CurrencySystem
-- Sistema de moedas e XP

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local CurrencyStore = DataStoreService:GetDataStore("PlayerCurrency")
local playerCoins = {}

local CurrencySystem = {}

function CurrencySystem.InitializePlayer(player)
	local success, data = pcall(function()
		return CurrencyStore:GetAsync("Player_" .. player.UserId)
	end)
	
	if success and data then
		playerCoins[player.UserId] = data.Coins or 0
	else
		playerCoins[player.UserId] = 0
	end
	
	-- Missão diária
	if success and data and data.LastDaily then
		local lastDaily = os.difftime(os.time(), data.LastDaily)
		if lastDaily >= 86400 then -- 24 horas
			CurrencySystem.AddCoins(player.UserId, 50)
		end
	else
		CurrencySystem.AddCoins(player.UserId, 50)
	end
end

function CurrencySystem.AddCoins(userId, amount)
	if not playerCoins[userId] then
		playerCoins[userId] = 0
	end
	playerCoins[userId] = playerCoins[userId] + amount
	
	-- Salvar para este jogador se estiver online
	local player = Players:GetPlayerByUserId(userId)
	if player then
		pcall(function()
			CurrencyStore:SetAsync("Player_" .. userId, {
				Coins = playerCoins[userId],
				LastDaily = os.time()
			})
		end)
	end
	
	return playerCoins[userId]
end

function CurrencySystem.RemoveCoins(userId, amount)
	if not playerCoins[userId] then
		playerCoins[userId] = 0
	end
	playerCoins[userId] = math.max(0, playerCoins[userId] - amount)
	
	local player = Players:GetPlayerByUserId(userId)
	if player then
		pcall(function()
			CurrencyStore:SetAsync("Player_" .. userId, {
				Coins = playerCoins[userId],
				LastDaily = os.time()
			})
		end)
	end
	
	return playerCoins[userId]
end

function CurrencySystem.GetCoins(userId)
	return playerCoins[userId] or 0
end

return CurrencySystem