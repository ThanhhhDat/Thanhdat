-- Azly Mizi Hub - Grow A Garden 2 (UI chuẩn, tự động tìm Remote)
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "AzlyMiziHub"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FRAME_W = 520
local FRAME_H = 480

-- ===== TÌM REMOTEEVENT =====
local ShopRemote = nil
local HarvestRemote = nil

-- Duyệt toàn bộ ReplicatedStorage
for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        local name = obj.Name:lower()
        if not ShopRemote and (name:find("shop") or name:find("buy") or name:find("purchase") or name:find("store")) then
            ShopRemote = obj
        end
        if not HarvestRemote and (name:find("harvest") or name:find("collect") or name:find("fruit") or name:find("pick")) then
            HarvestRemote = obj
        end
    end
end

-- Nếu chưa tìm thấy, thử tìm trong Workspace và ServerScriptService
if not ShopRemote or not HarvestRemote then
    for _, service in ipairs({workspace, game:GetService("ServerScriptService")}) do
        for _, obj in ipairs(service:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
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
end

print("ShopRemote:", ShopRemote and ShopRemote.Name or "KHÔNG TÌM THẤY")
print("HarvestRemote:", HarvestRemote and HarvestRemote.Name or "KHÔNG TÌM THẤY")

-- ===== HÀM MUA =====
local function buyItem(itemType, itemName, amount)
    if not ShopRemote then
        return false, "Không tìm thấy ShopRemote"
    end
    amount = amount or 1
    local success, err = pcall(function()
        ShopRemote:FireServer("Buy" .. itemType, itemName, amount)
        ShopRemote:FireServer(itemType, itemName, amount)
        ShopRemote:FireServer("Purchase", itemType, itemName, amount)
        ShopRemote:FireServer(itemName, amount)
    end)
    return success, err
end

-- ===== HÀM HÁI =====
local function harvestFruit(fruitName)
    if not HarvestRemote then
        return false, "Không tìm thấy HarvestRemote"
    end
    local success, err = pcall(function()
        HarvestRemote:FireServer("Harvest", fruitName)
        HarvestRemote:FireServer(fruitName)
        HarvestRemote:FireServer("Collect", fruitName)
    end)
    return success, err
end

-- ===== DANH SÁCH =====
local SEEDS = {"Carrot","Strawberry","Bamboo","Blueberry","Tulip","Apple","Tomato","Banana","Sunflower","Corn","Mushroom","Cherry","Mango","Grape","Coconut","Cactus","Baby Cactus","Pomegranate","Pineapple","Dragon Fruit","Green Bean","Acorn","Poison Apple","Moon Bloom","Poison Ivy","Ghost Pepper","Venus Fly Trap","Venom Spitter","Hypno Bloom","Dragon's Breath","Buttercup","Pumpkin","Beanstalk","Thorn Rose","Lotus","Romanesco","Glow Mushroom","Horned Melon","Briar Rose","Fire Fern","Rocket Pop","Mega","Gold","Rainbow"}
local GEARS = {"Common Watering Can","Common Sprinkler","Sign","Megaphone","Uncommon Sprinkler","Rare Sprinkler","Legendary Sprinkler","Wheelbarrow","Strawberry Sniper","Super Sprinkler","Trowel","Speed Mushroom","Jump Mushroom","Gnome","Shrink Mushroom","Supersize Mushroom","Invisibility Mushroom","Super Watering Can","Basic Pot","Flashbang","Player Magnet","Teleporter","Legendary Pet Teleporter"}
local PETS = {"IceSerpent","Raccoon","Unicorn","GoldenDragonfly","BlackDragon","Monkey","Bee","Robin","Deer","Owl","Bunny","Frog","Butterfly","BaldEagle","Bear","Turtle"}
local CRATES = {"Basic Crate","Rare Crate","Legendary Crate","Mystery Crate","Ladder Crate","Picture Frame Crate"}

-- ===== MAIN FRAME =====
local main = Instance.new("Frame")
main.Size = UDim2.new(0, FRAME_W, 0, FRAME_H)
main.Position = UDim2.new(0.5, -FRAME_W/2, 0.5, -FRAME_H/2)
main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
main.BorderSizePixel = 0
main.BackgroundTransparency = 0
main.Visible = true
main.Parent = gui

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.Transparency = 0.4
stroke.Parent = main

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = main

-- === AVATAR ===
local avatarFrame = Instance.new("Frame")
avatarFrame.Size = UDim2.new(0, 45, 0, 45)
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
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "rbxassetid://90447015543102"
avatarImage.ScaleType = Enum.ScaleType.Fit
avatarImage.Parent = avatarFrame

-- === TIÊU ĐỀ ===
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 35)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Azly Mizi Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Bottom
title.Parent = main

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

-- === STATUS BAR ===
local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(0.9, 0, 0, 40)
statusFrame.Position = UDim2.new(0.05, 0, 0.22, 0)
statusFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
statusFrame.BorderSizePixel = 0
statusFrame.BackgroundTransparency = 0
statusFrame.Visible = true
statusFrame.Parent = main

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 1, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Đang tải dữ liệu..."
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 13
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = statusFrame

local progressBg = Instance.new("Frame")
progressBg.Size = UDim2.new(0.9, 0, 0, 3)
progressBg.Position = UDim2.new(0.05, 0, 0.8, 0)
progressBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
progressBg.BorderSizePixel = 0
progressBg.Parent = statusFrame

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(1, 0)
progressCorner.Parent = progressBg

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = progressFill

-- === MENU ===
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0.96, 0, 0.68, 0)
menuFrame.Position = UDim2.new(0.02, 0, 0.30, 0)
menuFrame.BackgroundTransparency = 1
menuFrame.Visible = false
menuFrame.Parent = main

-- Cột trái: Tab
local tabList = Instance.new("ScrollingFrame")
tabList.Size = UDim2.new(0.3, 0, 1, 0)
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
    btn.Size = UDim2.new(0.92, 0, 0, 30)
    btn.Position = UDim2.new(0.04, 0, 0, (i-1)*34)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 0.9
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
tabList.CanvasSize = UDim2.new(0, 0, 0, #tabs * 34 + 10)

-- === ESP ===
local espEnabled = false
local espBoxes = {}
local espConnections = {}

local function createESP(p)
    if p == player then return end
    local char = p.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    if not root or not head then return end
    
    local box = Instance.new("BoxHandleAdornment")
    box.Size = Vector3.new(3, 5, 2)
    box.Color3 = Color3.fromRGB(0, 255, 0)
    box.Transparency = 0.5
    box.AlwaysOnTop = true
    box.Adornee = root
    box.Parent = gui
    
    local nameLabel = Instance.new("BillboardGui")
    nameLabel.Size = UDim2.new(0, 200, 0, 25)
    nameLabel.StudsOffset = Vector3.new(0, 2.5, 0)
    nameLabel.AlwaysOnTop = true
    nameLabel.Parent = head
    
    local nameText = Instance.new("TextLabel")
    nameText.Size = UDim2.new(1, 0, 1, 0)
    nameText.BackgroundTransparency = 1
    nameText.Text = "@" .. p.Name
    nameText.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameText.TextSize = 13
    nameText.Font = Enum.Font.GothamBold
    nameText.TextStrokeTransparency = 0.3
    nameText.Parent = nameLabel
    
    espBoxes[p] = {box = box, name = nameLabel}
    
    local conn = game:GetService("RunService").Heartbeat:Connect(function()
        if not espEnabled then conn:Disconnect() end
    end)
    table.insert(espConnections, conn)
end

local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        for _, p in ipairs(game.Players:GetPlayers()) do createESP(p) end
        game.Players.PlayerAdded:Connect(function(p) task.wait(0.5) createESP(p) end)
    else
        for _, data in pairs(espBoxes) do
            if data.box then data.box:Destroy() end
            if data.name then data.name:Destroy() end
        end
        espBoxes = {}
    end
end

-- ===== TẠO NỘI DUNG =====
local function createBuyContent(title, itemList)
    for _, c in ipairs(contentFrame:GetChildren()) do c:Destroy() end
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = contentFrame
    
    local dropdown = Instance.new("ScrollingFrame")
    dropdown.Size = UDim2.new(0.9, 0, 0, 90)
    dropdown.Position = UDim2.new(0.05, 0, 0.15, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    dropdown.BorderSizePixel = 1
    dropdown.BorderColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.ScrollBarThickness = 3
    dropdown.CanvasSize = UDim2.new(0, 0, 0, #itemList * 24)
    dropdown.Parent = contentFrame
    
    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 4)
    dropCorner.Parent = dropdown
    
    local selected = nil
    local selectedBtn = nil
    
    for i, item in ipairs(itemList) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.96, 0, 0, 22)
        btn.Position = UDim2.new(0.02, 0, 0, (i-1)*24)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        btn.BorderSizePixel = 0
        btn.Text = item
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamMedium
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = dropdown
        
        btn.MouseButton1Click:Connect(function()
            if selectedBtn then selectedBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35) end
            selected = item
            selectedBtn = btn
            btn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        end)
    end
    
    local amountBox = Instance.new("TextBox")
    amountBox.Size = UDim2.new(0.3, 0, 0, 28)
    amountBox.Position = UDim2.new(0.05, 0, 0.42, 0)
    amountBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    amountBox.BorderSizePixel = 1
    amountBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
    amountBox.Text = "1"
    amountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    amountBox.TextSize = 13
    amountBox.Font = Enum.Font.GothamMedium
    amountBox.Parent = contentFrame
    
    local amountCorner = Instance.new("UICorner")
    amountCorner.CornerRadius = UDim.new(0, 4)
    amountCorner.Parent = amountBox
    
    local buyBtn = Instance.new("TextButton")
    buyBtn.Size = UDim2.new(0.3, 0, 0, 32)
    buyBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
    buyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
    buyBtn.BorderSizePixel = 0
    buyBtn.Text = "Mua"
    buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    buyBtn.TextSize = 15
    buyBtn.Font = Enum.Font.GothamBold
    buyBtn.Parent = contentFrame
    
    local buyCorner = Instance.new("UICorner")
    buyCorner.CornerRadius = UDim.new(0, 4)
    buyCorner.Parent = buyBtn
    
    local resultLabel = Instance.new("TextLabel")
    resultLabel.Size = UDim2.new(0.9, 0, 0, 25)
    resultLabel.Position = UDim2.new(0.05, 0, 0.72, 0)
    resultLabel.BackgroundTransparency = 1
    resultLabel.Text = ""
    resultLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    resultLabel.TextSize = 12
    resultLabel.Font = Enum.Font.GothamMedium
    resultLabel.TextXAlignment = Enum.TextXAlignment.Left
    resultLabel.Parent = contentFrame
    
    buyBtn.MouseButton1Click:Connect(function()
        if not selected then
            resultLabel.Text = "Vui lòng chọn item"
            resultLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
            return
        end
        local amount = tonumber(amountBox.Text) or 1
        if amount < 1 then amount = 1
        resultLabel.Text = "Đang mua..."
        resultLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        local success, err = buyItem(title:gsub("Mua ",""), selected, amount)
        if success then
            resultLabel.Text = "Đã mua " .. amount .. " " .. selected
            resultLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
        else
            resultLabel.Text = "Lỗi: " .. tostring(err)
            resultLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
end

local function createHarvestContent()
    for _, c in ipairs(contentFrame:GetChildren()) do c:Destroy() end
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = "Hái trái"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = contentFrame
    
    local dropdown = Instance.new("ScrollingFrame")
    dropdown.Size = UDim2.new(0.9, 0, 0, 90)
    dropdown.Position = UDim2.new(0.05, 0, 0.15, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    dropdown.BorderSizePixel = 1
    dropdown.BorderColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.ScrollBarThickness = 3
    dropdown.CanvasSize = UDim2.new(0, 0, 0, #SEEDS * 24)
    dropdown.Parent = contentFrame
    
    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 4)
    dropCorner.Parent = dropdown
    
    local selected = nil
    local selectedBtn = nil
    
    for i, item in ipairs(SEEDS) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.96, 0, 0, 22)
        btn.Position = UDim2.new(0.02, 0, 0, (i-1)*24)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        btn.BorderSizePixel = 0
        btn.Text = item
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamMedium
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = dropdown
        
        btn.MouseButton1Click:Connect(function()
            if selectedBtn then selectedBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35) end
            selected = item
            selectedBtn = btn
            btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        end)
    end
    
    local harvestBtn = Instance.new("TextButton")
    harvestBtn.Size = UDim2.new(0.3, 0, 0, 32)
    harvestBtn.Position = UDim2.new(0.05, 0, 0.42, 0)
    harvestBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
    harvestBtn.BorderSizePixel = 0
    harvestBtn.Text = "Hái"
    harvestBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    harvestBtn.TextSize = 15
    harvestBtn.Font = Enum.Font.GothamBold
    harvestBtn.Parent = contentFrame
    
    local harvestCorner = Instance.new("UICorner")
    harvestCorner.CornerRadius = UDim.new(0, 4)
    harvestCorner.Parent = harvestBtn
    
    local resultLabel = Instance.new("TextLabel")
    resultLabel.Size = UDim2.new(0.9, 0, 0, 25)
    resultLabel.Position = UDim2.new(0.05, 0, 0.6, 0)
    resultLabel.BackgroundTransparency = 1
    resultLabel.Text = ""
    resultLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    resultLabel.TextSize = 12
    resultLabel.Font = Enum.Font.GothamMedium
    resultLabel.TextXAlignment = Enum.TextXAlignment.Left
    resultLabel.Parent = contentFrame
    
    harvestBtn.MouseButton1Click:Connect(function()
        if not selected then
            resultLabel.Text = "Vui lòng chọn trái"
            resultLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
            return
        end
        resultLabel.Text = "Đang hái..."
        resultLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        local success, err = harvestFruit(selected)
        if success then
            resultLabel.Text = "Đã hái: " .. selected
            resultLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
        else
            resultLabel.Text = "Lỗi: " .. tostring(err)
            resultLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
end

local function createAntiAFK()
    for _, c in ipairs(contentFrame:GetChildren()) do c:Destroy() end
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = "Chế độ Anti AFK"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = contentFrame
    
    local isOn = false
    local running = false
    local thread = nil
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0.8, 0, 0, 40)
    toggleFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    toggleFrame.BorderSizePixel = 1
    toggleFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    toggleFrame.Parent = contentFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 4)
    toggleCorner.Parent = toggleFrame
    
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(0.4, 0, 1, 0)
    statusText.Position = UDim2.new(0, 5, 0, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "Tắt"
    statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusText.TextSize = 14
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
    desc.Size = UDim2.new(0.8, 0, 0, 25)
    desc.Position = UDim2.new(0.05, 0, 0.55, 0)
    desc.BackgroundTransparency = 1
    desc.Text = "Giữ kết nối mỗi 5 phút (an toàn)"
    desc.TextColor3 = Color3.fromRGB(150, 150, 150)
    desc.TextSize = 12
    desc.Font = Enum.Font.GothamMedium
    desc.Parent = contentFrame
    
    toggleBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        if isOn then
            statusText.Text = "Bật"
            statusText.TextColor3 = Color3.fromRGB(100, 255, 150)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
            circle.Position = UDim2.new(0, 27, 0.5, -10)
            running = true
            thread = coroutine.create(function()
                while running do
                    pcall(function()
                        local vu = game:GetService("VirtualUser")
                        if vu then vu:CaptureController() vu:ClickButton2(Vector2.new()) end
                        local cam = workspace.CurrentCamera
                        if cam then
                            local cf = cam.CFrame
                            cam.CFrame = cf + Vector3.new(0.001, 0, 0)
                            task.wait(0.05)
                            cam.CFrame = cf
                        end
                    end)
                    for i = 1, 300 do if not running then break end task.wait(1) end
                end
            end)
            coroutine.resume(thread)
        else
            statusText.Text = "Tắt"
            statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            circle.Position = UDim2.new(0, 3, 0.5, -10)
            running = false
            if thread then coroutine.close(thread) thread = nil end
        end
    end)
end

local function createESPContent()
    for _, c in ipairs(contentFrame:GetChildren()) do c:Destroy() end
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = "ESP Player"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = contentFrame
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0.8, 0, 0, 40)
    toggleFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    toggleFrame.BorderSizePixel = 1
    toggleFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    toggleFrame.Parent = contentFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 4)
    toggleCorner.Parent = toggleFrame
    
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(0.4, 0, 1, 0)
    statusText.Position = UDim2.new(0, 5, 0, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "Tắt"
    statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusText.TextSize = 14
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
    desc.Size = UDim2.new(0.8, 0, 0, 25)
    desc.Position = UDim2.new(0.05, 0, 0.55, 0)
    desc.BackgroundTransparency = 1
    desc.Text = "Hiển thị khung xanh và tên player"
    desc.TextColor3 = Color3.fromRGB(150, 150, 150)
    desc.TextSize = 12
    desc.Font = Enum.Font.GothamMedium
    desc.Parent = contentFrame
    
    toggleBtn.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        if espEnabled then
            statusText.Text = "Bật"
            statusText.TextColor3 = Color3.fromRGB(100, 255, 150)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
            circle.Position = UDim2.new(0, 27, 0.5, -10)
            toggleESP()
        else
            statusText.Text = "Tắt"
            statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            circle.Position = UDim2.new(0, 3, 0.5, -10)
            toggleESP()
        end
    end)
end

-- ===== SWITCH TAB =====
local function switchTab(id)
    for k, btn in pairs(tabButtons) do
        btn.BackgroundTransparency = (k == id) and 0.5 or 0.9
    end
    if id == "antiafk" then createAntiAFK()
    elseif id == "esp" then createESPContent()
    elseif id == "buyseed" then createBuyContent("Mua Seed", SEEDS)
    elseif id == "buygear" then createBuyContent("Mua Gear", GEARS)
    elseif id == "buycrate" then createBuyContent("Mua Crate", CRATES)
    elseif id == "buypet" then createBuyContent("Mua Pet", PETS)
    elseif id == "harvest" then createHarvestContent()
    end
end

for id, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() switchTab(id) end)
end
switchTab("antiafk")

-- === NÚT MỞ LẠI ===
local btnRestore = Instance.new("ImageButton")
btnRestore.Size = UDim2.new(0, 50, 0, 50)
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

-- === XỬ LÝ THU NHỎ ===
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

-- === TẢI ===
local function startLoading()
    main.Visible = true
    fadeIn(main)
    statusFrame.Visible = true
    menuFrame.Visible = false
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    statusLabel.Text = "Đang tải dữ liệu..."
    
    local steps = {
        {text = "Đang tải cấu hình...", p = 0.2},
        {text = "Đang kết nối server...", p = 0.4},
        {text = "Đang tải dữ liệu...", p = 0.6},
        {text = "Đang kiểm tra...", p = 0.8},
        {text = "Hoàn tất!", p = 1.0}
    }
    
    for _, s in ipairs(steps) do
        statusLabel.Text = s.text
        TweenService:Create(progressFill, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(s.p, 0, 1, 0)}):Play()
        task.wait(0.4)
    end
    
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 180)
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

print("Azly Mizi Hub đã tải!")
print("ShopRemote:", ShopRemote and ShopRemote.Name or "KHÔNG TÌM THẤY")
print("HarvestRemote:", HarvestRemote and HarvestRemote.Name or "KHÔNG TÌM THẤY")
