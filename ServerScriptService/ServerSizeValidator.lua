-- ServerScriptService/ServerSizeValidator.lua
local Players = game:GetService("Players")
local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "SizeValidation"
RemoteEvent.Parent = game.ReplicatedStorage

return {
    Start = function()
        RemoteEvent.OnServerEvent:Connect(function(player, reportedSize)
            local character = player.Character
            if not character then return end
            
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            -- Size validation check
            if (reportedSize - hrp.Size).Magnitude > 0.5 then
                player:Kick("SD01")
            end
        end)

        -- Periodic verification
        game:GetService("RunService").Heartbeat:Connect(function()
            for _, player in ipairs(Players:GetPlayers()) do
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    RemoteEvent:FireClient(player, char.HumanoidRootPart.Size)
                end
            end
        end)
    end
}
