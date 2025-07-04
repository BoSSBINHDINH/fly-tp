if game.CoreGui:FindFirstChild("TPA_GUI") then game.CoreGui.TPA_GUI:Destroy() end

local function rainbow()
	local hue = tick() % 5 / 5
	return Color3.fromHSV(hue, 1, 1)
end

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TPA_GUI"

-- Logo nút mở
local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0, 60, 0, 60)
logo.Position = UDim2.new(0, 20, 0.5, -30)
logo.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
logo.Text = "TP\nBOSS"
logo.Font = Enum.Font.GothamBold
logo.TextSize = 16
logo.TextColor3 = Color3.fromRGB(255, 255, 255)
logo.TextWrapped = true
logo.BorderSizePixel = 2
logo.ClipsDescendants = true
logo.Name = "TPBossBtn"
logo.ZIndex = 2

-- Rainbow viền logo
spawn(function()
	while logo and logo.Parent do
		logo.BorderColor3 = rainbow()
		wait(0.05)
	end
end)

-- Frame chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 360, 0, 280)
frame.Position = UDim2.new(0.5, -180, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 3
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.Name = "TPAMain"

-- Rainbow viền frame
spawn(function()
	while frame and frame.Parent do
		frame.BorderColor3 = rainbow()
		wait(0.05)
	end
end)

-- Nút đóng
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
close.TextColor3 = Color3.new(1, 1, 1)
close.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

-- Tiêu đề
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "TPA MENU"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Mở menu
logo.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- Scroll danh sách người chơi
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0, 10, 0, 40)
scroll.Size = UDim2.new(1, -20, 0, 160)
scroll.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
scroll.ScrollBarThickness = 6
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

-- Lưu player đã chọn
local selectedPlayer = nil

-- Tạo danh sách người chơi
local function updateList()
	scroll:ClearAllChildren()
	local y = 0
	for _, plr in ipairs(game.Players:GetPlayers()) do
		if plr ~= game.Players.LocalPlayer then
			local b = Instance.new("TextButton", scroll)
			b.Size = UDim2.new(1, -10, 0, 30)
			b.Position = UDim2.new(0, 5, 0, y)
			b.Text = plr.Name
			b.TextColor3 = Color3.new(1, 1, 1)
			b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			b.Font = Enum.Font.Gotham
			b.TextSize = 14
			b.MouseButton1Click:Connect(function()
				selectedPlayer = plr
				for _, btn in pairs(scroll:GetChildren()) do
					if btn:IsA("TextButton") then
						btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
					end
				end
				b.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
			end)
			y += 35
		end
	end
	scroll.CanvasSize = UDim2.new(0, 0, 0, y)
end
updateList()

-- Nút TP
local tp = Instance.new("TextButton", frame)
tp.Size = UDim2.new(1, -20, 0, 40)
tp.Position = UDim2.new(0, 10, 1, -50)
tp.Text = "TPA"
tp.Font = Enum.Font.GothamBold
tp.TextSize = 20
tp.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
tp.TextColor3 = Color3.new(1, 1, 1)

-- ✅ Phần TP CHUẨN, người chơi đến đứng sát bạn
tp.MouseButton1Click:Connect(function()
	if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local me = game.Players.LocalPlayer.Character
		local hrp = me and me:FindFirstChild("HumanoidRootPart")
		local targetHRP = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
		if hrp and targetHRP then
			local targetPos = hrp.CFrame + Vector3.new(2, 0, 0) -- bên cạnh bạn
			for i = 1, 5 do
				targetHRP.CFrame = targetPos
				wait(0.05)
			end
			print("✅ Đã TP " .. selectedPlayer.Name .. " đến bạn!")
		end
	end
end)
