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

end

function