local Root = script.Parent
---/// Interchanable Values
local Modules = Root:WaitForChild("Modules")
local Services = {}

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

for _, exec in next, script:GetDescendants() do
	local file = require(exec)
	if file then
		if file["init"] then
			file.init()
		end
	else
		debug.traceback(`{exec.Name}, failed to load.`)
	end
	exec:Destroy() --// Cleanup time
end
