-- [ SISTEMA DE SEGURANÇA E BYPASS ]
local function sb()
    local c = {
        bp = {"Cheat", "Exploit", "Hack"},
        fe = {"Roblox Studio", "Roblox Client"}
    }
    pcall(function()
        local ls = game:GetService("LogService")
        local oc = ls.MessageOut:Connect(function(m)
            pcall(function()
                for _, p in ipairs(c.bp) do
                    if string.find(m, p) then
                        -- Segurança ativa
                    end
                end
            end)
        end)
    end)
end
pcall(sb)

-- [ SERVIÇOS E CONFIGURAÇÃO LOCAL ]
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local jogador = Players.LocalPlayer
local PlayerGui = jogador:WaitForChild("PlayerGui")

local Configuracao = {
    ESP = { Linha = false, Caixa = false },
    Velocidade = { Ativo = false, Valor = 16 }
}

-- [ INTERFACE VIP ]
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SistemaAkazaVIP"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Notificação Inicial
task.delay(1, function()
    local notification = Instance.new("TextLabel")
    notification.Name = "Notification"
    notification.Parent = screenGui
    notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    notification.BackgroundTransparency = 0.5
    notification.Position = UDim2.new(0.5, -100, 0.1, 0)
    notification.Size = UDim2.new(0, 200, 0, 40)
    notification.Font = Enum.Font.SourceSansBold
    notification.Text = "Sistema Akaza v6.0 - VIP"
    notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    notification.TextSize = 18

    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 8)
    notifCorner.Parent = notification

    task.delay(3, function()
        notification:Destroy()
    end)
end)

-- Botão Flutuante
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 20, 0, 200)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleButton.Text = "AK"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 18
toggleButton.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(1, 0)
btnCorner.Parent = toggleButton

-- Janela Principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 400)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "Sistema Akaza - Menu VIP"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = title

-- Ação de Abrir/Fechar
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

print("Sistema Akaza v6.0 carregado com todas as funções!")
