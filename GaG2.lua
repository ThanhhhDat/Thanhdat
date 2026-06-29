-- Script Azly Mizi Hub - Giao diện tải và menu chính  
-- Dành cho Guts & Glory 2 (game.GameId == 10200395747)  

local player = game.Players.LocalPlayer  
local gui = Instance.new("ScreenGui")  
gui.Name = "AzlyMiziHub"  
gui.Parent = player:WaitForChild("PlayerGui")  
gui.ResetOnSpawn = false  

-- === HÀM TẠO UI ===  
local function createUI()  
    -- Frame chính  
    local main = Instance.new("Frame")  
    main.Size = UDim2.new(0, 500, 0, 350)  
    main.Position = UDim2.new(0.5, -250, 0.5, -175)  
    main.BackgroundColor3 = Color3.fromRGB(20, 22, 35)  
    main.BackgroundTransparency = 0.15  
    main.BorderSizePixel = 0  
    main.Parent = gui  

    -- Bo góc  
    local corner = Instance.new("UICorner")  
    corner.CornerRadius = UDim.new(0, 16)  
    corner.Parent = main  

    -- Viền sáng  
    local stroke = Instance.new("UIStroke")  
    stroke.Color = Color3.fromRGB(100, 150, 255)  
    stroke.Thickness = 1.5  
    stroke.Transparency = 0.4  
    stroke.Parent = main  

    -- Đổ bóng  
    local shadow = Instance.new("UIShadow")  
    shadow.Color = Color3.fromRGB(0, 0, 0)  
    shadow.Offset = Vector2.new(0, 10)  
    shadow.BlurRadius = 20  
    shadow.Transparency = 0.6  
    shadow.Parent = main  

    -- === TIÊU ĐỀ ===  
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

    -- === TRẠNG THÁI TẢI ===  
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

    -- Nút "Main"  
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

    -- Nút "Player"  
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

    -- Hàm trả về các thành phần để tương tác  
    return {  
        statusLabel = statusLabel,  
        progressFill = progressFill,  
        statusFrame = statusFrame,  
        menuFrame = menuFrame,  
        btnMain = btnMain,  
        btnPlayer = btnPlayer  
    }  
end  

-- === TẠO UI ===  
local ui = createUI()  

-- === MÔ PHỎNG TIẾN TRÌNH TẢI ===  
local function simulateLoading()  
    local steps = {  
        {text = "Đang tải cấu hình...", progress = 0.2},  
        {text = "Đang kết nối server...", progress = 0.4},  
        {text = "Đang tải dữ liệu người chơi...", progress = 0.6},  
        {text = "Đang kiểm tra phiên bản...", progress = 0.8},  
        {text = "Hoàn tất!", progress = 1.0}  
    }  

    for _, step in ipairs(steps) do  
        ui.statusLabel.Text = step.text  
        ui.progressFill.Size = UDim2.new(step.progress, 0, 1, 0)  
        task.wait(0.8)  
    end  

    -- Đổi trạng thái thành công  
    ui.statusLabel.Text = "Tải dữ liệu thành công!"  
    ui.statusLabel.TextColor3 = Color3.fromRGB(100, 255, 180)  

    -- Chờ 0.5s rồi chuyển sang menu chính  
    task.wait(0.5)  

    -- Ẩn frame trạng thái, hiện menu  
    ui.statusFrame.Visible = false  
    ui.menuFrame.Visible = true  

    -- Hiệu ứng xuất hiện menu  
    ui.menuFrame.BackgroundTransparency = 1  
    local tween = game:GetService("TweenService"):Create(  
        ui.menuFrame,  
        TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),  
        {BackgroundTransparency = 0}  
    )  
    tween:Play()  
end  

-- === GÁN SỰ KIỆN CHO NÚT (tạm thời) ===  
ui.btnMain.MouseButton1Click:Connect(function()  
    print("Đã bấm nút Main")  
    -- Sau này thêm chức năng  
end)  

ui.btnPlayer.MouseButton1Click:Connect(function()  
    print("Đã bấm nút Player")  
    -- Sau này thêm chức năng  
end)  

-- === BẮT ĐẦU MÔ PHỎNG ===  
task.spawn(simulateLoading)  

-- Thông báo console  
print("Azly Mizi Hub đã khởi tạo!")  
