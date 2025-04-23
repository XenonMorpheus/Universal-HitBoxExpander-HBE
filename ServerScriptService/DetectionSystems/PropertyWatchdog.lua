-- ServerScriptService/PropertyWatchdog.lua
local PhysicsService = game:GetService("PhysicsService")
local DEFAULT_COLOR = Color3.new(0.388235, 0.372549, 0.384314)

return {
    Scan = function(character)
        local hrp = character:WaitForChild("HumanoidRootPart")
        
        -- Color check
        if hrp.Color ~= DEFAULT_COLOR then
            character.Parent:Kick("PV01")
        end
        
        -- Collision group check
        if PhysicsService:GetPartCollisionGroup(hrp) ~= "Players" then
            character.Parent:Kick("CG01")
        end
        
        -- Custom attribute check
        if hrp:GetAttribute("HitboxExpander") then
            character.Parent:Kick("PV01")
        end
    end
}
