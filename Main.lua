-- Azly Mizi Hub - Chuẩn trình tự: Đang tải → Tải xong → Hiện bảng  
local player = game.Players.LocalPlayer  
local gui = Instance.new("ScreenGui")  
gui.Name = "AzlyMiziHub"  
gui.Parent = player:WaitForChild("PlayerGui")  
gui.ResetOnSpawn = false  

-- === TẠO UI ===  
local main = Instance.new("Frame")  
main.Size = UDim2.new(0, 450, 0, 300)  
main.Position = UDim2.new(0.5, -225, 0.5, -150)  
main.BackgroundColor3 = Color3.fromRGB(20, 22, 35)  
main.BackgroundTransparency = 0.15  
main.BorderSizePixel = 0  
main.Parent = gui  

local corner = Instance.new("UICorner")  
corner.CornerRadius = UDim.new(0, 16)  
corner.Parent = main  

local stroke = Instance.new("UIStroke")  
stroke.Color = Color3.fromRGB(100, 150, 255)  
stroke.Thickness = 1.5  
stroke.Transparency = 0.4  
stroke.Parent = main  

-- Tiêu đề  
local title = Instance.new("TextLabel")  
title.Size = UDim2.new(1, 0, 0, 50)  
title.Position = UDim2.new(0, 0, 0, 10)  
title.BackgroundTransparency = 1  
title.Text = "Azly Mizi Hub"  
title.TextColor3 = Color3.fromRGB(255, 255, 255)  
title.TextSize = 28  
title.Font = Enum.Font.GothamBold  
title.TextXAlignment = Enum.TextXAlignment.Center  
title.Parent = main  

-- === TRẠNG THÁI TẢI (hiện ban đầu) ===  
local statusFrame = Instance.new("Frame")  
statusFrame.Size = UDim2.new(0.8, 0, 0, 60)  
statusFrame.Position = UDim2.new(0.1, 0, 0.3, 0)  
statusFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 55)  
statusFrame.BackgroundTransparency = 0.5  
statusFrame.BorderSizePixel = 0  
statusFrame.Parent = main  

local statusCorner = Instance.new("UICorner")  
statusCorner.CornerRadius = UDim.new(0, 12)  
statusCorner.Parent = statusFrame  

local statusLabel = Instance.new("TextLabel")  
statusLabel.Size = UDim2.new(1, 0, 1, 0)  
statusLabel.BackgroundTransparency = 1  
statusLabel.Text = "Đang Tải Dữ Liệu..."  
statusLabel.TextColor3 = Color3.fromRGB(200, 220, 255)  
statusLabel.TextSize = 18  
statusLabel.Font = Enum.Font.SourceSans  
statusLabel.TextXAlignment = Enum.TextXAlignment.Center  
statusLabel.Parent = statusFrame  

-- Thanh tiến trình  
local progressBar = Instance.new("Frame")  
progressBar.Size = UDim2.new(0.8, 0, 0, 4)  
progressBar.Position = UDim2.new(0.1, 0, 0.75, 0)  
progressBar.BackgroundColor3 = Color3.fromRGB(60, 70, 100)  
progressBar.BackgroundTransparency = 0.3  
progressBar.BorderSizePixel = 0  
progressBar.Parent = main  

local progressCorner = Instance.new("UICorner")  
progressCorner.CornerRadius = UDim.new(1, 0)  
progressCorner.Parent = progressBar  

local progressFill = Instance.new("Frame")  
progressFill.Size = UDim2.new(0, 0, 1, 0)  
progressFill.BackgroundColor3 = Color3.fromRGB(100, 180, 255)  
progressFill.BorderSizePixel = 0  
progressFill.Parent = progressBar  

local fillCorner = Instance.new("UICorner")  
fillCorner.CornerRadius = UDim.new(1, 0)  
fillCorner.Parent = progressFill  

-- === MENU CHÍNH (ẩn ban đầu) ===  
local menuFrame = Instance.new("Frame")  
menuFrame.Size = UDim2.new(0.9, 0, 0.5, 0)  
menuFrame.Position = UDim2.new(0.05, 0, 0.4, 0)  
menuFrame.BackgroundTransparency = 1  
menuFrame.Visible = false  
menuFrame.Parent = main  

-- Nút Main  
local btnMain = Instance.new("TextButton")  
btnMain.Size = UDim2.new(0.4, 0, 0, 40)  
btnMain.Position = UDim2.new(0.05, 0, 0, 0)  
btnMain.BackgroundColor3 = Color3.fromRGB(40, 80, 180)  
btnMain.BackgroundTransparency = 0.2  
btnMain.Text = "Main"  
btnMain.TextColor3 = Color3.fromRGB(255, 255, 255)  
btnMain.TextSize = 18  
btnMain.Font = Enum.Font.GothamBold  
btnMain.Parent = menuFrame  

local btnCorner = Instance.new("UICorner")  
btnCorner.CornerRadius = UDim.new(0, 8)  
btnCorner.Parent = btnMain  

-- Nút Player  
local btnPlayer = Instance.new("TextButton")  
btnPlayer.Size = UDim2.new(0.4, 0, 0, 40)  
btnPlayer.Position = UDim2.new(0.55, 0, 0, 0)  
btnPlayer.BackgroundColor3 = Color3.fromRGB(40, 80, 180)  
btnPlayer.BackgroundTransparency = 0.2  
btnPlayer.Text = "Player"  
btnPlayer.TextColor3 = Color3.fromRGB(255, 255, 255)  
btnPlayer.TextSize = 18  
btnPlayer.Font = Enum.Font.GothamBold  
btnPlayer.Parent = menuFrame  

local btnCorner2 = Instance.new("UICorner")  
btnCorner2.CornerRadius = UDim.new(0, 8)  
btnCorner2.Parent = btnPlayer  

-- === XỬ LÝ LUỒNG ===  
local function startLoading()  
    -- Giai đoạn 1: Đang tải (hiển thị thanh tiến trình)  
    statusLabel.Text = "Đang Tải Dữ Liệu..."  
    statusLabel.TextColor3 = Color3.fromRGB(200, 220, 255)  
    progressFill.Size = UDim2.new(0, 0, 1, 0)  

    -- Mô phỏng tiến trình  
    for i = 1, 10 do  
        progressFill.Size = UDim2.new(i / 10, 0, 1, 0)  
        task.wait(0.15)  
    end  

    -- Giai đoạn 2: Tải xong  
    statusLabel.Text = "Tải dữ liệu thành công!"  
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 180)  
    task.wait(0.8)  

    -- Giai đoạn 3: Hiện bảng menu  
    statusFrame.Visible = false  
    menuFrame.Visible = true  
    menuFrame.BackgroundTransparency = 1  

    local tween = game:GetService("TweenService"):Create(  
        menuFrame,  
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),  
        {BackgroundTransparency = 0}  
    )  
    tween:Play()  

    print("Azly Mizi Hub - Đã sẵn sàng!")  
end  

-- Gán sự kiện cho nút (tạm)  
btnMain.MouseButton1Click:Connect(function()  
    print("Main")  
end)  

btnPlayer.MouseButton1Click:Connect(function()  
    print("Player")  
end)  

-- Chạy  
task.spawn(startLoading)  
