local Rayfield = loadstring(Game:HttpGet('https://sirius.menu/rayfield'))()

-- Variables for controlling walk speed, jump settings
local WalktoggleEnabled = false
local walkSpeedValue = 16 -- Default walk speed
local JumptoggleEnabled = false
local JumpHeightValue = 7 -- Default jump height
local infiJumptoggleEnabled = false 
local FlightSpeed = 2
local FlightToggleEnabled = false -- Infinite jump toggle

local Window = Rayfield:CreateWindow({
   Name = "UniversalScript",
   Icon = 0,
   LoadingTitle = "UniversalScript",
   LoadingSubtitle = "by Jackie and Sanjoy",
   Theme = "Default",

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, 
      FileName = "UniScript"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink", 
      RememberJoins = true
   },

   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", 
      FileName = "Key",
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Hello"}
   }
})

Window.ModifyTheme("DarkBlue")

local Tab = Window:CreateTab("Player", nil)

Rayfield:Notify({
   Title = "Script executed",
   Content = "The Script Was Successfully executed",
   Duration = 6.5,
   Image = 4483362458,
})

local Section = Tab:CreateSection("Player Speed")

-- Slider for Walk Speed
local SpeedSlider = Tab:CreateSlider({
   Name = "Walk Speed",
   Range = {0, 300},
   Increment = 10,
   Suffix = "Speed",
   CurrentValue = walkSpeedValue,
   Flag = "Slider1",
   Callback = function(Value)
      walkSpeedValue = Value
      if WalktoggleEnabled then
         local player = Game.Players.LocalPlayer
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
   Callback = function(Value)
      WalktoggleEnabled = Value
      local player = Game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoid = character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         if WalktoggleEnabled then
            humanoid.WalkSpeed = walkSpeedValue
         else
            humanoid.WalkSpeed = 16
         end
      end
   end,
})

-- New feature: Fake Walking (Game thinks the player is walking)
local function fakeWalking()
    if WalktoggleEnabled then
        local player = Game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

        if humanoid and humanoidRootPart then
            -- Lock position in place but move at normal speed
            local currentVelocity = humanoidRootPart.Velocity
            local walkDirection = humanoid.MoveDirection -- Direction of movement

            -- Mimic walk speed but stop actual movement
            if walkDirection.Magnitude > 0 then
                humanoidRootPart.Velocity = walkDirection.Unit * walkSpeedValue
            else
                humanoidRootPart.Velocity = Vector3.new(0, currentVelocity.Y, 0) -- Keep vertical velocity (gravity, jumping) intact
            end
        end
    end
end

game:GetService("RunService").Heartbeat:Connect(fakeWalking)

-- Jump Height Settings
local Section2 = Tab:CreateSection("Player Jump")
local JumpSlider = Tab:CreateSlider({
   Name = "Jump Height",
   Range = {0, 300},
   Increment = 10,
   Suffix = "Jump",
   CurrentValue = JumpHeightValue,
   Flag = "Slider2",
   Callback = function(Value)
      JumpHeightValue = Value
   end,
})

-- Jump Toggle
local JumpToggle = Tab:CreateToggle({
   Name = "Enable Jump Height",
   CurrentValue = false,
   Flag = "Toggle2",
   Callback = function(Value)
      JumptoggleEnabled = Value
      local player = Game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoid = character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         if JumptoggleEnabled then
            humanoid.JumpHeight = JumpHeightValue
         else
            humanoid.JumpHeight = 7
         end
      end
   end,
})

-- Simulate a high jump with an immediate fall
local function fakeJump()
    if JumptoggleEnabled then
        local player = Game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

        if humanoid and humanoidRootPart then
            if humanoid:GetState() == Enum.HumanoidStateType.Seated or humanoid:GetState() == Enum.HumanoidStateType.Physics then
                return -- Avoid interfering with specific states like sitting
            end
            
            -- Simulate an immediate jump without a slow fall
            if humanoid.Jump then
                humanoid:ChangeState(Enum.HumanoidStateType.Physics) -- Simulate the jump state
                humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, JumpHeightValue, humanoidRootPart.Velocity.Z)
                -- Instant fall: adjust vertical velocity immediately after the jump
                humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, 0, humanoidRootPart.Velocity.Z)
            end
        end
    end
end


-- Infinite Jump behavior
game:GetService("UserInputService").JumpRequest:Connect(function()
    if infiJumptoggleEnabled then
        local player = Game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics) -- Ensure the humanoid is not stuck in the jump state
            humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, JumpHeightValue, humanoidRootPart.Velocity.Z)
        end
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if not infiJumptoggleEnabled then
        local player = Game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

        if humanoid and humanoidRootPart then
            if humanoid:GetState() == Enum.HumanoidStateType.Physics then
                humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, 0, humanoidRootPart.Velocity.Z) -- Prevent infinite jumping
            end
        end
    end
end)

game:GetService("RunService").Heartbeat:Connect(fakeJump)

-- The rest of your script...



-- Flight, NoClip, Combat, and Misc tabs (unchanged) will go here as you have them in the original script







local Flight = Tab:CreateSection("Flight")

-- Flight Section

local flightEnabled = false
local flightSpeed = 2
local bodyVelocity = nil

local FlightSpeedSlider = Tab:CreateSlider({
    Name = "Flight Speed",
    Range = {1, 50},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = flightSpeed,
    Flag = "FlightSpeedSlider",
    Callback = function(Value)
        flightSpeed = Value
    end,
})

local FlightToggle = Tab:CreateToggle({
    Name = "Enable Flight",
    CurrentValue = false,
    Flag = "FlightToggle",
    Callback = function(Value)
        flightEnabled = Value
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            if flightEnabled then
                -- Create BodyVelocity for flight
                bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
                bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
                bodyVelocity.Velocity = Vector3.zero
                bodyVelocity.P = 10000
            else
                -- Remove BodyVelocity when flight is disabled
                if bodyVelocity then
                    bodyVelocity:Destroy()
                    bodyVelocity = nil
                end
            end
        end
    end,
})

-- Flight Movement Logic
game:GetService("RunService").RenderStepped:Connect(function()
    if flightEnabled and bodyVelocity then
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            local moveDirection = Vector3.zero
            local userInput = game:GetService("UserInputService")

            -- W/A/S/D for directional movement
            if userInput:IsKeyDown(Enum.KeyCode.W) then
                moveDirection += workspace.CurrentCamera.CFrame.LookVector
            end
            if userInput:IsKeyDown(Enum.KeyCode.S) then
                moveDirection -= workspace.CurrentCamera.CFrame.LookVector
            end
            if userInput:IsKeyDown(Enum.KeyCode.A) then
                moveDirection -= workspace.CurrentCamera.CFrame.RightVector
            end
            if userInput:IsKeyDown(Enum.KeyCode.D) then
                moveDirection += workspace.CurrentCamera.CFrame.RightVector
            end

            -- Space/Shift for vertical movement
            if userInput:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection += Vector3.new(0, 1, 0)
            end
            if userInput:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection -= Vector3.new(0, 1, 0)
            end

            -- Normalize direction and apply flight speed
            if moveDirection.Magnitude > 0 then
                moveDirection = moveDirection.Unit * flightSpeed
            end

            bodyVelocity.Velocity = moveDirection
        end
    end
end)


local NoClip = Tab:CreateSection("NoClip")

-- NoClip Toggle
local noClipEnabled = false

local NoClipToggle = Tab:CreateToggle({
    Name = "Enable NoClip",
    CurrentValue = false,
    Flag = "NoClipToggle",
    Callback = function(Value)
        noClipEnabled = Value
    end,
})

-- NoClip Logic
game:GetService("RunService").Stepped:Connect(function()
    if noClipEnabled then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

























--COMBAT--



-- Combat Tab
local CombatTab = Window:CreateTab("Combat", nil)

-- Variables for Aimbot
local aimbotEnabled = false
local fovRadius = 50 -- Default FOV radius
local fovCircleVisible = false
local targetPlayer = nil
local rmbPressed = false -- Tracks if RMB is pressed
local aimSpeed = 0.2 -- Controls the speed of smooth aiming (0.1 = slower, 1 = instant)

-- Create Section for Aimbot
local aimbotSection = CombatTab:CreateSection("Aimbot")

-- FOV Slider
local fovSlider = CombatTab:CreateSlider({
    Name = "Aimbot FOV Radius",
    Range = {10, 200},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = fovRadius,
    Flag = "FovRadiusSlider",
    Callback = function(value)
        fovRadius = value
    end
})

-- FOV Circle Toggle
local fovToggle = CombatTab:CreateToggle({
    Name = "Show FOV Circle",
    CurrentValue = false,
    Flag = "FovCircleToggle",
    Callback = function(Value)
        fovCircleVisible = Value
    end
})

-- Aimbot Toggle (GUI)
local aimbotToggle = CombatTab:CreateToggle({
    Name = "Toggle Aimbot",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(Value)
        aimbotEnabled = Value
    end
})

-- Aim Speed Slider
local aimSpeedSlider = CombatTab:CreateSlider({
    Name = "Aimbot Smoothness",
    Range = {0.1, 1},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = aimSpeed,
    Flag = "AimSpeedSlider",
    Callback = function(value)
        aimSpeed = value
    end
})

-- Draw the FOV circle
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 2
fovCircle.Filled = false
fovCircle.Color = Color3.fromRGB(255, 0, 0) -- Red circle for the FOV

-- Function to find the closest player in FOV and on the opposite team
local function isVisible(target)
    local camera = game:GetService("Workspace").CurrentCamera
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character}

    local rayResult = workspace:Raycast(camera.CFrame.Position, (target.Position - camera.CFrame.Position).Unit * 1000, rayParams)

    return rayResult and rayResult.Instance and rayResult.Instance:IsDescendantOf(target.Parent)
end

local function getClosestPlayer()
    local closestDistance = math.huge
    local closestPlayer = nil
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return nil end

    local camera = game:GetService("Workspace").CurrentCamera
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

    -- Iterate through all players
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Team ~= player.Team and otherPlayer.Character then
            local target = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if target and target:IsA("BasePart") and isVisible(target) then
                local targetScreenPos, onScreen = camera:WorldToViewportPoint(target.Position)

                -- Check if the player is visible on screen and within the FOV circle
                if onScreen then
                    local distanceFromCenter = (Vector2.new(targetScreenPos.X, targetScreenPos.Y) - screenCenter).Magnitude

                    if distanceFromCenter <= fovRadius then
                        -- Check if the player is the closest
                        local distance = (target.Position - humanoidRootPart.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = otherPlayer
                        end
                    end
                end
            end
        end
    end

    return closestPlayer
end

-- Smoothly aim at the target
local function smoothAimAtTarget(targetHumanoidRootPart)
    local camera = game:GetService("Workspace").CurrentCamera
    local targetPosition = targetHumanoidRootPart.Position
    local newCFrame = CFrame.new(camera.CFrame.Position, targetPosition)

    -- Smoothly interpolate the camera's CFrame toward the target
    camera.CFrame = camera.CFrame:Lerp(newCFrame, aimSpeed)
end

-- Perform aimbot logic
local function aimbot()
    if not aimbotEnabled or not rmbPressed then
        return -- Don't proceed if aimbot is disabled or RMB isn't pressed
    end

    -- Find the closest player
    targetPlayer = getClosestPlayer()
    if targetPlayer and targetPlayer.Character then
        local targetHumanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetHumanoidRootPart and targetHumanoidRootPart:IsA("BasePart") then
            smoothAimAtTarget(targetHumanoidRootPart)
        end
    end
end

-- Update the FOV circle and handle aimbot logic
game:GetService("RunService").RenderStepped:Connect(function()
    local camera = game:GetService("Workspace").CurrentCamera

    -- Update the FOV circle visibility and position
    if fovCircleVisible then
        local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
        fovCircle.Position = screenCenter
        fovCircle.Radius = fovRadius
        fovCircle.Visible = true
    else
        fovCircle.Visible = false
    end

    -- Run the aimbot logic
    aimbot()
end)

-- Handle RMB to activate/deactivate aimbot
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        rmbPressed = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        rmbPressed = false
    end
end)

-- Toggle FOV visibility using a keybind
local keybind = Enum.KeyCode.LeftAlt -- Keybind to toggle FOV visibility

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == keybind then
        fovCircleVisible = not fovCircleVisible
    end
end)















--MISC--



local MiscTab = Window:CreateTab("Misc", nil) 
local Player Size = MiscTab:CreateSection("Player Size (Errors May Occur)")


-- Player Size Variables
local sizeEnabled = false
local sizeScale = 1 -- Default size (1 = normal size)
local originalSizes = {} -- Table to store original part sizes

-- Player Size Slider
local SizeSlider = MiscTab:CreateSlider({
    Name = "Player Size",
    Range = {0.5, 5}, -- Adjust the range to set minimum and maximum sizes
    Increment = 0.1,
    Suffix = "Scale",
    CurrentValue = sizeScale,
    Flag = "SizeSlider",
    Callback = function(Value)
        sizeScale = Value
        if sizeEnabled then
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            -- Scale all parts proportionally and store original sizes
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    -- Store the original size if not already stored
                    if not originalSizes[part] then
                        originalSizes[part] = part.Size
                    end
                    -- Scale the part size proportionally
                    part.Size = originalSizes[part] * sizeScale
                end
            end
            -- Rescale the humanoid's properties
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                -- Apply available scaling properties
                humanoid.BodyWidthScale = humanoid.BodyWidthScale and humanoid.BodyWidthScale * sizeScale or humanoid.BodyWidthScale
                humanoid.BodyHeightScale = humanoid.BodyHeightScale and humanoid.BodyHeightScale * sizeScale or humanoid.BodyHeightScale
                humanoid.BodyDepthScale = humanoid.BodyDepthScale and humanoid.BodyDepthScale * sizeScale or humanoid.BodyDepthScale
                humanoid.HeadScale = humanoid.HeadScale * sizeScale
            end
        end
    end,
})

-- Player Size Toggle
local SizeToggle = MiscTab:CreateToggle({
    Name = "Enable Player Size (ClientSide)",
    CurrentValue = false,
    Flag = "SizeToggle",
    Callback = function(Value)
        sizeEnabled = Value
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        if sizeEnabled then
            -- Apply size scaling proportionally and store original sizes
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    -- Store the original size if not already stored
                    if not originalSizes[part] then
                        originalSizes[part] = part.Size
                    end
                    -- Scale the part size proportionally
                    part.Size = originalSizes[part] * sizeScale
                end
            end
            -- Rescale the humanoid's properties
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                -- Apply available scaling properties
                humanoid.BodyWidthScale = humanoid.BodyWidthScale and humanoid.BodyWidthScale * sizeScale or humanoid.BodyWidthScale
                humanoid.BodyHeightScale = humanoid.BodyHeightScale and humanoid.BodyHeightScale * sizeScale or humanoid.BodyHeightScale
                humanoid.BodyDepthScale = humanoid.BodyDepthScale and humanoid.BodyDepthScale * sizeScale or humanoid.BodyDepthScale
                humanoid.HeadScale = humanoid.HeadScale * sizeScale
            end
        else
            -- Reset size to original values
            for part, originalSize in pairs(originalSizes) do
                if part and part.Parent then
                    part.Size = originalSize
                end
            end
            -- Reset humanoid scaling properties to default
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.BodyWidthScale = 1
                humanoid.BodyHeightScale = 1
                humanoid.BodyDepthScale = 1
                humanoid.HeadScale = 1
            end
        end
    end,
})
