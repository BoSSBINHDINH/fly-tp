-- ⚠️ Dán vào executor như Synapse, KRNL
-- TP GUI: TPA Player đến vị trí của bạn

-- Rainbow border function
local function rainbow()
	local hue = tick() % 5 / 5
	return Color3.fromHSV(hue, 1, 1)
end

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "TPA_GUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 180)
Frame.Position = UDim2.new(0.5, -150, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true

-- Rainbow border effect
spawn(function()
	while true do
		Frame.BorderColor3 = rainbow()
		wait(0.05)
	end
end)

-- Tiêu đề
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "TPA MENU"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Dropdown danh sách player
local PlayerList = Instance.new("TextButton", Frame)
PlayerList.Size = UDim2.new(1, -20, 0, 30)
PlayerList.Position = UDim2.new(0, 10, 0, 40)
PlayerList.Text = "Chọn người chơi..."
PlayerList.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PlayerList.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerList.Font = Enum.Font.Gotham
PlayerList.TextSize = 14

-- Danh sách ẩn hiện
local DropDownFrame = Instance.new("Frame", Frame)
DropDownFrame.Size = UDim2.new(1, -20, 0, 100)
DropDownFrame.Position = UDim2.new(0, 10, 0, 70)
DropDownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DropDownFrame.Visible = false
DropDownFrame.ClipsDescendants = true

-- Làm danh sách người chơi
local selectedPlayer = nil
PlayerList.MouseButton1Click:Connect(function()
	DropDownFrame:ClearAllChildren()
	DropDownFrame.Visible = not DropDownFrame.Visible
	local y = 0
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr ~= game.Players.LocalPlayer then
			local btn = Instance.new("TextButton", DropDownFrame)
			btn.Size = UDim2.new(1, 0, 0, 25)
			btn.Position = UDim2.new(0, 0, 0, y)
			btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			btn.Text = plr.Name
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 14
			btn.MouseButton1Click:Connect(function()
				PlayerList.Text = plr.Name
				selectedPlayer = plr
				DropDownFrame.Visible = false
			end)
			y = y + 25
		end
	end
end)

-- Nút TPA
local TPButton = Instance.new("TextButton", Frame)
TPButton.Size = UDim2.new(1, -20, 0, 40)
TPButton.Position = UDim2.new(0, 10, 1, -50)
TPButton.BackgroundColor3 = Color3.fromRGB(20, 130, 250)
TPButton.Text = "TPA"
TPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TPButton.Font = Enum.Font.GothamBold
TPButton.TextSize = 18

-- Xử lý TP
TPButton.MouseButton1Click:Connect(function()
	if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if myHRP then
			selectedPlayer.Character.HumanoidRootPart.CFrame = myHRP.CFrame + Vector3.new(2, 0, 0)
			print("Đã TP " .. selectedPlayer.Name .. " đến bạn!")
		end
	end
end)
