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
    if not success then debug.traceback(result) end
    return result
end

function _G.get(path: string, searchLocation: Instance?)
    local file = parse(searchLocation or Modules, path)
end

function _G.service(serviceName)
    if Services[serviceName] then return Services[serviceName] end
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
for _, exec in next, script:GetDescendents()

end