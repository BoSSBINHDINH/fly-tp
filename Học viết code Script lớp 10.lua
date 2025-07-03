-- Gui tạo bởi ChatGPT theo yêu cầu của Boss
-- GUI fly kéo bằng W + TP chọn người chơi

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

-- Fly setup
local flying = false
local UIS = game:GetService("UserInputService")
local camera = workspace.CurrentCamera
local flySpeed = 100

-- Rainbow border function
local function rainbow()
	local t = tick() * 2
	return Color3.fromHSV(t % 1, 1, 1)
end

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BossPythonUI"

local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 200, 0, 250)
mainFrame.Position = UDim2.new(0, 10, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
mainFrame.BorderSizePixel = 2
mainFrame.Name = "BossPython"

-- Viền rainbow
local border = Instance.new("UIStroke", mainFrame)
border.Thickness = 3
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
spawn(function()
	while true do
		border.Color = rainbow()
		wait(0.1)
	end
end)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "BossPython"
title.TextColor3 = Color3.new(0, 0, 0)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- Hide / Show Toggle
local toggle = Instance.new("TextButton", mainFrame)
toggle.Text = "Ẩn Menu"
toggle.Size = UDim2.new(1, 0, 0, 25)
toggle.Position = UDim2.new(0, 0, 1, -25)
toggle.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
toggle.TextColor3 = Color3.new(0, 0, 0)
toggle.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

local openButton = Instance.new("TextButton", ScreenGui)
openButton.Text = "👁 Mở"
openButton.Size = UDim2.new(0, 60, 0, 30)
openButton.Position = UDim2.new(0, 10, 0, 10)
openButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextColor3 = Color3.new(0, 0, 0)
openButton.Visible = true
openButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
end)

-- Fly Button
local flyBtn = Instance.new("TextButton", mainFrame)
flyBtn.Text = "✈️ Fly"
flyBtn.Size = UDim2.new(1, -10, 0, 40)
flyBtn.Position = UDim2.new(0, 5, 0, 40)
flyBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
flyBtn.TextColor3 = Color3.new(0, 0, 0)

flyBtn.MouseButton1Click:Connect(function()
	if flying then
		flying = false
	else
		flying = true
		local hrp = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
		local bodyVel = Instance.new("BodyVelocity", hrp)
		bodyVel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
		bodyVel.Velocity = Vector3.zero

		spawn(function()
			while flying do
				if UIS:IsKeyDown(Enum.KeyCode.W) then
					bodyVel.Velocity = camera.CFrame.LookVector * flySpeed
				else
					bodyVel.Velocity = Vector3.zero
				end
				wait()
			end
			bodyVel:Destroy()
		end)
	end
end)

-- TP Button + Player list
local tpBtn = Instance.new("TextButton", mainFrame)
tpBtn.Text = "🧍 TP"
tpBtn.Size = UDim2.new(1, -10, 0, 40)
tpBtn.Position = UDim2.new(0, 5, 0, 90)
tpBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
tpBtn.TextColor3 = Color3.new(0, 0, 0)

local dropdown = Instance.new("TextButton", mainFrame)
dropdown.Size = UDim2.new(1, -10, 0, 120)
dropdown.Position = UDim2.new(0, 5, 0, 140)
dropdown.Text = "Chọn người để TP..."
dropdown.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
dropdown.TextColor3 = Color3.new(0, 0, 0)
dropdown.TextWrapped = true

tpBtn.MouseButton1Click:Connect(function()
	local list = {}
	for _, player in pairs(Players:GetPlayers()) do
		if player.Name ~= LocalPlayer.Name then
			table.insert(list, player.Name)
		end
	end
	dropdown.Text = "Danh sách:\n" .. table.concat(list, "\n")
end)

dropdown.MouseButton1Click:Connect(function()
	local targetName = string.match(dropdown.Text, "(.+)\n") or dropdown.Text
	local targetPlayer = Players:FindFirstChild(targetName)
	if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = targetPlayer.Character.HumanoidRootPart
		hrp.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
	end
end)
