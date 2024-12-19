-- Load necessary libraries (replace with valid URL)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/..."))()

-- Create UI
local Window = Library:CreateLib("Blox Fruits Script", "DarkTheme")
local FarmTab = Window:NewTab("Farming")
local BossTab = Window:NewTab("Boss")
local RaidTab = Window:NewTab("Raids")

-- Variables
local autoFarmEnabled = false
local autoChestFarmEnabled = false
local autoBossFarmEnabled = false
local autoFactoryRaidEnabled = false
local autoFruitRaidEnabled = false

-- Auto Chest Farm Function
function autoChestFarm()
    while autoChestFarmEnabled do
        for _, chest in pairs(game.Workspace:GetDescendants()) do
            if chest:IsA("Model") and chest.Name == "Chest" then
                local player = game.Players.LocalPlayer
                local humanoidRootPart = player.Character.HumanoidRootPart
                humanoidRootPart.CFrame = chest.CFrame
                wait(0.5) -- Adjust as needed
                
                -- Check for God Chalice or Fist of Darkness
                local inventory = player.Backpack:GetChildren()
                for _, item in pairs(inventory) do
                    if item.Name == "God Chalice" or item.Name == "Fist of Darkness" then
                        autoChestFarmEnabled = false
                        print("Auto Chest Farm Stopped: Found rare item!")
                        break
                    end
                end
            end
        end
        wait(1)
    end
end

-- Auto Level Farm Function
function autoLevelFarm()
    while autoFarmEnabled do
        local player = game.Players.LocalPlayer
        local target = game.Workspace.Enemies:FindFirstChild("Enemy") -- Replace with specific enemy name
        
        if target and target:FindFirstChild("Humanoid") then
            player.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame
            repeat
                wait(0.1)
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            until target.Humanoid.Health <= 0 or not autoFarmEnabled
        end
        wait(1)
    end
end

-- Auto Boss Farm Function
function autoBossFarm()
    local bosses = {"Shanks", "Blackbeard", "Saber Expert", "Dragon"} -- Add more boss names
    while autoBossFarmEnabled do
        for _, bossName in pairs(bosses) do
            local boss = game.Workspace.Enemies:FindFirstChild(bossName)
            if boss and boss:FindFirstChild("Humanoid") then
                local player = game.Players.LocalPlayer
                local humanoidRootPart = player.Character.HumanoidRootPart
                humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame
                repeat
                    wait(0.1)
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                until boss.Humanoid.Health <= 0 or not autoBossFarmEnabled
            end
        end
        wait(5)
    end
end

-- Auto Factory Raid Function
function autoFactoryRaid()
    while autoFactoryRaidEnabled do
        local factory = game.Workspace:FindFirstChild("Factory")
        if factory then
            local player = game.Players.LocalPlayer
            player.Character.HumanoidRootPart.CFrame = factory.HumanoidRootPart.CFrame
            -- Add logic to attack Factory Core
        end
        wait(10)
    end
end

-- Auto Fruit Raid Function
function autoFruitRaid()
    while autoFruitRaidEnabled do
        local raid = game.Workspace:FindFirstChild("FruitRaid")
        if raid then
            local player = game.Players.LocalPlayer
            player.Character.HumanoidRootPart.CFrame = raid.HumanoidRootPart.CFrame
            -- Add logic to complete raid
        end
        wait(10)
    end
end

-- UI Toggles
FarmTab:NewToggle("Enable Auto Chest Farm", "Toggle Chest Farm", function(state)
    autoChestFarmEnabled = state
    if state then
        autoChestFarm()
    end
end)

FarmTab:NewToggle("Enable Auto Level Farm", "Toggle Level Farm", function(state)
    autoFarmEnabled = state
    if state then
        autoLevelFarm()
    end
end)

BossTab:NewToggle("Enable Auto Boss Farm", "Toggle Boss Farm", function(state)
    autoBossFarmEnabled = state
    if state then
        autoBossFarm()
    end
end)

RaidTab:NewToggle("Enable Auto Factory Raid", "Toggle Factory Raid", function(state)
    autoFactoryRaidEnabled = state
    if state then
        autoFactoryRaid()
    end
end)

RaidTab:NewToggle("Enable Auto Fruit Raid", "Toggle Fruit Raid", function(state)
    autoFruitRaidEnabled = state
    if state then
        autoFruitRaid()
    end
end)