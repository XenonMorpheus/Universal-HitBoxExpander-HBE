-- ServerScriptService/MetatableGuard.lua
return {
    Start = function()
        local protectedMethods = {
            __index = true,
            __newindex = true,
            __namecall = true
        }

        local function ValidateMetatable()
            local mt = getrawmetatable(game)
            if not mt then return end
            
            for method in pairs(protectedMethods) do
                if debug.getinfo(mt[method]).short_src:match("LocalScript") then
                    game:GetService("Players").LocalPlayer:Kick("MT01")
                end
            end
            
            setreadonly(mt, true)
        end

        ValidateMetatable()
        debug.setmetatable(game, nil)
    end
}
