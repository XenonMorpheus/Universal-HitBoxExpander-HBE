-- ServerScriptService/AntiCheatCore.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local AntiCheat = {
    Detections = {
        MetatableGuard = require(script.MetatableGuard),
        SizeSanityCheck = require(script.SizeSanityCheck),
        PropertyWatchdog = require(script.PropertyWatchdog)
    }
}

function AntiCheat.Init()
    -- Initialize all detection systems
    AntiCheat.Detections.MetatableGuard.Start()
    
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            AntiCheat.Detections.SizeSanityCheck.Monitor(player)
            AntiCheat.Detections.PropertyWatchdog.Scan(char)
        end)
    end)
    
    require(script.ServerSizeValidator).Start()
end

return AntiCheat
