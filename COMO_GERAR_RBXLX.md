# 🎮 Como Obter o Arquivo .rbxlx

## ⚠️ Importante

O arquivo `.rbxlx` é gerado **automaticamente** quando você:
1. Configura todo o jogo em Roblox Studio
2. Clica em **File > Save As** e seleciona formato `.rbxlx`

## 📥 Opção 1: Download Direto (Recomendado)

Não há um arquivo `.rbxlx` pré-gerado porque cada projeto Roblox é único.

**Por quê?**
- Arquivos `.rbxlx` contêm dados binários do Roblox
- GitHub não permite armazenar esses arquivos bem
- O tamanho pode ser de 5-50MB

## 🚀 Opção 2: Criar Localmente (5 minutos)

### Passo 1: Clonar o Repositório
```bash
git clone https://github.com/natatinhafeia/99-noites-ilha-caos.git
cd 99-noites-ilha-caos
```

### Passo 2: Usar o Setup Automático
1. Abra Roblox Studio
2. Crie um novo projeto (Blank)
3. **View > Command Bar** (Ctrl+Shift+P)
4. Copie todo o conteúdo de `SETUP_AUTOMATICO.lua`
5. Cole na Command Bar e aperte Enter

### Passo 3: Copiar os Scripts
Copie cada arquivo `.lua` para sua localização correta:
- `ServerScriptService/*.lua` → ServerScriptService
- `ReplicatedStorage/Modules/*.lua` → ReplicatedStorage > Modules
- `StarterPlayer/**/*.lua` → StarterPlayer
- `StarterGui/*.lua` → StarterGui > ScreenGui

### Passo 4: Salvar como .rbxlx
1. **File > Save As**
2. Digite o nome: `99-Noites-Ilha-Caos`
3. Selecione formato: **ROBLOX Place File (.rbxlx)**
4. Clique em **Save**

## 📋 Checklist de Instalação

- [ ] SETUP_AUTOMATICO.lua foi executado com sucesso
- [ ] GameManager.lua está em ServerScriptService
- [ ] PlayerManager.lua está em ServerScriptService
- [ ] EventManager.lua está em ServerScriptService
- [ ] VotingSystem.lua está em ServerScriptService
- [ ] GameConfig.lua está em ReplicatedStorage > Modules
- [ ] GameState.lua está em ReplicatedStorage > Modules
- [ ] Utils.lua está em ReplicatedStorage > Modules
- [ ] CurrencySystem.lua está em ReplicatedStorage > Modules
- [ ] CharacterHandler.lua está em StarterPlayer > StarterCharacterScripts
- [ ] PlayerHandler.lua está em StarterPlayer > StarterPlayerScripts
- [ ] MainUIScript.lua está em StarterGui > ScreenGui
- [ ] ScreenGui foi criada com todos os Frame e TextLabel
- [ ] RemoteEvents foram criados (7 events)
- [ ] RemoteFunction foi criada (RequestGameState)
- [ ] Workspace tem pastas: Map, SpawnPoints, PartSpawns, GameParts

## 🎯 Teste Rápido

Antes de salvar como .rbxlx:

1. Clique em **Run** (F5)
2. Seu personagem deve aparecer
3. Você deve ver o Timer na tela superior esquerda
4. A Output não deve mostrar erros vermelhos
5. Abra outra aba (Ctrl+Tab) para testar com 2 jogadores

## 📦 Arquivo .rbxlx Gerado

Ao salvar, você terá um arquivo como:
```
99-Noites-Ilha-Caos.rbxlx (15-30 MB)
```

Este arquivo contém:
✅ Todos os scripts
✅ Toda a UI
✅ Todas as configurações
✅ O mapa e estruturas
✅ RemoteEvents e RemoteFunctions

## 💾 Próximos Passos

1. **Compartilhe o arquivo .rbxlx** com amigos
2. Eles podem abrir diretamente em Roblox Studio
3. Ou publique no Roblox (File > Publish to Roblox)

## ❓ Dúvidas?

Ver **INSTALACAO_COMPLETA.md** para:
- Instruções detalhadas
- Solução de problemas
- Explicação de cada script

---

**Pronto! Seu jogo está a poucos cliques de distância! 🚀**
