local Root = script.Parent
local Modules = Root:WaitForChild("Modules")

local Linked = {}

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

function _G.get(path: string, base: Instance?)
	local complete_path = parse(base or Modules, path)
	if complete_path then
		return require(complete_path) or {}
	end
end

for _, exec in next, script:GetDescendents() do
	local file = require(exec)
	if file then
		if file["init"] then
			file.init(Linked) --// Inject main table
		else
			debug.traceback(`init was not found in {exec.Name}`)
		end
	else
		debug.traceback("Failed to load...")
	end
end