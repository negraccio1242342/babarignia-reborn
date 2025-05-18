Script = {
    Drawing = {}
}

Script.Drawing.intro = Drawing.new("Text")
Script.Drawing.intro.Text = "Index Is Loading.."
Script.Drawing.intro.Size = 20
Script.Drawing.intro.Color = Color3.new(1.000000, 1.000000, 1.000000)
Script.Drawing.intro.Outline = true
Script.Drawing.intro.OutlineColor = Color3.fromRGB(0, 0, 0)
Script.Drawing.intro.Visible = true
Script.Drawing.intro.Font = 2

local camera = workspace.CurrentCamera
Script.Drawing.intro.Position = Vector2.new(camera.ViewportSize.X / 2.2, camera.ViewportSize.Y - 370)

task.spawn(function()
    while true do
        for i = 0, 1, 0.1 do
            Script.Drawing.intro.Transparency = i
            task.wait(0.05)
        end
        for i = 1, 0, -0.1 do
            Script.Drawing.intro.Transparency = i
            task.wait(0.05)
        end
    end
end)

local startoftheintro = tick()
wait(2)
local LOADED = tick() - startoftheintro

Script.Drawing.intro:Remove()
Script.Drawing.Loaded = Drawing.new("Text")
Script.Drawing.Loaded.Text = "Loaded In " .. string.format("%.3f", LOADED) .. " sec"
Script.Drawing.Loaded.Size = 20
Script.Drawing.Loaded.Color = Color3.new(1.000000, 1.000000, 1.000000)
Script.Drawing.Loaded.Outline = true
Script.Drawing.Loaded.OutlineColor = Color3.fromRGB(0, 0, 0)
Script.Drawing.Loaded.Visible = true
Script.Drawing.Loaded.Position = Vector2.new(camera.ViewportSize.X / 2.2, camera.ViewportSize.Y - 370)
Script.Drawing.Loaded.Font = 2

task.spawn(function()
    for i = 0, 1, 0.1 do
        Script.Drawing.Loaded.Transparency = i
        task.wait(0.05)
    end
    wait(1)
    for i = 1, 0, -0.1 do
        Script.Drawing.Loaded.Transparency = i
        task.wait(0.05)
    end
    Script.Drawing.Loaded:Remove()
end)

wait(1)
local variable = true
if getgenv().JairoUGHH == true then
    if variable == true then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Index",
            Text = "Updated",
            Duration = 0.01
        })
    end
    return --// returns to check if the get globalenvirontment is enabled once agains
end


--//  Services and Players
local click = false
local rotate = 0
local render = 0
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jairo = Players.LocalPlayer

local function Args()
    if string.find(identifyexecutor(), 'Solara') then
        local i = game.PlaceId
        local Argument
        if i == 2788229376 or i == 7213786345 or i == 16033173781 then
            Argument = "UpdateMousePosI2"
        elseif i == 9825515356 then
            Argument = "MousePosUpdate"
        else
            Argument = "UpdateMousePos"
        end
        return Argument
    end
end

local Script = { --// variables for the table, target etc
    Table = getgenv().Index,
    Target = nil,
    MainEvent = nil,
    Argument = Args(),
    Functions = {},
    Connections = {},
}


if Script.Table.Start.IntroBlur.Active then
    Script.Functions.PlayThatBitch = function()
        local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "IntroScreen"
        screenGui.Parent = playerGui

        local frame = Instance.new("Frame")
        frame.Name = "IntroFrame"
        frame.Parent = screenGui
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1

        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Name = "IntroImage"
        imageLabel.Parent = frame
        imageLabel.Size = UDim2.new(0.01, 0, 0.01, 0)  
        imageLabel.Position = UDim2.new(0.5, -0.1, 0.5, -0.1) 
        imageLabel.Image = "rbxassetid://106428636831184"
        imageLabel.BackgroundTransparency = 1
        imageLabel.ImageTransparency = 100
        imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)

        local sound = Instance.new("Sound")
        sound.Name = "IntroSound"
        sound.Parent = frame
        sound.SoundId = "rbxassetid://6580172940"
        sound.Volume = 50
        sound:Play()

        local tweenService = game:GetService("TweenService")

        local blurEffect = Instance.new("BlurEffect")
        blurEffect.Parent = game.Lighting
        blurEffect.Size = 60

        local zoomTweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)  
        local blurTweenInfo = TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)  

        local fadeIn = tweenService:Create(imageLabel, zoomTweenInfo, {ImageTransparency = 0.5})
        local fadeOut = tweenService:Create(imageLabel, zoomTweenInfo, {ImageTransparency = 1})
        local blurTween = tweenService:Create(blurEffect, blurTweenInfo, {Size = 0})  
        local zoomTween = tweenService:Create(imageLabel, zoomTweenInfo, {Size = UDim2.new(0.35, 0, 0.35, 0)})

        fadeIn:Play()
        fadeIn.Completed:Wait()

        zoomTween:Play()
        blurTween:Play()

        wait(3)  

        fadeOut:Play()
        fadeOut.Completed:Wait()

        blurTween:Play()
        blurTween.Completed:Wait()

        blurEffect:Destroy()
        screenGui:Destroy()
    end

    Script.Functions.PlayThatBitch()
end


--// FOV
local RunService = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local Gui = game:GetService("GuiService")
local Camera = workspace.CurrentCamera
local mouse = Player:GetMouse()
local insetX, insetY = Gui:GetGuiInset().X, Gui:GetGuiInset().Y
local rs = game:GetService("RunService")

Script.Functions.GetClosest = function() --// functions to get player near cursor this basically detects the player humanoidrootpart based on mouselocation of localplayers
    local Target
    local Closest = math.huge
    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= Jairo and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local PartPos, OnScreen = Camera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
            local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - UserInputService:GetMouseLocation()).Magnitude
            if Magnitude < Closest and OnScreen then
                Target = Player
                Closest = Magnitude
            end
        end
    end
    return Target
end

--// Main Drwaing functions
local Fov = getgenv().Index.Start.Silent.Fov
local blunt = Drawing.new("Circle")
blunt.Radius = Fov.Radius
blunt.Transparency = Fov.Transparency
blunt.Thickness = Fov.Thickness
blunt.Visible = Fov.Visible
blunt.Color = Fov.Color


--// I used Inset To make it goes to the middle 
Script.Connections.FovOptimization = rs.RenderStepped:Connect(function()
    blunt.Position = Vector2.new(mouse.X + insetX, mouse.Y + insetY)
end)

Script.Functions.NearestPlayer = function()
    local Target
    local Closest = math.huge
    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= Jairo and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local PartPos, OnScreen = Camera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
            local MouseLocation = UserInputService:GetMouseLocation()
            local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - MouseLocation).Magnitude
            if Magnitude < Closest and Magnitude <= blunt.Radius and OnScreen then
                Target = Player
                Closest = Magnitude
            end
        end
    end
    return Target
end



local player = game.Players.LocalPlayer
local Mouse = player:GetMouse()


Script.Functions.GetClosestPart = function(player)
    local MaxDistance = math.huge
    local ClosestPart = nil
 
    for value, index in pairs(player.Character:GetChildren()) do
        if table.find({"Part", "MeshPart", "BasePart"}, index.ClassName) then
            local Position = workspace.CurrentCamera:WorldToScreenPoint(index.Position)
            local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(mouse.X, Mouse.Y)).Magnitude
            if Distance < MaxDistance then
                ClosestPart = index
                MaxDistance = Distance
            end
        end
    end
    return ClosestPart
 end
Script.Functions.ResolvedVelocity = function(bodypart, delta, lastpos)
    local ggpos = bodypart.Position
    local tick = tick()
    local timepos = ggpos - lastpos
    local deltatime = tick - delta

    deltatime = math.clamp(deltatime, 0, 0.033333333333333)

    local latestvel = timepos / deltatime

    return latestvel, ggpos, tick
end

Script.Functions.POS = function()
    local silentSettings = getgenv().Index and getgenv().Index.Start.Silent
    local target

    if not silentSettings then return end

    if silentSettings.Type == "Fov" then
        target = Script.Functions.NearestPlayer()
    elseif silentSettings.Type == "Target" then
        target = Script.Target
    end

    if target and target.Character then
        local character = target.Character
        local bodyEffects = character:FindFirstChild("BodyEffects")
        local KOd = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
        local humanoid = character:FindFirstChild("Humanoid")
        
        if getgenv().Index.Start.Misc.Checks.KO and humanoid and (humanoid.Health <= 0 or KOd) then
            target = nil
        end

        if target and character then
            local targetPart = character:FindFirstChild(getgenv().Index.Start.Silent.TargetParts)
            local airPart = character:FindFirstChild(getgenv().Index.Start.Silent.Air)

            if targetPart then
                local prediction = targetPart.Velocity * silentSettings.Prediction
                local position

                if character:FindFirstChild("Humanoid") and character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                    targetPart = airPart
                    position = targetPart and targetPart.CFrame or nil
                else
                    position = targetPart.CFrame
                end
                
                if getgenv().Index.Start.Misc.Resolver.Active then
                local parts = getgenv().Index.Start.Silent.TargetParts
                local formula = Script.Functions.ResolvedVelocity(targetPart, tick(), targetPart.Position)
                local endpoint = targetPart.Position + formula * silentSettings.Prediction
                return CFrame.new(endpoint)
                elseif silentSettings.ClosestPart then
                    local closestPart = Script.Functions.GetClosestPart(target)
                    local endpoint = closestPart and closestPart.Position + prediction
                    return CFrame.new(endpoint)
                else
                    local predictedPosition = position + prediction
                    return predictedPosition
                end
            end
        end
    end
end

Script.Functions.POS2 = function()
    local silentSettings = getgenv().Index and getgenv().Index.Start.Silent
    local target

    if not silentSettings then return end

    if silentSettings.Type == "Fov" then
        target = Script.Functions.NearestPlayer()
    elseif silentSettings.Type == "Target" then
        target = Script.Target
    end

    if target and target.Character then
        local character = target.Character
        local bodyEffects = character:FindFirstChild("BodyEffects")
        local KOd = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
        local humanoid = character:FindFirstChild("Humanoid")
        
        if getgenv().Index.Start.Misc.Checks.KO and humanoid and (humanoid.Health <= 0 or KOd) then
            target = nil
        end

        if target and character then
            local targetPart = character:FindFirstChild(getgenv().Index.Start.Silent.TargetParts)
            local airPart = character:FindFirstChild(getgenv().Index.Start.Silent.Air)

            if targetPart then
                local prediction = targetPart.Velocity * silentSettings.Prediction
                local position

                if character:FindFirstChild("Humanoid") and character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                    targetPart = airPart
                    position = targetPart and targetPart.Position or nil
                else
                    position = targetPart.Position
                end
                
                if getgenv().Index.Start.Misc.Resolver.Active then
                local parts = getgenv().Index.Start.Silent.TargetParts
                local formula = Script.Functions.ResolvedVelocity(targetPart, tick(), targetPart.Position)
                local endpoint = targetPart.Position + formula * silentSettings.Prediction
                return endpoint
                elseif silentSettings.ClosestPart then
                    local closestPart = Script.Functions.GetClosestPart(target)
                    local endpoint = closestPart and closestPart.Position + prediction
                    return endpoint
                else
                    local predictedPosition = position + prediction
                    return predictedPosition
                end
            end
        end
    end
end

if game.PlaceId == 9825515356 then
    RunService.PostSimulation:Connect(function()
        local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
        local framework = playerGui:WaitForChild("Framework", math.huge)
        
        if framework then
            local env = getsenv(framework)
            if env and env._G then
                local BIGNIGGER = Script.Functions.POS2()
                if BIGNIGGER then
                    env._G.MOUSE_POSITION = BIGNIGGER
                end
            end
        end
    end)
end

if game.PlaceId ~= 9825515356 and not string.find(identifyexecutor(), "Solara") 
    and not string.find(identifyexecutor(), "Wave") 
    and not string.find(identifyexecutor(), "Xeno") 
    and not string.find(identifyexecutor(), "Synapse Z") then
    
    local grm = getrawmetatable(game)
    local MousePosChanger2 = nil
    setreadonly(grm, false)
    MousePosChanger2 = grm.__index
    grm.__index = function(self, Index)
        if not checkcaller() and self == Mouse then
            if Index == "Hit" then
                local EndPoint = Script.Functions.POS()
                if EndPoint then
                    return EndPoint
                end
            elseif Index == "Target" and game.PlaceId == 2788229376 then
                local EndPoint = Script.Functions.POS()
                if EndPoint then
                    return EndPoint
                end
            end
        end
        return MousePosChanger2(self, Index)
    end
end



--// Keybind  NOT OPTIMIZED i got lazy
Script.Connections.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input, gameProcessedEvent)
    if gameProcessedEvent then return end

    local keybind = getgenv().Index.Start.AimBot.Keybind
    local aimBotActive = getgenv().Index.Start.AimBot.Active

    if Input.KeyCode == Enum.KeyCode[keybind] and aimBotActive then
        if Script.Target then
            Script.Target = nil
        else
            Script.Target = Script.Functions.GetClosest()
            if Script.Target then
                if getgenv().Index.Start.AimBot.Notification then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "INDEX",
                        Text = "opps: " .. Script.Target.DisplayName,
                        Duration = 0.001,
                    })
                end
            end
        end
    end
end)


local p_lr = game.Players.LocalPlayer
local players = game:GetService("Players")
local vec3 = Vector3.new
local renderstepped = game:GetService("RunService").RenderStepped

Utility = {}

if game.PlaceId == 2788229376 then
    Utility.HitBoxExpander = function()
        if getgenv().Index.Start.HitboxExpander.Enabled then
            for _, player in ipairs(players:GetPlayers()) do
                if player ~= p_lr then
                    local character = player.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local part = character.HumanoidRootPart
                    if getgenv().Index.Start.HitboxExpander.Scaling.Enabled then
                        part.Size = Vector3.new(
                            getgenv().Index.Start.HitboxExpander.Scaling.X,
                            getgenv().Index.Start.HitboxExpander.Scaling.Y,
                            getgenv().Index.Start.HitboxExpander.Scaling.Z
                        )
                    else
                        part.Size = Vector3.new(
                            getgenv().Index.Start.HitboxExpander.NormalSize,
                            getgenv().Index.Start.HitboxExpander.NormalSize,
                            getgenv().Index.Start.HitboxExpander.NormalSize
                        )
                    end
                        part.Transparency = 1
                        part.CanCollide = false
    
                        if getgenv().Index.Start.HitboxExpander.Visualize then
                            local edgeAdornment = part:FindFirstChild("HitboxEdges") or Instance.new("SelectionBox")
                            edgeAdornment.Name = "HitboxEdges"
                            edgeAdornment.Adornee = part
                            edgeAdornment.LineThickness = 0.05
                            edgeAdornment.SurfaceColor3 = Color3.fromRGB(0, 0, 255)
                            edgeAdornment.SurfaceTransparency = 0.9
                            edgeAdornment.Parent = part
                        end
                    end
                end
            end
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if game.PlaceId == 2788229376 then
            Utility.HitBoxExpander()
        end
    end)
end)


Script.Functions.isAirborne = function(player)
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    return humanoid and humanoid:GetState() == Enum.HumanoidStateType.Freefall
end
--// AImbot
Script.Functions.rewrittenAimbot = function()
    if not Script.Target or not Script.Target.Character then return end

    local bodyEffects = Script.Target.Character:FindFirstChild("BodyEffects")
    if not bodyEffects then return end

    local KOd = bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
    local humanoid = Script.Target.Character:FindFirstChild("Humanoid")
    if getgenv().Index.Start.Misc.Checks.KO and humanoid and (humanoid.Health <= 0 or KOd) then
        Script.Target = nil
        return
    end

    local partName = tostring(getgenv().Index.Start.AimBot.TargetParts)
    local Parts = Script.Target.Character:FindFirstChild(partName)
    if not Parts then return end

    local Smooth = getgenv().Index.Start.AimBot.Smoothness
    local future = getgenv().Index.Start.AimBot.Predictions
    local AirSmoothness = getgenv().Index.Start.MouseTp.LerpValues
    local airpreds = getgenv().Index.Start.MouseTp.MousePredictions

    if getgenv().Index.Start.MouseTp.Active and Script.Functions.isAirborne(Script.Target) then
        future = airpreds
        Smooth = AirSmoothness
    end

    local runService = game:GetService("RunService")
    if getgenv().Index.Start.Misc.Resolver.Active and Parts then
        local lastPosition = Parts.Position
        task.wait()
        local currentPosition = Parts.Position
        local velocity = (currentPosition - lastPosition) / runService.RenderStepped:Wait()
        Parts.AssemblyLinearVelocity = velocity
        Parts.Velocity = velocity
    end

    local futurepos = Parts.Position + Parts.Velocity * future
    if getgenv().Index.Start.AimbotOffsets.Active and humanoid then
        local humanoidState = humanoid:GetState()
        if humanoidState == Enum.HumanoidStateType.Freefall then
            futurepos = futurepos + Vector3.new(0, getgenv().Index.Start.AimbotOffsets.Jump, 0)
        else
            futurepos = futurepos + Vector3.new(0, getgenv().Index.Start.AimBot.Fall, 0)
        end
    end

    local Endpoint = Script.Functions.GetClosestPart(Script.Target)
    local Mainendpoint = Endpoint.Position + Parts.Velocity * future

    local TargetCamera
    if getgenv().Index.Start.AimBot.ClosestPart then
        TargetCamera = CFrame.new(workspace.CurrentCamera.CFrame.Position, Mainendpoint)
    else
        TargetCamera = CFrame.new(workspace.CurrentCamera.CFrame.Position, futurepos)
    end
    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(TargetCamera, Smooth,Enum.EasingStyle[getgenv().Index.Start.Style.Easing],Enum.EasingDirection[getgenv().Index.Start.Style.Direction])
end



local settings = getgenv().Index.Start
local isActive = false
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")

Script.Functions.handleMacro = function()
    local acceleration = settings.Misc.Macro.Acceleration
    if type(acceleration) ~= "number" then
        warn("Invalid Acceleration value") --// To handle a Value and make the variables from table to be enable only using number
        return
    end
    
    local speed = acceleration / 100000

    if settings.Misc.Macro.Variety == "Third" then
        repeat
            task.wait(speed)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.I, false, game)
            task.wait(speed)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.O, false, game)
            task.wait(speed)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.I, false, game)
            task.wait(speed)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.O, false, game)
        until not isActive
    elseif settings.Misc.Macro.Variety == "First" then
        repeat
            VirtualInputManager:SendMouseWheelEvent("0", "0", true, game)
            wait(speed)
            VirtualInputManager:SendMouseWheelEvent("0", "0", false, game)
            wait(speed)
            VirtualInputManager:SendMouseWheelEvent("0", "0", true, game)
            wait(speed)
            VirtualInputManager:SendMouseWheelEvent("0", "0", false, game)
            wait(speed)
        until not isActive
    end
end

Script.Functions.onInputBegan = function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode[settings.Misc.Macro.Keybind] then
        isActive = not isActive
        if isActive then
            Script.Functions.handleMacro()
        end
    end
end

UserInputService.InputBegan:Connect(Script.Functions.onInputBegan)

--// got this from my old tb kinda sucks 


Script.Functions.isDead = function(player)
    local character = player.Character
    if not character or not character:FindFirstChild("BodyEffects") then
        return false
    end
    local bodyEffects = character.BodyEffects
    local ko = bodyEffects:FindFirstChild("K.O") or bodyEffects:FindFirstChild("KO")
    return ko and ko.Value or false
end

Script.Functions.getTarget = function(instance)
    if not instance then
        return false
    end

    for _, player in next, Players:GetPlayers() do
        if player.Character and (instance == player.Character or instance:IsDescendantOf(player.Character)) then
            if not Script.Functions.isDead(player) then
                return player
            end
        end
    end

    return false
end

Script.Functions.isToolBlacklisted = function(tool)
    for _, toolName in ipairs(Script.Table.Start.TriggerBot.Blacklisted) do
        if tool.Name == toolName then
            return true
        end
    end
    return false
end
Script.Functions.sendNotification = function(message)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Notification",
        Text = message,
        Duration = 2
    })
end

local JAIROUGH = false
Script.Functions.onKeyPress = function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode[Script.Table.Start.TriggerBot.Keybind] then
        JAIROUGH = not JAIROUGH
        if Script.Table.Start.TriggerBot.Notification then
            Script.Functions.sendNotification("TriggerBot " .. (JAIROUGH and "Enabled" or "Disabled"))
        end
    end
end

UserInputService.InputBegan:Connect(Script.Functions.onKeyPress)

Script.Functions.triggerBot = function()
    local con
    con = RunService.Heartbeat:Connect(function()
        if JAIROUGH then
            local target = mouse.Target

            if target and Script.Functions.getTarget(target) then
                if Jairo.Character then
                    local tool = Jairo.Character:FindFirstChildWhichIsA('Tool')
                    if tool and not Script.Functions.isToolBlacklisted(tool) then
                        if tool then
                            task.wait(Script.Table.Start.TriggerBot.Delay)
                            tool:Activate() --// tool activate is the best method
                        end
                    end
                end
            end
        end
    end)

    Script.Connections.triggerBot = con
end



Script.Functions.triggerBot()

getgenv().disable = function()
    getgenv().disable = nil
    warn("Disconnecting:", Script.Connections.triggerBot)
    Script.Connections.triggerBot:Disconnect() --// disconnect the fucking triggerbot when its disabled from the keybind 
end

--// ass rotation
Script.Functions.onKeyPress = function(Input, GameProcessedEvent)
    if Input.KeyCode == Enum.KeyCode[getgenv().Index.Start.Misc.Spin.Keybind] and not GameProcessedEvent then
        click = not click
    end
end

Script.Functions.getDirectionVector = function(direction)
    if direction == "North" then
        return Vector3.new(0, 1, 0)
    elseif direction == "South" then
        return Vector3.new(0, -1, 0)
    elseif direction == "East" then
        return Vector3.new(1, 0, 0)
    elseif direction == "West" then
        return Vector3.new(-1, 0, 0)
    else
        return Vector3.new(0, 1, 0)
    end
end

Script.Functions.rotateCamera = function()
    if click then
        local currentTime = tick()
        local timeDelta = math.min(currentTime - render, 0.01)
        render = currentTime

        local rotationSpeed = getgenv().Index.Start.Misc.Spin.Acceleration * timeDelta
        local smoothRotation = rotationSpeed * getgenv().Index.Start.Misc.Spin.Smoothness

        local directionVector = Script.Functions.getDirectionVector(getgenv().Index.Start.Misc.Spin.Directions)
        local rotation = CFrame.fromAxisAngle(directionVector, math.rad(smoothRotation))
        Camera.CFrame = Camera.CFrame * rotation

        rotate = rotate + rotationSpeed
        if rotate >= getgenv().Index.Start.Misc.Spin.Degrees then
            click = false
            rotate = 0
        end
    end
end

UserInputService.InputBegan:Connect(Script.Functions.onKeyPress)


UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode[getgenv().Index.Start.Misc.Resolver.Keybind] then
        local resolver = getgenv().Index.Start.Misc.Resolver
        if resolver.Active then
            resolver.Active = false
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Resolver OFF",
                Text = "igettoomanyhuzz",
                Duration = 2,
            })
        else
            resolver.Active = true
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Resolver ON",
                Text = "igettoomanyhuzz",
                Duration = 2,
            })
        end
    end
end)








local Players = game:GetService("Players")
local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()











local isSpeeding = false

Mouse.KeyDown:Connect(function(key)
    if getgenv().Index.Start.Misc.WalkSpeed.Active and key:lower() == getgenv().Index.Start.Misc.WalkSpeed.Keybind:lower() then
        isSpeeding = not isSpeeding

        local character = Client.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = isSpeeding and getgenv().Index.Start.Misc.WalkSpeed.Speed or 20

                humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                    humanoid.WalkSpeed = isSpeeding and getgenv().Index.Start.Misc.WalkSpeed.Speed or 20
                end)
            end
        end
    end
end)

 Script.Functions.RemoveJumpCooldown = function(Character)
    if Character then
        if getgenv().Index.Start.Misc.NoJumpCoolDown.Active then
            local hum = Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:GetPropertyChangedSignal("JumpPower"):Connect(function()
                    if hum.JumpPower ~= 55 then
                        hum.JumpPower = 55
                    end
                end)
            end
        end
    end
end

Script.Functions.RemoveJumpCooldown(character)

player.CharacterAdded:Connect(function(newCharacter)
    Script.Functions.RemoveJumpCooldown(newCharacter)
end)

RunService.RenderStepped:Connect(function()
if getgenv().Index.Start.HitboxExpander.Enabled and game.PlaceId == 2788229376 then
    Utility.HitBoxExpander()
    end
    if Script.Target then
        Script.Functions.rewrittenAimbot()
    end
    Script.Functions.rotateCamera()
end)





getgenv().JairoUGHH = true
