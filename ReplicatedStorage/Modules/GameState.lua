-- ReplicatedStorage > Modules > GameState
-- Estado global do jogo

local GameState = {
	_gameActive = false,
	_currentPlayers = 0,
	_roundNumber = 0,
}

function GameState.SetGameActive(active)
	GameState._gameActive = active
end

function GameState.IsGameActive()
	return GameState._gameActive
end

function GameState.SetRoundNumber(num)
	GameState._roundNumber = num
end

function GameState.GetRoundNumber()
	return GameState._roundNumber
end

function GameState.SetPlayerCount(count)
	GameState._currentPlayers = count
end

function GameState.GetPlayerCount()
	return GameState._currentPlayers
end

return GameState