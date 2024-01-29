## Paswa Framework
* Modular
* Lightweight
* Flexible
* Reduces Repetitve :GetService Calls by caching services locally.
* Quick Access to Modules, Remotes, or Services.

### Implementation (Script Name: Bootloader)
- Create 1 Local Script/Script (Optionally you can add one into StarterCharacterScripts)
> Script and LocalScript should be placed in StarterPlayerScripts or ServerScriptStorage
- Modules contained under the bootloader 
```lua
--// Example Bootload Module
--// Main use is to get your system up and running

local function started()
  --// Code ran
end

return {
  init = started
}
```
- If there are any scripts you do not wish to run, but rather utilize. Create a folder called `Utilities` in the same directory as `Bootloader`
```lua
--// Example use of a Utility on the Server
local get = _G.get
local MyModule = get "MyModule"
local Persistent = get "Persistent"

local function started()
  Persistent.push("Player", MyModule:PlayerController())
  Persistent.get("Player"):RequestTeleport("Paswa", Vector3.zero)
end

return {
  init = started
}
```
