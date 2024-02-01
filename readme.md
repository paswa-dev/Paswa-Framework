## Paswa Framework
* Modular
* Lightweight
* Flexible
* ~~Reduces Repetitve :GetService Calls by caching services locally.~~ (not yet implemented)
* Quick Access to Modules, Remotes, or Data.

## Tips for structuring
Create 4 Folders.
1. Data
2. Classes
3. Manangers
4. Services
> Structure using your own logic; depending on another guideline further complicates what is already simple.
## Implementation (Script Name: Bootloader)
Place Bootloaders under corresponding areas.
> -> ServerScriptService

> -> StarterPlayerScripts

## Syntax Usage (Examples are a bit dumb, use your own logic when using this framework)
> Formatting Option #1
```lua
--// Round.lua
local get = _G.get
local remote = _G.remote

local StartRound = remote "GameEvents/StartRound"
local TeamUI = get "Managers/Team"
local Teams = get "Data/Teams"

local module = {}

local function newRound(team1, team2)
  TeamUI.DefaultTeams = {
    Teams[team1],
    Teams[team2]
  } -- Sets tables in module. 
  TeamUI.DefaultUI() -- Tells module to prepare all UI
  TeamUI.Show(false) --// should animate
end

function module.init()
  StartRound.OnClientEvent:Connect(newRound)
  Teams.onTicketUpdate:Connect(TeamUI.updateTickets)
end

return
```
> Formatting Option #2
```lua
--// Example.lua
local get = _G.get
local remote = _G.remote

local function main(framework)
  framework.roundActive = false
  --// Lets say I put some sort of players module into the framework
  framework.Players:GetPlayer("Paswa"):Teleport(Vector3.new(0, 0, 0))
end

return {
  init = main
}
```
I would like to add that, the `init` function may sometimes be useless and is not required. The framework table injection is simply to share a bit of information between all executables. Using a module to share data between other modules is a different story.
> Formatting Option #3
```lua
--// Other
local get = _G.get
local remote = _G.remote

local Input = get "Services/InputService" -- UIS

local RequestTool = get "Inventory/Equip"
local RequestInventory = remote "Inventory/GetInventory"

local Root = {}

Root.Framework.Equipped = nil
Root.Framework.Inventory = RequestInventory:FireServer()
--[[
  {
  "Mark 1 Blaster",
  "Apple",
  "Sword",
  }
]]

Input.Number:Subscribe(function(value)
  if Root.Framework.Inventory[value] then
    --// Check if a tool is equipped, unequip it. 
    RequestTool:FireServer(Root.Framework.Inventory[value])
  end
end)

return Root
------- Another Script
local get = _G.get
local remote = _G.remote

local ToolService = get "Services/ToolService"
local equipTool = remote "Inventory/Equip"

local Root = {}

equipTool.OnClientEvent:Connect(function(tool_name)
  ToolService:Unequip()
  ToolService:Equip(tool_name)
  Root.Framework.Equipped = tool_name
end)

return Root
```


