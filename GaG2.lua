-- Azly Mizi Hub - Anti AFK + ESP + Mua Seed/Gear/Crate + Hái trái
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "AzlyMiziHub"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FRAME_W = 540
local FRAME_H = 480

-- ===== DANH SÁCH ITEM =====
local ITEMS = {
    Seed = {
        "Carrot", "Strawberry", "Bamboo", "Blueberry", "Tulip", "Apple", "Tomato", "Banana",
        "Sunflower", "Corn", "Mushroom", "Cherry", "Mango", "Grape", "Coconut", "Cactus",
        "Baby Cactus", "Pomegranate", "Pineapple", "Dragon Fruit", "Green Bean", "Acorn",
        "Poison Apple", "Moon Bloom", "Poison Ivy", "Ghost Pepper", "Venus Fly Trap",
        "Venom Spitter", "Hypno Bloom", "Dragon's Breath", "Buttercup", "Pumpkin",
        "Beanstalk", "Thorn Rose", "Lotus", "Romanesco", "Glow Mushroom", "Horned Melon",
        "Briar Rose", "Fire Fern", "Rocket Pop", "Mega", "Gold", "Rainbow"
    },
    Pet = {
        "IceSerpent", "Raccoon", "Unicorn", "GoldenDragonfly", "BlackDragon", "Monkey",
        "Bee", "Robin", "Deer", "Owl", "Bunny", "Frog", "Butterfly", "BaldEagle", "Bear", "Turtle"
    },
    Gear = {
        "Common Watering Can", "Common Sprinkler", "Sign", "Megaphone", "Uncommon Sprinkler",
        "Rare Sprinkler", "Legendary Sprinkler", "Wheelbarrow", "Strawberry Sniper",
        "Super Sprinkler", "Trowel", "Speed Mushroom", "Jump Mushroom", "Gnome",
        "Shrink Mushroom", "Supersize Mushroom", "Invisibility Mushroom",
        "Super Watering Can", "Basic Pot", "Flashbang", "Player Magnet",
        "Teleporter", "Legendary Pet Teleporter"
    },
    Crate = {
        "Basic Crate", "Rare Crate", "Legendary Crate", "Mystery Crate"
    }
}

-- ===== TÌM REMOTEEVENT =====
local ShopRemote = nil
local HarvestRemote = nil

for _, service in ipairs({ReplicatedStorage, workspace, player}) do
    for _, obj in ipairs(service:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = obj.Name:lower()
            if not ShopRemote and (name:find("shop") or name:find("buy") or name:find("purchase")) then
                ShopRemote = obj
            end
            if not HarvestRemote and (name:find("harvest") or name:find("collect") or name:find("fruit")) then
                HarvestRemote = obj
            end
        end
    end
end

-- ===== HÀM MUA HÀNG =====
local function buyItem(itemType, itemName, amount)
    if not ShopRemote then
        warn("Không tìm thấy RemoteEvent mua hàng")
        return false, "Không tìm thấy RemoteEvent"
    end
    amount = amount or 1
    local success, err = pcall(function()
        -- Thử nhiều cách gọi
        ShopRemote:FireServer("Buy" .. itemType, itemName, amount)
        ShopRemote:FireServer(itemType, itemName, amount)
        ShopRemote:FireServer({Type = itemType, Name = itemName, Amount = amount})
        ShopRemote:FireServer("Purchase", itemType, itemName, amount)
    end)
    if success then
        print("Đã mua " .. amount .. " " .. itemName .. " (" .. itemType .. ")")
        return true, "Thành công"
    else
        return false, tostring(err)
    end
end

-- ===== HÀM HÁI TRÁI =====
local function harvestFruit(fruitName)
    if not HarvestRemote then
        warn("Không tìm thấy RemoteEvent hái trái")
        return false, "Không tìm thấy RemoteEvent"
    end
    local success, err = pcall(function()
        HarvestRemote:FireServer("Harvest", fruitName)
        HarvestRemote:FireServer(fruitName)
        HarvestRemote:FireServer("Collect", fruitName)
    end)
    if success then
        print("Đã hái: " .. fruitName)
        return true, "Thành công"
    else
        return false, tostring(err)
    end
end

-- ===== MAIN FRAME =====
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

-- === AVATAR ===
local avatarFrame = Instance.new("Frame")
avatarFrame.Size = UDim2.new(0, 50, 0, 50)
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
statusFrame.Position = UDim2.new(0.075, 0, 0.25, 0)
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
menuFrame.Size = UDim2.new(0.96, 0, 0.68, 0)
menuFrame.Position = UDim2.new(0.02, 0, 0.34, 0)
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
tabList.CanvasSize = UDim2.new(0, 0, 0, 300)
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

-- === TẠO TAB ===
local tabs = {
    {name = "Anti AFK", id = "antiafk"},
    {name = "ESP", id = "esp"},
    {name = "Mua Seed", id = "buyseed"},
    {name = "Mua Gear", id = "buygear"},
    {name = "Mua Crate", id = "buycrate"},
    {name = "Mua Pet", id = "buypet"},
    {name = "Hái trái", id = "harvest"}
}

local tabButtons = {}
for i, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 28)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1)*32)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 0.85
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = tab.name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.Parent = tabList
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    tabButtons[tab.id] = btn
end
tabList.CanvasSize = UDim2.new(0, 0, 0, #tabs * 32 + 10)

-- === BIẾN ESP ===
local espEnabled = false
local espBoxes = {}
local espConnections = {}

-- === HÀM ESP ===
local function createESP(playerObj)
    if playerObj == player then return end
    local character = playerObj.Character
    if not character then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    local box = Instance.new("BoxHandleAdornment")
    box.Size = Vector3.new(3, 5, 2)
    box.Color3 = Color3.fromRGB(0, 255, 0)
    box.Transparency = 0.5
    box.ZIndex = 0
    box.AlwaysOnTop = true
    box.Adornee = root
    box.Parent = gui
    
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
    
    local conn = RunService.Heartbeat:Connect(function()
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

local function enableESP()
    if espEnabled then return end
    espEnabled = true
    for _, p in ipairs(Players:GetPlayers()) do
        createESP(p)
    end
    local newConn = Players.PlayerAdded:Connect(function(p)
        task.wait(0.5)
        createESP(p)
    end)
    table.insert(espConnections, newConn)
    local leaveConn = Players.PlayerRemoving:Connect(function(p)
        if espBoxes[p] then
            if espBoxes[p].box then espBoxes[p].box:Destroy() end
            if espBoxes[p].name then espBoxes[p].name:Destroy() end
            if espBoxes[p].dist then espBoxes[p].dist:Destroy() end
            espBoxes[p] = nil
        end
    end)
    table.insert(espConnections, leaveConn)
end

local function disableESP()
    if not espEnabled then return end
    espEnabled = false
    for _, data in pairs(espBoxes) do
        if data.box then data.box:Destroy() end
        if data.name then data.name:Destroy() end
        if data.dist then data.dist:Destroy() end
    end
    espBoxes = {}
    for _, conn in ipairs(espConnections) do
        conn:Disconnect()
    end
    espConnections = {}
end

-- === HÀM TẠO NỘI DUNG MUA HÀNG ===
local function createBuyContent(itemType, itemList)
    for _, child in ipairs(contentFrame:GetChildren()) do child:Destroy() end
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 28)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = "Mua " .. itemType
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = contentFrame
    
    -- Dropdown danh sách item
    local dropdown = Instance.new("ScrollingFrame")
    dropdown.Size = UDim2.new(0.7, 0, 0, 100)
    dropdown.Position = UDim2.new(0.05, 0, 0.15, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    dropdown.BorderSizePixel = 1
    dropdown.BorderColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.ScrollBarThickness = 4
    dropdown.CanvasSize = UDim2.new(0, 0, 0, #itemList * 25)
    dropdown.Parent = contentFrame
    
    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 6)
    dropCorner.Parent = dropdown
    
    local selectedItem = nil
    local selectedBtn = nil
    
    for i, item in ipairs(itemList) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.95, 0, 0, 22)
        btn.Position = UDim2.new(0.025, 0, 0, (i-1)*25)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.BackgroundTransparency = 0
        btn.BorderSizePixel = 0
        btn.Text = item
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamMedium
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = dropdown
        
        btn.MouseButton1Click:Connect(function()
            if selectedBtn then
                selectedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end
            selectedItem = item
            selectedBtn = btn
            btn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        end)
    end
    
    -- Ô nhập số lượng
    local amountBox = Instance.new("TextBox")
    amountBox.Size = UDim2.new(0.3, 0, 0, 30)
    amountBox.Position = UDim2.new(0.05, 0, 0.45, 0)
    amountBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    amountBox.BorderSizePixel = 1
    amountBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
    amountBox.Text = "1"
    amountBox.PlaceholderText = "Số lượng"
    amountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    amountBox.TextSize = 14
    amountBox.Font = Enum.Font.GothamMedium
    amountBox.Parent = contentFrame
    
    local amountCorner = Instance.new("UICorner")
    amountCorner.CornerRadius = UDim.new(0, 6)
    amountCorner.Parent = amountBox
    
    -- Nút mua
    local buyBtn = Instance.new("TextButton")
    buyBtn.Size = UDim2.new(0.3, 0, 0, 35)
    buyBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
    buyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
    buyBtn.BorderSizePixel = 0
    buyBtn.Text = "Mua"
    buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    buyBtn.TextSize = 16
    buyBtn.Font = Enum.Font.GothamBold
    buyBtn.Parent = contentFrame
    
    local buyCorner = Instance.new("UICorner")
    buyCorner.CornerRadius = UDim.new(0, 6)
    buyCorner.Parent = buyBtn
    
    -- Label thông báo
    local resultLabel = Instance.new("TextLabel")
    resultLabel.Size = UDim2.new(0.8, 0, 0, 25)
    resultLabel.Position = UDim2.new(0.05, 0, 0.78, 0)
    resultLabel.BackgroundTransparency = 1
    resultLabel.Text = ""
    resultLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    resultLabel.TextSize = 12
    resultLabel.Font = Enum.Font.GothamMedium
    resultLabel.TextXAlignment = Enum.TextXAlignment.Left
    resultLabel.Parent = contentFrame
    
    buyBtn.MouseButton1Click:Connect(function()
        if not selectedItem then
            resultLabel.Text = "Vui lòng chọn " .. itemType
            resultLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
            return
        end
        local amount = tonumber(amountBox.Text) or 1
        if amount < 1 then amount = 1 end
        
        resultLabel.Text = "Đang mua..."
        resultLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        
        local success, msg = buyItem(itemType, selectedItem, amount)
        if success then
            resultLabel.Text = "Đã mua " .. amount .. " " .. selectedItem
            resultLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
        else
            resultLabel.Text = "Lỗi: " .. msg
            resultLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
end

-- === HÀM TẠO NỘI DUNG HÁI TRÁI ===
local function createHarvestContent()
    for _, child in ipairs(contentFrame:GetChildren()) do child:Destroy() end
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 28)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = "Hái trái"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = contentFrame
    
    -- Danh sách trái
    local fruitList = ITEMS.Seed
    local dropdown = Instance.new("ScrollingFrame")
    dropdown.Size = UDim2.new(0.7, 0, 0, 100)
    dropdown.Position = UDim2.new(0.05, 0, 0.15, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    dropdown.BorderSizePixel = 1
    dropdown.BorderColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.ScrollBarThickness = 4
    dropdown.CanvasSize = UDim2.new(0, 0, 0, #fruitList * 25)
    dropdown.Parent = contentFrame
    
    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 6)
    dropCorner.Parent = dropdown
    
    local selectedFruit = nil
    local selectedBtn = nil
    
    for i, fruit in ipairs(fruitList) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.95, 0, 0, 22)
        btn.Position = UDim2.new(0.025, 0, 0, (i-1)*25)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.BackgroundTransparency = 0
        btn.BorderSizePixel = 0
        btn.Text = fruit
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamMedium
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = dropdown
        
        btn.MouseButton1Click:Connect(function()
            if selectedBtn then
                selectedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end
            selectedFruit = fruit
            selectedBtn = btn
            btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        end)
    end
    
    -- Nút hái
    local harvestBtn = Instance.new("TextButton")
    harvestBtn.Size = UDim2.new(0.3, 0, 0, 35)
    harvestBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
    harvestBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
    harvestBtn.BorderSizePixel = 0
    harvestBtn.Text = "Hái"
    harvestBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    harvestBtn.TextSize = 16
    harvestBtn.Font = Enum.Font.GothamBold
    harvestBtn.Parent = contentFrame
    
    local harvestCorner = Instance.new("UICorner")
    harvestCorner.CornerRadius = UDim.new(0, 6)
    harvestCorner.Parent = harvestBtn
    
    -- Label thông báo
    local resultLabel = Instance.new("TextLabel")
    resultLabel.Size = UDim2.new(0.8, 0, 0, 25)
    resultLabel.Position = UDim2.new(0.05, 0, 0.65, 0)
    resultLabel.BackgroundTransparency = 1
    resultLabel.Text = ""
    resultLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    resultLabel.TextSize = 12
    resultLabel.Font = Enum.Font.GothamMedium
    resultLabel.TextXAlignment = Enum.TextXAlignment.Left
    resultLabel.Parent = contentFrame
    
    harvestBtn.MouseButton1Click:Connect(function()
        if not selectedFruit then
            resultLabel.Text = "Vui lòng chọn trái cây"
            resultLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
            return
        end
        
        resultLabel.Text = "Đang hái..."
        resultLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        
        local success, msg = harvestFruit(selectedFruit)
        if success then
            resultLabel.Text = "Đã hái: " .. selectedFruit
            resultLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
        else
            resultLabel.Text = "Lỗi: " .. msg
            resultLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
end

-- === TẠO NỘI DUNG ANTI AFK ===
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
               
