# 🎮 99 Noites: Ilha do Caos - GUIA DE INSTALAÇÃO COMPLETO

## 📋 Sumário
1. [Requisitos](#requisitos)
2. [Passo 1: Setup Automático](#passo-1-setup-automático)
3. [Passo 2: Copiar Scripts](#passo-2-copiar-scripts)
4. [Passo 3: Testar o Jogo](#passo-3-testar-o-jogo)
5. [Solução de Problemas](#solução-de-problemas)

---

## 📦 Requisitos

✅ Roblox Studio instalado (https://create.roblox.com/)
✅ Acesso ao GitHub para copiar os scripts
✅ Computador capaz de rodar Roblox Studio

---

## ✨ Passo 1: Setup Automático

Este script cria todas as pastas, RemoteEvents, UI e estrutura do mapa automaticamente.

### Como usar:

1. Abra **Roblox Studio**
2. Crie um novo jogo (Start > Blank)
3. Abra a **Command Bar**:
   - Vá para **View > Command Bar** (ou aperte **Ctrl+Shift+P**)

4. Copie o conteúdo do arquivo `SETUP_AUTOMATICO.lua` do repositório
5. Cole na Command Bar
6. Aperte **Enter**

### Resultado esperado:
```
🎮 Iniciando setup automático de '99 Noites: Ilha do Caos'...
✓ Criado RemoteEvent: UpdateUI
✓ Criado RemoteEvent: ShowRole
... (mais eventos)
✓ Pastas do Workspace criadas
✓ SpawnLocation criado
✓ 8 Part Spawns criados
✓ Barco criado
✓ ScreenGui criada com todos os elementos

✅ SETUP COMPLETO!
```

---

## 📝 Passo 2: Copiar Scripts

Agora você precisa copiar os scripts Lua para suas localizações corretas.

### 2.1 Scripts do Servidor (ServerScriptService)

#### GameManager.lua
1. Em **ServerScriptService**, crie um novo **Script** chamado `GameManager`
2. Copie o conteúdo de `ServerScriptService/GameManager.lua` do repositório
3. Cole no script

#### PlayerManager.lua
1. Crie um novo **Script** em **ServerScriptService** chamado `PlayerManager`
2. Copie `ServerScriptService/PlayerManager.lua`

#### EventManager.lua
1. Crie um novo **Script** em **ServerScriptService** chamado `EventManager`
2. Copie `ServerScriptService/EventManager.lua`

#### VotingSystem.lua
1. Crie um novo **Script** em **ServerScriptService** chamado `VotingSystem`
2. Copie `ServerScriptService/VotingSystem.lua`

### 2.2 Módulos (ReplicatedStorage > Modules)

#### GameConfig.lua
1. Vá para **ReplicatedStorage > Modules**
2. Crie um **ModuleScript** chamado `GameConfig`
3. Copie `ReplicatedStorage/Modules/GameConfig.lua`

#### GameState.lua
1. Crie um **ModuleScript** chamado `GameState`
2. Copie `ReplicatedStorage/Modules/GameState.lua`

#### Utils.lua
1. Crie um **ModuleScript** chamado `Utils`
2. Copie `ReplicatedStorage/Modules/Utils.lua`

#### CurrencySystem.lua
1. Crie um **ModuleScript** chamado `CurrencySystem`
2. Copie `ReplicatedStorage/Modules/CurrencySystem.lua`

### 2.3 Scripts do Cliente

#### CharacterHandler.lua
1. Vá para **StarterPlayer > StarterCharacterScripts**
2. Crie um novo **LocalScript** chamado `CharacterHandler`
3. Copie `StarterPlayer/StarterCharacterScripts/CharacterHandler.lua`

#### PlayerHandler.lua
1. Vá para **StarterPlayer > StarterPlayerScripts**
2. Crie um novo **LocalScript** chamado `PlayerHandler`
3. Copie `StarterPlayer/StarterPlayerScripts/PlayerHandler.lua`

### 2.4 UI Script

#### MainUIScript.lua
1. Vá para **StarterGui > ScreenGui**
2. Clique com botão direito em **ScreenGui** > Insert Object > LocalScript
3. Nomeie como `MainUIScript`
4. Copie `StarterGui/MainUIScript.lua`

---

## 🎮 Passo 3: Testar o Jogo

### Teste Single Player
1. Clique em **Run** (F5) no Studio
2. Seu personagem deve spawnar
3. Você deve ver o Timer na tela
4. As peças devem aparecer no mapa

### Teste Multiplayer
1. Clique em **Start Server** (no canto superior)
2. Clique em **Start Player** 
3. Abra outra aba (Ctrl+Tab) para adicionar mais jogadores
4. Repita o passo 3 para cada jogador (máximo 12)

### Checklist de Testes

✅ **Teste 1: Entrada de Jogadores**
- [ ] 2 jogadores entram sem erro
- [ ] Timer começa a contar

✅ **Teste 2: Papéis Secretos**
- [ ] Um jogador vê "AGENTE DO CAOS" em vermelho
- [ ] Outro vê "SOBREVIVENTE" em verde
- [ ] Mensagens desaparecem após 5 segundos

✅ **Teste 3: Peças**
- [ ] 8 peças aparecem no mapa (bolinhas amarelas)
- [ ] Quando toca a peça, ela desaparece
- [ ] Contador de peças atualiza (Peças: 1/8)

✅ **Teste 4: Eventos**
- [ ] Eventos aleatórios são anunciados na tela
- [ ] Tempestade escurece a tela
- [ ] Meteoros caem
- [ ] Apagão desliga a luz

✅ **Teste 5: Fim do Jogo**
- [ ] Quando todas as 8 peças são coletadas, tela de "RESULTADO" aparece
- [ ] Moedas são adicionadas
- [ ] Nova rodada começa automaticamente

---

## 🔧 Solução de Problemas

### Erro: "ReplicatedStorage.RemoteEvents.UpdateUI is not a valid member"
**Solução:** Execute o `SETUP_AUTOMATICO.lua` novamente. Ele cria todos os RemoteEvents automaticamente.

### Erro: "GameConfig is nil"
**Solução:** Verifique se o módulo `GameConfig` está em `ReplicatedStorage > Modules` e se o script foi copiado corretamente.

### Nenhuma peça aparece no mapa
**Solução:** Verifique se a pasta `PartSpawns` existe em **Workspace** com 8 parts dentro.

### Timer não aparece na tela
**Solução:** Verifique se o `ScreenGui` tem um `Frame` chamado `InfoPanel` com um `TextLabel` chamado `TimerLabel`.

### Erro ao executar: "Esperado '>=' mas encontrado 'end'"
**Solução:** Há um erro de sintaxe Lua. Copie o script novamente verificando que não há caracteres cortados.

### Jogo muito lento
**Solução:** 
- Reduza `GameConfig.EVENT_INTERVAL` de 30 para 60
- Reduza `GameConfig.ROUND_DURATION` de 300 para 180
- Feche outros programas

---

## 📂 Estrutura Final

```
Workspace/
├── Map/
│   ├── BoatHull
│   └── BoatMast
├── SpawnPoints/
│   └── SpawnLocation
├── PartSpawns/ (8 spawns)
└── GameParts/ (onde as peças aparecerão)

ServerScriptService/
├── GameManager
├── PlayerManager
├── EventManager
└── VotingSystem

ReplicatedStorage/
├── RemoteEvents/ (7 events)
├── RemoteFunction/ (1 function)
└── Modules/
    ├── GameConfig
    ├── GameState
    ├── Utils
    └── CurrencySystem

Starter Players/
├── StarterCharacterScripts/
│   └── CharacterHandler
└── StarterPlayerScripts/
    └── PlayerHandler

StarterGui/
└── ScreenGui/
    ├── MainUIScript
    ├── InfoPanel
    ├── RolePanel
    ├── EventAnnouncement
    ├── VotingPanel
    └── GameEndScreen
```

---

## 🚀 Próximos Passos

Após a instalação bem-sucedida:

1. **Teste com 12 jogadores** (máximo do jogo)
2. **Publique no Roblox** (File > Publish to Roblox)
3. **Customize o mapa** (adicione mais estruturas, árvores, etc)
4. **Ajuste as recompensas** em `GameConfig.lua`
5. **Crie um logo** para o jogo

---

## 📞 Suporte

Se encontrar problemas:
1. Verifique a **Output Window** (View > Output) para mensagens de erro
2. Confirme que todos os scripts estão em seus locais corretos
3. Verifique se não há caracteres especiais nos nomes dos scripts
4. Tente fazer um **Game Server Restart** (File > Studio > Restart Studio)

---

**Divirta-se desenvolvendo seu jogo! 🎮✨**
