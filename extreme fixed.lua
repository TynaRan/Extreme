local SelfModules = {
		Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))(),
}

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
        local TW = TweenService:Create(game.Lighting.MainColorCorrection, TweenInfo.new(80), {TintColor = "White"})
        TW:Play()

        wait(34)

        

        wait(0)

        local character = game.Players.LocalPlayer.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        local startCFrame = character and character.PrimaryPart.CFrame

        if humanoid and startCFrame then
            wait(math.random(1, 3))

            local moved = false
            local function checkMovement()
                for _ = 1, 10 do -- 2.5 seconds check (0.1 * 25 = 2.5)
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
            end

            -- If not moved, everything cancels and waits for the next cycle
        end
    end
end)()
local entityName = "disappointed"

coroutine.wrap(function()
    local startTime = tick() -- Record the starting time

    while task.wait(65) do -- Loop until 50 seconds have passed
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
end)()
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Timer-based Execution ======---

coroutine.wrap(function()
    task.wait(135) -- Wait for 135 seconds before executing entity logic
    applyTween(Color3.fromRGB(255, 0, 0), 1.5) -- Red color effect for 1.5 seconds
	local Idle = GetGitSound("https://github.com/Brololto/G95-MOVING/blob/main/Screen_Recording_20230323-172501_YouTube%20(online-audio-converter.com)%20(1).mp3?raw=true","anxddg")
	Idle.Parent = workspace
	Idle.Volume = 20
	Idle:Play()
		
    ---====== Create entity ======---

    local entity = spawner.Create({
        Entity = {
            Name = "Obsession",
            Asset = "https://github.com/Brololto/ExtremeModeG-95/blob/main/G-95Remastered-1.rbxm?raw=true",
            HeightOffset = 0
        },
        Lights = {
            Flicker = {
                Enabled = true,
                Duration = 1
            },
            Shatter = true,
            Repair = false
        },
        Earthquake = {
            Enabled = true
        },
        CameraShake = {
            Enabled = true,
            Range = 100,
            Values = {1.5, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
        },
        Movement = {
            Speed = 100,
            Delay = 8,
            Reversed = false
        },
        Rebounding = {
            Enabled = false,
            Type = "Ambush",
            Min = 1,
            Max = 1,
            Delay = 0
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

    ---====== Debug entity ======---

    entity:SetCallback("OnSpawned", function()
        print("0")
    end)

    entity:SetCallback("OnStartMoving", function()
        print("Entity has started moving")
    end)

    entity:SetCallback("OnEnterRoom", function(room, firstTime)
        if firstTime == true then
            print("Entity has entered room: ".. room.Name.. " for the first time")
        else
            print("Entity has entered room: ".. room.Name.. " again")
        end
    end)

    entity:SetCallback("OnLookAt", function(lineOfSight)
        if lineOfSight == true then
            print("Player is looking at entity")
        else
            print("Player view is obstructed by something")
        end
    end)

    entity:SetCallback("OnRebounding", function(startOfRebound)
        if startOfRebound == true then
            print("Entity has started rebounding")
        else
            print("Entity has finished rebounding")
        end
    end)

    entity:SetCallback("OnDespawning", function()
        print("Entity is despawning")
    end)

    entity:SetCallback("OnDespawned", function()
        local Slam = GetGitSound("https://github.com/Brololto/FUCKYOUFACCIST/blob/main/Screen_Recording_20230407-114843_YouTube%20(online-audio-converter.com).mp3?raw=true","Slamsaa")
	Slam.Parent = workspace
        Slam.Volume = 20
	Slam:Play()
    end)

    entity:SetCallback("OnDamagePlayer", function(newHealth)
        if newHealth == 0 then
            print("Entity has killed the player")
        else
            print("Entity has damaged the player")
        end
    end)

    ---====== Run entity ======---

    entity:Run()
end)()
