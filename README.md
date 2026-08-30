# 99 Noites: Ilha do Caos

🎮 **Um jogo Roblox multiplayer onde jogadores precisam coletar peças para escapar de uma ilha apocalíptica, mas um deles é um "Agente do Caos" secreto tentando sabotá-los!**

## ✨ Características

✅ **2-12 Jogadores** - Suporte para multiplayer completo
✅ **Agente do Caos Secreto** - Um jogador escolhido aleatoriamente
✅ **8 Peças para Coletar** - Objetivo cooperativo
✅ **5 Eventos Aleatórios** - Tempestade, Meteoros, Apagão, Terremoto, Invasão
✅ **Sistema de Votação** - Acuse o Agente do Caos
✅ **Moedas e Recompensas** - Ganhe moedas por vitória
✅ **UI Responsiva** - Funciona bem em mobile e desktop
✅ **Anti-Exploit** - Validação de movimento no servidor
✅ **Otimizado** - Sem lags perceptíveis
✅ **Código Limpo** - Modular e bem documentado

## 🚀 Quick Start

1. Clone este repositório
2. Abra Roblox Studio
3. Crie um novo projeto "Blank"
4. Abra **View > Command Bar** (Ctrl+Shift+P)
5. Copie e execute `SETUP_AUTOMATICO.lua`
6. Copie todos os scripts Lua para suas localizações
7. Clique em Run (F5) para testar

## 📚 Documentação Completa

Veja `INSTALACAO_COMPLETA.md` para:
- Instalação passo-a-passo
- Estrutura do projeto
- Testes e validação
- Solução de problemas

## 🎯 Gameplay

**Fase 1: Lobby (10s)**
- Jogadores entram no jogo
- Um é escolhido como Agente do Caos
- Cada jogador vê seu papel secretamente

**Fase 2: Coleta (5 minutos)**
- Sobreviventes coletam 8 peças
- Agente do Caos sabota (pode empurrar jogadores, bloquear peças)
- Eventos aleatórios ocorrem a cada 30s
- A cada 60s há uma votação para acusar alguém

**Fase 3: Resultado**
- Sobreviventes vencem se coletarem todas as 8 peças
- Agente do Caos vence se o tempo expirar
- Moedas são distribuídas
- Nova rodada começa

## 🗂️ Estrutura de Arquivos

```
99-noites-ilha-caos/
├── ServerScriptService/
│   ├── GameManager.lua
│   ├── PlayerManager.lua
│   ├── EventManager.lua
│   └── VotingSystem.lua
├── ReplicatedStorage/
│   └── Modules/
│       ├── GameConfig.lua
│       ├── GameState.lua
│       ├── Utils.lua
│       └── CurrencySystem.lua
├── StarterPlayer/
│   ├── StarterCharacterScripts/CharacterHandler.lua
│   └── StarterPlayerScripts/PlayerHandler.lua
├── StarterGui/
│   └── MainUIScript.lua
├── SETUP_AUTOMATICO.lua
├── INSTALACAO_COMPLETA.md
└── README.md
```

## 🎮 Controles

- **WASD** - Movimento
- **Espaço** - Pulo
- **Mouse** - Câmera
- **Botão de Votação** (UI) - Votar em alguém

## 📊 Configurações

Edite `GameConfig.lua` para ajustar:
- `MIN_PLAYERS` - Mínimo de jogadores para começar
- `ROUND_DURATION` - Duração da rodada (padrão: 300s = 5min)
- `PARTS_TO_COLLECT` - Número de peças (padrão: 8)
- `EVENT_INTERVAL` - Intervalo entre eventos (padrão: 30s)
- `SURVIVOR_REWARD` - Moedas para sobreviventes (padrão: 100)
- `CHAOS_AGENT_REWARD` - Moedas para Agente (padrão: 150)

## 🐛 Solução de Problemas

**Q: RemoteEvent não existe**
A: Execute `SETUP_AUTOMATICO.lua` na Command Bar

**Q: Scripts não funcionam**
A: Verifique a Output Window (View > Output) para erros

**Q: Jogo muito lento**
A: Reduza `EVENT_INTERVAL` e `ROUND_DURATION` em GameConfig

## 💡 Ideias Futuras

- [ ] Sistema de classes/roles adicionais
- [ ] Shop de cosméticos com moedas
- [ ] Missões diárias
- [ ] Níveis progressivos
- [ ] Sistema de amigos/clã
- [ ] Mapa maior com mais áreas
- [ ] Mais tipos de eventos
- [ ] Sistema de chat integrado
- [ ] Efeitos sonoros completos
- [ ] Animações customizadas

## 📝 Licença

MIT License - Use livremente!

## 🤝 Contribuições

Quer melhorar? Crie um Pull Request!

---

**Desenvolvido para criar momentos engraçados, tensos e virais no Roblox! 🎮✨**
