local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local PlayerGui = localPlayer:WaitForChild("PlayerGui")

-- Cria a ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MenuVIPGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Cria o Botão Flutuante (para abrir/fechar o menu)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 20, 0, 200)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleButton.Text = "VIP"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 18
toggleButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = toggleButton

-- Cria a Janela Principal do Menu
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 350)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Título do Menu
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "Menu VIP Exclusivo"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Ação de abrir e fechar o menu ao clicar no botão flutuante
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

print("Menu VIP carregado com sucesso!")
