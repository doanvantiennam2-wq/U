repeat wait() until game:IsLoaded()

--// N HUB V2
getgenv().NHUB = {
    AutoFarm = false,
    FastAttack = false,
}

local plr = game.Players.LocalPlayer

--// UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "NHUB_V2"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 200)
Frame.Position = UDim2.new(0.1, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)

-- 🔥 BO GÓC
local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 15)

-- 🔥 VIỀN
local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Color = Color3.fromRGB(0,255,255)
UIStroke.Thickness = 2

-- 🔥 TITLE
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "N HUB V2"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(30,30,30)

-- BO GÓC TITLE
local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 15)

-- 🔥 DRAG (kéo khung)
local dragging, dragInput, dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

--// BUTTON AUTO FARM
local AutoFarmBtn = Instance.new("TextButton", Frame)
AutoFarmBtn.Size = UDim2.new(1, -20, 0, 40)
AutoFarmBtn.Position = UDim2.new(0,10,0,50)
AutoFarmBtn.Text = "Auto Farm: OFF"
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
AutoFarmBtn.TextColor3 = Color3.new(1,1,1)

local BtnCorner1 = Instance.new("UICorner", AutoFarmBtn)
BtnCorner1.CornerRadius = UDim.new(0,10)

AutoFarmBtn.MouseButton1Click:Connect(function()
    getgenv().NHUB.AutoFarm = not getgenv().NHUB.AutoFarm
    AutoFarmBtn.Text = "Auto Farm: "..(getgenv().NHUB.AutoFarm and "ON" or "OFF")
end)

--// BUTTON FAST ATTACK
local FastAtkBtn = Instance.new("TextButton", Frame)
FastAtkBtn.Size = UDim2.new(1, -20, 0, 40)
FastAtkBtn.Position = UDim2.new(0,10,0,100)
FastAtkBtn.Text = "Fast Attack: OFF"
FastAtkBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
FastAtkBtn.TextColor3 = Color3.new(1,1,1)

local BtnCorner2 = Instance.new("UICorner", FastAtkBtn)
BtnCorner2.CornerRadius = UDim.new(0,10)

FastAtkBtn.MouseButton1Click:Connect(function()
    getgenv().NHUB.FastAttack = not getgenv().NHUB.FastAttack
    FastAtkBtn.Text = "Fast Attack: "..(getgenv().NHUB.FastAttack and "ON" or "OFF")
end)

--// AUTO FARM
spawn(function()
    while wait() do
        if getgenv().NHUB.AutoFarm then
            for i,v in pairs(workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                    break
                end
            end
        end
    end
end)

--// FAST ATTACK
spawn(function()
    while wait() do
        if getgenv().NHUB.FastAttack then
            pcall(function()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0))
            end)
        end
    end
end)
