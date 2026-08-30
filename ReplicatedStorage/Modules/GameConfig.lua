-- ReplicatedStorage > Modules > GameConfig
-- Configurações centralizadas do jogo

local GameConfig = {
	-- Gameplay
	MIN_PLAYERS = 2,
	MAX_PLAYERS = 12,
	ROUND_DURATION = 300, -- 5 minutos
	COUNTDOWN_TIME = 10,
	RESULTS_DISPLAY_TIME = 10,
	
	-- Partes e Coleta
	PARTS_TO_COLLECT = 8,
	
	-- Moedas e Recompensas
	SURVIVOR_REWARD = 100,
	CHAOS_AGENT_REWARD = 150,
	DAILY_REWARD = 50,
	
	-- Eventos
	EVENT_INTERVAL = 30, -- A cada 30 segundos
	
	-- Votação
	VOTING_INTERVAL = 60, -- A cada 60 segundos
	VOTING_DURATION = 20, -- 20 segundos de votação
	
	-- Spawn
	SPAWN_PROTECTION_TIME = 3,
	
	-- Otimização
	RENDER_DISTANCE = 200,
	PHYSICS_UPDATE_RATE = 20,
}

return GameConfig