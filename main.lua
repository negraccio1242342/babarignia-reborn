local ModernUI = {}
local Utility = {}

-- Core setup
do
    local startupArgs = ({...})[1] or {}
    
    if getgenv().ModernUI then
        getgenv().ModernUI:Unload()
    end

    if not game:IsLoaded() then
        game.Loaded:Wait()
    end

    local function GetService(service)
        return game:GetService(service)
    end

    -- Services
    local Players = GetService('Players')
    local HttpService = GetService('HttpService')
    local RunService = GetService('RunService')
    local UserInputService = GetService('UserInputService')
    local TweenService = GetService('TweenService')
    local ContextActionService = GetService('ContextActionService')
    
    local LocalPlayer = Players.LocalPlayer

    -- Math shortcuts
    local floor, ceil, huge, pi, clamp = math.floor, math.ceil, math.huge, math.pi, math.clamp
    local Color3New, FromRGB, FromHSV = Color3.new, Color3.fromRGB, Color3.fromHSV
    local NewInstance, NewUDim2, NewVector2 = Instance.new, UDim2.new, Vector2.new

    -- Library table
    ModernUI = {
        Windows = {},
        Indicators = {},
        Flags = {},
        Options = {},
        Connections = {},
        Drawings = {},
        Instances = {},
        Notifications = {},
        Tweens = {},
        Theme = {},
        
        ZIndexOrder = {
            Indicator = 950,
            Window = 1000,
            Dropdown = 1200,
            ColorPicker = 1100,
            Watermark = 1300,
            Notification = 1400,
            Cursor = 1500,
        },
        
        Stats = {
            FPS = 0,
            Ping = 0,
        },
        
        Images = {
            GradientP90 = 'rbxassetid://1234567890',
            GradientP45 = 'rbxassetid://1234567891',
            ColorHue = 'rbxassetid://1234567892',
            ColorTrans = 'rbxassetid://1234567893',
        },
        
        Open = false,
        Opening = false,
        HasInit = false,
        Name = startupArgs.name or 'ModernUI',
        GameName = startupArgs.gamename or 'Universal',
        FileExt = startupArgs.fileext or '.cfg',
    }

    -- Modern theme
    ModernUI.Themes = {
        {
            Name = 'Modern Dark',
            Theme = {
                Accent = FromRGB(0, 150, 255),
                Background = FromRGB(25, 25, 30),
                BackgroundSecondary = FromRGB(35, 35, 40),
                BackgroundTertiary = FromRGB(45, 45, 50),
                Border = FromRGB(60, 60, 70),
                BorderHover = FromRGB(80, 80, 90),
                TextPrimary = FromRGB(240, 240, 240),
                TextSecondary = FromRGB(200, 200, 200),
                TextTertiary = FromRGB(160, 160, 160),
                TextAccent = FromRGB(0, 180, 255),
                TextRisky = FromRGB(255, 80, 80),
                TextRiskyEnabled = FromRGB(255, 120, 120),
            }
        }
    }

    -- Utility functions
    function Utility:Create(class, properties)
        local inst = NewInstance(class)
        for prop, val in pairs(properties or {}) do
            pcall(function() inst[prop] = val end)
        end
        return inst
    end

    function Utility:Tween(object, property, target, duration, easingStyle, easingDirection)
        easingStyle = easingStyle or Enum.EasingStyle.Quad
        easingDirection = easingDirection or Enum.EasingDirection.Out
        
        local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
        local tween = TweenService:Create(object, tweenInfo, {[property] = target})
        tween:Play()
        return tween
    end

    function Utility:CreateSignal()
        local signal = {
            Connections = {},
            
            Connect = function(self, callback)
                local connection = {
                    Callback = callback,
                    Disconnect = function(self)
                        signal.Connections[self] = nil
                    end
                }
                signal.Connections[connection] = true
                return connection
            end,
            
            Fire = function(self, ...)
                for connection in pairs(self.Connections) do
                    connection.Callback(...)
                end
            end
        }
        return signal
    end

    -- Drawing utilities
    function Utility:CreateDrawing(class, properties)
        local drawing = Drawing.new(class)
        for prop, val in pairs(properties or {}) do
            pcall(function() drawing[prop] = val end)
        end
        return drawing
    end

    -- More utility functions would go here...
end

-- Window class
function ModernUI:CreateWindow(config)
    local window = {
        Title = config.title or "Window",
        Size = config.size or NewUDim2(0, 600, 0, 500), -- Wider than original
        Position = config.position or NewUDim2(0, 100, 0, 100),
        Open = false,
        Tabs = {},
        CurrentTab = nil,
        Objects = {}
    }

    -- Create window visuals
    do
        -- Main background
        window.Objects.Background = Utility:CreateDrawing('Square', {
            Size = window.Size,
            Position = window.Position,
            Color = ModernUI.Theme.Background,
            Filled = true,
            ZIndex = ModernUI.ZIndexOrder.Window
        })

        -- Outer border (thicker with rounded effect)
        window.Objects.BorderOuter = Utility:CreateDrawing('Square', {
            Size = window.Size + NewVector2(6, 6),
            Position = window.Position - NewVector2(3, 3),
            Color = ModernUI.Theme.Border,
            Filled = false,
            Thickness = 3,
            ZIndex = ModernUI.ZIndexOrder.Window - 1
        })

        -- Inner border (subtle accent)
        window.Objects.BorderInner = Utility:CreateDrawing('Square', {
            Size = window.Size - NewVector2(4, 4),
            Position = window.Position + NewVector2(2, 2),
            Color = ModernUI.Theme.Accent,
            Filled = false,
            Thickness = 1,
            ZIndex = ModernUI.ZIndexOrder.Window + 1
        })

        -- Title bar
        window.Objects.TitleBar = Utility:CreateDrawing('Square', {
            Size = NewUDim2(1, 0, 0, 30),
            Position = window.Position,
            Color = ModernUI.Theme.BackgroundSecondary,
            Filled = true,
            ZIndex = ModernUI.ZIndexOrder.Window + 2
        })

        -- Title text
        window.Objects.TitleText = Utility:CreateDrawing('Text', {
            Position = window.Position + NewVector2(10, 8),
            Text = window.Title,
            Color = ModernUI.Theme.TextPrimary,
            Size = 18,
            Font = 2,
            Outline = true,
            ZIndex = ModernUI.ZIndexOrder.Window + 3
        })

        -- Tab container
        window.Objects.TabContainer = Utility:CreateDrawing('Square', {
            Size = NewUDim2(1, -20, 0, 30),
            Position = window.Position + NewVector2(10, 40),
            Color = ModernUI.Theme.BackgroundTertiary,
            Filled = true,
            ZIndex = ModernUI.ZIndexOrder.Window + 1
        })

        -- Content area
        window.Objects.ContentArea = Utility:CreateDrawing('Square', {
            Size = NewUDim2(1, -20, 1, -80),
            Position = window.Position + NewVector2(10, 80),
            Color = ModernUI.Theme.BackgroundSecondary,
            Filled = true,
            ZIndex = ModernUI.ZIndexOrder.Window + 1
        })
    end

    -- Tab functions
    function window:AddTab(name)
        local tab = {
            Name = name,
            Sections = {},
            Objects = {}
        }

        -- Create tab visuals
        tab.Objects.Button = Utility:CreateDrawing('Square', {
            Size = NewUDim2(0, 100, 0, 25),
            Position = window.Objects.TabContainer.Position + NewVector2(#window.Tabs * 105, 2),
            Color = ModernUI.Theme.BackgroundTertiary,
            Filled = true,
            ZIndex = ModernUI.ZIndexOrder.Window + 2
        })

        tab.Objects.Text = Utility:CreateDrawing('Text', {
            Position = tab.Objects.Button.Position + NewVector2(10, 5),
            Text = name,
            Color = ModernUI.Theme.TextSecondary,
            Size = 14,
            Font = 2,
            ZIndex = ModernUI.ZIndexOrder.Window + 3
        })

        -- Hover effects
        local originalColor = tab.Objects.Button.Color
        local originalTextColor = tab.Objects.Text.Color

        tab.Objects.Button.MouseEnter = function()
            Utility:Tween(tab.Objects.Button, 'Color', ModernUI.Theme.BackgroundSecondary, 0.2)
            Utility:Tween(tab.Objects.Text, 'Color', ModernUI.Theme.TextPrimary, 0.2)
        end

        tab.Objects.Button.MouseLeave = function()
            if window.CurrentTab ~= tab then
                Utility:Tween(tab.Objects.Button, 'Color', originalColor, 0.2)
                Utility:Tween(tab.Objects.Text, 'Color', originalTextColor, 0.2)
            end
        end

        -- Click handler
        tab.Objects.Button.MouseButton1Down = function()
            window:SelectTab(tab)
        end

        table.insert(window.Tabs, tab)
        if #window.Tabs == 1 then
            window:SelectTab(tab)
        end

        return tab
    end

    function window:SelectTab(tab)
        if window.CurrentTab then
            -- Deselect current tab
            Utility:Tween(window.CurrentTab.Objects.Button, 'Color', ModernUI.Theme.BackgroundTertiary, 0.2)
            Utility:Tween(window.CurrentTab.Objects.Text, 'Color', ModernUI.Theme.TextSecondary, 0.2)
        end

        -- Select new tab
        window.CurrentTab = tab
        Utility:Tween(tab.Objects.Button, 'Color', ModernUI.Theme.Background, 0.2)
        Utility:Tween(tab.Objects.Text, 'Color', ModernUI.Theme.TextAccent, 0.2)
    end

    -- Section functions
    function window:AddSection(tab, name, side)
        local section = {
            Name = name,
            Side = side or 1, -- 1 for left, 2 for right
            Options = {},
            Objects = {}
        }

        -- Create section visuals
        local xPos = (section.Side == 1) and 15 or (window.Size.X.Offset / 2 + 5)
        
        section.Objects.Background = Utility:CreateDrawing('Square', {
            Size = NewUDim2(0, (window.Size.X.Offset / 2) - 25, 0, 200),
            Position = window.Objects.ContentArea.Position + NewVector2(xPos, 15),
            Color = ModernUI.Theme.Background,
            Filled = true,
            ZIndex = ModernUI.ZIndexOrder.Window + 2
        })

        section.Objects.Border = Utility:CreateDrawing('Square', {
            Size = section.Objects.Background.Size + NewVector2(2, 2),
            Position = section.Objects.Background.Position - NewVector2(1, 1),
            Color = ModernUI.Theme.Border,
            Filled = false,
            Thickness = 1,
            ZIndex = ModernUI.ZIndexOrder.Window + 1
        })

        section.Objects.Title = Utility:CreateDrawing('Text', {
            Position = section.Objects.Background.Position + NewVector2(10, 5),
            Text = name,
            Color = ModernUI.Theme.TextPrimary,
            Size = 16,
            Font = 2,
            ZIndex = ModernUI.ZIndexOrder.Window + 3
        })

        section.Objects.Divider = Utility:CreateDrawing('Line', {
            From = section.Objects.Background.Position + NewVector2(10, 25),
            To = section.Objects.Background.Position + NewVector2(section.Objects.Background.Size.X - 10, 25),
            Color = ModernUI.Theme.Border,
            Thickness = 1,
            ZIndex = ModernUI.ZIndexOrder.Window + 3
        })

        table.insert(tab.Sections, section)
        return section
    end

    -- Option creation functions would go here (Toggle, Slider, Button, etc.)
    -- Each would include modern hover effects and styling

    -- Window visibility control
    function window:SetVisible(visible)
        window.Open = visible
        for _, obj in pairs(window.Objects) do
            obj.Visible = visible
        end
    end

    -- Add to library
    table.insert(ModernUI.Windows, window)
    return window
end

-- Initialize library
function ModernUI:Init()
    if self.HasInit then return end
    
    -- Create cursor
    self.Cursor = {
        Main = Utility:CreateDrawing('Triangle', {
            Color = Color3New(1, 1, 1),
            Filled = true,
            ZIndex = self.ZIndexOrder.Cursor
        }),
        Shadow = Utility:CreateDrawing('Triangle', {
            Color = Color3New(0.3, 0.3, 0.3),
            Filled = true,
            ZIndex = self.ZIndexOrder.Cursor - 1
        })
    }

    -- Input handling
    self.InputBegan = Utility:CreateSignal()
    self.InputEnded = Utility:CreateSignal()
    self.MouseMoved = Utility:CreateSignal()

    -- More initialization code would go here...

    self.HasInit = true
end

-- Unload function
function ModernUI:Unload()
    for _, connection in pairs(self.Connections) do
        connection:Disconnect()
    end
    
    for _, drawing in pairs(self.Drawings) do
        drawing:Remove()
    end
    
    getgenv().ModernUI = nil
end

return ModernUI
