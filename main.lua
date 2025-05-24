local UILib = {}

-- Theme settings
UILib.Theme = {
    PrimaryColor = Color3.fromRGB(25, 25, 25),
    SecondaryColor = Color3.fromRGB(40, 40, 40),
    AccentColor = Color3.fromRGB(0, 120, 215),
    TextColor = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.Gotham
}

-- Create main window
function UILib:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TabHolder = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    
    -- Basic properties
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.Name = "UILib"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = UILib.Theme.PrimaryColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = UILib.Theme.SecondaryColor
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Font = UILib.Theme.Font
    Title.Text = title
    Title.TextColor3 = UILib.Theme.TextColor
    Title.TextSize = 16
    
    -- Add drag functionality
    local UserInputService = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    Title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    Title.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Tab holder setup
    TabHolder.Name = "TabHolder"
    TabHolder.Parent = MainFrame
    TabHolder.BackgroundColor3 = UILib.Theme.SecondaryColor
    TabHolder.BorderSizePixel = 0
    TabHolder.Position = UDim2.new(0, 0, 0, 30)
    TabHolder.Size = UDim2.new(1, 0, 0, 30)
    
    UIListLayout.Parent = TabHolder
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    -- Store tabs
    local tabs = {}
    
    -- Add tab function
    function MainFrame:AddTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name
        TabButton.Parent = TabHolder
        TabButton.BackgroundColor3 = UILib.Theme.SecondaryColor
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(0, 80, 1, 0)
        TabButton.Font = UILib.Theme.Font
        TabButton.Text = name
        TabButton.TextColor3 = UILib.Theme.TextColor
        TabButton.TextSize = 14
        
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = name.."Content"
        TabContent.Parent = MainFrame
        TabContent.Active = true
        TabContent.BackgroundColor3 = UILib.Theme.PrimaryColor
        TabContent.BorderSizePixel = 0
        TabContent.Position = UDim2.new(0, 0, 0, 60)
        TabContent.Size = UDim2.new(1, 0, 1, -60)
        TabContent.Visible = false
        TabContent.ScrollBarThickness = 5
        
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = TabContent
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)
        
        -- Button functionality
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(tabs) do
                tab.Content.Visible = false
                tab.Button.BackgroundColor3 = UILib.Theme.SecondaryColor
            end
            TabContent.Visible = true
            TabButton.BackgroundColor3 = UILib.Theme.AccentColor
        end)
        
        -- Store tab
        tabs[name] = {
            Button = TabButton,
            Content = TabContent
        }
        
        -- Select first tab
        if #tabs == 1 then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = UILib.Theme.AccentColor
        end
        
        return TabContent
    end
    
    return MainFrame
end

-- Create button element
function UILib:CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text
    Button.Parent = parent
    Button.BackgroundColor3 = UILib.Theme.SecondaryColor
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(1, -10, 0, 30)
    Button.Font = UILib.Theme.Font
    Button.Text = text
    Button.TextColor3 = UILib.Theme.TextColor
    Button.TextSize = 14
    
    Button.MouseButton1Click:Connect(callback)
    
    return Button
end

-- Create toggle element
function UILib:CreateToggle(parent, text, default, callback)
    local ToggleFrame = Instance.new("Frame")
    local ToggleButton = Instance.new("TextButton")
    local ToggleStatus = Instance.new("Frame")
    
    ToggleFrame.Name = text.."Toggle"
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Size = UDim2.new(1, -10, 0, 30)
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = UILib.Theme.SecondaryColor
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleButton.Font = UILib.Theme.Font
    ToggleButton.Text = text
    ToggleButton.TextColor3 = UILib.Theme.TextColor
    ToggleButton.TextSize = 14
    ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
    
    ToggleStatus.Name = "ToggleStatus"
    ToggleStatus.Parent = ToggleFrame
    ToggleStatus.BackgroundColor3 = default and UILib.Theme.AccentColor or Color3.fromRGB(80, 80, 80)
    ToggleStatus.BorderSizePixel = 0
    ToggleStatus.Position = UDim2.new(0.75, 5, 0.2, 0)
    ToggleStatus.Size = UDim2.new(0.25, -10, 0.6, 0)
    
    local toggled = default
    
    local function updateToggle()
        ToggleStatus.BackgroundColor3 = toggled and UILib.Theme.AccentColor or Color3.fromRGB(80, 80, 80)
        callback(toggled)
    end
    
    ToggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        updateToggle()
    end)
    
    ToggleStatus.MouseButton1Click:Connect(function()
        toggled = not toggled
        updateToggle()
    end)
    
    return {
        Set = function(value)
            toggled = value
            updateToggle()
        end,
        Get = function()
            return toggled
        end
    }
end

return UILib
