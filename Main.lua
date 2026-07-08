-- Azly Mizi Hub - Anti AFK + ESP (khung xanh, tên + @ trên đầu)
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "AzlyMiziHub"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local FRAME_W = 480
local FRAME_H = 380

-- === MAIN FRAME ===
local main = Instance.new("Frame")
main.Size = UDim2.new(0, FRAME_W, 0, FRAME_H)
main.Position = UDim2.new(0.5, -FRAME_W/2, 0.5, -FRAME_H/2)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.BorderSizePixel = 0
main.BackgroundTransparency = 0
main.Visible = true
main.Parent = gui

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1.2
stroke.Transparency = 0.3
stroke.Parent = main

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

-- === AVATAR BO TRÒN ===
local avatarFrame = Instance.new("Frame")
avatarFrame.Size = UDim2.new(0, 55, 0, 55)
avatarFrame.Position = UDim2.new(0, 10, 0, 10)
avatarFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
avatarFrame.BorderSizePixel = 2
avatarFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
avatarFrame.Parent = main

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1, 0)
avatarCorner.Parent = avatarFrame

local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(1, 0, 1, 0)
avatarImage.Position = UDim2.new(0, 0, 0, 0)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "rbxassetid://90447015543102"
avatarImage.ScaleType = Enum.ScaleType.Fit
avatarImage.Parent = avatarFrame

-- === NÚT THU NHỎ ===
local btnMinimize = Instance.new("TextButton")
btnMinimize.Size = UDim2.new(0, 28, 0, 28)
btnMinimize.Position = UDim2.new(1, -34, 0, 10)
btnMinimize.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnMinimize.BorderSizePixel = 0
btnMinimize.Text = "−"
btnMinimize.TextColor3 = Color3.fromRGB(200, 200, 200)
btnMinimize.TextSize = 18
btnMinimize.Font = Enum.Font.GothamBold
btnMinimize.Parent = main

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = btnMinimize

-- === TIÊU ĐỀ ===
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 0, 35)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Azly Mizi Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Bottom
title.Parent = main

-- === STATUS + THANH TIẾN TRÌNH ===
local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(0.85, 0, 0, 45)
statusFrame.Position = UDim2.new(0.075, 0, 0.28, 0)
statusFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
statusFrame.BorderSizePixel = 0
statusFrame.BackgroundTransparency = 0
statusFrame.Visible = true
statusFrame.Parent = main

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0.6, 0)
statusLabel.Position = UDim2.new(0, 0, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Đang tải dữ liệu..."
statusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = statusFrame

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(0.9, 0, 0, 3)
progressBg.Position = UDim2.new(0.05, 0, 0.75, 0)
progressBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
progressBg.BorderSizePixel = 0
progressBg.Parent = statusFrame

local progressBgCorner = Instance.new("UICorner")
progressBgCorner.CornerRadius = UDim.new(1, 0)
progressBgCorner.Parent = progressBg

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBg

local progressFillCorner = Instance.new("UICorner")
progressFillCorner.CornerRadius = UDim.new(1, 0)
progressFillCorner.Parent = progressFill

-- === MENU CHÍNH ===
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0.96, 0, 0.62, 0)
menuFrame.Position = UDim2.new(0.02, 0, 0.36, 0)
menuFrame.BackgroundTransparency = 1
menuFrame.Visible = false
menuFrame.Parent = main

-- Cột trái: Tab
local tabList = Instance.new("ScrollingFrame")
tabList.Size = UDim2.new(0.28, 0, 1, 0)
tabList.Position = UDim2.new(0, 0, 0, 0)
tabList.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
tabList.BackgroundTransparency = 0
tabList.BorderSizePixel = 0
tabList.ScrollBarThickness = 3
tabList.CanvasSize = UDim2.new(0, 0, 0, 90)
tabList.Parent = menuFrame

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 6)
tabCorner.Parent = tabList

-- Cột phải: Nội dung
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0.68, 0, 1, 0)
contentFrame.Position = UDim2.new(0.30, 0, 0, 0)
contentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
contentFrame.BackgroundTransparency = 0
contentFrame.BorderSizePixel = 0
contentFrame.Parent = menuFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 6)
contentCorner.Parent = contentFrame

-- === TẠO TAB ANTI AFK ===
local btnAntiAFK = Instance.new("TextButton")
btnAntiAFK.Size = UDim2.new(0.9, 0, 0, 35)
btnAntiAFK.Position = UDim2.new(0.05, 0, 0, 0)
btnAntiAFK.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
btnAntiAFK.BackgroundTransparency = 0.5
btnAntiAFK.BorderSizePixel = 1
btnAntiAFK.BorderColor3 = Color3.fromRGB(255, 255, 255)
btnAntiAFK.Text = "Anti AFK"
btnAntiAFK.TextColor3 = Color3.fromRGB(255, 255, 255)
btnAntiAFK.TextSize = 14
btnAntiAFK.Font = Enum.Font.GothamMedium
btnAntiAFK.Parent = tabList

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = btnAntiAFK

-- === TẠO TAB ESP ===
local btnESP = Instance.new("TextButton")
btnESP.Size = UDim2.new(0.9, 0, 0, 35)
btnESP.Position = UDim2.new(0.05, 0, 0, 45)
btnESP.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
btnESP.BackgroundTransparency = 0.85
btnESP.BorderSizePixel = 1
btnESP.BorderColor3 = Color3.fromRGB(255, 255, 255)
btnESP.Text = "ESP"
btnESP.TextColor3 = Color3.fromRGB(255, 255, 255)
btnESP.TextSize = 14
btnESP.Font = Enum.Font.GothamMedium
btnESP.Parent = tabList

local btnCorner2 = Instance.new("UICorner")
btnCorner2.CornerRadius = UDim.new(0, 4)
btnCorner2.Parent = btnESP

-- === BIẾN ESP ===
local espEnabled = false
local espBoxes = {}
local espConnections = {}

-- === HÀM TẠO ESP ===
local function createESP(playerObj)
    if playerObj == player then return end
    
    local character = playerObj.Character
    if not character then return end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    -- Khung xanh
    local box = Instance.new("BoxHandleAdornment")
    box.Size = Vector3.new(3, 5, 2)
    box.Color3 = Color3.fromRGB(0, 255, 0)
    box.Transparency = 0.5
    box.ZIndex = 0
    box.AlwaysOnTop = true
    box.Adornee = root
    box.Parent = gui
    
    -- Tên (gắn vào Head)
    local nameLabel = Instance.new("BillboardGui")
    nameLabel.Size = UDim2.new(0, 200, 0, 30)
    nameLabel.StudsOffset = Vector3.new(0, 2.5, 0)
    nameLabel.AlwaysOnTop = true
    nameLabel.MaxDistance = 200
    nameLabel.Parent = head
    
    local nameText = Instance.new("TextLabel")
    nameText.Size = UDim2.new(1, 0, 1, 0)
    nameText.BackgroundTransparency = 1
    nameText.Text = "@" .. playerObj.Name
    nameText.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameText.TextSize = 14
    nameText.Font = Enum.Font.GothamBold
    nameText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameText.TextStrokeTransparency = 0.3
    nameText.Parent = nameLabel
    
    -- Khoảng cách (gắn vào Head)
    local distLabel = Instance.new("BillboardGui")
    distLabel.Size = UDim2.new(0, 80, 0, 15)
    distLabel.StudsOffset = Vector3.new(0, -1.5, 0)
    distLabel.AlwaysOnTop = true
    distLabel.MaxDistance = 200
    distLabel.Parent = head
    
    local distText = Instance.new("TextLabel")
    distText.Size = UDim2.new(1, 0, 1, 0)
    distText.BackgroundTransparency = 1
    distText.Text = "0m"
    distText.TextColor3 = Color3.fromRGB(200, 200, 200)
    distText.TextSize = 10
    distText.Font = Enum.Font.GothamMedium
    distText.Parent = distLabel
    
    espBoxes[playerObj] = {box = box, name = nameLabel, dist = distLabel, head = head}
    
    -- Cập nhật khoảng cách
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not espEnabled then
            conn:Disconnect()
            return
        end
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local myRoot = char.HumanoidRootPart
            local targetRoot = root
            if targetRoot then
                local dist = (myRoot.Position - targetRoot.Position).Magnitude
                distText.Text = math.floor(dist) .. "m"
            end
        end
    end)
    table.insert(espConnections, conn)
end

-- === HÀM BẬT ESP ===
local function enableESP()
    if espEnabled then return end
    espEnabled = true
    
    -- Tạo ESP cho tất cả người chơi hiện tại
    for _, p in ipairs(Players:GetPlayers()) do
        createESP(p)
    end
    
    -- Kết nối khi người chơi mới vào
    local newConn = Players.PlayerAdded:Connect(function(p)
        task.wait(0.5)
        createESP(p)
    end)
    table.insert(espConnections, newConn)
    
    -- Kết nối khi người chơi rời
    local leaveConn = Players.PlayerRemoving:Connect(function(p)
        if espBoxes[p] then
            if espBoxes[p].box then espBoxes[p].box:Destroy() end
            if espBoxes[p].name then espBoxes[p].name:Destroy() end
            if espBoxes[p].dist then espBoxes[p].dist:Destroy() end
            espBoxes[p] = nil
        end
    end)
    table.insert(espConnections, leaveConn)
    
    print("ESP đã bật")
end

-- === HÀM TẮT ESP ===
local function disableESP()
    if not espEnabled then return end
    espEnabled = false
    
    -- Xóa tất cả ESP
    for _, data in pairs(espBoxes) do
        if data.box then data.box:Destroy() end
        if data.name then data.name:Destroy() end
        if data.dist then data.dist:Destroy() end
    end
    espBoxes = {}
    
    -- Ngắt tất cả kết nối
    for _, conn in ipairs(espConnections) do
        conn:Disconnect()
    end
    espConnections = {}
    
    print("ESP đã tắt")
end

-- === TẠO NỘI DUNG CHO TỪNG TAB ===
local function createAntiAFKContent()
    for _, child in ipairs(contentFrame:GetChildren()) do child:Destroy() end

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 28)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = "Chế độ Anti AFK"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = contentFrame

    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0.8, 0, 0, 38)
    toggleFrame.Position = UDim2.new(0.05, 0, 0.22, 0)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    toggleFrame.BorderSizePixel = 1
    toggleFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    toggleFrame.Parent = contentFrame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleFrame

    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(0.4, 0, 1, 0)
    statusText.Position = UDim2.new(0, 5, 0, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "Tắt"
    statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusText.TextSize = 15
    statusText.Font = Enum.Font.GothamMedium
    statusText.TextXAlignment = Enum.TextXAlignment.Left
    statusText.Parent = toggleFrame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 26)
    toggleBtn.Position = UDim2.new(0.6, 0, 0.5, -13)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.Parent = toggleFrame

    local toggleCorner2 = Instance.new("UICorner")
    toggleCorner2.CornerRadius = UDim.new(1, 0)
    toggleCorner2.Parent = toggleBtn

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 3, 0.5, -10)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = toggleBtn

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(0.8, 0, 0, 28)
    desc.Position = UDim2.new(0.05, 0, 0.6, 0)
    desc.BackgroundTransparency = 1
    desc.Text = "Giữ kết nối mỗi 5 phút (an toàn)"
    desc.TextColor3 = Color3.fromRGB(150, 150, 150)
    desc.TextSize = 12
    desc.Font = Enum.Font.GothamMedium
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = contentFrame

    -- Biến trạng thái
    local isOn = false
    local antiAFKRunning = false
    local antiAFKThread = nil

    local function safeAntiAFK()
        pcall(function()
            local vu = game:GetService("VirtualUser")
            if vu then
                vu:CaptureController()
                vu:ClickButton2(Vector2.new())
            end
        end)
        pcall(function()
            local camera = workspace.CurrentCamera
            if camera then
                local cf = camera.CFrame
                camera.CFrame = cf + Vector3.new(0.001, 0, 0)
                task.wait(0.05)
                camera.CFrame = cf
            end
        end)
    end

    local function toggleAntiAFK()
        isOn = not isOn

        if isOn then
            statusText.Text = "Bật"
            statusText.TextColor3 = Color3.fromRGB(100, 255, 150)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
            circle.Position = UDim2.new(0, 27, 0.5, -10)

            antiAFKRunning = true
            antiAFKThread = coroutine.create(function()
                while antiAFKRunning do
                    safeAntiAFK()
                    for i = 1, 300 do
                        if not antiAFKRunning then break end
                        task.wait(1)
                    end
                end
            end)
            coroutine.resume(antiAFKThread)
            print("Anti AFK đã bật (an toàn)")
        else
            statusText.Text = "Tắt"
            statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            circle.Position = UDim2.new(0, 3, 0.5, -10)

            antiAFKRunning = false
            if antiAFKThread then
                coroutine.close(antiAFKThread)
                antiAFKThread = nil
            end
            print("Anti AFK đã tắt")
        end
    end

    toggleBtn.MouseButton1Click:Connect(toggleAntiAFK)
end

local function createESPContent()
    for _, child in ipairs(contentFrame:GetChildren()) do child:Destroy() end

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 28)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = "ESP (Player ESP)"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = contentFrame

    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0.8, 0, 0, 38)
    toggleFrame.Position = UDim2.new(0.05, 0, 0.22, 0)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    toggleFrame.BorderSizePixel = 1
    toggleFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    toggleFrame.Parent = contentFrame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleFrame

    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(0.4, 0, 1, 0)
    statusText.Position = UDim2.new(0, 5, 0, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "Tắt"
    statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusText.TextSize = 15
    statusText.Font = Enum.Font.GothamMedium
    statusText.TextXAlignment = Enum.TextXAlignment.Left
    statusText.Parent = toggleFrame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 26)
    toggleBtn.Position = UDim2.new(0.6, 0, 0.5, -13)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.Parent = toggleFrame

    local toggleCorner2 = Instance.new("UICorner")
    toggleCorner2.CornerRadius = UDim.new(1, 0)
    toggleCorner2.Parent = toggleBtn

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 3, 0.5, -10)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = toggleBtn

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(0.8, 0, 0, 28)
    desc.Position = UDim2.new(0.05, 0, 0.6, 0)
    desc.BackgroundTransparency = 1
    desc.Text = "Hiển thị khung xanh, tên và khoảng cách"
    desc.TextColor3 = Color3.fromRGB(150, 150, 150)
    desc.TextSize = 12
    desc.Font = Enum.Font.GothamMedium
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = contentFrame

    -- Sự kiện toggle ESP (dùng enable/disable riêng)
    toggleBtn.MouseButton1Click:Connect(function()
        if espEnabled then
            -- Đang bật -> tắt
            espEnabled = false
            statusText.Text = "Tắt"
            statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            circle.Position = UDim2.new(0, 3, 0.5, -10)
            disableESP()
        else
            -- Đang tắt -> bật
            espEnabled = true
            statusText.Text = "Bật"
            statusText.TextColor3 = Color3.fromRGB(100, 255, 150)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
            circle.Position = UDim2.new(0, 27, 0.5, -10)
            enableESP()
        end
    end)
end

-- === XỬ LÝ CHUYỂN TAB ===
btnAntiAFK.MouseButton1Click:Connect(function()
    btnAntiAFK.BackgroundTransparency = 0.5
    btnESP.BackgroundTransparency = 0.85
    createAntiAFKContent()
end)

btnESP.MouseButton1Click:Connect(function()
    btnESP.BackgroundTransparency = 0.5
    btnAntiAFK.BackgroundTransparency = 0.85
    createESPContent()
end)

-- Mặc định hiển thị Anti AFK
createAntiAFKContent()

-- === NÚT MỞ LẠI ===
local btnRestore = Instance.new("ImageButton")
btnRestore.Size = UDim2.new(0, 55, 0, 55)
btnRestore.Position = UDim2.new(0.05, 0, 0.05, 0)
btnRestore.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
btnRestore.BackgroundTransparency = 0
btnRestore.BorderSizePixel = 2
btnRestore.BorderColor3 = Color3.fromRGB(255, 255, 255)
btnRestore.Image = "rbxassetid://90447015543102"
btnRestore.Visible = false
btnRestore.Parent = gui

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(1, 0)
restoreCorner.Parent = btnRestore

local restoreStroke = Instance.new("UIStroke")
restoreStroke.Color = Color3.fromRGB(255, 255, 255)
restoreStroke.Thickness = 2
restoreStroke.Parent = btnRestore

-- Kéo thả nút Restore
local dragRestore = false
local dragStartRestore = nil
local startPosRestore = nil

btnRestore.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragRestore = true
        dragStartRestore = input.Position
        startPosRestore = btnRestore.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragRestore and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartRestore
        btnRestore.Position = UDim2.new(
            startPosRestore.X.Scale,
            startPosRestore.X.Offset + delta.X,
            startPosRestore.Y.Scale,
            startPosRestore.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragRestore = false
    end
end)

-- === KÉO THẢ BẢNG ===
local dragToggle = false
local dragStart = nil
local startPos = nil

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = false
    end
end)

-- === ANIMATION ===
local function fadeIn(obj)
    obj.BackgroundTransparency = 1
    obj.Visible = true
    TweenService:Create(obj, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
end

local function fadeOut(obj)
    TweenService:Create(obj, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
end

-- === XỬ LÝ THU NHỎ / MỞ LẠI ===
btnMinimize.MouseButton1Click:Connect(function()
    fadeOut(main)
    task.wait(0.2)
    main.Visible = false
    btnRestore.Visible = true
    fadeIn(btnRestore)
end)

btnRestore.MouseButton1Click:Connect(function()
    fadeOut(btnRestore)
    task.wait(0.2)
    btnRestore.Visible = false
    main.Visible = true
    fadeIn(main)
    if menuFrame.Visible == false and statusFrame.Visible == false then
        menuFrame.Visible = true
        btnAntiAFK.BackgroundTransparency = 1
        fadeIn(btnAntiAFK)
    end
end)

-- === XỬ LÝ TẢI ===
local function startLoading()
    main.Visible = true
    fadeIn(main)

    statusFrame.Visible = true
    statusFrame.BackgroundTransparency = 0
    menuFrame.Visible = false
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    statusLabel.Text = "Đang tải dữ liệu..."
    statusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)

    local steps = {
        {text = "Đang tải cấu hình...", progress = 0.2},
        {text = "Đang kết nối server...", progress = 0.4},
        {text = "Đang tải dữ liệu...", progress = 0.6},
        {text = "Đang kiểm tra...", progress = 0.8},
        {text = "Hoàn tất!", progress = 1.0}
    }

    for _, step in ipairs(steps) do
        statusLabel.Text = step.text
        TweenService:Create(progressFill, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(step.progress, 0, 1, 0)}):Play()
        task.wait(0.4)
    end

    statusLabel.TextColor3 = Color3.fromRGB(180, 255, 200)
    statusLabel.Text = "Tải dữ liệu thành công!"
    task.wait(0.5)

    fadeOut(statusFrame)
    task.wait(0.25)
    statusFrame.Visible = false
    menuFrame.Visible = true

    btnAntiAFK.BackgroundTransparency = 1
    fadeIn(btnAntiAFK)
end

task.spawn(startLoading)
