local gui = Instance.new("ScreenGui")
gui.Name = "UI"
gui.Parent = game:GetService("CoreGui")

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 400)
main.Position = UDim2.new(0, 10, 0, 10)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Text = "ScriptSpy v1"
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.Size = UDim2.new(0, 200, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.Font = Enum.Font.Code
title.TextSize = 18
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, 0, 1, -40)
content.Position = UDim2.new(0, 0, 0, 40)
content.BackgroundTransparency = 1

local tabs = Instance.new("ScrollingFrame", content)
tabs.Size = UDim2.new(0, 120, 1, 0)
tabs.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabs.CanvasSize = UDim2.new(0, 9999, 0, 999999999)
tabs.ScrollBarThickness = 6
tabs.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
tabs.ClipsDescendants = true

local tabStroke = Instance.new("UIStroke", tabs)
tabStroke.Color = Color3.fromRGB(60, 60, 60)
tabStroke.Thickness = 1

local funcs = Instance.new("Frame", content)
funcs.Size = UDim2.new(1, -125, 1, -10)
funcs.Position = UDim2.new(0, 125, 0, 5)
funcs.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local funcScroll = Instance.new("ScrollingFrame", funcs)
funcScroll.Size = UDim2.new(1, 0, 1, 0)
funcScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
funcScroll.ScrollBarThickness = 6
funcScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
funcScroll.BackgroundTransparency = 1
funcScroll.ClipsDescendants = true
funcScroll.ScrollingEnabled = true

local funcStroke = Instance.new("UIStroke", funcs)
funcStroke.Color = Color3.fromRGB(60, 60, 60)
funcStroke.Thickness = 1

local tabLayout = Instance.new("UIListLayout", tabs)
tabLayout.FillDirection = Enum.FillDirection.Vertical
tabLayout.Padding = UDim.new(0, 5)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

local funcLayout = Instance.new("UIListLayout", funcScroll)
funcLayout.FillDirection = Enum.FillDirection.Vertical
funcLayout.Padding = UDim.new(0, 5)

local function CreateTab(name)
    local btn = Instance.new("TextButton", tabs)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name
    btn.Font = Enum.Font.Code
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.BackgroundTransparency = 1
    btn.TextSize = 14
    return btn
end

local function CreatePage(script)
    local page = Instance.new("Frame", funcScroll)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false

    local result = decompile(script) or "Failed Decompile"

    local info = Instance.new("TextLabel", page)
    info.Size = UDim2.new(1, -20, 0, 0)
    info.Position = UDim2.new(0, 10, 0, 10)
    info.BackgroundTransparency = 1
    info.TextWrapped = true
    info.AutomaticSize = Enum.AutomaticSize.Y
    info.Text = result
    info.TextColor3 = Color3.fromRGB(200, 200, 200)
    info.Font = Enum.Font.Code
    info.TextSize = 14
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.TextYAlignment = Enum.TextYAlignment.Top

    task.defer(function()
        funcScroll.CanvasSize = UDim2.new(0, 0, 0, info.TextBounds.Y + 20)
    end)

    return page
end

local function AddCorner(parent)
    Instance.new("UICorner", parent).CornerRadius = UDim.new(0, 6)
end

AddCorner(main)
AddCorner(tabs)
AddCorner(funcs)

local tabList = {}
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
        table.insert(tabList, {Name = obj.Name, Page = CreatePage(obj)})
    end
end

local function UpdateTabSize()
    tabs.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 10)
end

for index, tab in ipairs(tabList) do
    local tabBtn = CreateTab(tab.Name)
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in ipairs(tabList) do
            t.Page.Visible = false
        end
        tab.Page.Visible = true
    end)

    tab.Page.Parent = funcScroll

    if index == 1 then
        tab.Page.Visible = true
    end

    task.defer(UpdateTabSize)
end
