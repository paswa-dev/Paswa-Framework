local Root = script.Parent
local Player = game.Players.LocalPlayer
---/// Interchanable Values
local Modules = Root:WaitForChild("Modules")
local Services = {}
---/// Core Modules
local Maid = require(Modules.Maid)
local Observer = require(Modules.Observer)
---/// Core Values
local CharacterObserver = Observer.new(function(event)
	Player.CharacterAdded:Connect(function(newChar)
		event:Fire(newChar)
	end)
end)

local function parse(base, path)
	local success, result = pcall(function()
		for _, subpath in next, path:split("/") do
			base = base[subpath]
		end
		return base
	end)
	if not success then
		debug.traceback(result)
	end
	return result
end

function _G.get(path: string, searchLocation: Instance?) -- Why is this erroring?????????
	local file = parse(searchLocation or Modules, path)
	return file and require(file) or nil
end

function _G.bridge(path: string)
	--// Create bride via Core module
end

function _G.service(serviceName)
	if Services[serviceName] then
		return Services[serviceName]
	end
	local newService = game:GetService(serviceName)
	Services[serviceName] = newService
	return newService
end

--// Executable Params
--[[ if isCharacter, maid function is supplied through
{
    init: (maid: maid | nil) -> ()
    isCharacter: boolean?,
}

]]
for _, exec in next, script:GetDescendants() do
	local file = require(exec)
	if file then
		if file["init"] then
			if file["isCharacter"] then
				local ExecMaid = Maid.new()
				CharacterObserver:Subscribe(function(character)
					ExecMaid:DoCleanup()
					ExecMaid._character = character
					file.init(ExecMaid)
				end)
			else
				file.init()
			end
		end
	else
		debug.traceback(`{exec.Name}, failed to load.`)
	end
	exec:Destroy() --// Cleanup time
end
