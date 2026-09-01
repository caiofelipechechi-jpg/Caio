-- [ SISTEMA DE SEGURANÇA E BYPASS ]
local function sb()
    local c = {
        bp = {"Cheat", "Exploit", "Hack", "Script", "Inject", "Memory", "Speed", "Teleport", "Noclip", "Fly", "Bypass", "Macro", "AutoFarm", "WallHack", "AimBot", "SpeedHack", "NoClip", "InfiniteResource", "ModifiedClient", "GameModifier", "ClientModification", "RuntimePatch", "MemoryManipulation", "ProcessInjection"},
        fe = {"Roblox Studio", "Roblox Client", "Roblox Player", "Roblox Beta", "Roblox Test Client", "RobloxPlayerBeta", "RobloxStudioBeta", "RobloxApp", "RobloxMobile"},
    }
    pcall(function()
        local ls = game:GetService("LogService")
        local oc = ls.MessageOut.Connect
        hookfunction(oc, function(self, cb)
            return oc(self, function(m)
                for _, p in ipairs(c.bp) do
                    if m:lower():find(p:lower()) then return end
                end
                cb(m)
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

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local Config = {
    ESP = { Linha = false, Caixa = false, Vida = false, Distancia = false, Nome = false, NivelForca = false },
    Speed = { Ativo = false, Velocidade = 16, HitboxAtivo = false, HitboxTamanho = 5 }
}

local function criarInterface()
    local playerGui = player:WaitForChild("PlayerGui")
    if playerGui:FindFirstChild("VipScriptGui") then
        playerGui.VipScriptGui:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VipScriptGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- Bolinha Flutuante Inicial
    local floatingButton = Instance.new("TextButton")
    floatingButton.Size = UDim2.new(0, 52, 0, 52)
    floatingButton.Position = UDim2.new(0.1, 0, 0.2, 0)
    floatingButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    floatingButton.Text = "VIP"
    floatingButton.TextColor3 = Color3.fromRGB(255, 215, 0)
    floatingButton.TextSize = 15
    floatingButton.Font = Enum.Font.GothamBold
    floatingButton.Active = true
    floatingButton.Parent = screenGui
    Instance.new("UICorner", floatingButton).CornerRadius = UDim.new(1, 0)

    -- Menu Principal
    local menuFrame = Instance.new("Frame")
    menuFrame.Size = UDim2.new(0, 320, 0, 430)
    menuFrame.Position = UDim2.new(0.65, 0, 0.1, 0)
    menuFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
    menuFrame.Visible = false
    menuFrame.Parent = screenGui
    Instance.new("UICorner", menuFrame).CornerRadius = UDim.new(0, 16)

    -- Texto de Execução VIP no Meio da Tela
    local avisoCentro = Instance.new("TextLabel")
    avisoCentro.Size = UDim2.new(0, 200, 0, 40)
    avisoCentro.AnchorPoint = Vector2.new(0.5, 0.5)
    avisoCentro.Position = UDim2.new(0.5, 0, 0.5, 0)
    avisoCentro.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    avisoCentro.TextColor3 = Color3.fromRGB(255, 215, 0)
    avisoCentro.TextSize = 16
    avisoCentro.Font = Enum.Font.GothamBold
    avisoCentro.Text = "Script VIP"
    avisoCentro.Parent = screenGui
    Instance.new("UICorner", avisoCentro).CornerRadius = UDim.new(0, 8)

    task.spawn(function()
        task.wait(1.2)
        local tw = TweenService:Create(avisoCentro, TweenInfo.new(0.4), {TextTransparency = 1, BackgroundTransparency = 1})
        tw:Play()
        tw.Completed:Connect(function()
            avisoCentro:Destroy()
        end)
    end)

    -- Trava Inicial de 1 Segundo para Mover
    local podeMover = false
    local timerAviso = Instance.new("TextLabel")
    timerAviso.Size = UDim2.new(1, 0, 0, 25)
    timerAviso.Position = UDim2.new(0, 0, 1, 5)
    timerAviso.BackgroundTransparency = 1
    timerAviso.TextColor3 = Color3.fromRGB(255, 100, 100)
    timerAviso.TextSize = 11
    timerAviso.Font = Enum.Font.GothamMedium
    timerAviso.Text = "Bloqueado para mover (1s)..."
    timerAviso.Parent = menuFrame

    task.spawn(function()
        task.wait(1)
        podeMover = true
        timerAviso.Text = "Liberado para mover!"
        task.wait(1.5)
        timerAviso.Text = ""
    end)

    -- Sistema de Arraste Otimizado para Mobile (Touch & Mouse)
    local dragging, dragInput, dragStart, startPos
    menuFrame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and podeMover then
            dragging = true
            dragStart = input.Position
            startPos = menuFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    menuFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging and podeMover then
            local delta = input.Position - dragStart
            menuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 50)
    topBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    topBar.Parent = menuFrame
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 16)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "akaza_67m"
    titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    titleLabel.TextSize = 15
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = topBar

    -- Abas de Navegação
    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(1, -20, 0, 35)
    tabHolder.Position = UDim2.new(0, 10, 0, 60)
    tabHolder.BackgroundTransparency = 1
    tabHolder.Parent = menuFrame

    local btnServidores = Instance.new("TextButton")
    btnServidores.Size = UDim2.new(0.32, 0, 1, 0)
    btnServidores.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    btnServidores.Text = "Servidores"
    btnServidores.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnServidores.TextSize = 11
    btnServidores.Font = Enum.Font.GothamMedium
    btnServidores.Parent = tabHolder
    Instance.new("UICorner", btnServidores).CornerRadius = UDim.new(0, 8)

    local btnESP = Instance.new("TextButton")
    btnESP.Size = UDim2.new(0.32, 0, 1, 0)
    btnESP.Position = UDim2.new(0.34, 0, 0, 0)
    btnESP.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    btnESP.Text = "Funções ESP"
    btnESP.TextColor3 = Color3.fromRGB(140, 140, 140)
    btnESP.TextSize = 11
    btnESP.Font = Enum.Font.GothamMedium
    btnESP.Parent = tabHolder
    Instance.new("UICorner", btnESP).CornerRadius = UDim.new(0, 8)

    local btnSpeed = Instance.new("TextButton")
    btnSpeed.Size = UDim2.new(0.32, 0, 1, 0)
    btnSpeed.Position = UDim2.new(0.68, 0, 0, 0)
    btnSpeed.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    btnSpeed.Text = "Speed / Hitbox"
    btnSpeed.TextColor3 = Color3.fromRGB(140, 140, 140)
    btnSpeed.TextSize = 10
    btnSpeed.Font = Enum.Font.GothamMedium
    btnSpeed.Parent = tabHolder
    Instance.new("UICorner", btnSpeed).CornerRadius = UDim.new(0, 8)

    -- Páginas
    local paginaServidores = Instance.new("ScrollingFrame")
    paginaServidores.Size = UDim2.new(1, -20, 1, -115)
    paginaServidores.Position = UDim2.new(0, 10, 0, 105)
    paginaServidores.BackgroundTransparency = 1
    paginaServidores.ScrollBarThickness = 3
    paginaServidores.Parent = menuFrame
    local layoutSrv = Instance.new("UIListLayout", paginaServidores)
    layoutSrv.SortOrder = Enum.SortOrder.LayoutOrder
    layoutSrv.Padding = UDim.new(0, 8)
    layoutSrv:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        paginaServidores.CanvasSize = UDim2.new(0, 0, 0, layoutSrv.AbsoluteContentSize.Y)
    end)

    local refreshBtn = Instance.new("TextButton")
    refreshBtn.Size = UDim2.new(0, 30, 0, 30)
    refreshBtn.Position = UDim2.new(1, -40, 0, 10)
    refreshBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    refreshBtn.Text = "🔄"
    refreshBtn.TextSize = 12
    refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    refreshBtn.Parent = topBar
    Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(1, 0)

    local paginaESP = Instance.new("ScrollingFrame")
    paginaESP.Size = UDim2.new(1, -20, 1, -115)
    paginaESP.Position = UDim2.new(0, 10, 0, 105)
    paginaESP.BackgroundTransparency = 1
    paginaESP.Visible = false
    paginaESP.ScrollBarThickness = 3
    paginaESP.Parent = menuFrame
    local layoutESP = Instance.new("UIListLayout", paginaESP)
    layoutESP.SortOrder = Enum.SortOrder.LayoutOrder
    layoutESP.Padding = UDim.new(0, 8)
    layoutESP:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        paginaESP.CanvasSize = UDim2.new(0, 0, 0, layoutESP.AbsoluteContentSize.Y)
    end)

    local paginaSpeed = Instance.new("ScrollingFrame")
    paginaSpeed.Size = UDim2.new(1, -20, 1, -115)
    paginaSpeed.Position = UDim2.new(0, 10, 0, 105)
    paginaSpeed.BackgroundTransparency = 1
    paginaSpeed.Visible = false
    paginaSpeed.ScrollBarThickness = 3
    paginaSpeed.Parent = menuFrame
    local layoutSpeed = Instance.new("UIListLayout", paginaSpeed)
    layoutSpeed.SortOrder = Enum.SortOrder.LayoutOrder
    layoutSpeed.Padding = UDim.new(0, 8)
    layoutSpeed:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        paginaSpeed.CanvasSize = UDim2.new(0, 0, 0, layoutSpeed.AbsoluteContentSize.Y)
    end)

    -- Alternância de Abas
    btnServidores.Activated:Connect(function()
        paginaServidores.Visible = true; paginaESP.Visible = false; paginaSpeed.Visible = false; refreshBtn.Visible = true
        btnServidores.BackgroundColor3 = Color3.fromRGB(35, 35, 48); btnServidores.TextColor3 = Color3.fromRGB(255, 255, 255)
        btnESP.BackgroundColor3 = Color3.fromRGB(22, 22, 30); btnESP.TextColor3 = Color3.fromRGB(140, 140, 140)
        btnSpeed.BackgroundColor3 = Color3.fromRGB(22, 22, 30); btnSpeed.TextColor3 = Color3.fromRGB(140, 140, 140)
    end)

    btnESP.Activated:Connect(function()
        paginaServidores.Visible = false; paginaESP.Visible = true; paginaSpeed.Visible = false; refreshBtn.Visible = false
        btnESP.BackgroundColor3 = Color3.fromRGB(35, 35, 48); btnESP.TextColor3 = Color3.fromRGB(255, 255, 255)
        btnServidores.BackgroundColor3 = Color3.fromRGB(22, 22, 30); btnServidores.TextColor3 = Color3.fromRGB(140, 140, 140)
        btnSpeed.BackgroundColor3 = Color3.fromRGB(22, 22, 30); btnSpeed.TextColor3 = Color3.fromRGB(140, 140, 140)
    end)

    btnSpeed.Activated:Connect(function()
        paginaServidores.Visible = false; paginaESP.Visible = false; paginaSpeed.Visible = true; refreshBtn.Visible = false
        btnSpeed.BackgroundColor3 = Color3.fromRGB(35, 35, 48); btnSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
        btnServidores.BackgroundColor3 = Color3.fromRGB(22, 22, 30); btnServidores.TextColor3 = Color3.fromRGB(140, 140, 140)
        btnESP.BackgroundColor3 = Color3.fromRGB(22, 22, 30); btnESP.TextColor3 = Color3.fromRGB(140, 140, 140)
    end)

    -- Função com Debounce para Carregar Servidores
    local carregandoSrv = false
    local function carregarServidores()
        if carregandoSrv then return end
        carregandoSrv = true

        for _, child in ipairs(paginaServidores:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(url))
        end)

        if success and result and result.data then
            for _, srv in ipairs(result.data) do
                if srv.playing <= 3 and srv.id ~= game.JobId then
                    local btn = Instance.new("TextButton")
                    btn.Size = UDim2.new(1, 0, 0, 42)
                    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
                    btn.Text = ""
                    btn.Parent = paginaServidores
                    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

                    local txtSrv = Instance.new("TextLabel")
                    txtSrv.Size = UDim2.new(1, -20, 1, 0)
                    txtSrv.Position = UDim2.new(0, 10, 0, 0)
                    txtSrv.BackgroundTransparency = 1
                    txtSrv.Text = "Servidor Vazio (" .. srv.playing .. "/" .. srv.maxPlayers .. ")"
                    txtSrv.TextColor3 = Color3.fromRGB(0, 255, 120)
                    txtSrv.TextSize = 13
                    txtSrv.Font = Enum.Font.GothamMedium
                    txtSrv.TextXAlignment = Enum.TextXAlignment.Left
                    txtSrv.Parent = btn

                    btn.Activated:Connect(function()
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, player)
                    end)
                end
            end
        end
        task.wait(1.5)
        carregandoSrv = false
    end

    -- Abertura Instantânea e Fluida (Sem delay)
    floatingButton.Activated:Connect(function()
        if not menuFrame.Visible then
            menuFrame.Visible = true
            task.spawn(carregarServidores)
            TweenService:Create(menuFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 320, 0, 430)
            }):Play()
        else
            local tween = TweenService:Create(menuFrame, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0)
            })
            tween:Play()
            tween.Completed:Connect(function()
                menuFrame.Visible = false
            end)
        end
    end)

    refreshBtn.Activated:Connect(function()
        carregarServidores()
    end)

    -- Funções Reutilizáveis de Componentes
    local function criarToggle(parent, nomeTexto, configTable, chave)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        btn.Text = ""
        btn.Parent = parent
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -50, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = nomeTexto
        label.TextColor3 = Color3.fromRGB(220, 220, 220)
        label.TextSize = 13
        label.Font = Enum.Font.GothamMedium
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = btn

        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 18, 0, 18)
        indicator.Position = UDim2.new(1, -28, 0.5, -9)
        indicator.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        indicator.Parent = btn
        Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

        btn.Activated:Connect(function()
            configTable[chave] = not configTable[chave]
            indicator.BackgroundColor3 = configTable[chave] and Color3.fromRGB(0, 220, 100) or Color3.fromRGB(50, 50, 60)
        end)
    end

    local function criarInputConfig(parent, nomeTexto, configTable, chave, minVal, maxVal)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 55)
        frame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        frame.Parent = parent
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -100, 0, 25)
        label.Position = UDim2.new(0, 12, 0, 15)
        label.BackgroundTransparency = 1
        label.Text = nomeTexto .. " (Máx: " .. maxVal .. ")"
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
        label.TextSize = 12
        label.Font = Enum.Font.GothamMedium
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame

        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(0, 70, 0, 32)
        textBox.Position = UDim2.new(1, -80, 0.5, -16)
        textBox.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
        textBox.Text = tostring(configTable[chave])
        textBox.TextColor3 = Color3.fromRGB(255, 215, 0)
        textBox.TextSize = 13
        textBox.Font = Enum.Font.GothamBold
        textBox.Parent = frame
        Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

        textBox.FocusLost:Connect(function()
            local val = tonumber(textBox.Text)
            if val then
                configTable[chave] = math.clamp(val, minVal, maxVal)
                textBox.Text = tostring(configTable[chave])
            else
                textBox.Text = tostring(configTable[chave])
            end
        end)
    end

    -- Criação dos Elementos na Aba ESP
    criarToggle(paginaESP, "ESP Linha", Config.ESP, "Linha")
    criarToggle(paginaESP, "ESP Caixa", Config.ESP, "Caixa")
    criarToggle(paginaESP, "ESP Vida", Config.ESP, "Vida")
    criarToggle(paginaESP, "ESP Distância", Config.ESP, "Distancia")
    criarToggle(paginaESP, "ESP Nome", Config.ESP, "Nome")
    criarToggle(paginaESP, "ESP Nível de Força", Config.ESP, "NivelForca")

    -- Criação dos Elementos na Aba Speed / Hitbox
    criarToggle(paginaSpeed, "Ativar Velocidade Customizada", Config.Speed, "Ativo")
    criarInputConfig(paginaSpeed, "Velocidade", Config.Speed, "Velocidade", 1, 500)
    criarToggle(paginaSpeed, "Ativar Hitbox Ampliada", Config.Speed, "HitboxAtivo")
    criarInputConfig(paginaSpeed, "Tamanho Hitbox", Config.Speed, "HitboxTamanho", 1, 300)
end

criarInterface()

-- Suporte para recriar ao renascer o personagem
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    criarInterface()
end)

-- Loop de Velocidade Ajustado (Só aplica se o módulo estiver ativado no menu)
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        
        if Config.Speed.Ativo then
            hum.WalkSpeed = Config.Speed.Velocidade
        end
    end
end)

-- Render Loop para Hitbox e ESP Centralizado
local drawings = {}
local function removerESP(plr)
    if drawings[plr] then
        for _, obj in pairs(drawings[plr]) do
            obj:Remove()
        end
        drawings[plr] = nil
    end
end

local function calcularForca(humanoid)
    local score = humanoid.MaxHealth + humanoid.WalkSpeed
    if score > 300 then return " [BOSS 💀]", Color3.fromRGB(255, 50, 50)
    elseif score > 150 then return " [Forte ⚔️]", Color3.fromRGB(255, 165, 0)
    else return " [Novato 🌱]", Color3.fromRGB(0, 255, 100) end
end

RunService.RenderStepped:Connect(function()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then
            local char = plr.Character
            local hrp = char.HumanoidRootPart
            local humanoid = char.Humanoid

            if Config.Speed.HitboxAtivo then
                local t
