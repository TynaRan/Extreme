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

	local SelfModules = {
		Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))(),
}

game:GetService("ReplicatedStorage").GameData.LatestRoom:GetPropertyChangedSignal("Value"):Wait()  

    local function GetGitSound(GithubSnd,SoundName)
				local url=GithubSnd
				if not isfile(SoundName..".mp3") then
					writefile(SoundName..".mp3", game:HttpGet(url))
				end
				local sound=Instance.new("Sound")
				sound.SoundId=(getcustomasset or getsynasset)(SoundName..".mp3")
				return sound
			end
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

        game.Lighting.MainColorCorrection.TintColor = "Blue"
        game.Lighting.MainColorCorrection.Contrast = 1

        local tween = game:GetService("TweenService")
        tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(2.5), {Contrast = 0}):Play()

        local TweenService = game:GetService("TweenService")
        local TW = TweenService:Create(game.Lighting.MainColorCorrection, TweenInfo.new(80), {TintColor = "White"})
        TW:Play()

        wait(34)

        game.ReplicatedStorage.EntityInfo.UseEventModule.OnClientEvent:Fire("flicker", game.ReplicatedStorage.GameData.LatestRoom.Value, 1)

        wait(math.random(2, 5))

        local character = game.Players.LocalPlayer.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        local startCFrame = character and character.PrimaryPart.CFrame

        if humanoid and startCFrame then
            wait(math.random(1, 3))

            local moved = false
            local function checkMovement()
                for _ = 1, 25 do -- 2.5 seconds check (0.1 * 25 = 2.5)
                    task.wait(0.1)
                    if character.PrimaryPart.CFrame ~= startCFrame then
                        moved = true
                        break
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
