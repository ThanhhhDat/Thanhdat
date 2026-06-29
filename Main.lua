-- Azly Mizi Hub - Basic đen trắng, có thu nhỏ/mở lại  
local player = game.Players.LocalPlayer  
local gui = Instance.new("ScreenGui")  
gui.Name = "AzlyMiziHub"  
gui.Parent = player:WaitForChild("PlayerGui")  
gui.ResetOnSpawn = false  

-- === FRAME CHÍNH ===  
local main = Instance.new("Frame")  
main.Size = UDim2.new(0, 400, 0, 300)  
main.Position = UDim2.new(0.5, -200, 0.5, -150)  
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
main.BorderSizePixel = 1  
main.BorderColor3 = Color3.fromRGB(255, 255, 255)  
main.Parent = gui  

-- === NÚT THU NHỎ (dấu -) ===  
local btnMinimize = Instance.new("TextButton")  
btnMinimize.Size = UDim2.new(0, 30, 0, 30)  
btnMinimize.Position = UDim2.new(1, -35, 0, 5)  
btnMinimize.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  
btnMinimize.BorderSizePixel = 1  
btnMinimize.BorderColor3 = Color3.fromRGB(255, 255, 255)  
btnMinimize.Text = "-"  
btnMinimize.TextColor3 = Color3.fromRGB(255, 255, 255)  
btnMinimize.TextSize = 20  
btnMinimize.Font = Enum.Font.SourceSans  
btnMinimize.Parent = main  

-- === TIÊU ĐỀ ===  
local title = Instance.new("TextLabel")  
title.Size = UDim2.new(1, -40, 0, 50)  
title.Position = UDim2.new(0, 0, 0, 10)  
title.BackgroundTransparency = 1  
title.Text = "Azly Mizi Hub"  
title.TextColor3 = Color3.fromRGB(255, 255, 255)  
title.TextSize = 24  
title.Font = Enum.Font.SourceSans  
title.TextXAlignment = Enum.TextXAlignment.Center  
title.Parent = main  

-- === TRẠNG THÁI TẢI ===  
local statusFrame = Instance.new("Frame")  
statusFrame.Size = UDim2.new(0.8, 0, 0, 50)  
statusFrame.Position = UDim2.new(0.1, 0, 0.3, 0)  
statusFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  
statusFrame.BorderSizePixel = 1  
statusFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)  
statusFrame.Parent = main  

local statusLabel = Instance.new("TextLabel")  
statusLabel.Size = UDim2.new(1, 0, 1, 0)  
statusLabel.BackgroundTransparency = 1  
statusLabel.Text = "Đang Tải Dữ Liệu..."  
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  
statusLabel.TextSize = 16  
statusLabel.Font = Enum.Font.SourceSans  
statusLabel.TextXAlignment = Enum.TextXAlignment.Center  
statusLabel.Parent = statusFrame  

-- === MENU CHÍNH ===  
local menuFrame = Instance.new("Frame")  
menuFrame.Size = UDim2.new(0.9, 0, 0.4, 0)  
menuFrame.Position = UDim2.new(0.05, 0, 0.45, 0)  
menuFrame.BackgroundTransparency = 1  
menuFrame.Visible = false  
menuFrame.Parent = main  

-- Nút Main  
local btnMain = Instance.new("TextButton")  
btnMain.Size = UDim2.new(0.4, 0, 0, 40)  
btnMain.Position = UDim2.new(0.05, 0, 0, 0)  
btnMain.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  
btnMain.BorderSizePixel = 1  
btnMain.BorderColor3 = Color3.fromRGB(255, 255, 255)  
btnMain.Text = "Main"  
btnMain.TextColor3 = Color3.fromRGB(255, 255, 255)  
btnMain.TextSize = 18  
btnMain.Font = Enum.Font.SourceSans  
btnMain.Parent = menuFrame  

-- Nút Player  
local btnPlayer = Instance.new("TextButton")  
btnPlayer.Size = UDim2.new(0.4, 0, 0, 40)  
btnPlayer.Position = UDim2.new(0.55, 0, 0, 0)  
btnPlayer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  
btnPlayer.BorderSizePixel = 1  
btnPlayer.BorderColor3 = Color3.fromRGB(255, 255, 255)  
btnPlayer.Text = "Player"  
btnPlayer.TextColor3 = Color3.fromRGB(255, 255, 255)  
btnPlayer.TextSize = 18  
btnPlayer.Font = Enum.Font.SourceSans  
btnPlayer.Parent = menuFrame  

-- === NÚT MỞ LẠI (dấu +) - ẩn ban đầu ===  
local btnRestore = Instance.new("TextButton")  
btnRestore.Size = UDim2.new(0, 40, 0, 40)  
btnRestore.Position = UDim2.new(0.5, -20, 0.5, -20)  
btnRestore.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
btnRestore.BorderSizePixel = 1  
btnRestore.BorderColor3 = Color3.fromRGB(255, 255, 255)  
btnRestore.Text = "+"  
btnRestore.TextColor3 = Color3.fromRGB(255, 255, 255)  
btnRestore.TextSize = 30  
btnRestore.Font = Enum.Font.SourceSans  
btnRestore.Visible = false  
btnRestore.Parent = gui  

-- === XỬ LÝ THU NHỎ / MỞ LẠI ===  
local function minimize()  
    main.Visible = false  
    btnRestore.Visible = true  
end  

local function restore()  
    main.Visible = true  
    btnRestore.Visible = false  
end  

btnMinimize.MouseButton1Click:Connect(minimize)  
btnRestore.MouseButton1Click:Connect(restore)  

-- === XỬ LÝ LUỒNG TẢI ===  
local function startLoading()  
    statusLabel.Text = "Đang Tải Dữ Liệu..."  
    task.wait(2)  

    statusLabel.Text = "Tải dữ liệu thành công!"  
    task.wait(1)  

    statusFrame.Visible = false  
    menuFrame.Visible = true  
end  

-- Gán sự kiện nút menu (tạm)  
btnMain.MouseButton1Click:Connect(function() print("Main") end)  
btnPlayer.MouseButton1Click:Connect(function() print("Player") end)  

-- Chạy  
task.spawn(startLoading)  
