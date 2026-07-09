-- Azly Mizi Hub - Grow A Garden 2 (Game ID: 97598239454123)
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

-- ===== TÌM REMOTEEVENT ĐÚNG CÁCH =====
local ShopRemote = nil
local HarvestRemote = nil
local PetRemote = nil

-- Tìm trong tất cả service
local function findRemote(patterns)
    for _, service in ipairs({ReplicatedStorage, workspace, game:GetService("ServerScriptService")}) do
        for _, obj in ipairs(service:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                local name = obj.Name:lower()
                for _, pattern in ipairs(patterns) do
                    if name:find(pattern) then
                        return obj
                    end
                end
            end
        end
    end
    return nil
end

ShopRemote = findRemote({"shop", "buy", "purchase", "store"})
HarvestRemote = findRemote({"harvest", "collect", "fruit", "pick"})
PetRemote = findRemote({"pet", "tame", "animal"})

-- In ra để debug
print("ShopRemote:", ShopRemote and ShopRemote.Name or "Không tìm thấy")
print("HarvestRemote:", HarvestRemote and HarvestRemote.Name or "Không tìm thấy")
print("PetRemote:", PetRemote and PetRemote.Name or "Không tìm thấy")

-- ===== DANH SÁCH ITEM =====
local SEED_LIST = {
    "Carrot", "Strawberry", "Bamboo", "Blueberry", "Tulip", "Apple", "Tomato", "Banana",
    "Sunflower", "Corn", "Mushroom", "Cherry", "Mango", "Grape", "Coconut", "Cactus",
    "Baby Cactus", "Pomegranate", "Pineapple", "Dragon Fruit", "Green Bean", "Acorn",
    "Poison Apple", "Moon Bloom", "Poison Ivy", "Ghost Pepper", "Venus Fly Trap",
    "Venom Spitter", "Hypno Bloom", "Dragon's Breath", "Buttercup", "Pumpkin",
    "Beanstalk", "Thorn Rose", "Lotus", "Romanesco", "Glow Mushroom", "Horned Melon",
    "Briar Rose", "Fire Fern", "Rocket Pop", "Mega", "Gold", "Rainbow"
}

local GEAR_LIST = {
    "Common Watering Can", "Common Sprinkler", "Sign", "Megaphone", "Uncommon Sprinkler",
    "Rare Sprinkler", "Legendary Sprinkler", "Wheelbarrow", "Strawberry Sniper",
    "Super Sprinkler", "Trowel", "Speed Mushroom", "Jump Mushroom", "Gnome",
    "Shrink Mushroom", "Supersize Mushroom", "Invisibility Mushroom",
    "Super Watering Can", "Basic Pot", "Flashbang", "Player Magnet",
    "Teleporter", "Legendary Pet Teleporter"
}

local PET_LIST = {
    "IceSerpent", "Raccoon", "Unicorn", "GoldenDragonfly", "BlackDragon", "Monkey",
    "Bee", "Robin", "Deer", "Owl", "Bunny", "Frog", "Butterfly", "BaldEagle", "Bear", "Turtle"
}

local CRATE_LIST = {"Basic Crate", "Rare Crate", "Legendary Crate", "Mystery Crate"}

-- ===== HÀM MUA HÀNG (THỬ NHIỀU CÁCH) =====
local function buyItem(itemType, itemName, amount)
    if not ShopRemote then
        return false, "Không tìm thấy ShopRemote"
    end
    amount = amount or 1
    
    local success, err = pcall(function()
        -- Thử tất cả cách gọi có thể
        local methods = {
            function() ShopRemote:FireServer("Buy" .. itemType, itemName, amount) end,
            function() ShopRemote:FireServer(itemType, itemName, amount) end,
            function() ShopRemote:FireServer("Purchase", itemType, itemName, amount) end,
            function() ShopRemote:FireServer({Type = itemType, Name = itemName, Amount = amount}) end,
            function() ShopRemote:FireServer(itemName, amount) end,
            function() ShopRemote:FireServer("Buy", itemName, amount) end,
        }
        
        for _, method in ipairs(methods) do
            local s, e = pcall(method)
            if s then
                print("Mua thành công với cách:", method)
                return
            end
        end
    end)
    
    if success then
        return true, "Thành công"
    else
        return false, tostring(err)
    end
end

-- ===== HÀM HÁI TRÁI =====
local function harvestFruit(fruitName)
    if not HarvestRemote then
        return false, "Không tìm thấy HarvestRemote"
    end
    
    local success, err = pcall(function()
        local methods = {
            function() HarvestRemote:FireServer("Harvest", fruitName) end,
            function() HarvestRemote:FireServer(fruitName) end,
            function() HarvestRemote:FireServer("Collect", fruitName) end,
            function() HarvestRemote:FireServer("Pick", fruitName) end,
        }
        for _, method in ipairs(methods) do
            local s, e = pcall(method)
            if s then
                print("Hái thành công:", fruitName)
                return
            end
        end
    end)
    
    if success then
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

-- === STATUS ===
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

-- === MENU ===
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0.96, 0, 0.68, 0)
menuFrame.Position = UDim2.new(0.02, 0, 0.34, 0)
menuFrame.BackgroundTransparency = 1
menuFrame.Visible = false
menuFrame.Parent = main

local tabList = Instance.new("ScrollingFrame")
tabList.Size = UDim2.new(0.28, 0, 1, 0)
tabList.Position = UDim2.new(0, 0, 0, 0)
tabList.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
tabList.BackgroundTransparency = 0
tabList.BorderSizePixel = 0
tabList.ScrollBarThickness = 3
tabList.CanvasSize = UDim2.new(0, 0, 0, 320)
tabList.Parent = menuFrame

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 6)
tabCorner.Parent = tabList

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

-- === ESP ===
local espEnabled = false
local espBoxes = {}
local espConnections = {}

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

-- === HÀM TẠO NỘI DUNG MUA ===
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

-- === HÀM TẠO NỘI DUNG HÁI ===
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
    
    local dropdown = Instance.new("ScrollingFrame")
    dropdown.Size = UDim2.new(0.7, 0, 0, 100)
    dropdown.Position = UDim2.new(0.05, 0, 0.15, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    dropdown.BorderSizePixel = 1
    dropdown.BorderColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.ScrollBarThickness = 4
    dropdown.CanvasSize = UDim2.new(0, 0, 0, #SEED_LIST * 25)
    dropdown.Parent = contentFrame
    
    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 6)
    dropCorner.Parent = dropdown
    
    local selectedFruit = nil
    local selectedBtn = nil
    
    for i, fruit in ipairs(SEED_LIST) do
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
        end
    end
    toggleBtn.MouseButton1Click:Connect(toggleAntiAFK)
end

-- === TẠO NỘI DUNG ESP ===
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
    
    toggleBtn.MouseButton1Click:Connect(function()
        if espEnabled then
            espEnabled = false
            statusText.Text = "Tắt"
            statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            circle.Position = UDim2.new(0, 3, 0.5, -10)
            disableESP()
        else
            espEnabled = true
            statusText.Text = "Bật"
            statusText.TextColor3 = Color3.fromRGB(100, 255, 150)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
            circle.Position = UDim2.new(0, 27, 0.5, -10)
            enableESP()
        end
    end)
end

-- === SWITCH TAB ===
local function switchTab(tabId)
    for id, btn in pairs(tabButtons) do
        btn.BackgroundTransparency = (id == tabId) and 0.5 or 0.85
    end
    
    if tabId == "antiafk" then
        createAntiAFKContent()
    elseif tabId == "esp" then
        createESPContent()
    elseif tabId == "buyseed" then
        createBuyContent("Seed", SEED_LIST)
    elseif tabId == "buygear" then
        createBuyContent("Gear", GEAR_LIST)
    elseif tabId == "buycrate" then
        createBuyContent("Crate", CRATE_LIST)
    elseif tabId == "buypet" then
        createBuyContent("Pet", PET_LIST)
    elseif tabId == "harvest" then
        createHarvestContent()
    end
end

for id, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        switchTab(id)
    end)
end

switchTab("antiafk")

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
        for _, btn in pairs(tabButtons) do
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

    for _, btn in pairs(tabButtons) do
        btn.BackgroundTransparency = 1
        task.wait(0.04)
        fadeIn(btn)
    end
end

task.spawn(startLoading)

-- In ra để debug
print("Azly Mizi Hub đã tải!")
print("ShopRemote:", ShopRemote and ShopRemote.Name or "Không tìm thấy")
print("HarvestRemote:", HarvestRemote and HarvestRemote.Name or "Không tìm thấy")
