-- Load cattoware UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TynaRan/Decoder/refs/heads/main/cat%20(1).txt"))()

-- Create main window
local Window = Library:CreateWindow("btye.cc", Vector2.new(492, 598), Enum.KeyCode.RightControl)
local MainTab = Window:CreateTab("Main")
local VisualsTab = Window:CreateTab("Visuals")
local ConfigTab = Window:CreateTab("Config")

-- Universal ESP Library
local UniversalESP = {}
UniversalESP.Settings = {
    Enabled = false,
    Boxes = true,
    Names = true,
    HealthBars = true,
    Distances = true,
    Tracers = false,
    Skeletons = false,
    HeadDots = false,
    TeamColor = true,
    VisibleOnly = true,
    BoxColor = Color3.new(1, 1, 1),
    TextColor = Color3.new(1, 1, 1),
    TextSize = 13,
    Font = 2,
    TeamCheck = false,
    MaxDistance = 1000,
    TracerOrigin = "Bottom",
    SkeletonColor = Color3.new(1, 0, 0),
    HeadDotSize = 5
}

-- Internal references
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
UniversalESP.Objects = {}
UniversalESP.PlayerConnections = {}
UniversalESP.UpdateConnection = nil

-- Drawing templates
local DrawingTemplates = {
    Box = function()
        local box = Drawing.new("Square")
        box.Thickness = 1
        box.Filled = false
        box.ZIndex = 2
        return box
    end,
    Name = function()
        local text = Drawing.new("Text")
        text.Size = UniversalESP.Settings.TextSize
        text.Center = true
        text.Outline = true
        text.ZIndex = 3
        return text
    end,
    HealthBar = function()
        local line = Drawing.new("Line")
        line.Thickness = 2
        line.ZIndex = 1
        return line
    end,
    HealthText = function()
        local text = Drawing.new("Text")
        text.Size = UniversalESP.Settings.TextSize - 2
        text.Center = true
        text.Outline = true
        text.ZIndex = 4
        return text
    end,
    Distance = function()
        local text = Drawing.new("Text")
        text.Size = UniversalESP.Settings.TextSize
        text.Center = true
        text.Outline = true
        text.ZIndex = 3
        return text
    end,
    Tracer = function()
        local line = Drawing.new("Line")
        line.Thickness = 1
        line.ZIndex = 1
        return line
    end,
    HeadDot = function()
        local circle = Drawing.new("Circle")
        circle.Thickness = 1
        circle.Filled = true
        circle.ZIndex = 5
        return circle
    end,
    Bone = function()
        local line = Drawing.new("Line")
        line.Thickness = 1
        line.ZIndex = 1
        return line
    end
}

-- Bone connections for skeleton ESP
local BONE_CONNECTIONS = {
    {from = "HumanoidRootPart", to = "UpperTorso"},
    {from = "UpperTorso", to = "LowerTorso"},
    {from = "UpperTorso", to = "LeftUpperArm"},
    {from = "LeftUpperArm", to = "LeftLowerArm"},
    {from = "LeftLowerArm", to = "LeftHand"},
    {from = "UpperTorso", to = "RightUpperArm"},
    {from = "RightUpperArm", to = "RightLowerArm"},
    {from = "RightLowerArm", to = "RightHand"},
    {from = "LowerTorso", to = "LeftUpperLeg"},
    {from = "LeftUpperLeg", to = "LeftLowerLeg"},
    {from = "LeftLowerLeg", to = "LeftFoot"},
    {from = "LowerTorso", to = "RightUpperLeg"},
    {from = "RightUpperLeg", to = "RightLowerLeg"},
    {from = "RightLowerLeg", to = "RightFoot"},
    {from = "UpperTorso", to = "Head"}
}

-- Utility functions
local function worldToViewport(position)
    local vector, visible = Camera:WorldToViewportPoint(position)
    return Vector2.new(vector.X, vector.Y), visible, vector.Z
end

local function getTeamColor(player)
    if UniversalESP.Settings.TeamColor and player.Team then
        return player.TeamColor.Color
    end
    return UniversalESP.Settings.BoxColor
end

local function isPartVisible(part, origin, target)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {LocalPlayer.Character, part.Parent}
    params.IgnoreWater = true
    
    local result = workspace:Raycast(origin, (target - origin).Unit * (origin - target).Magnitude, params)
    return not result
end

-- Object management
function UniversalESP:AddPlayer(player)
    if self.Objects[player] then return end
    
    local espObject = {
        Type = "Player",
        Character = nil,
        Humanoid = nil,
        HRP = nil,
        Head = nil,
        Components = {},
        BoneConnections = {},
        Connections = {}
    }
    
    for name, creator in pairs(DrawingTemplates) do
        espObject.Components[name] = creator()
    end
    
    for i = 1, #BONE_CONNECTIONS do
        espObject.Components["Bone"..tostring(i)] = DrawingTemplates.Bone()
    end
    
    self.Objects[player] = espObject
    
    local function addCharacter(character)
        espObject.Character = character
        espObject.Humanoid = character:WaitForChild("Humanoid")
        espObject.HRP = character:WaitForChild("HumanoidRootPart")
        espObject.Head = character:WaitForChild("Head")
        
        espObject.Bones = {}
        for _, boneName in ipairs({"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart",
                                  "LeftUpperArm", "LeftLowerArm", "LeftHand",
                                  "RightUpperArm", "RightLowerArm", "RightHand",
                                  "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
                                  "RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
            local bone = character:FindFirstChild(boneName)
            if bone then
                espObject.Bones[boneName] = bone
            end
        end
        
        table.insert(espObject.Connections, espObject.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if espObject.Humanoid then
                espObject.Health = espObject.Humanoid.Health
                espObject.MaxHealth = espObject.Humanoid.MaxHealth
            end
        end))
    end

    if player.Character then
        addCharacter(player.Character)
    end
    
    table.insert(espObject.Connections, player.CharacterAdded:Connect(addCharacter))
    table.insert(espObject.Connections, player.CharacterRemoving:Connect(function()
        espObject.Character = nil
        espObject.Humanoid = nil
        espObject.HRP = nil
        espObject.Head = nil
        espObject.Bones = nil
    end))
end

function UniversalESP:RemoveObject(obj)
    local espObject = self.Objects[obj]
    if not espObject then return end
    
    if espObject.Connections then
        for _, conn in ipairs(espObject.Connections) do
            conn:Disconnect()
        end
    end
    
    for _, drawing in pairs(espObject.Components) do
        drawing:Remove()
    end
    
    self.Objects[obj] = nil
end

-- Library controls
function UniversalESP:Toggle(state)
    self.Settings.Enabled = state
    
    if state then
        if not self.UpdateConnection then
            self.UpdateConnection = RunService.Heartbeat:Connect(function()
                self:Update()
            end)
        end
    else
        for _, espObject in pairs(self.Objects) do
            for _, drawing in pairs(espObject.Components) do
                drawing.Visible = false
            end
        end
    end
end

function UniversalESP:Update()
    if not self.Settings.Enabled then return end
    
    local cameraPos = Camera.CFrame.Position
    
    for obj, espObject in pairs(self.Objects) do
        local position, visible, depth, distance
        
        if espObject.Type == "Player" then
            local character = espObject.Character
            local hrp = espObject.HRP
            
            if character and hrp then
                position = hrp.Position
                local screenPos, onScreen, depth = worldToViewport(position)
                distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) 
                    and (position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude 
                    or 0
                
                if (not onScreen) or (depth < 0) or (distance > self.Settings.MaxDistance) then
                    self:SetVisible(espObject, false)
                    continue
                end
                
                if self.Settings.VisibleOnly then
                    onScreen = isPartVisible(hrp, cameraPos, position)
                end
                
                if not onScreen then
                    self:SetVisible(espObject, false)
                    continue
                end
                
                self:UpdatePlayerESP(espObject, obj, screenPos, depth, distance)
                self:SetVisible(espObject, true)
                
                continue
            else
                self:SetVisible(espObject, false)
            end
        end
    end
end

function UniversalESP:SetVisible(espObject, state)
    for _, drawing in pairs(espObject.Components) do
        drawing.Visible = state
    end
end

-- ESP component updates
function UniversalESP:UpdatePlayerESP(espObject, player, screenPos, depth, distance)
    local scaleFactor = 1 / (depth * math.tan(math.rad(Camera.FieldOfView * 0.5)) * 2) * 1000
    local width = 4 * scaleFactor
    local height = 6 * scaleFactor
    local teamColor = getTeamColor(player)
    
    -- Box
    if self.Settings.Boxes then
        local box = espObject.Components.Box
        box.Visible = true
        box.Color = teamColor
        box.Size = Vector2.new(width, height)
        box.Position = screenPos - Vector2.new(width/2, height/2)
    else
        espObject.Components.Box.Visible = false
    end
    
    -- Name
    if self.Settings.Names then
        local nameText = espObject.Components.Name
        nameText.Visible = true
        nameText.Text = player.Name
        nameText.Color = self.Settings.TextColor
        nameText.Position = screenPos - Vector2.new(0, height/2 + 15)
        nameText.Size = self.Settings.TextSize
    else
        espObject.Components.Name.Visible = false
    end
    
    -- Health Bar
    if self.Settings.HealthBars and espObject.Health and espObject.MaxHealth then
        local healthPercentage = math.clamp(espObject.Health / espObject.MaxHealth, 0, 1)
        local barWidth = width
        local barPos = screenPos + Vector2.new(-width/2, height/2 + 5)
        
        local healthBar = espObject.Components.HealthBar
        healthBar.Visible = true
        healthBar.Color = Color3.new(1 - healthPercentage, healthPercentage, 0)
        healthBar.From = barPos
        healthBar.To = barPos + Vector2.new(barWidth * healthPercentage, 0)
        
        local healthText = espObject.Components.HealthText
        healthText.Visible = true
        healthText.Text = tostring(math.floor(espObject.Health))
        healthText.Color = self.Settings.TextColor
        healthText.Position = barPos + Vector2.new(barWidth/2, -12)
    else
        espObject.Components.HealthBar.Visible = false
        espObject.Components.HealthText.Visible = false
    end
    
    -- Distance
    if self.Settings.Distances then
        local distanceText = espObject.Components.Distance
        distanceText.Visible = true
        distanceText.Text = string.format("[%d]", distance)
        distanceText.Color = self.Settings.TextColor
        distanceText.Position = screenPos + Vector2.new(0, height/2 + 5)
    else
        distanceText.Visible = false
    end
    
    -- Tracers
    if self.Settings.Tracers then
        local tracer = espObject.Components.Tracer
        tracer.Visible = true
        tracer.Color = teamColor
        
        local originY
        if self.Settings.TracerOrigin == "Top" then
            originY = 0
        elseif self.Settings.TracerOrigin == "Middle" then
            originY = Camera.ViewportSize.Y / 2
        else
            originY = Camera.ViewportSize.Y
        end
        
        tracer.From = Vector2.new(Camera.ViewportSize.X / 2, originY)
        tracer.To = screenPos
    else
        espObject.Components.Tracer.Visible = false
    end
    
    -- Head Dots
    if self.Settings.HeadDots and espObject.Head then
        local headPos = worldToViewport(espObject.Head.Position)
        local headDot = espObject.Components.HeadDot
        headDot.Visible = true
        headDot.Color = teamColor
        headDot.Position = headPos
        headDot.Radius = self.Settings.HeadDotSize
    else
        espObject.Components.HeadDot.Visible = false
    end
    
    -- Skeletons
    if self.Settings.Skeletons and espObject.Bones then
        for i, connection in ipairs(BONE_CONNECTIONS) do
            local fromBone = espObject.Bones[connection.from]
            local toBone = espObject.Bones[connection.to]
            
            if fromBone and toBone then
                local fromPos = worldToViewport(fromBone.Position)
                local toPos = worldToViewport(toBone.Position)
                local boneLine = espObject.Components["Bone"..tostring(i)]
                
                boneLine.Visible = true
                boneLine.Color = self.Settings.SkeletonColor
                boneLine.From = fromPos
                boneLine.To = toPos
            end
        end
    else
        for i = 1, #BONE_CONNECTIONS do
            espObject.Components["Bone"..tostring(i)].Visible = false
        end
    end
end

-- Initialization
function UniversalESP:Initialize()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            self:AddPlayer(player)
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        self:AddPlayer(player)
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        self:RemoveObject(player)
    end)
end

-- Initialize ESP
UniversalESP:Initialize()

-- UI Setup
local ESPsection = VisualsTab:CreateSector("ESP Settings", "left")
local VisualsSection = VisualsTab:CreateSector("Visual Customization", "right")
local ConfigSection = ConfigTab:CreateSector("Configuration", "left")

-- Enable Toggle
ESPsection:AddToggle("Enable ESP", false, function(state)
    UniversalESP:Toggle(state)
end)

-- Component Toggles
ESPsection:AddToggle("Boxes", true, function(state)
    UniversalESP.Settings.Boxes = state
end)

ESPsection:AddToggle("Names", true, function(state)
    UniversalESP.Settings.Names = state
end)

ESPsection:AddToggle("Health Bars", true, function(state)
    UniversalESP.Settings.HealthBars = state
end)

ESPsection:AddToggle("Distances", true, function(state)
    UniversalESP.Settings.Distances = state
end)

ESPsection:AddToggle("Tracers", false, function(state)
    UniversalESP.Settings.Tracers = state
end)

ESPsection:AddToggle("Skeletons", false, function(state)
    UniversalESP.Settings.Skeletons = state
end)

ESPsection:AddToggle("Head Dots", false, function(state)
    UniversalESP.Settings.HeadDots = state
end)

ESPsection:AddToggle("Team Color", true, function(state)
    UniversalESP.Settings.TeamColor = state
end)

ESPsection:AddToggle("Visible Only", true, function(state)
    UniversalESP.Settings.VisibleOnly = state
end)

-- Visual Customization
local TextColorToggle = VisualsSection:AddToggle("Text Color", false, function(state)
    -- Placeholder for color toggle
end)

TextColorToggle:AddColorpicker(Color3.new(1, 1, 1), function(color)
    UniversalESP.Settings.TextColor = color
end)

local BoxColorToggle = VisualsSection:AddToggle("Box Color", false, function(state)
    -- Placeholder for color toggle
end)

BoxColorToggle:AddColorpicker(Color3.new(1, 1, 1), function(color)
    UniversalESP.Settings.BoxColor = color
end)

local SkeletonColorToggle = VisualsSection:AddToggle("Skeleton Color", false, function(state)
    -- Placeholder for color toggle
end)

SkeletonColorToggle:AddColorpicker(Color3.new(1, 0, 0), function(color)
    UniversalESP.Settings.SkeletonColor = color
end)

VisualsSection:AddSlider("Text Size", 8, 13, 20, 1, function(value)
    UniversalESP.Settings.TextSize = value
end)

VisualsSection:AddSlider("Head Dot Size", 2, 5, 10, 1, function(value)
    UniversalESP.Settings.HeadDotSize = value
end)

-- Tracer Options
VisualsSection:AddDropdown("Tracer Origin", {"Top", "Middle", "Bottom"}, "Bottom", false, function(origin)
    UniversalESP.Settings.TracerOrigin = origin
end)

-- Distance Settings
ConfigSection:AddSlider("Max Distance", 100, 1000, 5000, 10, function(value)
    UniversalESP.Settings.MaxDistance = value
end)

-- Font Selection
ConfigSection:AddDropdown("Font Style", {"UI", "System", "Plex", "Monospace"}, "Plex", false, function(font)
    UniversalESP.Settings.Font = ({"UI", "System", "Plex", "Monospace"})[font] and table.find({"UI", "System", "Plex", "Monospace"}, font) - 1 or 2
end)

-- Config System
MainTab:CreateConfigSystem("right")

-- Info Section
local InfoSection = ConfigTab:CreateSector("esp load", "right")
InfoSection:AddButton("Unload ESP", function()
    UniversalESP:Toggle(false)
    for player in pairs(UniversalESP.Objects) do
        UniversalESP:RemoveObject(player)
    end
    UniversalESP.UpdateConnection:Disconnect()
end)

-- Initialize ESP after UI setup
UniversalESP:Toggle(true)
-- Aimbot Core
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Configuration
local Config = {
    Enabled = false,
    TeamCheck = true,
    VisibilityCheck = true,
    Smoothness = 0.5,
    FOV = 100,
    HitPart = "Head",
    TriggerKey = Enum.KeyCode.Q,
    Mode = "Hold", -- "Hold", "Toggle", "Always"
    Toggled = false,
    Prediction = 0.165,
    Sensitivity = 0.2,
    AimMethod = "CFrameLookAt", -- "CFrameNew", "CFrameAngles", "LookVector"
    Humanizer = 0.3, -- Randomization for more human-like aiming
    LockWhenShooting = true
}

-- Core func
local AimbotTab = Window:CreateTab("Aimbot")

-- Main Section
local MainSection = AimbotTab:CreateSector("Main", "left")
MainSection:AddToggle("Enable Aimbot", false, function(state)
    Config.Enabled = state
end)

local KeybindToggle = MainSection:AddToggle("Keybind Toggle", false, function(state)
    Config.Toggled = state
end)
KeybindToggle:AddKeybind(Config.TriggerKey, function(key)
    Config.TriggerKey = key
end)

MainSection:AddDropdown("Mode", {"Hold", "Toggle", "Always"}, "Hold", false, function(mode)
    Config.Mode = mode
end)

MainSection:AddSlider("Smoothness", 0.1, 1, 0.5, 0.01, function(value)
    Config.Smoothness = value
end)

-- Target Section
local TargetSection = AimbotTab:CreateSector("Target", "right")
TargetSection:AddDropdown("Hit Part", {"Head", "UpperTorso", "HumanoidRootPart", "Random"}, "Head", false, function(part)
    Config.HitPart = part
end)

TargetSection:AddToggle("Team Check", true, function(state)
    Config.TeamCheck = state
end)

TargetSection:AddToggle("Visibility Check", true, function(state)
    Config.VisibilityCheck = state
end)

-- Advanced Section
local AdvancedSection = AimbotTab:CreateSector("Advanced", "left")
AdvancedSection:AddSlider("FOV", 1, 360, 100, 1, function(value)
    Config.FOV = value
end)

AdvancedSection:AddToggle("Prediction", false, function(state)
    Config.PredictionEnabled = state
end)

AdvancedSection:AddSlider("Prediction", 0.1, 0.3, 0.165, 0.001, function(value)
    Config.Prediction = value
end)

AdvancedSection:AddSlider("Humanizer", 0, 1, 0.3, 0.01, function(value)
    Config.Humanizer = value
end)

-- Aim Method Section
local MethodSection = AimbotTab:CreateSector("Aim Method", "right")
MethodSection:AddDropdown("Aim Method", {"CFrameLookAt", "CFrameNew", "CFrameAngles", "LookVector"}, "CFrameLookAt", false, function(method)
    Config.AimMethod = method
end)

MethodSection:AddToggle("Lock When Shooting", true, function(state)
    Config.LockWhenShooting = state
end)

-- Aimbot Functions
local function IsVisible(part)
    if not Config.VisibilityCheck then return true end
    local origin = Camera.CFrame.Position
    local _, onScreen = Camera:WorldToViewportPoint(part.Position)
    if not onScreen then return false end
    
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    params.IgnoreWater = true
    
    local result = workspace:Raycast(origin, part.Position - origin, params)
    if result and result.Instance:IsDescendantOf(part.Parent) then
        return true
    end
    return false
end

local function GetRandomOffset()
    return Vector3.new(
        (math.random() - 0.5) * Config.Humanizer,
        (math.random() - 0.5) * Config.Humanizer,
        (math.random() - 0.5) * Config.Humanizer
    )
end

local function GetTargetPart(character)
    if Config.HitPart == "Random" then
        local parts = {"Head", "UpperTorso", "HumanoidRootPart"}
        return character[parts[math.random(1, #parts)]]
    end
    return character[Config.HitPart]
end

local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = Config.FOV
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if Config.TeamCheck and player.Team == LocalPlayer.Team then continue end
            
            local part = GetTargetPart(player.Character)
            if not part or not IsVisible(part) then continue end
            
            local screenPoint = Camera:WorldToViewportPoint(part.Position)
            local magnitude = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
            
            if magnitude < shortestDistance then
                shortestDistance = magnitude
                closestPlayer = player
            end
        end
    end
    
    return closestPlayer
end

local function AimAt(targetPart)
    local camera = workspace.CurrentCamera
    local targetPosition = targetPart.Position
    
    -- Apply prediction if enabled
    if Config.PredictionEnabled and targetPart.Parent:FindFirstChild("HumanoidRootPart") then
        local velocity = targetPart.Parent.HumanoidRootPart.Velocity
        targetPosition = targetPosition + (velocity * Config.Prediction)
    end
    
    -- Apply humanizer randomization
    if Config.Humanizer > 0 then
        targetPosition = targetPosition + GetRandomOffset()
    end
    
    local current = camera.CFrame
    local direction = (targetPosition - camera.CFrame.Position).Unit
    
    -- Different aiming methods
    if Config.AimMethod == "CFrameLookAt" then
        local target = CFrame.lookAt(camera.CFrame.Position, targetPosition)
        camera.CFrame = current:Lerp(target, Config.Smoothness * Config.Sensitivity)
    elseif Config.AimMethod == "CFrameNew" then
        local target = CFrame.new(camera.CFrame.Position, targetPosition)
        camera.CFrame = current:Lerp(target, Config.Smoothness * Config.Sensitivity)
    elseif Config.AimMethod == "CFrameAngles" then
        local lookVector = (targetPosition - camera.CFrame.Position).Unit
        local target = CFrame.fromMatrix(
            camera.CFrame.Position,
            camera.CFrame.RightVector,
            Vector3.new(0, 1, 0),
            lookVector
        )
        camera.CFrame = current:Lerp(target, Config.Smoothness * Config.Sensitivity)
    elseif Config.AimMethod == "LookVector" then
        camera.CFrame = current:Lerp(
            CFrame.new(camera.CFrame.Position) * CFrame.fromMatrix(
                Vector3.new(),
                camera.CFrame.RightVector,
                Vector3.new(0, 1, 0),
                direction
            ),
            Config.Smoothness * Config.Sensitivity
        )
    end
end

-- Main Loop
RunService.RenderStepped:Connect(function()
    if not Config.Enabled then return end
    
    local shouldAim = false
    if Config.Mode == "Always" then
        shouldAim = true
    elseif Config.Mode == "Hold" and UserInputService:IsKeyDown(Config.TriggerKey) then
        shouldAim = true
    elseif Config.Mode == "Toggle" and Config.Toggled then
        shouldAim = true
    end
    
    -- Additional check for shooting lock
    if Config.LockWhenShooting and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        shouldAim = true
    end
    
    if shouldAim then
        local closestPlayer = GetClosestPlayer()
        if closestPlayer and closestPlayer.Character then
            local targetPart = GetTargetPart(closestPlayer.Character)
            if targetPart then
                AimAt(targetPart)
            end
        end
    end
end)

-- Config System
AimbotTab:CreateConfigSystem("right")
