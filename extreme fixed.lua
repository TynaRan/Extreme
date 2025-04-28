local v = game.Players.LocalPlayer

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

Spawn1 = coroutine.wrap(function()
while task.wait(0) do
local roomdoor = game.Workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Door.Door
		roomdoor.Material = "Ice"
		roomdoor.Sign.Material = "Ice"
		end
		end)
		Spawn1()
wait(3)
