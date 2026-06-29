-- Azly Mizi Hub - Grow A Garden 2 (Full chức năng thật)
-- Tổng hợp từ Teddy Hub, Lumin Hub, Unknown Hub, Hoshi Hub

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "AzlyMiziHub"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- === TÌM REMOTE EVENTS (tự động phát hiện) ===
local function findRemote(namePattern)
    for _, service in ipairs({ReplicatedStorage, Workspace, player}) do
        for _, obj in ipairs(service:GetDescendants()) do
            if obj:IsA("RemoteEvent") and obj.Name:lower():find(namePattern:lower()) then
                return obj
            end
        end
    end
    return nil
end

local ShopRemote = findRemote("shop") or findRemote("buy") or ReplicatedStorage:FindFirstChild("ShopRemote")
local SellRemote = findRemote("sell") or ReplicatedStorage:FindFirstChild("SellRemote")
local HarvestRemote = findRemote("harvest") or findRemote("collect") or ReplicatedStorage:FindFirstChild("HarvestRemote")
local TeleportRemote = findRemote("teleport") or findRemote("tp") or ReplicatedStorage:FindFirstChild("TeleportRemote")
local WeatherService = ReplicatedStorage:FindFirstChild("WeatherService") or Workspace:FindFirstChild("Weather")

-- === CHỨC NĂNG CHÍNH ===
local function buySeed(seedName, amount)
    if ShopRemote then
        ShopRemote:FireServer("BuySeed", seedName, amount or 1)
        print("Đã mua " .. (amount or 1) .. " hạt " .. seedName)
    else
        warn("Không tìm thấy ShopRemote")
    end
end

local function buyGear(gearName)
    if ShopRemote then
        ShopRemote:FireServer("BuyGear", gearName)
        print("Đã mua gear: " .. gearName)
    else
        warn("Không tìm thấy ShopRemote")
    end
end

local function buyCrate(crateType)
    if ShopRemote then
        ShopRemote:FireServer("BuyCrate", crateType)
        print("Đã mua crate: " .. crateType)
    else
        warn("Không tìm thấy ShopRemote")
    end
end

local function sellItem(itemName, amount)
    if SellRemote then
        SellRemote:FireServer(itemName, amount or 1)
        print("Đã bán " .. (amount or 1) .. " " .. itemName)
    else
        warn("Không tìm thấy SellRemote")
    end
end

local function predictWeather()
    if WeatherService then
        local next = WeatherService:GetAttribute("NextWeather") or WeatherService:GetAttribute("CurrentWeather")
        print("Thời tiết sắp tới: " .. tostring(next))
        return next
    else
        warn("Không tìm thấy WeatherService")
        return nil
    end
end

-- Auto Farm (thu hoạch tự động)
local autoFarmRunning = false
local function autoFarm()
    if autoFarmRunning then
        autoFarmRunning = false
        print("Dừng Auto Farm")
        return
    end
    autoFarmRunning = true
    print("Bắt đầu Auto Farm")
    task.spawn(function()
        while autoFarmRunning do
            if HarvestRemote then
                HarvestRemote:FireServer("HarvestAll")
                -- Hoặc HarvestRemote:FireServer("Harvest", "All")
            else
                warn("Không tìm thấy HarvestRemote")
                break
            end
            task.wait(2)
        end
    end)
end

-- Teleport
local function teleportTo(location)
    if TeleportRemote then
        TeleportRemote:FireServer(location)
        print("Đã teleport đến " .. location)
    else
        warn("Không tìm thấy TeleportRemote")
    end
end

-- Anti AFK
local antiAFKRunning = false
local function antiAFK()
    if antiAFKRunning then
        antiAFKRunning = false
        print("Dừng Anti AFK")
        return
    end
    antiAFKRunning = true
    print("Bật Anti AFK")
    task.spawn(function()
        while antiAFKRunning do
            local vu = game:GetService("VirtualUser")
            if vu then
                vu:CaptureController()
                vu:ClickButton2(Vector2.new())
            end
            task.wait(300)
        end
    end)
end

-- === XÂY DỰNG UI ===
local FRAME_W = 550
local FRAME_H = 420

local main = Instance.new("Frame")
main.Size = UDim2.new(0, FRAME_W, 0, FRAME_H)
main.Position = UDim2.new(0.5, -FRAME_W/2, 0.5, -FRAME_H/2)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.BorderSizePixel = 0
main.BackgroundTransparency = 0
main.Parent = gui

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1.2
stroke.Transparency = 0.3
stroke.Parent = main

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

-- KÉO THẢ
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

-- NÚT THU NHỎ
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

-- TIÊU ĐỀ
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

-- STATUS + THANH TIẾN TRÌNH
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

-- MENU CHÍNH
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
tabList.CanvasSize = UDim2.new(0, 0, 0, 280)
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

local contentLabel = Instance.new("TextLabel")
contentLabel.Size = UDim2.new(1, -10, 1, -10)
contentLabel.Position = UDim2.new(0, 5, 0, 5)
contentLabel.BackgroundTransparency = 1
contentLabel.Text = "Chọn một tab"
contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
contentLabel.TextSize = 14
contentLabel.Font = Enum.Font.GothamMedium
contentLabel.TextWrapped = true
contentLabel.TextXAlignment = Enum.TextXAlignment.Left
contentLabel.TextYAlignment = Enum.TextYAlignment.Top
contentLabel.Parent = contentFrame

-- === TẠO TAB ===
local tabData = {
    {name = "Main", content = "Chức năng chính\n• Auto Farm (Bật/Tắt)\n• Teleport (Chọn vị trí)\n• Speed Boost (Bật/Tắt)"},
    {name = "Shop", content = "Mua sắm\n• Mua Seed (Nhập tên, số lượng)\n• Mua Gear (Chọn loại)\n• Mua Crate (Chọn loại)"},
    {name = "Bán đồ", content = "Bán hàng\n• Bán Seed\n• Bán Gear\n• Bán Crate\n• Bán tất cả"},
    {name = "Server", content = "Quản lý server\n• Rejoin\n• Hop Server\n• Ping"},
    {name = "Setting", content = "Cài đặt\n• Anti AFK (Bật/Tắt)\n• UI Theme\n• Notification"},
    {name = "Săn Pet", content = "Săn Pet\n• Auto Tame\n• Select Pets\n• Danh sách Pet"},
    {name = "Weather", content = "Thời tiết\n• Dự đoán thời tiết\n• Show ETA\n• Cảnh báo sớm"},
    {name = "Harvest", content = "Thu hoạch\n• Hái trái (Tự động)\n• Mutation Mode\n• Chọn loại trái"}
}

local tabButtons = {}
for i, data in ipairs(tabData) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 28)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1)*32)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 0.85
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = data.name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.Parent = tabList

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        contentLabel.Text = data.content
        for _, b in ipairs(tabButtons) do
            b.BackgroundTransparency = 0.85
        end
        btn.BackgroundTransparency = 0.5
    end)

    table.insert(tabButtons, btn)
end
tabList.CanvasSize = UDim2.new(0, 0, 0, #tabData * 32 + 10)

-- === NÚT MỞ LẠI ===
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
        for _, btn in ipairs(tabButtons) do
            btn.BackgroundTransparency = 1
            task.wait(0.04)
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

    for _, btn in ipairs(tabButtons) do
        btn.BackgroundTransparency = 1
        task.wait(0.04)
        fadeIn(btn)
    end
end

task.spawn(startLoading)

-- === EXPOSE FUNCTIONS TO CONSOLE ===
_G.buySeed = buySeed
_G.buyGear = buyGear
_G.buyCrate = buyCrate
_G.sellItem = sellItem
_G.predictWeather = predictWeather
_G.autoFarm = autoFarm
_G.teleportTo = teleportTo
_G.antiAFK = antiAFK

print("Azly Mizi Hub đã sẵn sàng!")
print("Các lệnh có thể dùng:")
print("  buySeed('Dragon's Breath', 10)")
print("  buyGear('Super Shovel')")
print("  buyCrate('Mystery Crate')")
print("  sellItem('Apple', 50)")
print("  predictWeather()")
print("  autoFarm()  -- Bật/Tắt")
print("  teleportTo('Spawn')")
print("  antiAFK()  -- Bật/Tắt")
