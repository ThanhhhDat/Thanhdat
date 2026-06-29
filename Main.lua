-- Azly Mizi Hub - Menu lớn (tham khảo RealKid Hub)
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "AzlyMiziHub"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local FRAME_W = 500
local FRAME_H = 420

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

-- === NÚT THU NHỎ (CÓ KÉO) ===
local btnMinimize = Instance.new("TextButton")
btnMinimize.Size = UDim2.new(0, 32, 0, 32)
btnMinimize.Position = UDim2.new(1, -38, 0, 6)
btnMinimize.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnMinimize.BorderSizePixel = 0
btnMinimize.Text = "−"
btnMinimize.TextColor3 = Color3.fromRGB(200, 200, 200)
btnMinimize.TextSize = 22
btnMinimize.Font = Enum.Font.GothamBold
btnMinimize.Parent = main

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = btnMinimize

-- Kéo thả
local dragging = false
local dragStart = nil
local startPos = nil

btnMinimize.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- === TIÊU ĐỀ ===
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 50)
title.Position = UDim2.new(0, 0, 0, 8)
title.BackgroundTransparency = 1
title.Text = "Azly Mizi Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 26
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Bottom
title.Parent = main

local underline = Instance.new("Frame")
underline.Size = UDim2.new(0.6, 0, 0, 2)
underline.Position = UDim2.new(0.2, 0, 0.22, 0)
underline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
underline.BackgroundTransparency = 0.2
underline.BorderSizePixel = 0
underline.Parent = main

-- === STATUS + THANH TIẾN TRÌNH ===
local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(0.85, 0, 0, 60)
statusFrame.Position = UDim2.new(0.075, 0, 0.30, 0)
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
statusLabel.TextSize = 16
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = statusFrame

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(0.9, 0, 0, 4)
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

-- === MENU CHÍNH (LỚN) ===
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0.9, 0, 0.6, 0)
menuFrame.Position = UDim2.new(0.05, 0, 0.38, 0)
menuFrame.BackgroundTransparency = 1
menuFrame.Visible = false
menuFrame.Parent = main

-- Tạo các nút chức năng (dạng cột)
local function createButton(name, yPos, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 0.9
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamMedium
    btn.Parent = parent

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    return btn
end

-- Danh sách nút menu (theo ảnh tham khảo)
local menuItems = {
    "Main", "Shop", "Server", "Setting", "Sản Pet (Hop)",
    "Weather And Stock", "Collect Seeds", "Pets", "Harvest Fruits"
}

local buttons = {}
for i, item in ipairs(menuItems) do
    local y = (i - 1) * 40
    local btn = createButton(item, y, menuFrame)
    table.insert(buttons, btn)
end

-- === NÚT MỞ LẠI ===
local btnRestore = Instance.new("TextButton")
btnRestore.Size = UDim2.new(0, 56, 0, 56)
btnRestore.Position = UDim2.new(0.5, -28, 0.5, -28)
btnRestore.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
btnRestore.BorderSizePixel = 2
btnRestore.BorderColor3 = Color3.fromRGB(255, 255, 255)
btnRestore.Text = "+"
btnRestore.TextColor3 = Color3.fromRGB(255, 255, 255)
btnRestore.TextSize = 36
btnRestore.Font = Enum.Font.GothamBold
btnRestore.Visible = false
btnRestore.Parent = gui

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(1, 0)
restoreCorner.Parent = btnRestore

-- === ANIMATION ===
local function fadeIn(obj)
    obj.BackgroundTransparency = 1
    obj.Visible = true
    TweenService:Create(obj, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
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
        for _, btn in ipairs(buttons) do
            btn.BackgroundTransparency = 1
            task.wait(0.05)
            fadeIn(btn)
        end
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
        TweenService:Create(progressFill, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(step.progress, 0, 1, 0)}):Play()
        task.wait(0.5)
    end

    statusLabel.TextColor3 = Color3.fromRGB(180, 255, 200)
    statusLabel.Text = "Tải dữ liệu thành công!"
    task.wait(0.6)

    fadeOut(statusFrame)
    task.wait(0.3)
    statusFrame.Visible = false
    menuFrame.Visible = true

    for _, btn in ipairs(buttons) do
        btn.BackgroundTransparency = 1
        task.wait(0.05)
        fadeIn(btn)
    end
end

-- Gán sự kiện cho các nút (tạm)
for _, btn in ipairs(buttons) do
    btn.MouseButton1Click:Connect(function()
        print("Đã bấm: " .. btn.Text)
    end)
end

task.spawn(startLoading)
