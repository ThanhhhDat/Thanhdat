-- Azly Mizi Hub - Có animation nhẹ, đen trắng  
local player = game.Players.LocalPlayer  
local gui = Instance.new("ScreenGui")  
gui.Name = "AzlyMiziHub"  
gui.Parent = player:WaitForChild("PlayerGui")  
gui.ResetOnSpawn = false  

local TweenService = game:GetService("TweenService")  

-- === FRAME CHÍNH ===  
local main = Instance.new("Frame")  
main.Size = UDim2.new(0, 300, 0, 200)  
main.Position = UDim2.new(0.5, -150, 0.5, -100)  
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
main.BorderSizePixel = 2  
main.BorderColor3 = Color3.fromRGB(255, 255, 255)  
main.BackgroundTransparency = 1  -- Bắt đầu ẩn để animation  
main.Parent = gui  

-- === NÚT THU NHỎ (dấu -) ===  
local btnMinimize = Instance.new("TextButton")  
btnMinimize.Size = UDim2.new(0, 25, 0, 25)  
btnMinimize.Position = UDim2.new(1, -30, 0, 5)  
btnMinimize.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  
btnMinimize.BorderSizePixel = 1  
btnMinimize.BorderColor3 = Color3.fromRGB(255, 255, 255)  
btnMinimize.Text = "-"  
btnMinimize.TextColor3 = Color3.fromRGB(255, 255, 255)  
btnMinimize.TextSize = 18  
btnMinimize.Font = Enum.Font.SourceSans  
btnMinimize.Parent = main  

-- === TIÊU ĐỀ ===  
local title = Instance.new("TextLabel")  
title.Size = UDim2.new(1, -35, 0, 40)  
title.Position = UDim2.new(0, 0, 0, 5)  
title.BackgroundTransparency = 1  
title.Text = "Azly Mizi Hub"  
title.TextColor3 = Color3.fromRGB(255, 255, 255)  
title.TextSize = 22  
title.Font = Enum.Font.SourceSans  
title.TextXAlignment = Enum.TextXAlignment.Center  
title.Parent = main  

-- === TRẠNG THÁI TẢI ===  
local statusFrame = Instance.new("Frame")  
statusFrame.Size = UDim2.new(0.8, 0, 0, 40)  
statusFrame.Position = UDim2.new(0.1, 0, 0.35, 0)  
statusFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  
statusFrame.BorderSizePixel = 1  
statusFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)  
statusFrame.Parent = main  

local statusLabel = Instance.new("TextLabel")  
statusLabel.Size = UDim2.new(1, 0, 1, 0)  
statusLabel.BackgroundTransparency = 1  
statusLabel.Text = "Đang Tải Dữ Liệu..."  
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  
statusLabel.TextSize = 14  
statusLabel.Font = Enum.Font.SourceSans  
statusLabel.TextXAlignment = Enum.TextXAlignment.Center  
statusLabel.Parent = statusFrame  

-- === MENU CHÍNH (ẩn ban đầu) ===  
local menuFrame = Instance.new("Frame")  
menuFrame.Size = UDim2.new(0.9, 0, 0.4, 0)  
menuFrame.Position = UDim2.new(0.05, 0, 0.5, 0)  
menuFrame.BackgroundTransparency = 1  
menuFrame.Visible = false  
menuFrame.Parent = main  

-- Nút Main  
local btnMain = Instance.new("TextButton")  
btnMain.Size = UDim2.new(0.8, 0, 0, 35)  
btnMain.Position = UDim2.new(0.1, 0, 0, 0)  
btnMain.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  
btnMain.BorderSizePixel = 1  
btnMain.BorderColor3 = Color3.fromRGB(255, 255, 255)  
btnMain.Text = "Main"  
btnMain.TextColor3 = Color3.fromRGB(255, 255, 255)  
btnMain.TextSize = 16  
btnMain.Font = Enum.Font.SourceSans  
btnMain.Parent = menuFrame  

-- Nút Player  
local btnPlayer = Instance.new("TextButton")  
btnPlayer.Size = UDim2.new(0.8, 0, 0, 35)  
btnPlayer.Position = UDim2.new(0.1, 0, 0.55, 0)  
btnPlayer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  
btnPlayer.BorderSizePixel = 1  
btnPlayer.BorderColor3 = Color3.fromRGB(255, 255, 255)  
btnPlayer.Text = "Player"  
btnPlayer.TextColor3 = Color3.fromRGB(255, 255, 255)  
btnPlayer.TextSize = 16  
btnPlayer.Font = Enum.Font.SourceSans  
btnPlayer.Parent = menuFrame  

-- === NÚT MỞ LẠI (dấu +) ===  
local btnRestore = Instance.new("TextButton")  
btnRestore.Size = UDim2.new(0, 40, 0, 40)  
btnRestore.Position = UDim2.new(0.5, -20, 0.5, -20)  
btnRestore.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
btnRestore.BorderSizePixel = 2  
btnRestore.BorderColor3 = Color3.fromRGB(255, 255, 255)  
btnRestore.Text = "+"  
btnRestore.TextColor3 = Color3.fromRGB(255, 255, 255)  
btnRestore.TextSize = 30  
btnRestore.Font = Enum.Font.SourceSans  
btnRestore.Visible = false  
btnRestore.Parent = gui  

-- === HÀM ANIMATION ===  
local function fadeIn(obj)  
    local tween = TweenService:Create(obj, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0})  
    tween:Play()  
    return tween  
end  

local function fadeOut(obj)  
    local tween = TweenService:Create(obj, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1})  
    tween:Play()  
    return tween  
end  

-- === XỬ LÝ THU NHỎ / MỞ LẠI ===  
btnMinimize.MouseButton1Click:Connect(function()  
    fadeOut(main):OnComplete(function()  
        main.Visible = false  
        btnRestore.Visible = true  
        fadeIn(btnRestore)  
    end)  
end)  

btnRestore.MouseButton1Click:Connect(function()  
    fadeOut(btnRestore):OnComplete(function()  
        btnRestore.Visible = false  
        main.Visible = true  
        fadeIn(main)  
    end)  
end)  

-- === XỬ LÝ LUỒNG TẢI ===  
local function startLoading()  
    -- Xuất hiện main  
    fadeIn(main)  

    statusLabel.Text = "Đang Tải Dữ Liệu..."  
    task.wait(2)  

    -- Hiệu ứng chuyển trạng thái  
    local oldColor = statusLabel.TextColor3  
    statusLabel.Text = "Tải dữ liệu thành công!"  
    statusLabel.TextColor3 = Color3.fromRGB(180, 255, 180)  
    task.wait(0.8)  

    -- Ẩn status với hiệu ứng  
    fadeOut(statusFrame):OnComplete(function()  
        statusFrame.Visible = false  
        menuFrame.Visible = true  
        -- Hiệu ứng xuất hiện menu (các nút)  
        for _, child in ipairs(menuFrame:GetChildren()) do  
            if child:IsA("TextButton") then  
                child.BackgroundTransparency = 1  
                TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2}):Play()  
            end  
        end  
    end)  
end  

-- Gán sự kiện nút (tạm)  
btnMain.MouseButton1Click:Connect(function() print("Main") end)  
btnPlayer.MouseButton1Click:Connect(function() print("Player") end)  

task.spawn(startLoading)  
