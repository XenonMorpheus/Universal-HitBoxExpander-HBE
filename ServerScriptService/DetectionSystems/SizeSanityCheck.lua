-- ServerScriptService/SizeSanityCheck.lua
local MAX_SIZE = Vector3.new(5, 5, 5)
local MAX_GROWTH_RATE = 0.2 -- Studs/second

return {
    Monitor = function(player)
        local char = player.Character
        if not char then return end
        
        local hrp = char:WaitForChild("HumanoidRootPart")
        local sizeHistory = {}
        
        game:GetService("RunService").Heartbeat:Connect(function(dt)
            -- Size limit check
            if hrp.Size.Magnitude > MAX_SIZE.Magnitude then
                player:Kick("SD01")
            end
            
            -- Growth rate check
            table.insert(sizeHistory, hrp.Size)
            if #sizeHistory > 10 then table.remove(sizeHistory, 1) end
            
            if #sizeHistory >= 2 then
                local growthRate = (sizeHistory[#sizeHistory] - sizeHistory[1]).Magnitude / dt
                if growthRate > MAX_GROWTH_RATE then
                    player:Kick("SD01")
                end
            end
        end)
    end
}
