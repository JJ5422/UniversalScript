-- RobloxClasses ModuleScript (Store all Roblox classes)
local RobloxClasses = {}

-- Game services
RobloxClasses.Players = game:GetService("Players")
RobloxClasses.Workspace = game:GetService("Workspace")
RobloxClasses.ReplicatedStorage = game:GetService("ReplicatedStorage")
RobloxClasses.ServerStorage = game:GetService("ServerStorage")
RobloxClasses.Lighting = game:GetService("Lighting")
RobloxClasses.SoundService = game:GetService("SoundService")
RobloxClasses.StarterGui = game:GetService("StarterGui")
RobloxClasses.StarterPack = game:GetService("StarterPack")
RobloxClasses.StarterPlayer = game:GetService("StarterPlayer")
RobloxClasses.Teams = game:GetService("Teams")
RobloxClasses.Chat = game:GetService("Chat")
RobloxClasses.Debris = game:GetService("Debris")
RobloxClasses.HttpService = game:GetService("HttpService")
RobloxClasses.DataStoreService = game:GetService("DataStoreService")
RobloxClasses.RunService = game:GetService("RunService")
RobloxClasses.TweenService = game:GetService("TweenService")
RobloxClasses.PathfindingService = game:GetService("PathfindingService")
RobloxClasses.UserInputService = game:GetService("UserInputService")
RobloxClasses.ContextActionService = game:GetService("ContextActionService")
RobloxClasses.MarketplaceService = game:GetService("MarketplaceService")
RobloxClasses.MessagingService = game:GetService("MessagingService")
RobloxClasses.AssetService = game:GetService("AssetService")

-- Local player
RobloxClasses.LocalPlayer = RobloxClasses.Players.LocalPlayer

-- Player-related classes
if RobloxClasses.LocalPlayer then
    RobloxClasses.Backpack = RobloxClasses.LocalPlayer:FindFirstChild("Backpack")
    RobloxClasses.Character = RobloxClasses.LocalPlayer.Character or RobloxClasses.LocalPlayer.CharacterAdded:Wait()
    RobloxClasses.PlayerGui = RobloxClasses.LocalPlayer:FindFirstChild("PlayerGui")
    RobloxClasses.PlayerScripts = RobloxClasses.LocalPlayer:FindFirstChild("PlayerScripts")
    if RobloxClasses.Character then
        RobloxClasses.Humanoid = RobloxClasses.Character:FindFirstChildOfClass("Humanoid")
        RobloxClasses.Head = RobloxClasses.Character:FindFirstChild("Head")
    end
end

-- Workspace-related classes
RobloxClasses.CurrentCamera = RobloxClasses.Workspace.CurrentCamera
RobloxClasses.Terrain = RobloxClasses.Workspace:FindFirstChildOfClass("Terrain")

-- Other classes
RobloxClasses.Part = Instance.new("Part")
RobloxClasses.Model = Instance.new("Model")
RobloxClasses.Script = Instance.new("Script")
RobloxClasses.LocalScript = Instance.new("LocalScript")
RobloxClasses.Tool = Instance.new("Tool")
RobloxClasses.VehicleSeat = Instance.new("VehicleSeat")
RobloxClasses.SurfaceGui = Instance.new("SurfaceGui")
RobloxClasses.ScreenGui = Instance.new("ScreenGui")
RobloxClasses.TextLabel = Instance.new("TextLabel")
RobloxClasses.TextButton = Instance.new("TextButton")

return RobloxClasses
