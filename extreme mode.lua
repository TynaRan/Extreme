local SelfModules = {
		Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))(),
}
local function modifyAllNeon()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Neon" then
            obj.Color = Color3.fromRGB(0, 0, 255)
        end
    end
end

local modifyNeonCoroutine = coroutine.wrap(function()
    while true do
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        modifyAllNeon()
    end
end)

modifyNeonCoroutine()
coroutine.wrap(function()
    while true do
        task.wait(0.01)

        for _, obj in ipairs(game.Workspace:GetChildren()) do
            if string.find(string.lower(obj.Name), "pathfindnodes") then
                if not obj.Parent:FindFirstChild("Nodes") then
                    local clonedNode = obj:Clone()
                    clonedNode.Parent = obj.Parent
                    clonedNode.Name = "Nodes"
                end
            end
        end
    end
end)()
    local function GetGitSound(GithubSnd,SoundName)
				local url=GithubSnd
				if not isfile(SoundName..".mp3") then
					writefile(SoundName..".mp3", game:HttpGet(url))
				end
				local sound=Instance.new("Sound")
				sound.SoundId=(getcustomasset or getsynasset)(SoundName..".mp3")
				return sound
end
local v = game.Players.LocalPlayer
local function applyTween(color, duration)
    local tweenInfo = TweenInfo.new(duration)
    local tweenProperties = {Color = color}

    for _, v in pairs(game.Workspace.CurrentRooms:GetDescendants()) do
        if v:IsA("Light") then
            game.TweenService:Create(v, tweenInfo, tweenProperties):Play()
            if v.Parent.Name == "LightFixture" then
                game.TweenService:Create(v.Parent, tweenInfo, tweenProperties):Play()
            end
        end
    end
end

Spawn1 = coroutine.wrap(function()
while task.wait(0) do
local roomdoor = game.Workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Door.Door
		roomdoor.Material = "Ice"
		roomdoor.Sign.Material = "Ice"
		end
		end)
		Spawn1()
local EntityInfo = {}
function EntityInfo.DeathHint(messages, color)
    game.ReplicatedStorage.EntityInfo.DeathHint:Fire(messages, color)
end

local Lighting = game:GetService("Lighting")
local atmosphere = workspace:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere", Lighting)

local function updateLightingAndSound()
    Lighting.Technology = Enum.Technology.Future
    Lighting.EnvironmentDiffuseScale = 0.35  
    Lighting.EnvironmentSpecularScale = 0.35  
    Lighting.OutdoorAmbient = Color3.fromRGB(5, 5, 5)  
    Lighting.Ambient = Color3.fromRGB(10, 10, 10)  
    Lighting.GlobalShadows = true
    Lighting.ShadowSoftness = 0.7
    Lighting.ClockTime = 18.5  
    Lighting.Brightness = 0.3  
    Lighting.ColorShift_Bottom = Color3.fromRGB(15, 15, 15)
    Lighting.ColorShift_Top = Color3.fromRGB(25, 25, 25)
    Lighting.ExposureCompensation = -0.75  
    Lighting.ShadowColor = Color3.fromRGB(15, 15, 15)
    Lighting.GeographicLatitude = 45
    
    atmosphere.Density = 0.75  
    atmosphere.Color = Color3.fromRGB(20, 20, 20)
    atmosphere.Haze = 0.8  
    
    local colorCorrection = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
    colorCorrection.Contrast = 0.25
    colorCorrection.Saturation = -0.4  

    local function setBlueLighting(light)
        light.Shadows = true
        light.Brightness = 0.5  
        light.Range = 10
        light.Color = Color3.fromRGB(0, 150, 255)  
    end
    
    for _, light in pairs(workspace:GetDescendants()) do
        if light:IsA("PointLight") or light:IsA("SpotLight") or light:IsA("SurfaceLight") then
            setBlueLighting(light)
        end
    end
end

local listenForRoomChanges = coroutine.wrap(function()
    while true do
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        updateLightingAndSound()
    end
end)

listenForRoomChanges()

game:GetService("ReplicatedStorage").GameData.LatestRoom:GetPropertyChangedSignal("Value"):Wait()  

    
   local roar = GetGitSound("https://github.com/Tinkgy111/Bang/blob/main/Screen_Recording_20230519-203543_YouTube.mp3?raw=true","roarove")

				roar.Parent = workspace

				roar.Volume = 3

				roar:Play()

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("extreme mode Loaded",true)
wait(2)

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Fix Creator :Bad darkness",true)
wait(2)

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Original Creator:Tinkgy#111 and other..",true)

local entityName = "Void Stalker"

coroutine.wrap(function()
    while task.wait(65) do
        local latestRoom = game.ReplicatedStorage.GameData.LatestRoom.Value
        local seekMovingExists = false

        for _, obj in ipairs(game.Workspace:GetChildren()) do
            if string.find(obj.Name, "SeekMoving") then
                seekMovingExists = true
                break
            end
        end

        if latestRoom == 50 or latestRoom == 100 or seekMovingExists then
            return -- Stops execution if room is 50/100 or any object contains "SeekMoving" in its name
        else
            local Clock = GetGitSound(
                "https://github.com/Brololto/bing-/blob/main/Screen_Recording_20230419-164136_Chrome%20(online-audio-converter.com).mp3?raw=true",
                entityName .. " Clock"
            )
            Clock.Parent = workspace
            Clock.Volume = 5
            Clock:Play()

            wait(1)

            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 9

            local Bell = GetGitSound(
                "https://github.com/Potato032/Entt/blob/main/ClockSoundsCreditsToVynixus.mp3?raw=true",
                entityName .. " Bell"
            )
            Bell.Parent = workspace
            Bell.Volume = 5
            Bell:Play()

            game.Lighting.MainColorCorrection.TintColor = Color3.fromRGB(71, 151, 211)
            game.Lighting.MainColorCorrection.Contrast = 1

            local tween = game:GetService("TweenService")
            tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(2.5), {Contrast = 0}):Play()

            local TweenService = game:GetService("TweenService")
            local TW = TweenService:Create(game.Lighting.MainColorCorrection, TweenInfo.new(80), {TintColor = Color3.fromRGB(255, 255, 255)})
            TW:Play()

            wait(34)

            local character = game.Players.LocalPlayer.Character
            local humanoid = character and character:FindFirstChild("Humanoid")
            local startCFrame = character and character.PrimaryPart.CFrame

            if humanoid and startCFrame then
                wait(math.random(1, 3))

                local moved = false
                local function checkMovement()
                    for _ = 1, 10 do
                        task.wait(0.1)
                        if humanoid.MoveDirection.Magnitude > 0 then
                            moved = true
                        end
                    end
                end

                coroutine.wrap(checkMovement)()

                task.wait(2.5)

                if moved then
                    humanoid.Health = 0
                    EntityInfo.DeathHint(entityName .. " is watching... You should not have moved...", "Blue")
                    task.wait(math.random(1, 2))
                    EntityInfo.DeathHint(entityName .. " whispers... Your end has come...", "Blue")
                    task.wait(math.random(2, 3))
                    EntityInfo.DeathHint(entityName .. " fades away... Farewell...", "Blue")
                else
                    game.Lighting.MainColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
                    game.Lighting.MainColorCorrection.Contrast = 0
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                end
            end
        end
    end
end)()
local entityName = "disappointed"

coroutine.wrap(function()
    while task.wait(85) do
        local latestRoom = game.ReplicatedStorage.GameData.LatestRoom.Value
        local seekMovingExists = false

        for _, obj in ipairs(game.Workspace:GetChildren()) do
            if string.find(obj.Name, "SeekMoving") then
                seekMovingExists = true
                break
            end
        end

        if latestRoom == 50 or latestRoom == 100 or seekMovingExists then
            return -- Stops execution if room is 50/100 or any object contains "SeekMoving" in its name
        else
            local static = Instance.new("Sound")
            static.SoundId = "rbxassetid://9120425687"
            static.Parent = game.ReplicatedStorage
            static.Name = "Se"
            static.Pitch = 0.6
            static.Volume = 1.5
            static.TimePosition = 0.2
            static:Play()

            local GUI = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
            local Image = Instance.new("ImageLabel", GUI)

            GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Image.BackgroundTransparency = 1
            Image.Size = UDim2.new(1, 0, 1, 0)
            Image.Image = "rbxassetid://13362464118"
            Image.ImageTransparency = 0

            task.wait(1)
            game.Players.LocalPlayer.PlayerGui.ScreenGui:Destroy()

            local character = game.Players.LocalPlayer.Character
            local humanoid = character and character:FindFirstChild("Humanoid")
            local startCFrame = character and character.PrimaryPart.CFrame

            if humanoid then
                local moved = false
                for _ = 1, 10 do
                    task.wait(0.1)
                    if humanoid.MoveDirection.Magnitude > 0 then
                        moved = true
                    end
                end

                if moved then
                    humanoid.Health = 0
                    EntityInfo.DeathHint(entityName .. " is watching... You should not have moved...", "Blue")
                    task.wait(math.random(1, 2))
                    EntityInfo.DeathHint(entityName .. " whispers... Your end has come...", "Blue")
                    task.wait(math.random(2, 3))
                    EntityInfo.DeathHint(entityName .. " fades away... Farewell...", "Blue")
                    break
                end
            end
        end
    end
end)()
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

coroutine.wrap(function()
    while true do
        task.wait(135)

        local latestRoom = game.ReplicatedStorage.GameData.LatestRoom.Value
        local seekMovingExists = false

        for _, obj in ipairs(game.Workspace:GetChildren()) do
            if string.find(obj.Name, "SeekMoving") then
                seekMovingExists = true
                break
            end
        end

        if latestRoom == 50 or latestRoom == 100 or seekMovingExists then
            return -- Stops execution if room is 50/100 or any object contains "SeekMoving" in its name
        else
            applyTween(Color3.fromRGB(255, 0, 0), 1.5)
            local Idle = GetGitSound("https://github.com/Brololto/G95-MOVING/blob/main/Screen_Recording_20230323-172501_YouTube%20(online-audio-converter.com)%20(1).mp3?raw=true", "anxddg")
            Idle.Parent = workspace
            Idle.Volume = 20
            Idle:Play()

            local entity = spawner.Create({
                Entity = {
                    Name = "Obsession",
                    Asset = "https://github.com/Brololto/ExtremeModeG-95/blob/main/G-95Remastered-1.rbxm?raw=true",
                    HeightOffset = 0
                },
                Lights = {
                    Flicker = { Enabled = true, Duration = 1 },
                    Shatter = true,
                    Repair = false
                },
                Earthquake = { Enabled = true },
                CameraShake = {
                    Enabled = true,
                    Range = 100,
                    Values = {1.5, 20, 0.1, 1}
                },
                Movement = {
                    Speed = 700,
                    Delay = 12,
                    Reversed = false
                },
                Damage = {
                    Enabled = true,
                    Range = 100,
                    Amount = 125
                },
                Crucifixion = {
                    Enabled = true,
                    Range = 40,
                    Resist = false,
                    Break = true
                },
                Death = {
                    Type = "Curious",
                    Hints = {"Oh hi", "I'm light", ":))) I WILL KILL YOU", "Scream!!!"},
                    Cause = "G-95"
                }
            })

            entity:SetCallback("OnSpawned", function()
                print("Entity has spawned")
            end)

            entity:SetCallback("OnStartMoving", function()
                print("Entity has started moving")
            end)

            entity:SetCallback("OnEnterRoom", function(room, firstTime)
                local roomName = room.Name
                print("Entity has entered room: " .. roomName .. (firstTime and " for the first time" or " again"))
            end)

            entity:SetCallback("OnLookAt", function(lineOfSight)
                print(lineOfSight and "Player is looking at entity" or "Player view is obstructed by something")
            end)

            entity:SetCallback("OnRebounding", function(startOfRebound)
                print(startOfRebound and "Entity has started rebounding" or "Entity has finished rebounding")
            end)

            entity:SetCallback("OnDespawning", function()
                local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
                local character = game.Players.LocalPlayer.Character
                local humanoid = character and character:FindFirstChild("Humanoid")

                if humanoid and humanoid.Health > 0 then
                    achievementGiver({
                        Title = "Scream Demon of Hell",
                        Desc = "You will die",
                        Reason = "Encounter G-95",
                        Image = "rbxassetid://3457898957"
                    })
                else
                    print("Achievement not granted.")
                end
            end)

            entity:SetCallback("OnDespawned", function()
                local Slam = GetGitSound("https://github.com/Brololto/FUCKYOUFACCIST/blob/main/Screen_Recording_20230407-114843_YouTube%20(online-audio-converter.com).mp3?raw=true", "Slamsaa")
                Slam.Parent = workspace
                Slam.Volume = 20
                Slam:Play()
            end)

            entity:SetCallback("OnDamagePlayer", function(newHealth)
                print(newHealth == 0 and "Entity has killed the player" or "Entity has damaged the player")
            end)

            entity:Run()
        end
    end
end)()
local TweenService = game:GetService("TweenService")

local executed = {} -- Tracks already processed models

coroutine.wrap(function()
    while true do
        task.wait(1)

        for _, model in ipairs(game.Workspace:GetChildren()) do
            if string.lower(model.Name) == "50" and model.PrimaryPart and not executed[model] then
                executed[model] = true -- Mark as processed

                for _, obj in ipairs(model:GetChildren()) do
                    if obj.Name == "RoomExit" then
                        local asset = game:GetObjects("rbxassetid://13989622160")[1]
                        asset.Parent = game.Workspace
                        asset.CFrame = obj.CFrame * model.PrimaryPart.CFrame
                    end
                end

                local nodes = model:FindFirstChild("Nodes")
                if nodes then
                    local parts = {}

                    for _, obj in ipairs(nodes:GetChildren()) do
                        table.insert(parts, obj)
                    end

                    table.sort(parts, function(a, b)
                        return (model.PrimaryPart.CFrame - a.CFrame).Magnitude < (model.PrimaryPart.CFrame - b.CFrame).Magnitude
                    end)

                    local startCFrame = model.PrimaryPart.CFrame

                    for _, part in ipairs(parts) do
                        local tween = TweenService:Create(model.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = part.CFrame})
                        tween:Play()
                        tween.Completed:Wait()
                    end

                    for i = #parts, 1, -1 do
                        local tween = TweenService:Create(model.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = parts[i].CFrame})
                        tween:Play()
                        tween.Completed:Wait()
                    end

                    local returnTween = TweenService:Create(model.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = startCFrame})
                    returnTween:Play()
                    returnTween.Completed:Wait()
                end

                for _, player in ipairs(game.Players:GetPlayers()) do
                    local character = player.Character
                    local humanoid = character and character:FindFirstChild("Humanoid")
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")

                    if humanoid and rootPart then
                        local distance = (model.PrimaryPart.CFrame - rootPart.CFrame).Magnitude
                        if distance <= 4.5 then
                            humanoid.Health = 0
                        end
                    end
                end
            end
        end
    end
end)()
