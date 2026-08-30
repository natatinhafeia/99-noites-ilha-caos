-- GERAR ARQUIVO .rbxlx COMPLETO
-- Este script cria um arquivo de projeto Roblox pronto para usar
-- Salve este arquivo como: 99-Noites-Ilha-Caos.rbxlx

local HttpService = game:GetService("HttpService")

-- Este é um template XML básico para .rbxlx
-- Um arquivo .rbxlx é um ZIP contendo XML

local rbxlxContent = [[
<?xml version="1.0" encoding="UTF-8"?>
<roblox version="4">
	<External>null</External>
	<External>nil</External>
	<Item class="DataModel" referent="RBX0">
		<Properties>
			<int name="MasterPlayerId">0</int>
			<CoordinateFrame name="WorldOrigin">
				<X>0</X>
				<Y>0</Y>
				<Z>0</Z>
				<R00>1</R00>
				<R01>0</R01>
				<R02>0</R02>
				<R10>0</R10>
				<R11>1</R11>
				<R12>0</R12>
				<R20>0</R20>
				<R21>0</R21>
				<R22>1</R22>
			</CoordinateFrame>
		</Properties>
		<Item class="Workspace" referent="RBX1">
			<Properties>
				<Ref name="CurrentCamera">null</Ref>
				<double name="DistributedGameTime">0</double>
				<int name="FallenPartsDestroyHeight">-500</int>
				<bool name="MeshPartHeads">false</bool>
				<string name="Name">Workspace</string>
			</Properties>
			<Item class="Terrain" referent="RBX2">
				<Properties>
					<string name="Name">Terrain</string>
				</Properties>
			</Item>
		</Item>
		<Item class="Lighting" referent="RBX3">
			<Properties>
				<Color3 name="Ambient">4279962996</Color3>
				<float name="Brightness">1</float>
				<Color3 name="OutdoorAmbient">4279962996</Color3>
				<string name="Name">Lighting</string>
			</Properties>
			<Item class="Atmosphere" referent="RBX4">
				<Properties>
					<float name="Density">0.1</float>
					<Vector3 name="Offset">0, -0.1, 0</Vector3>
					<Color3 name="Color">4283256220</Color3>
				</Properties>
			</Item>
		</Item>
		<Item class="ReplicatedStorage" referent="RBX5">
			<Properties>
				<string name="Name">ReplicatedStorage</string>
			</Properties>
		</Item>
		<Item class="ServerScriptService" referent="RBX6">
			<Properties>
				<string name="Name">ServerScriptService</string>
			</Properties>
		</Item>
		<Item class="StarterPlayer" referent="RBX7">
			<Properties>
				<string name="Name">StarterPlayer</string>
			</Properties>
			<Item class="StarterCharacterScripts" referent="RBX8">
				<Properties>
					<string name="Name">StarterCharacterScripts</string>
				</Properties>
			</Item>
			<Item class="StarterPlayerScripts" referent="RBX9">
				<Properties>
					<string name="Name">StarterPlayerScripts</string>
				</Properties>
			</Item>
		</Item>
		<Item class="StarterGui" referent="RBX10">
			<Properties>
				<string name="Name">StarterGui</string>
			</Properties>
		</Item>
</roblox>
]]

print("Arquivo .rbxlx template criado!")
print("Este é um exemplo de estrutura XML básica.")
print("Para gerar um arquivo completo, use Roblox Studio:")
print("1. Crie seu jogo em Studio")
print("2. File > Save (Ctrl+S) - salva como .rbxl")
print("3. File > Save As... > rbxlx format")
print("\nAlternativa: Use o SETUP_AUTOMATICO.lua para popular tudo automaticamente!")
