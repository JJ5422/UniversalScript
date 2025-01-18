local RobloxClasses = require(game.ReplicatedStorage.RobloxClasses)

local Rayfield = loadstring(RobloxClasses:HttpGet('https://sirius.menu/rayfield'))()


-- Variables for controlling walk speed
local WalktoggleEnabled = false
local walkSpeedValue = 16 -- Default walk speed
-- Variables for controlling walk speed
local JumptoggleEnabled = false
local JumpHeightValue = 7 -- Default walk speed



 

local Window = Rayfield:CreateWindow({
   Name = "UniversalScript",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "UniversalScript",
   LoadingSubtitle = "by Jackie and Sanjoy",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "UniScript"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})






local Tab = Window:CreateTab("Player", nil) -- Title, Image


Rayfield:Notify({
   Title = "Script executed",
   Content = "The Script Was Successfully executed",
   Duration = 6.5,
   Image = 4483362458,
})



local Section = Tab:CreateSection("Player Speed")

-- Slider
-- Walk Speed Slider
local SpeedSlider = Tab:CreateSlider({
   Name = "Walk Speed",
   Range = {0, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = walkSpeedValue,
   Flag = "Slider1",
   Callback = function(Value) -- Corrected
      walkSpeedValue = Value
      if WalktoggleEnabled then -- Check if the toggle is enabled
         local player = RobloxClasses.Players.LocalPlayer
         local character = player.Character or player.CharacterAdded:Wait()
         local humanoid = character:FindFirstChildOfClass("Humanoid")
         if humanoid then
            humanoid.WalkSpeed = walkSpeedValue
         end
      end
   end,
})

-- Walk Speed Toggle
local SpeedToggle = Tab:CreateToggle({
   Name = "Enable Walk Speed",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value) -- Corrected
      WalktoggleEnabled = Value -- Update toggle state
      local player = RobloxClasses.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoid = character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         if WalktoggleEnabled then
            humanoid.WalkSpeed = walkSpeedValue -- Apply the current walk speed
         else
            humanoid.WalkSpeed = 16 -- Reset to default walk speed when disabled
         end
      end
   end,
})

local Divider1 = Tab:CreateDivider()

local Section2 = Tab:CreateSection("Player Jump")

-- Jump Height Slider
local JumpSlider = Tab:CreateSlider({
   Name = "Jump Height",
   Range = {0, 300},
   Increment = 1,
   Suffix = "Jump",
   CurrentValue = JumpHeightValue,
   Flag = "Slider2",
   Callback = function(Value) -- Corrected
      JumpHeightValue = Value
      if JumptoggleEnabled then -- Check if the toggle is enabled
         local player = RobloxClasses.Players.LocalPlayer
         local character = player.Character or player.CharacterAdded:Wait()
         local humanoid = character:FindFirstChildOfClass("Humanoid")
         if humanoid then
            humanoid.JumpHeight = JumpHeightValue
         end
      end
   end,
})

-- Jump Height Toggle
local JumpToggle = Tab:CreateToggle({
   Name = "Enable Jump Height",
   CurrentValue = false,
   Flag = "Toggle2",
   Callback = function(Value) -- Corrected
      JumptoggleEnabled = Value -- Update toggle state
      local player = RobloxClasses.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoid = character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         if JumptoggleEnabled then
            humanoid.JumpHeight = JumpHeightValue -- Apply the current jump height
         else
            humanoid.JumpHeight = 7 -- Reset to default jump height when disabled
         end
      end
   end,
})

