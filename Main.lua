-- Azly Mizi Hub - Tab Anti AFK + Nút gạt bật/tắt + Kéo thả dấu +
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "AzlyMiziHub"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local FRAME_W = 450
local FRAME_H = 320

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

-- === NÚT THU NHỎ (dấu -) ===
local btnMinimize = Instance.new("TextButton")
btnMinimize.Size = UDim2.new(0, 30, 0, 30)
btnMinimize.Position = UDim2.new(1, -36, 0, 6)
btnMinimize.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnMinimize.BorderSizePixel = 0
btnMinimize.Text = "−"
btnMinimize.TextColor3 = Color3.fromRGB(200, 200, 200)
btnMinimize.TextSize = 20
btnMinimize.Font = Enum.Font.GothamBold
btnMinimize.Parent = main

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = btnMinimize

-- === TIÊU ĐỀ ===
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 40)
title.Position = UDim2.new(0, 0, 0, 6)
title.BackgroundTransparency = 1
title.Text = "Azly Mizi Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Bottom
title.Parent = main

-- === STATUS + THANH TIẾN TRÌNH ===
local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(0.85, 0, 0, 55)
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
statusLabel.TextSize = 15
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

-- === MENU CHÍNH (TAB + NỘI DUNG) ===
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0.96, 0, 0.62, 0)
menuFrame.Position = UDim2.new(0.02, 0, 0.36, 0)
menuFrame.BackgroundTransparency = 1
menuFrame.Visible = false
menuFrame.Parent = main

-- Cột trái: Tab (chỉ có Anti AFK)
local tabList = Instance.new("ScrollingFrame")
tabList.Size = UDim2.new(0.28, 0, 1, 0)
tabList.Position = UDim2.new(0, 0, 0, 0)
tabList.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
tabList.BackgroundTransparency = 0
tabList.BorderSizePixel = 0
tabList.ScrollBarThickness = 3
tabList.CanvasSize = UDim2.new(0, 0, 0, 50)
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

-- Label nội dung (sẽ hiển thị Anti AFK)
local contentLabel = Instance.new("TextLabel")
contentLabel.Size = UDim2.new(1, -10, 1, -10)
contentLabel.Position = UDim2.new(0, 5, 0, 5)
contentLabel.BackgroundTransparency = 1
contentLabel.Text = ""
contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
contentLabel.TextSize = 14
contentLabel.Font = Enum.Font.GothamMedium
contentLabel.TextWrapped = true
contentLabel.TextXAlignment = Enum.TextXAlignment.Left
contentLabel.TextYAlignment = Enum.TextYAlignment.Top
contentLabel.Parent = contentFrame

-- === TẠO TAB ANTI AFK ===
local btnAntiAFK = Instance.new("TextButton")
btnAntiAFK.Size = UDim2.new(0.9, 0, 0, 40)
btnAntiAFK.Position = UDim2.new(0.05, 0, 0, 0)
btnAntiAFK.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
btnAntiAFK.BackgroundTransparency = 0.85
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

-- Nổi bật tab khi chọn
btnAntiAFK.BackgroundTransparency = 0.5

-- === TẠO NỘI DUNG CHO ANTI AFK ===
local function createAntiAFKContent()
    -- Xóa nội dung cũ
    for _, child in ipairs(contentFrame:GetChildren()) do
        if child ~= contentLabel then child:Destroy() end
    end

    -- Label tiêu đề
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = "Anti AFK"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 18
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = contentFrame

    -- Khung chứa toggle
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0.8, 0, 0, 40)
    toggleFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    toggleFrame.BorderSizePixel = 1
    toggleFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    toggleFrame.Parent = contentFrame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleFrame

    -- Label trạng thái
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(0.5, 0, 1, 0)
    statusText.Position = UDim2.new(0, 5, 0, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "Tắt"
    statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusText.TextSize = 16
    statusText.Font = Enum.Font.GothamMedium
    statusText.TextXAlignment = Enum.TextXAlignment.Left
    statusText.Parent = toggleFrame

    -- Nút gạt (toggle)
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 26)
    toggleBtn.Position = UDim2.new(0.7, 0, 0.5, -13)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.Parent = toggleFrame

    local toggleCorner2 = Instance.new("UICorner")
    toggleCorner2.CornerRadius = UDim.new(1, 0)
    toggleCorner2.Parent = toggleBtn

    -- Nút tròn bên trong toggle
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 3, 0.5, -10)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = toggleBtn

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle

    -- Biến trạng thái
    local isOn = false
    local antiAFKRunning = false
    local antiAFKThread = nil

    -- Hàm bật/tắt Anti AFK
    local function toggleAntiAFK()
        isOn = not isOn

        if isOn then
            statusText.Text = "Bật"
            statusText.TextColor3 = Color3.fromRGB(100, 255, 150)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
            circle.Position = UDim2.new(0, 27, 0.5, -10)

            -- Bắt đầu Anti AFK
            if antiAFKRunning then
                antiAFKRunning = false
                if antiAFKThread then
                    coroutine.close(antiAFKThread)
                    antiAFKThread = nil
                end
            end
            antiAFKRunning = true
            antiAFKThread = coroutine.create(function()
                while antiAFKRunning do
                    -- Kiểm tra nhân vật tồn tại
                    local character = player.Character
                    if character and character:FindFirstChild("Humanoid") then
                        local humanoid = character.Humanoid
                        -- Nhảy lên
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        print("Anti AFK: Đã nhảy")
                    else
                        print("Anti AFK: Không tìm thấy nhân vật")
                    end
                    -- Chờ 5 phút (300 giây)
                    for i = 1, 300 do
                        if not antiAFKRunning then break end
                        task.wait(1)
                    end
                end
            end)
            coroutine.resume(antiAFKThread)

        else
            statusText.Text = "Tắt"
            statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            circle.Position = UDim2.new(0, 3, 0.5, -10)

            -- Dừng Anti AFK
            antiAFKRunning = false
            if antiAFKThread then
                coroutine.close(antiAFKThread)
                antiAFKThread = nil
            end
        end
    end

    -- Gán sự kiện cho toggle
    toggleBtn.MouseButton1Click:Connect(toggleAntiAFK)

    -- Thêm mô tả nhỏ
    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(0.8, 0, 0, 30)
    desc.Position = UDim2.new(0.05, 0, 0.5, 0)
    desc.BackgroundTransparency = 1
    desc.Text = "Mỗi 5 phút nhân vật sẽ nhảy 1 lần"
    desc.TextColor3 = Color3.fromRGB(150, 150, 150)
    desc.TextSize = 12
    desc.Font = Enum.Font.GothamMedium
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = contentFrame
end

-- Gọi tạo nội dung Anti AFK
createAntiAFKContent()

-- === NÚT MỞ LẠI (dấu +) - CÓ KÉO THẢ ===
local btnRestore = Instance.new("TextButton")
btnRestore.Size = UDim2.new(0, 50, 0, 50)
btnRestore.Position = UDim2.new(0.5, -25, 0.5, -25)
btnRestore.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
btnRestore.BorderSizePixel = 2
btnRestore.BorderColor3 = Color3.fromRGB(255, 255, 255)
btnRestore.Text = "+"
btnRestore.TextColor3 = Color3.fromRGB(255, 255, 255)
btnRestore.TextSize = 32
btnRestore.Font = Enum.Font.GothamBold
btnRestore.Visible = false
btnRestore.Parent = gui

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(1, 0)
restoreCorner.Parent = btnRestore

-- Kéo thả cho nút Restore
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

-- === KÉO THẢ TOÀN BỘ BẢNG ===
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
