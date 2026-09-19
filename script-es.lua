
-- ============================================================
-- 🔍 VERIFICADOR DE PLACE ID
-- ============================================================
local TARGET_PLACE_ID = 4924922222

if game.PlaceId ~= TARGET_PLACE_ID then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/psychoSAGAZ/SAGAZx-HUB/refs/heads/main/SAGAZx%20Hub%20Universal"))()
    return
end



-- ====================================================================
-- 🌍 TRADUTOR SIMPLIFICADO — SAGAZx HUB
-- ====================================================================

local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local TARGET_GUI = "SAGAZx HUB"
local LANG_FILE = "SAGAZx HUB Lib/language.json"

-- ========== CARREGAMENTO DAS TRADUÇÕES REMOTE ==========
local Translations = { Frases = { ["pt"] = {}, ["en"] = {}, ["es"] = {}, ["it"] = {} } }

local ok, remoteTable = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/psychoSAGAZ/SAGAZx-HUB/refs/heads/main/Teste%20part%20Redz"))()
end)

if ok and type(remoteTable) == "table" then
    Translations.Frases = remoteTable
end

-- Determina idioma padrão do jogo ou do arquivo salvo
local defaultLocale = (game.Players.LocalPlayer.LocaleId or "en-US"):sub(1, 2):lower()
Translations.Idioma = Translations.Frases[defaultLocale] and defaultLocale or "en"

local function SaveLanguage(lang)
    if writefile then
        pcall(function() writefile(LANG_FILE, HttpService:JSONEncode({ language = lang })) end)
    end
end

local function LoadLanguage()
    if isfile and isfile(LANG_FILE) then
        local s, data = pcall(function() return HttpService:JSONEncode(readfile(LANG_FILE)) end)
        if s and data and data.language and Translations.Frases[data.language] then
            return data.language
        end
    end
end

Translations.Idioma = LoadLanguage() or Translations.Idioma

-- ====================================================================
-- ⚙️ MOTOR DE TRADUÇÃO DAS GUIS
-- ====================================================================

local function TranslateText(text)
    if not text or text == "" then return text end
    local dic = Translations.Frases[Translations.Idioma]
    return (dic and dic[text]) or text
end

local function ApplyTranslation(obj)
    if not (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then return end

    -- TextLabel e TextButton
    if obj:IsA("TextLabel") or obj:IsA("TextButton") then
        if not obj:GetAttribute("_OriginalText") and obj.Text ~= "" then
            obj:SetAttribute("_OriginalText", obj.Text)
        end

        local original = obj:GetAttribute("_OriginalText")
        if original then
            obj.Text = TranslateText(original)
        end
    end

    -- TextBox (Apenas Placeholder)
    if obj:IsA("TextBox") then
        if not obj:GetAttribute("_OriginalPlaceholder") and obj.PlaceholderText ~= "" then
            obj:SetAttribute("_OriginalPlaceholder", obj.PlaceholderText)
        end

        local origPh = obj:GetAttribute("_OriginalPlaceholder")
        if origPh and not obj:IsFocused() then
            obj.PlaceholderText = TranslateText(origPh)
        end
    end
end

local function TranslateAll()
    local gui = CoreGui:FindFirstChild(TARGET_GUI) or CoreGui:FindFirstChild("Redz Library")
    if not gui then return end

    for _, descendant in ipairs(gui:GetDescendants()) do
        ApplyTranslation(descendant)
    end
end

-- ====================================================================
-- 🌐 API PÚBLICA (Translator)
-- ====================================================================

getgenv().Translator = {
    GetLanguage = function() 
        return Translations.Idioma 
    end,

    SetLanguage = function(lang)
        if not Translations.Frases[lang] then return end
        Translations.Idioma = lang
        SaveLanguage(lang)
        TranslateAll()
    end,

    Translate = TranslateText
}

-- ====================================================================
-- 🚀 AUTOLOAD E CONEXÕES
-- ====================================================================

task.spawn(function()
    local gui = CoreGui:WaitForChild(TARGET_GUI, 10) or CoreGui:WaitForChild("Redz Library", 5)
    if not gui then return end

    -- Tradução Inicial
    TranslateAll()

    -- Traduz dinamicamente novos elementos inseridos (Dropdowns, Notificações, etc)
    gui.DescendantAdded:Connect(function(descendant)
        task.wait(0.05)
        ApplyTranslation(descendant)
    end)
end)


----------------------------------------------------------------------------------------------------------------
-----------------------------------------Aba Redz Lib-----------------------------------------------------
----------------------------------------------------------------------------------------------------------------
local MyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/psychoSAGAZ/SAGAZx-HUB/refs/heads/main/redz%20sgzx%20teste"))()

local Window = MyLibrary:MakeWindow({
    Title = "SAGAZx Hub",
    SubTitle = "by SAGAZx😎",
    SaveFolder = "SAGAZxConfig"
})


----------------------------------------------------------------------------------------------------------------
-----------------------------------------Aba Home-----------------------------------------------------
----------------------------------------------------------------------------------------------------------------
local Tab1 = Window:MakeTab({ "| Início", "menu" })


Tab1:AddDiscordInvite({
    Name = "SAGAZx",
    Description = "",
    Logo = "rbxassetid://86050226751861",
    ["Tik Tok"] = "tiktok.com/@sagazx_xd",
    Discord = "https://discord.gg/JHHZUtUeT8"
})

Tab1:AddSection({Name = "Perfil"})


local function detectExecutor()
    if identifyexecutor then
        return identifyexecutor()
    elseif syn then
        return "Synapse X4"
    elseif KRNL_LOADED then
        return "KRNL4"
    elseif is_sirhurt_closure then
        return "SirHurt"
    elseif pebc_execute then
        return "ProtoSmasher"
    elseif getexecutorname then
        return getexecutorname()
    else
        return "Executor Desconhecido"
    end
end

local executorName = detectExecutor()



local Paragraph = Tab1:AddParagraph({"Execultor", executorName})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Pega nickname do jogador
local nickname = player.Name 

-- Novo bloco igual ao do Executor
Tab1:AddParagraph({"Nickname", nickname})
Tab1:AddParagraph({"Versão", "3.0.1"})

Tab1:AddSection({Name = "Outros"}) 
Tab1:AddButton({
    Name = "Deletar Brookhaven News",
    Description = "Faz Muira Zuada",
    Callback = function()
        local obj = workspace:FindFirstChild("BrookavenNewsSign")

        if obj then
            obj:Destroy()
            print("BrookavenNewsSign deletado!")
        else
            warn("Objeto não encontrado.")
        end
    end
})

----------------------------------------------------------------------------------------------------------------
-----------------------------------------Aba Cliente-----------------------------------------------------
----------------------------------------------------------------------------------------------------------------

-- ==========================================
-- SERVIÇOS E VARIÁVEIS GLOBAIS (OTIMIZADOS)
-- ==========================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local cam = workspace.CurrentCamera

-- Variaveis de Controle Geral
local InfiniteJumpEnabled = false
local noclipEnabled = false
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

LocalPlayer.CharacterAdded:Connect(function(char)
    character = char
end)

-- Loop do Noclip (Unificado)
RunService.Stepped:Connect(function()
    if noclipEnabled and character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- ==========================================
-- ABA 2 - CLIENTE
-- ==========================================
local Tab2 = Window:MakeTab({ "| Cliente", "user" })

Tab2:AddSlider({
    Name = "VELOCIDADE",
    Increase = 1,
    MinValue = 16,
    MaxValue = 1000,
    Default = 16,
    Callback = function(Value)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = Value end
    end
})
 
Tab2:AddSlider({
    Name = "PULO",
    Increase = 1,
    MinValue = 50,
    MaxValue = 500,
    Default = 50,
    Callback = function(Value)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.JumpPower = Value end
    end
})
 
Tab2:AddSlider({
    Name = "GRAVIDADE",
    Increase = 1,
    MinValue = 0,
    MaxValue = 10000,
    Default = 196.2,
    Callback = function(Value)
        Workspace.Gravity = Value
    end
})

-- Loop Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled and character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

Tab2:AddButton({
    Name = "REDEFINIR VELOCIDADE/GRAVIDADE/ PULO",
    Callback = function()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
        Workspace.Gravity = 196.2
        InfiniteJumpEnabled = false
    end
})

Tab2:AddSection({ Name = "Outros" })

local SpinConnection
local SpinSpeed = 0.5

Tab2:AddTextBox({
    Name = "Velocidade do Spin",
    PlaceholderText = "Digite a velocidade",
    ClearText = false,
    Callback = function(Value)
        local Number = tonumber(Value)
        if Number then SpinSpeed = Number end
    end
})

Tab2:AddToggle({
    Name = "Spin",
    Description = "Gira o Personagem Infinitamente",
    Default = false,
    Callback = function(Value)
        if SpinConnection then SpinConnection:Disconnect() end
        if Value then
            SpinConnection = RunService.RenderStepped:Connect(function(dt)
                local Root = character and character:FindFirstChild("HumanoidRootPart")
                if Root then
                    Root.CFrame = Root.CFrame * CFrame.Angles(0, math.rad(360 * SpinSpeed * dt), 0)
                end
            end)
        else
            SpinConnection = nil
        end
    end
})

Tab2:AddToggle({
    Name = "PULO INFINITO",
    Default = false,
    Callback = function(Value)
       InfiniteJumpEnabled = Value
    end
})

----------------------------------------------------
-- FLOAT V1 + V2 (SAGAZx HUB) - autocontido
----------------------------------------------------
do
    local Players     = game:GetService("Players")
    local RunService  = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer

    local function makeFloat(isV2)
        local state = {
            Enabled = false,
            Part = nil,
            Render = nil,
            Jump = nil,
            TargetY = 0,
            IsV2 = isV2
        }

        local function disconnectAll()
            if state.Render then state.Render:Disconnect(); state.Render = nil end
            if state.Jump   then state.Jump:Disconnect();   state.Jump   = nil end
        end

        local function disable()
            state.Enabled = false
            disconnectAll()
            if state.Part then state.Part:Destroy(); state.Part = nil end
        end

        local function enable()
            if state.Enabled then return end
            local char = LocalPlayer.Character
            if not char then return end

            local root = char:FindFirstChild("HumanoidRootPart")
            local hum  = char:FindFirstChildOfClass("Humanoid")
            if not root or not hum then return end

            state.Enabled = true
            state.TargetY = root.Position.Y - (hum.HipHeight + 1.5)

            state.Part = Instance.new("Part")
            state.Part.Name          = "SAGAZ_Float_" .. (isV2 and "V2" or "V1")
            state.Part.Size          = Vector3.new(7, 1, 7)
            state.Part.Transparency  = 1
            state.Part.Anchored      = true
            state.Part.CanCollide    = true
            state.Part.Parent        = workspace

            -- Pulo
            state.Jump = hum.Jumping:Connect(function()
                if not state.Part then return end
                state.Part.CanCollide = false

                task.spawn(function()
                    local r = root
                    while r and r.Parent and r.AssemblyLinearVelocity.Y > 0 do
                        task.wait()
                    end
                    if state.Part then
                        if not isV2 and r and r.Parent then
                            local h = char:FindFirstChildOfClass("Humanoid")
                            if h then
                                state.TargetY = r.Position.Y - (h.HipHeight + 1.5)
                            end
                        end
                        state.Part.CanCollide = true
                    end
                end)
            end)

            -- Render
            state.Render = RunService.RenderStepped:Connect(function()
                local c = LocalPlayer.Character
                if not state.Part or not c then return end
                local r = c:FindFirstChild("HumanoidRootPart")
                local h = c:FindFirstChildOfClass("Humanoid")
                if not r or not h then return end

                state.Part.Position = Vector3.new(r.Position.X, state.TargetY, r.Position.Z)

                local st = h:GetState()
                local grounded =
                    st == Enum.HumanoidStateType.Running
                    or st == Enum.HumanoidStateType.RunningNoPhysics
                    or st == Enum.HumanoidStateType.Landed
                    or st == Enum.HumanoidStateType.Seated

                if grounded and state.Part.CanCollide then
                    r.AssemblyLinearVelocity =
                        Vector3.new(r.AssemblyLinearVelocity.X, 0, r.AssemblyLinearVelocity.Z)
                end
            end)
        end

        return {
            SetState = function(v) if v then enable() else disable() end end,
            Disable  = disable
        }
    end

    local FloatV1 = makeFloat(false)
    local FloatV2 = makeFloat(true)

    LocalPlayer.CharacterAdded:Connect(function()
        FloatV1.Disable()
        FloatV2.Disable()
    end)

    Tab2:AddToggle({
        Name = "Float",
        Default = false,
        Callback = function(v) FloatV1.SetState(v) end
    })

    Tab2:AddToggle({
        Name = "Float v2",
        Default = false,
        Callback = function(v) FloatV2.SetState(v) end
    })
end

Tab2:AddToggle({
    Name = "NOCLIP",
    Description = "ATRAVESSA PAREDES",
    Default = false,
    Callback = function(v)
        noclipEnabled = v
    end
})

Tab2:AddToggle({
    Name = "FullBright",
    Description = "Deixa o Mapa iluminado",
    Default = false,
    Callback = function(Value)
        if Value then
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 2
        else
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
            Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            Lighting.Brightness = 1
        end
    end
})

local Swimming = false
local OldGravity = Workspace.Gravity
local SwimBeat
local GravReset

Tab2:AddToggle({
    Name = "Swim",
    Description = "Nadar Sem Água",
    Default = false,
    Callback = function(Value)
        if not character then return end
        local Humanoid = character:FindFirstChildWhichIsA("Humanoid")
        local Root = character:FindFirstChild("HumanoidRootPart")
        if not Humanoid or not Root then return end

        if Value then
            OldGravity = Workspace.Gravity
            Workspace.Gravity = 0

            GravReset = Humanoid.Died:Connect(function()
                Workspace.Gravity = OldGravity
                Swimming = false
            end)

            for _, State in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
                if State ~= Enum.HumanoidStateType.None then
                    Humanoid:SetStateEnabled(State, false)
                end
            end

            Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)

            SwimBeat = RunService.Heartbeat:Connect(function()
                if Humanoid.MoveDirection.Magnitude > 0 then
                    Root.Velocity = Humanoid.MoveDirection * 20
                elseif UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    Root.Velocity = Vector3.new(0, 20, 0)
                else
                    Root.Velocity = Vector3.zero
                end
                Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
            end)
            Swimming = true
        else
            Workspace.Gravity = OldGravity
            Swimming = false

            if GravReset then GravReset:Disconnect() GravReset = nil end
            if SwimBeat then SwimBeat:Disconnect() SwimBeat = nil end

            for _, State in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
                if State ~= Enum.HumanoidStateType.None then
                    Humanoid:SetStateEnabled(State, true)
                end
            end
        end
    end
})

local LayConnection
Tab2:AddToggle({
    Name = "Deitar",
    Description = "Deita no Chão",
    Default = false,
    Callback = function(Value)
        if not character then return end
        local Humanoid = character:FindFirstChildWhichIsA("Humanoid")
        local Root = character:FindFirstChild("HumanoidRootPart")
        if not Humanoid or not Root then return end

        if Value then
            LayConnection = RunService.Heartbeat:Connect(function()
                Humanoid.PlatformStand = true
                Root.CFrame = CFrame.new(Root.Position) * CFrame.Angles(math.rad(90), Root.Orientation.Y * math.pi / 180, 0)
            end)
        else
            if LayConnection then LayConnection:Disconnect() LayConnection = nil end
            Humanoid.PlatformStand = false
            Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
})

Tab2:AddButton({
    Name = "Jerk",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
    end
})

Tab2:AddButton({
    Name = "Sit",
    Description = "Faz o Personagem Sentar",
    Callback = function()
        if character then
            local Humanoid = character:FindFirstChildWhichIsA("Humanoid")
            if Humanoid then Humanoid.Sit = true end
        end
    end
})

Tab2:AddButton({
    Name = "Tp Tool",
    Description = "Teleporta Você Para Onde Você Clicar",
    Callback = function()
        if LocalPlayer.Backpack:FindFirstChild("Tp Tool") then return end
        local Mouse = LocalPlayer:GetMouse()
        local Tool = Instance.new("Tool")
        Tool.Name = "Tp Tool"
        Tool.RequiresHandle = false
        Tool.TextureId = "rbxassetid://1234567890"

        Tool.Activated:Connect(function()
            local Root = character and character:FindFirstChild("HumanoidRootPart")
            if Root then
                Root.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 2.5, 0))
            end
        end)
        Tool.Parent = LocalPlayer.Backpack
    end
})

-- ==========================================
-- SEÇÃO ESPIÃO (COLOCADA NA COREGUI)
-- ==========================================
Tab2:AddSection({ Name = "Espião" })

local viewing = false
local playerList = {}
local currentIndex = 1
local screenGui
local lastPlayerName = nil

local function UpdatePlayerList()
    playerList = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then table.insert(playerList, plr) end
    end
    table.sort(playerList, function(a,b) return a.Name < b.Name end)
end

local function GetCurrentPlayer() return playerList[currentIndex] end

local function Spectate(plr)
    if not plr then return end
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hum = char:FindFirstChild("Humanoid")
    if hum then cam.CameraSubject = hum end
end

local function ResetCamera()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then cam.CameraSubject = char.Humanoid end
end

local function CreateUI()
    if screenGui then screenGui:Destroy() end

    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "EspiaoCoreGui"
    screenGui.Parent = CoreGui

    local back = Instance.new("TextButton", screenGui)
    back.Size = UDim2.new(0, 60, 0, 60)
    back.Position = UDim2.new(0, 412, 0, 425)
    back.Text = "<"
    back.TextSize = 50
    back.BackgroundColor3 = Color3.fromRGB(108,108,108)
    Instance.new("UICorner", back)

    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0, 200, 0, 60)
    frame.Position = UDim2.new(1, -688, 0, 425)
    frame.BackgroundColor3 = Color3.fromRGB(108,108,108)
    Instance.new("UICorner", frame)

    local img = Instance.new("ImageLabel", frame)
    img.Size = UDim2.new(0,40,0,40)
    img.Position = UDim2.new(0,10,0,10)
    img.BackgroundTransparency = 1

    local titulo = Instance.new("TextLabel", frame)
    titulo.Size = UDim2.new(1,-60,0,20)
    titulo.Position = UDim2.new(0,60,0,8)
    titulo.Text = "Espionando:"
    titulo.TextColor3 = Color3.new(1,1,1)
    titulo.BackgroundTransparency = 1
    titulo.Font = Enum.Font.GothamBold
    titulo.TextSize = 15
    titulo.TextXAlignment = Enum.TextXAlignment.Left

    local username = Instance.new("TextLabel", frame)
    username.Size = UDim2.new(1,-60,0,18)
    username.Position = UDim2.new(0,60,0,30)
    username.BackgroundTransparency = 1
    username.TextColor3 = Color3.new(1,1,1)
    username.Font = Enum.Font.Gotham
    username.TextSize = 12
    username.TextXAlignment = Enum.TextXAlignment.Left

    local nextBtn = Instance.new("TextButton", screenGui)
    nextBtn.Size = UDim2.new(0, 60, 0, 60)
    nextBtn.Position = UDim2.new(0, 685, 0, 425)
    nextBtn.Text = ">"
    nextBtn.TextSize = 50
    nextBtn.BackgroundColor3 = Color3.fromRGB(108,108,108)
    Instance.new("UICorner", nextBtn)

    local function UpdateUI()
        local plr = GetCurrentPlayer()
        if not plr then return end
        lastPlayerName = plr.Name
        username.Text = "@" .. plr.Name
        img.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. plr.UserId .. "&width=150&height=150&format=png"
        Spectate(plr)
    end

    back.MouseButton1Click:Connect(function()
        if #playerList == 0 then return end
        currentIndex = currentIndex - 1
        if currentIndex < 1 then currentIndex = #playerList end
        UpdateUI()
    end)

    nextBtn.MouseButton1Click:Connect(function()
        if #playerList == 0 then return end
        currentIndex = currentIndex + 1
        if currentIndex > #playerList then currentIndex = 1 end
        UpdateUI()
    end)

    UpdateUI()
end



Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)

-- ==========================================
-- GERENCIADOR DE ESP & CORES UNIFICADO
-- ==========================================
local selectedColor = "RGB"
local espEnabled = false
local billboardGuis = {}
local connections = {}

-- Variáveis para os Cones
local ActiveEsps = {}
local EspConesEnabled = false
local TargetFolder = Workspace:WaitForChild("WorkspaceCom", 10):WaitForChild("001_TrafficCones", 10)

local function getESPColor()
    if selectedColor == "RGB" then
        local h = (tick() % 5) / 5
        return Color3.fromHSV(h, 1, 1)
    elseif selectedColor == "Preto" then return Color3.fromRGB(0,0,0)
    elseif selectedColor == "Branco" then return Color3.fromRGB(255,255,255)
    elseif selectedColor == "Vermelho" then return Color3.fromRGB(255,0,0)
    elseif selectedColor == "Verde" then return Color3.fromRGB(0,255,0)
    elseif selectedColor == "Azul" then return Color3.fromRGB(0,170,255)
    elseif selectedColor == "Amarelo" then return Color3.fromRGB(255,255,0)
    elseif selectedColor == "Rosa" then return Color3.fromRGB(255,105,180)
    elseif selectedColor == "Roxo" then return Color3.fromRGB(128,0,128)
    end
    return Color3.new(1,1,1)
end

Tab2:AddDropdown({
    Name = "COR DO ESP",
    Default = "RGB",
    Options = {"RGB", "Branco", "Preto", "Vermelho", "Verde", "Azul", "Amarelo", "Rosa", "Roxo"},
    Search = true,
    Callback = function(value)
        selectedColor = value
        local color = getESPColor()
        for _, gui in pairs(billboardGuis) do
            if gui and gui:FindFirstChild("TextLabel") then gui.TextLabel.TextColor3 = color end
        end
        for _, data in pairs(ActiveEsps) do
            if data.Label then data.Label.TextColor3 = color end
            if data.Highlight then data.Highlight.OutlineColor = color end
        end
    end
})

Tab2:AddToggle({
    Name = "Espiona Todos Os Players",
    Default = false,
    Callback = function(Value)
        viewing = Value
        if viewing then
            UpdatePlayerList()
            if #playerList == 0 then return end
            currentIndex = 1
            if lastPlayerName then
                for i, plr in ipairs(playerList) do
                    if plr.Name == lastPlayerName then currentIndex = i break end
                end
            end
            CreateUI()
            Spectate(GetCurrentPlayer())
        else
            if screenGui then screenGui:Destroy() screenGui = nil end
            ResetCamera()
        end
    end
})

-- Funções ESP Players
local function updateESP(player)
    if player == LocalPlayer or not espEnabled then return end
    local char = player.Character
    local head = char and char:FindFirstChild("Head")
    if not head then return end

    local gui = billboardGuis[player]
    if gui and gui:FindFirstChild("TextLabel") then
        gui.TextLabel.TextColor3 = getESPColor()
        return
    elseif gui then
        gui:Destroy()
    end

    local billboard = Instance.new("BillboardGui", head)
    billboard.Name = "ESP_Billboard"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0,3,0)
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.Name = "TextLabel"
    textLabel.Size = UDim2.new(1,0,1,0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 14
    textLabel.Text = player.Name .. " | " .. player.AccountAge .. " dias"
    textLabel.TextColor3 = getESPColor()

    billboardGuis[player] = billboard
end

local function removeESP(player)
    if billboardGuis[player] then
        billboardGuis[player]:Destroy()
        billboardGuis[player] = nil
    end
end

Tab2:AddToggle({
    Name = "ESP PLAYERS",
    Description = "MOSTRA NOME E DIAS DOS PLAYERS",
    Default = false,
    Callback = function(value)
        espEnabled = value
        if espEnabled then
            for _, player in pairs(Players:GetPlayers()) do updateESP(player) end
            table.insert(connections, Players.PlayerAdded:Connect(function(p)
                updateESP(p)
                table.insert(connections, p.CharacterAdded:Connect(function() updateESP(p) end))
            end))
            table.insert(connections, Players.PlayerRemoving:Connect(removeESP))
        else
            for _, player in pairs(Players:GetPlayers()) do removeESP(player) end
            for _, conn in pairs(connections) do conn:Disconnect() end
            connections = {}
            billboardGuis = {}
        end
    end
})

-- ==========================================
-- ESP TRAFFIC CONES (LIMPO E LONGO ALCANCE)
-- ==========================================
local function CreateConeEsp(model)
    if not model:IsA("Model") or ActiveEsps[model] then return end
    local adornPart = model:FindFirstChildWhichIsA("BasePart")
    if not adornPart then return end

    local espData = {}
    local currentColor = getESPColor()

    -- Remove o prefixo "Prop_" ou "Prop" deixando apenas o nome real do player
    local cleanName = string.gsub(model.Name, "^Prop_?", "")

    -- Visto de muito longe e através de paredes (AlwaysOnTop)
    local highlight = Instance.new("Highlight")
    highlight.Name = "ZsgdHighlight"
    highlight.FillColor = currentColor
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = currentColor
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = model
    highlight.Parent = model
    espData.Highlight = highlight

    local billboard = Instance.new("BillboardGui", model)
    billboard.Name = "ZsgdBillboard"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = adornPart
    espData.Billboard = billboard

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = cleanName
    label.TextColor3 = currentColor
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    espData.Label = label

    ActiveEsps[model] = espData
end

local function RemoveConeEsp(model)
    local data = ActiveEsps[model]
    if data then
        if data.Highlight then data.Highlight:Destroy() end
        if data.Billboard then data.Billboard:Destroy() end
        ActiveEsps[model] = nil
    end
end

local function CleanAllConeEsps()
    for model, _ in pairs(ActiveEsps) do RemoveConeEsp(model) end
end

-- Loop Geral de Atualização de Cores (RGB) e Verificação de Cones
RunService.Heartbeat:Connect(function()
    local color = getESPColor()
    
    -- Atualiza Cores de Players
    if espEnabled and selectedColor == "RGB" then
        for _, player in pairs(Players:GetPlayers()) do
            local gui = billboardGuis[player]
            if gui and gui:FindFirstChild("TextLabel") then gui.TextLabel.TextColor3 = color end
        end
    end

    -- Gerenciamento do ESP de Cones
    if not EspConesEnabled or not TargetFolder then 
        CleanAllConeEsps()
        return 
    end

    for _, child in ipairs(TargetFolder:GetChildren()) do
        if string.sub(child.Name, 1, 4) == "Prop" then
            CreateConeEsp(child)
        end
    end

    for model, data in pairs(ActiveEsps) do
        if not model or not model.Parent then
            ActiveEsps[model] = nil
        else
            if selectedColor == "RGB" then
                if data.Label then data.Label.TextColor3 = color end
                if data.Highlight then data.Highlight.OutlineColor = color end
            end
        end
    end
end)

Tab2:AddToggle({
    Name = "Esp Props",
    Description = "Mostra os Props e Donos",
    Default = false,
    Callback = function(Value)
        EspConesEnabled = Value
        if not Value then CleanAllConeEsps() end
    end
})

----------------------------------------------------------------------------------------------------------------
-----------------------------------------Aba Jogadores-----------------------------------------------------
----------------------------------------------------------------------------------------------------------------

local Tab3= Window:MakeTab({ "| Jogadores", "users" })

--==============================================================
-- 🎯 SEÇÃO: DROPDOWNS
--==============================================================

local selectedPlayer = nil -- Nome do jogador selecionado
local selectedMethod = nil -- Método ativo (kill/bring/fling)

-- 🎯 DROPDOWN DE TARGET
Tab3:AddDropdownPlayer({
    Name = "Selecionar Jogador",
    Callback = function(Value)
        selectedPlayer = (typeof(Value) == "Instance") and Value.Name or tostring(Value)
    end
})

-- 🎯 DROPDOWN UNIFICADO (Kill / Bring / Fling)
Tab3:AddDropdown({
    Name = "Método (Kill/Bring/Fling)",
    Options = { "ônibus", "sofa", "prop", "bola" },
    Default = nil,
    Callback = function(Value)
        selectedMethod = Value
    end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Cam = workspace.CurrentCamera

local viewing = false

-- Restaura a câmera para o próprio personagem
local function ResetCamera()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            Cam.CameraSubject = hum
        end
    end
end

----------------------------------------------------
-- TOGGLE REDZ LIB
----------------------------------------------------

Tab3:AddToggle({
    Name = "Visualizar Jogador",
    Default = false,
    Callback = function(Value)
        viewing = Value

        if viewing then
            task.spawn(function()
                local shown = false

                while viewing do
                    -- Busca o jogador pelo nome selecionado no Dropdown
                    local target = Players:FindFirstChild(selectedPlayer)

                    if target then
                        -- Envia a notificação apenas uma vez ao iniciar a visualização
                        if not shown then
                            local thumbUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. target.UserId .. "&width=150&height=150&format=png"
                            
                            MyLibrary:NotifyWithImage({
                                Name = "Visualizando:",
                                Sub = target.DisplayName,        -- Nome secundário / visual
                                Text = "@" .. target.Name,       -- Nome original / username
                                Icon = thumbUrl,
                                Time = 3
                            })
                            shown = true
                        end

                        -- Acompanha o Humanoid do alvo
                        local char = target.Character
                        if char then
                            local hum = char:FindFirstChildOfClass("Humanoid")
                            if hum then
                                Cam.CameraSubject = hum
                            end
                        end
                    else
                        -- Notificação quando o jogador selecionado não é encontrado ou sai
                        MyLibrary:NotifyWithImage({
                            Name = "Jogador Indisponível",
                            Sub = tostring(selectedPlayer),
                            Text = "Jogador desconectado ou inválido",
                            Icon = "rbxassetid://86050226751861",
                            Time = 3
                        })

                        viewing = false
                        ResetCamera()
                        break
                    end
                    task.wait(0.1)
                end
            end)
        else
            ResetCamera()
        end
    end
})

--==============================================================
-- 🚀 SEÇÃO: BOTÃO TP JOGADOR
--==============================================================

Tab3:AddButton({
    Name = "Tp Jogador",
    Callback = function()
        if not selectedPlayer then
            MyLibrary:Notify({ Title = "Notificação", Message = "Nenhum jogador selecionado!", Duration = 3 })
            return
        end

        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = Character:FindFirstChild("HumanoidRootPart")

        local target = Players:FindFirstChild(selectedPlayer)
        if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
            MyLibrary:Notify({ Title = "Notificação", Message = "Jogador não encontrado!", Duration = 3 })
            return
        end

        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        HRP.CFrame = targetHRP.CFrame + Vector3.new(0, 3, 0)
    end
})

--==============================================================
-- 🚀 SEÇÃO: BOTÃO BRING
--==============================================================

Tab3:AddButton({
    Name = "Bring",
    Callback = function()
        if not selectedPlayer then
            MyLibrary:Notify({ Title = "Notificação", Message = "Nenhum jogador selecionado!", Duration = 3 })
            return
        end
        if not selectedMethod then
            MyLibrary:Notify({ Title = "Notificação", Message = "Escolha um método antes!", Duration = 3 })
            return
        end

        -----------------------------------------------------------
        -- 🚌 BRING: ÔNIBUS
        -----------------------------------------------------------
        if selectedMethod == "ônibus" then
            task.spawn(function()
                local targetPlayer = game:GetService("Players"):FindFirstChild(selectedPlayer)
                if not targetPlayer or not targetPlayer.Character then return end

                local character = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
                local rootPart  = character:WaitForChild("HumanoidRootPart")
                local humanoid  = character:WaitForChild("Humanoid")

                local realOriginalPos = rootPart.CFrame
                local busSpawnPlace   = CFrame.new(82.657265, 6.133477, -1368.286011)

                rootPart.CFrame = busSpawnPlace
                task.wait(2)

                game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer("PickingCar", "Bus", "Work")
                task.wait(3)

                local bus = workspace.Vehicles:FindFirstChild(game:GetService("Players").LocalPlayer.Name .. "Car")
                if bus then
                    local seat = bus:FindFirstChild("Seats") and bus.Seats:FindFirstChild("VehicleSeat")
                    if seat then
                        seat:Sit(humanoid)
                        repeat task.wait() until humanoid.Sit
                    end

                    local tChar = targetPlayer.Character
                    local tRoot = tChar:FindFirstChild("HumanoidRootPart")
                    local tHum  = tChar:FindFirstChildOfClass("Humanoid")

                    if tRoot and tHum then
                        local pullTimer = tick()
                        while tHum.Health > 0 and not tHum.Sit and (tick() - pullTimer) < 15 do
                            task.wait()
                            local time = tick() * 35
                            local lateralOffset   = math.sin(time) * 4
                            local frontBackOffset = math.cos(time) * 20
                            bus:PivotTo(tRoot.CFrame * CFrame.new(lateralOffset, 0, frontBackOffset))
                        end

                        if tHum.Sit then
                            task.wait(0.5)
                            bus:PivotTo(realOriginalPos)
                            task.wait(1.5)
                        end
                    end

                    humanoid.Sit = false
                    task.wait(0.2)
                    rootPart.CFrame = realOriginalPos + Vector3.new(0, 3, 0)
                    task.wait(0.3)

                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
                end
            end)

        -----------------------------------------------------------
        -- 🛋️ BRING: SOFÁ
        -----------------------------------------------------------
        elseif selectedMethod == "sofa" then
            task.spawn(function()
                local targetPlayer = game:GetService("Players"):FindFirstChild(selectedPlayer)
                local char = game:GetService("Players").LocalPlayer.Character
                if not targetPlayer or not char then return end

                local hum       = char:FindFirstChildOfClass("Humanoid")
                local root      = char:FindFirstChild("HumanoidRootPart")
                local targetRoot = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                local targetHum  = targetPlayer.Character and targetPlayer.Character:FindFirstChildOfClass("Humanoid")

                if not hum or not root or not targetRoot or not targetHum then return end

                local originalCFrame = root.CFrame
                local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("RE")

                Remotes:WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
                task.wait(0.2)
                Remotes:WaitForChild("1Too1l"):InvokeServer("PickingTools", "Couch")

                local couch = game:GetService("Players").LocalPlayer.Backpack:WaitForChild("Couch", 5)
                if not couch then return end
                couch.Parent = char

                task.wait(0.2)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
                hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

                local bp = Instance.new("BodyPosition")
                bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bp.D = 100
                bp.P = 10000
                bp.Parent = targetRoot

                local startTime = tick()
                while tick() - startTime < 7 do
                    if targetHum.Sit then break end
                    local rot = CFrame.Angles(math.rad(math.random(-90, 90)), math.rad(math.random(-90, 90)), math.rad(math.random(-90, 90)))
                    local offset = Vector3.new(math.random(-4, 4), 2, math.random(-4, 4))
                    root.CFrame = CFrame.new(targetRoot.Position + offset) * rot
                    bp.Position = root.Position
                    task.wait(0.05)
                end

                bp:Destroy()
                root.Velocity = Vector3.zero
                root.RotVelocity = Vector3.zero
                root.CFrame = originalCFrame
                task.wait(1)

                Remotes:WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
                local checkTool = char:FindFirstChild("Couch") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Couch")
                if checkTool then checkTool:Destroy() end

                hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                hum.WalkSpeed = 0
                hum.JumpPower = 0

                local stopTime = tick()
                while tick() - stopTime < 3 do
                    root.Velocity = Vector3.zero
                    root.RotVelocity = Vector3.zero
                    root.CFrame = originalCFrame
                    task.wait()
                end

                hum.WalkSpeed = 16
                hum.JumpPower = 50
            end)

        -----------------------------------------------------------
        -- 📦 BRING: PROP
        -----------------------------------------------------------
        elseif selectedMethod == "prop" then
            task.spawn(function()
                local targetPlayer = game:GetService("Players"):FindFirstChild(selectedPlayer)
                if not targetPlayer or targetPlayer == game:GetService("Players").LocalPlayer then return end

                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllTools")
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllProps")
                task.wait(0.2)

                local char = game:GetService("Players").LocalPlayer.Character
                if not char then return end
                local hrp      = char:WaitForChild("HumanoidRootPart")
                local humanoid = char:WaitForChild("Humanoid")

                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "PropMaker")
                local tool = game:GetService("Players").LocalPlayer.Backpack:WaitForChild("PropMaker", 5)
                if tool then
                    humanoid:EquipTool(tool)
                    task.wait(0.3)
                    pcall(function()
                        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer("RequestingPropName", "FurnitureBleachers", "Furniture")
                    end)
                    task.wait(0.5)
                    local toolRemote = tool:FindFirstChild("Tool_PropMake")
                    if toolRemote then
                        pcall(function()
                            toolRemote:FireServer(workspace.Model.Street.Street, hrp.Position + Vector3.new(0, -15, 0))
                        end)
                    end
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 500), workspace.CurrentCamera.CFrame)
                    task.wait(0.1)
                    game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 500), workspace.CurrentCamera.CFrame)
                end

                local dest = hrp.CFrame * CFrame.new(0, 0, -5)
                local wasSitting  = false
                local liftOffset  = -10

                local connection
                connection = game:GetService("RunService").Heartbeat:Connect(function()
                    local c = targetPlayer.Character
                    local r = c and c:FindFirstChild("HumanoidRootPart")
                    local h = c and c:FindFirstChild("Humanoid")
                    if not r or not h or not connection then return end

                    local props = {}
                    local workspaceCom = workspace:FindFirstChild("WorkspaceCom")
                    if workspaceCom then
                        for _, folder in ipairs(workspaceCom:GetChildren()) do
                            for _, p in ipairs(folder:GetChildren()) do
                                if p.Name:find("Prop" .. game:GetService("Players").LocalPlayer.Name) and p:FindFirstChild("SetCurrentCFrame") then
                                    table.insert(props, p)
                                end
                            end
                        end
                    end

                    if h.Sit then
                        if not wasSitting then
                            wasSitting = true
                            for _, prop in ipairs(props) do
                                pcall(function() prop.SetCurrentCFrame:InvokeServer(dest) end)
                            end
                            task.wait(0.4)
                            if connection then connection:Disconnect() connection = nil end
                            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllTools")
                            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllProps")
                        end
                    else
                        wasSitting = false
                        liftOffset = liftOffset + 0.5
                        if liftOffset > 2 then liftOffset = -10 end
                        for _, prop in ipairs(props) do
                            pcall(function() prop.SetCurrentCFrame:InvokeServer(r.CFrame * CFrame.new(0, liftOffset, 0)) end)
                        end
                    end
                end)

                task.wait(10)
                if connection then connection:Disconnect() connection = nil end
            end)

        -----------------------------------------------------------
        -- ⚽ BRING: BOLA
        -----------------------------------------------------------
        elseif selectedMethod == "bola" then
            MyLibrary:Notify({
                Title = "Notificação",
                Message = "Método 'bola' é exclusivo para Fling.",
                Duration = 3
            })

        else
            MyLibrary:Notify({ Title = "Notificação", Message = "Nenhum método selecionado!", Duration = 3 })
        end
    end
})

--==============================================================
-- 🚀 SEÇÃO: BOTÃO KILL
--==============================================================

Tab3:AddButton({
    Name = "Kill",
    Callback = function()
        if not selectedPlayer then
            MyLibrary:Notify({ Title = "Notificação", Message = "Nenhum jogador selecionado!", Duration = 3 })
            return
        end
        if not selectedMethod then
            MyLibrary:Notify({ Title = "Notificação", Message = "Escolha um método antes!", Duration = 3 })
            return
        end

        -----------------------------------------------------------
        -- 🚌 KILL: ÔNIBUS
        -----------------------------------------------------------
        if selectedMethod == "ônibus" then
            task.spawn(function()
                local targetPlayer = game:GetService("Players"):FindFirstChild(selectedPlayer)
                if not targetPlayer or not targetPlayer.Character then return end

                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local LocalPlayer = game:GetService("Players").LocalPlayer
                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local rootPart  = character:WaitForChild("HumanoidRootPart")
                local humanoid  = character:WaitForChild("Humanoid")
                local oldPos    = rootPart.CFrame

                rootPart.CFrame = CFrame.new(82.657265, 6.133477, -1368.286011)
                task.wait(2)

                ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer("PickingCar", "Bus", "Work")
                task.wait(3)

                local bus = workspace:WaitForChild("Vehicles"):FindFirstChild(LocalPlayer.Name .. "Car")
                if bus then
                    local seat = bus:FindFirstChild("Seats") and bus.Seats:FindFirstChild("VehicleSeat")
                    if seat then
                        seat:Sit(humanoid)
                        repeat task.wait() until humanoid.Sit
                    end

                    local tChar = targetPlayer.Character
                    local tRoot = tChar:FindFirstChild("HumanoidRootPart")
                    local tHum  = tChar:FindFirstChildOfClass("Humanoid")

                    if tRoot and tHum then
                        local killTimer = tick()
                        while tHum.Health > 0 and not tHum.Sit and (tick() - killTimer) < 15 do
                            task.wait()
                            local randomX, randomY, randomZ = math.random(-360, 360), math.random(-360, 360), math.random(-360, 360)
                            local offset = tHum.MoveDirection * (tRoot.Velocity.Magnitude / 1.05)
                            local ang = CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ))

                            local function kill(pos)
                                if bus and (bus.PrimaryPart or bus:FindFirstChild("Seats")) then
                                    bus:PivotTo(CFrame.new(tRoot.Position) * pos * ang)
                                end
                            end

                            kill(CFrame.new(0, 1, 0) + offset)
                            kill(CFrame.new(0, -2.25, 5) + offset)
                            kill(CFrame.new(0, 2.25, 0.25) + offset)
                            kill(CFrame.new(-2.25, -1.5, 2.25) + offset)
                            kill(CFrame.new(0, 1.5, 0) + offset)
                            kill(CFrame.new(0, -1.5, 0) + offset)
                        end
                    end

                    bus:PivotTo(CFrame.new(0, -470, 0))
                    task.wait(0.2)
                    humanoid.Sit = false
                    task.wait(0.1)
                    rootPart.CFrame = oldPos
                    ReplicatedStorage.RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
                end
            end)

        -----------------------------------------------------------
        -- 🛋️ KILL: SOFÁ
        -----------------------------------------------------------
        elseif selectedMethod == "sofa" then
            task.spawn(function()
                local Players = game:GetService("Players")
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local VirtualInputManager = game:GetService("VirtualInputManager")
                local LocalPlayer = Players.LocalPlayer
                local Remotes = ReplicatedStorage:WaitForChild("RE")

                local targetPlayer = Players:FindFirstChild(selectedPlayer)
                local char = LocalPlayer.Character
                if not targetPlayer or not char then return end

                local hum        = char:FindFirstChildOfClass("Humanoid")
                local root       = char:FindFirstChild("HumanoidRootPart")
                local targetRoot = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                local targetHum  = targetPlayer.Character and targetPlayer.Character:FindFirstChildOfClass("Humanoid")

                if not hum or not root or not targetRoot or not targetHum then return end

                local originalCFrame = root.CFrame

                Remotes:WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
                task.wait(0.3)
                Remotes:WaitForChild("1Too1l"):InvokeServer("PickingTools", "Couch")

                local couch = LocalPlayer.Backpack:WaitForChild("Couch", 5)
                if not couch then return end
                couch.Parent = char

                task.wait(0.2)
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

                local bp = Instance.new("BodyPosition")
                bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bp.D = 100
                bp.P = 10000
                bp.Parent = targetRoot

                local startTime = tick()
                while tick() - startTime < 7 do
                    if targetHum.Sit then break end
                    local rot = CFrame.Angles(math.rad(math.random(-90, 90)), math.rad(math.random(-90, 90)), math.rad(math.random(-90, 90)))
                    local offset = Vector3.new(math.random(-4, 4), 2, math.random(-4, 4))
                    root.CFrame = CFrame.new(targetRoot.Position + offset) * rot
                    bp.Position = root.Position
                    task.wait(0.05)
                end

                bp:Destroy()
                root.Velocity    = Vector3.zero
                root.RotVelocity = Vector3.zero

                if targetHum.Sit then
                    task.wait(0.1)
                    root.CFrame = CFrame.new(root.Position.X, -100, root.Position.Z)
                    task.wait(0.3)

                    Remotes:WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
                    local checkTool = char:FindFirstChild("Couch") or LocalPlayer.Backpack:FindFirstChild("Couch")
                    if checkTool then checkTool:Destroy() end
                    task.wait(0.5)
                end

                hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                root.Velocity    = Vector3.zero
                root.RotVelocity = Vector3.zero
                root.CFrame      = originalCFrame

                hum.WalkSpeed = 0
                hum.JumpPower = 0

                local stopTime = tick()
                while tick() - stopTime < 3 do
                    root.Velocity    = Vector3.zero
                    root.RotVelocity = Vector3.zero
                    root.CFrame      = originalCFrame
                    task.wait()
                end
                hum.WalkSpeed = 16
                hum.JumpPower = 50
            end)

        -----------------------------------------------------------
        -- 📦 KILL: PROP
        -----------------------------------------------------------
        elseif selectedMethod == "prop" then
            task.spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local VirtualUser = game:GetService("VirtualUser")
                local LocalPlayer = Players.LocalPlayer

                local targetPlayer = Players:FindFirstChild(selectedPlayer)
                if not targetPlayer then return end

                local function ClearTools()
                    pcall(function()
                        ReplicatedStorage.RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllTools")
                        ReplicatedStorage.RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllProps")
                    end)
                end

                local function GetMyProps()
                    local props = {}
                    local workspaceCom = workspace:FindFirstChild("WorkspaceCom")
                    if not workspaceCom then return props end
                    for _, folder in ipairs(workspaceCom:GetChildren()) do
                        for _, prop in ipairs(folder:GetChildren()) do
                            if prop.Name:find("Prop" .. LocalPlayer.Name) and prop:FindFirstChild("SetCurrentCFrame") then
                                table.insert(props, prop)
                            end
                        end
                    end
                    return props
                end

                local function TeleportProps(cf)
                    for _, prop in ipairs(GetMyProps()) do
                        task.spawn(function()
                            pcall(function() prop.SetCurrentCFrame:InvokeServer(cf) end)
                        end)
                    end
                end

                ClearTools()
                task.wait(0.2)
                local char = LocalPlayer.Character
                if not char then return end
                local hrp      = char:WaitForChild("HumanoidRootPart")
                local humanoid = char:WaitForChild("Humanoid")

                ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "PropMaker")
                local tool = LocalPlayer.Backpack:WaitForChild("PropMaker", 5)
                if tool then
                    humanoid:EquipTool(tool)
                    task.wait(0.3)
                    pcall(function()
                        ReplicatedStorage.RE:FindFirstChild("1Clea1rTool1s"):FireServer("RequestingPropName", "FurnitureBleachers", "Furniture")
                    end)
                    task.wait(0.5)
                    local toolRemote = tool:FindFirstChild("Tool_PropMake")
                    if toolRemote then
                        pcall(function()
                            toolRemote:FireServer(workspace.Model.Street.Street, hrp.Position + Vector3.new(0, -15, 0))
                        end)
                    end
                    VirtualUser:Button1Down(Vector2.new(0, 500), workspace.CurrentCamera.CFrame)
                    task.wait(0.1)
                    VirtualUser:Button1Up(Vector2.new(0, 500), workspace.CurrentCamera.CFrame)
                end

                local wasSitting  = false
                local liftOffset  = -10
                local destinationCF = CFrame.new(216, -1338, -477)

                local connection
                local startTime = tick()

                connection = RunService.Heartbeat:Connect(function()
                    local c = targetPlayer.Character
                    local r = c and c:FindFirstChild("HumanoidRootPart")
                    local h = c and c:FindFirstChild("Humanoid")

                    if not r or not h or (tick() - startTime > 12) then
                        if connection then connection:Disconnect() end
                        ClearTools()
                        return
                    end

                    if h.Sit then
                        if not wasSitting then
                            wasSitting = true
                            TeleportProps(destinationCF)
                            task.wait(0.4)
                            if connection then connection:Disconnect() end
                            ClearTools()
                        end
                    else
                        wasSitting = false
                        liftOffset = liftOffset + 0.5
                        if liftOffset > 2 then liftOffset = -10 end
                        TeleportProps(r.CFrame * CFrame.new(0, liftOffset, 0))
                    end
                end)
            end)

        -----------------------------------------------------------
        -- ⚽ KILL: BOLA
        -----------------------------------------------------------
        elseif selectedMethod == "bola" then
            MyLibrary:Notify({
                Title = "Notificação",
                Message = "Método 'bola' é exclusivo para Fling.",
                Duration = 3
            })

        else
            MyLibrary:Notify({ Title = "Notificação", Message = "Nenhum método selecionado!", Duration = 3 })
        end
    end
})

--==============================================================
-- 🚀 SEÇÃO: BOTÃO FLING
--==============================================================

Tab3:AddButton({
    Name = "Fling",
    Description = "",
    Callback = function()
        if not selectedMethod then
            MyLibrary:Notify({ Title = "Notificação", Message = "Escolha um método antes!", Duration = 3 })
            return
        end
        if not selectedPlayer then
            MyLibrary:Notify({ Title = "Notificação", Message = "Escolha um jogador antes!", Duration = 3 })
            return
        end

        -----------------------------------------------------------
        -- 🚌 FLING: ÔNIBUS
        -----------------------------------------------------------
        if selectedMethod == "ônibus" then
            local targetPlayer = game:GetService("Players"):FindFirstChild(selectedPlayer)
            if not targetPlayer or not targetPlayer.Character then return end

            local character = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
            local rootPart  = character:WaitForChild("HumanoidRootPart")
            local humanoid  = character:WaitForChild("Humanoid")
            local oldPos    = rootPart.CFrame
            local spawnPlace = CFrame.new(82.657265, 6.133477, -1368.286011)

            rootPart.CFrame = spawnPlace
            task.wait(2)

            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer("PickingCar", "Bus", "Work")
            task.wait(3)

            local bus = workspace.Vehicles:FindFirstChild(game:GetService("Players").LocalPlayer.Name .. "Car")
            if bus then
                local seat = bus:FindFirstChild("Seats") and bus.Seats:FindFirstChild("VehicleSeat")
                if seat then
                    seat:Sit(humanoid)
                    repeat task.wait() until humanoid.Sit
                end

                local tChar = targetPlayer.Character
                local tRoot = tChar:FindFirstChild("HumanoidRootPart")
                local tHum  = tChar:FindFirstChildOfClass("Humanoid")

                if tRoot and tHum then
                    local searchTimer = tick()
                    while tHum.Health > 0 and not tHum.Sit and (tick() - searchTimer) < 15 do
                        task.wait()
                        local time = tick() * 60
                        bus:PivotTo(tRoot.CFrame * CFrame.new(math.sin(time) * 5, 0, math.cos(time) * 5) * CFrame.Angles(0, time, 0))
                    end

                    if tHum.Sit then
                        local extremeSkyPos = CFrame.new(tRoot.Position.X, 999999, tRoot.Position.Z)
                        bus:PivotTo(extremeSkyPos)
                        task.wait(0.5)

                        local flingTimer = tick()
                        while (tick() - flingTimer) < 10 do
                            game:GetService("RunService").Heartbeat:Wait()
                            local randRotation = CFrame.Angles(
                                math.rad(math.random(-10000, 10000)),
                                math.rad(math.random(-10000, 10000)),
                                math.rad(math.random(-10000, 10000))
                            )
                            bus:PivotTo(extremeSkyPos * randRotation)
                        end
                    end
                end

                task.wait(0.1)
                humanoid.Sit = false
                rootPart.CFrame = oldPos
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
            end

        -----------------------------------------------------------
        -- 🛋️ FLING: SOFÁ
        -----------------------------------------------------------
        elseif selectedMethod == "sofa" then
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local cam = workspace.CurrentCamera

            local target = Players:FindFirstChild(selectedPlayer)
            if not target or not target.Character then return end

            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local tRoot = target.Character:FindFirstChild("HumanoidRootPart")
            local tHum  = target.Character:FindFirstChildOfClass("Humanoid")
            local hum   = char and char:FindFirstChildOfClass("Humanoid")
            if not (root and tRoot and tHum and hum) then return end

            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllTools")
            task.wait(0.3)
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")

            local original = root.CFrame
            local tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
            if tool then tool.Parent = char end

            workspace.FallenPartsDestroyHeight = -math.huge

            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlingForce"
            bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Parent = root

            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            hum.PlatformStand = false
            cam.CameraSubject = tRoot

            local angle = 0
            local t = tick()
            while tick() - t < 3 and target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") do
                tHum  = target.Character:FindFirstChildOfClass("Humanoid")
                tRoot = target.Character:FindFirstChild("HumanoidRootPart")
                if not tRoot then break end
                angle += 30
                root.CFrame = CFrame.new(tRoot.Position + Vector3.new(0, 1, 0)) * CFrame.Angles(math.rad(angle), 0, 0)
                root.Velocity    = Vector3.new(9e8, 9e8, 9e8)
                root.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                task.wait()
            end

            bv:Destroy()
            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            hum.PlatformStand = false
            root.CFrame = original
            cam.CameraSubject = hum
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.Velocity    = Vector3.zero
                    p.RotVelocity = Vector3.zero
                end
            end
            hum:UnequipTools()
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")

        -----------------------------------------------------------
        -- 📦 FLING: PROP
        -----------------------------------------------------------
        elseif selectedMethod == "prop" then
            local targetPlayer = game:GetService("Players"):FindFirstChild(selectedPlayer)
            if not targetPlayer then return end

            pcall(function()
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllTools")
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllProps")
            end)
            task.wait(0.2)

            local char = game:GetService("Players").LocalPlayer.Character
            if not char then return end
            local hrp      = char:WaitForChild("HumanoidRootPart")
            local humanoid = char:WaitForChild("Humanoid")

            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "PropMaker")
            local tool = game:GetService("Players").LocalPlayer.Backpack:WaitForChild("PropMaker", 5)
            if tool then
                humanoid:EquipTool(tool)
                task.wait(0.3)
                pcall(function()
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer("RequestingPropName", "FurnitureBleachers", "Furniture")
                end)
                task.wait(0.5)
                local toolRemote = tool:FindFirstChild("Tool_PropMake")
                if toolRemote then
                    pcall(function()
                        toolRemote:FireServer(workspace.Model.Street.Street, hrp.Position + Vector3.new(0, -15, 0))
                    end)
                end
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 500), workspace.CurrentCamera.CFrame)
                task.wait(0.1)
                game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 500), workspace.CurrentCamera.CFrame)
            end

            local wasSitting = false
            local liftOffset = -10
            local destinationCF = CFrame.new(1082537, 81322368, -4719626)

            local startTime = tick()
            while tick() - startTime < 10 and targetPlayer.Character do
                game:GetService("RunService").Heartbeat:Wait()
                local c = targetPlayer.Character
                local r = c and c:FindFirstChild("HumanoidRootPart")
                local h = c and c:FindFirstChild("Humanoid")
                if not r or not h then break end

                if h.Sit then
                    if not wasSitting then
                        wasSitting = true
                        local wCom = workspace:FindFirstChild("WorkspaceCom")
                        if wCom then
                            for _, f in ipairs(wCom:GetChildren()) do
                                for _, prop in ipairs(f:GetChildren()) do
                                    if prop.Name:find("Prop" .. game:GetService("Players").LocalPlayer.Name) and prop:FindFirstChild("SetCurrentCFrame") then
                                        pcall(function() prop.SetCurrentCFrame:InvokeServer(destinationCF) end)
                                    end
                                end
                            end
                        end
                        task.wait(0.4)
                        pcall(function()
                            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllTools")
                            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllProps")
                        end)
                        break
                    end
                else
                    wasSitting = false
                    liftOffset = liftOffset + 0.5
                    if liftOffset > 2 then liftOffset = -10 end
                    local wCom = workspace:FindFirstChild("WorkspaceCom")
                    if wCom then
                        for _, f in ipairs(wCom:GetChildren()) do
                            for _, prop in ipairs(f:GetChildren()) do
                                if prop.Name:find("Prop" .. game:GetService("Players").LocalPlayer.Name) and prop:FindFirstChild("SetCurrentCFrame") then
                                    pcall(function() prop.SetCurrentCFrame:InvokeServer(r.CFrame * CFrame.new(0, liftOffset, 0)) end)
                                end
                            end
                        end
                    end
                end
            end

        -----------------------------------------------------------
        -- ⚽ FLING: BOLA
        -----------------------------------------------------------
        elseif selectedMethod == "bola" then
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Workspace = game:GetService("Workspace")

            local LocalPlayer = Players.LocalPlayer
            local targetPlayer = Players:FindFirstChild(selectedPlayer)
            if not targetPlayer or not targetPlayer.Character then return end

            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local backpack  = LocalPlayer:WaitForChild("Backpack")
            local ServerBalls = Workspace:WaitForChild("WorkspaceCom"):WaitForChild("001_SoccerBalls")

            if not backpack:FindFirstChild("SoccerBall") and not character:FindFirstChild("SoccerBall") then
                ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "SoccerBall")
            end

            repeat task.wait() until backpack:FindFirstChild("SoccerBall") or character:FindFirstChild("SoccerBall")

            local ballTool = backpack:FindFirstChild("SoccerBall")
            if ballTool then ballTool.Parent = character end

            repeat task.wait() until ServerBalls:FindFirstChild("Soccer" .. LocalPlayer.Name)
            local Ball = ServerBalls:FindFirstChild("Soccer" .. LocalPlayer.Name)

            Ball.CanCollide = false
            Ball.Massless = true
            Ball.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0)

            local tchar = targetPlayer.Character
            local troot = tchar and tchar:FindFirstChild("HumanoidRootPart")
            local thum  = tchar and tchar:FindFirstChildOfClass("Humanoid")
            if not troot or not thum then return end

            if Ball:FindFirstChildWhichIsA("BodyVelocity") then
                Ball:FindFirstChildWhichIsA("BodyVelocity"):Destroy()
            end

            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlingPower"
            bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.P = 9e900
            bv.Parent = Ball

            task.spawn(function()
                repeat
                    if troot.Velocity.Magnitude > 0 then
                        local pos = troot.Position + (troot.Velocity / 1.5)
                        Ball.CFrame = CFrame.new(pos)
                        Ball.Orientation += Vector3.new(45, 60, 30)
                    else
                        for _, v in pairs(tchar:GetChildren()) do
                            if v:IsA("BasePart") and v.CanCollide and not v.Anchored then
                                Ball.CFrame = v.CFrame
                                task.wait(1 / 6000)
                            end
                        end
                    end
                    task.wait(1 / 6000)
                until troot.Velocity.Magnitude > 1000 or thum.Health <= 0 or not tchar:IsDescendantOf(Workspace) or targetPlayer.Parent ~= Players
            end)

            -- Limpeza do BodyVelocity (evita fling eterno)
            bv:Destroy()
            Ball.CFrame = CFrame.new(0, -500, 0)

        else
            MyLibrary:Notify({ Title = "Notificação", Message = "Método inválido!", Duration = 3 })
        end
    end
})

Tab3:AddSection({Name = "Outros"})

Tab3:AddToggle({
    Name = "Head Sit (Cavalinho)",
    Default = false,
    Callback = function(bool)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")

        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:WaitForChild("Humanoid")

        if bool then
            if not selectedPlayer then
                warn("Nenhum jogador selecionado!")
                return false
            end

            humanoid.Sit = true

            -- Anti fling
            humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            humanoidRootPart.AssemblyAngularVelocity = Vector3.zero

            if headSitConnection then
                headSitConnection:Disconnect()
            end

            headSitConnection = RunService.Heartbeat:Connect(function()
                -- Atualiza o alvo em tempo real
                local targetPlayer = Players:FindFirstChild(selectedPlayer)

                if targetPlayer
                    and targetPlayer.Character
                    and targetPlayer.Character:FindFirstChild("Head") then

                    -- Continua sentado mesmo se apertar espaço
                    if not humanoid.Sit then
                        humanoid.Sit = true
                    end

                    local head = targetPlayer.Character.Head

                    humanoidRootPart.CFrame =
                        head.CFrame * CFrame.new(0, 1.6, 0.4)

                    -- Anti fling
                    humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                    humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
                else
                    if headSitConnection then
                        headSitConnection:Disconnect()
                        headSitConnection = nil
                    end

                    humanoid.Sit = false
                end
            end)
        else
            if headSitConnection then
                headSitConnection:Disconnect()
                headSitConnection = nil
            end

            humanoid.Sit = false
            humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        end
    end
})


Tab3:AddButton({
    Name = "Colocar Banana no Player",
    Callback = function()
        if selectedPlayer and selectedPlayer ~= "..." and selectedPlayer ~= "Selecionar Jogador" then
            
            local targetPlayer = game:GetService("Players"):FindFirstChild(selectedPlayer)
            
            if targetPlayer and targetPlayer.Character then
                local TargetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                local LocalPlayer = game:GetService("Players").LocalPlayer
                local MyCharacter = LocalPlayer.Character
                local MyRoot = MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart")
                local Humanoid = MyCharacter and MyCharacter:FindFirstChildOfClass("Humanoid")
                
                if TargetRoot and MyRoot and Humanoid then
                    
                    -- 🎥 LÓGICA DO VIEW TEMPORÁRIO (Se o Toggle de View contínua não estiver ativo)
                    if not viewing then
                        local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if targetHumanoid then
                            task.spawn(function()
                                local cam = workspace.CurrentCamera
                                cam.CameraSubject = targetHumanoid
                                ShowPlayerNotification(targetPlayer) -- Dispara a sua notificação visual personalizada
                                
                                task.wait(3) -- Mantém visualizando por 3 segundos
                                
                                -- Restaura a câmera para o seu personagem apenas se o toggle contínuo não tiver sido ligado nesse meio tempo
                                if not viewing and MyCharacter and MyCharacter:FindFirstChildOfClass("Humanoid") then
                                    cam.CameraSubject = MyCharacter:FindFirstChildOfClass("Humanoid")
                                end
                            end)
                        end
                    end
                    
                    -- 1. FUNÇÃO INTERNA PARA BUSCAR A TOOL NO INVENTÁRIO OU NA MÃO
                    local function obterPeelTool()
                        local tool = nil
                        if LocalPlayer:FindFirstChild("Backpack") then
                            tool = LocalPlayer.Backpack:FindFirstChild("Minions2026_BananaPeel")
                        end
                        if not tool and MyCharacter then
                            tool = MyCharacter:FindFirstChild("Minions2026_BananaPeel")
                        end
                        return tool
                    end

                    local PeelTool = obterPeelTool()

                    -- 2. SE NÃO TIVER A TOOL, SOLICITA AO SERVIDOR E AGUARDA APARECER
                    if not PeelTool then
                        local args = {
                            [1] = "AcceptedToolToServer",
                            [2] = "Minions2026_BananaPeel",
                            [3] = LocalPlayer
                        }
                        
                        local triggerEvent = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t")
                        if triggerEvent then
                            triggerEvent:FireServer(unpack(args))
                            
                            -- Aguarda a ferramenta chegar na mochila por até 2 segundos
                            local timeout = 0
                            while not PeelTool and timeout < 40 do
                                timeout = timeout + 1
                                task.wait(0.05)
                                PeelTool = obterPeelTool()
                            end
                        end
                    end

                    -- 3. EXECUTA A LÓGICA SE A FERRAMENTA ESTIVER DISPONÍVEL
                    if PeelTool then
                        local RemotesLib = nil
                        pcall(function()
                            RemotesLib = require(game:GetService("ReplicatedStorage").Packages.Remotes)
                        end)

                        if RemotesLib and RemotesLib.fireServerComponent then
                            pcall(function()
                                -- Garante que a ferramenta está equipada na mão
                                if PeelTool.Parent ~= MyCharacter then
                                    Humanoid:EquipTool(PeelTool)
                                    task.wait(0.05)
                                end

                                local TargetPosition = TargetRoot.Position - Vector3.new(0, 3, 0)
                                local distancia = (MyRoot.Position - TargetRoot.Position).Magnitude
                                
                                -- Se estiver longe (mais de 30 studs), teleporta com segurança por baixo
                                if distancia > 30 then
                                    local originalCFrame = MyRoot.CFrame
                                    
                                    local bV = Instance.new("BodyVelocity")
                                    bV.Velocity = Vector3.new(0, 0, 0)
                                    bV.MaxForce = Vector3.new(0, math.huge, 0)
                                    bV.Parent = MyRoot
                                    
                                    MyRoot.CFrame = TargetRoot.CFrame * CFrame.new(0, -14, 0)
                                    task.wait(0.35)
                                    
                                    RemotesLib.fireServerComponent(PeelTool, "PlaceBananaPeel", TargetPosition)
                                    task.wait(0.10)
                                    
                                    MyRoot.CFrame = originalCFrame
                                    bV:Destroy()
                                else
                                    RemotesLib.fireServerComponent(PeelTool, "PlaceBananaPeel", TargetPosition)
                                end
                            end)
                        else
                            warn("Biblioteca de Remotes nativa não encontrada.")
                        end
                    else
                        warn("Não foi possível puxar ou encontrar a casca de banana.")
                    end
                    
                end
            end
        else
            warn("Nenhum jogador válido selecionado no dropdown.")
        end
    end
})

----------------------------------------------------------------------------------------------------------------
-----------------------------------------Aba Antis-----------------------------------------------------
----------------------------------------------------------------------------------------------------------------

local Tab4= Window:MakeTab({ "| Antis", "shield" })

local antiSitEnabled = false
local antiSitLoop

Tab4:AddToggle({
    Name = "Anti-Sit",
    Description = "Impede o jogador de sentar",
    Default = false,
    Callback = function(state)
        antiSitEnabled = state

        if state then
            antiSitLoop = task.spawn(function()
                while antiSitEnabled do
                    local character = game.Players.LocalPlayer.Character

                    if character then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")

                        if humanoid then
                            humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

                            if humanoid.Sit then
                                humanoid.Sit = false
                                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                            end
                        end
                    end

                    task.wait()
                end
            end)
        else
            local character = game.Players.LocalPlayer.Character

            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")

                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                end
            end
        end
    end
})

-- Toggle Anti Fling Ball (Noclip apenas para as bolas)
Tab4:AddToggle({
    Name = "Anti Fling Ball",
    Description = "As bolas de futebol não vão mais te empurrar!",
    Default = false,
    Callback = function(state)
        _G.AntiBall = state
        
        local player = game:GetService("Players").LocalPlayer
        
        -- Loop para garantir que as bolas novas e antigas não te toquem
        task.spawn(function()
            while _G.AntiBall do
                -- Procura em todo o Workspace por SoccerBall
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Name == "SoccerBall" or obj.Name:find("Soccer")) then
                        -- Desativa a colisão da bola com o seu personagem
                        obj.CanCollide = false
                    end
                end
                task.wait(1) -- Verifica a cada 1 segundo para não dar lag
            end
            
            -- Se desligar o toggle, as bolas voltam ao normal (opcional)
            if not _G.AntiBall then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Name == "SoccerBall" or obj.Name:find("Soccer")) then
                        obj.CanCollide = true
                    end
                end
            end
        end)
    end
})


local doorParts = {} -- Agora vai guardar o estado original: [part] = estado_original_booleano
local doorConnection

local function isDoor(obj)
    local name = obj.Name:lower()
    return name:find("door") or name:find("porta")
end

local function setDoorNoclip(obj, state)
    -- Função auxiliar para processar uma única parte
    local function processPart(part)
        if part:IsA("BasePart") then
            -- Só salva o estado original se a parte ainda não estiver na tabela
            if doorParts[part] == nil then
                doorParts[part] = part.CanCollide
            end
            
            if state then
                part.CanCollide = false -- Se noclip ativado, desativa colisão
            else
                part.CanCollide = doorParts[part] -- Se desativado, restaura o original
            end
        end
    end

    processPart(obj)
    for _, v in ipairs(obj:GetDescendants()) do
        processPart(v)
    end
end

local function applyDoorNoclip(state)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if isDoor(obj) then
            setDoorNoclip(obj, state)
        end
    end
end

Tab4:AddToggle({
    Name = "Noclip Portas / Anti Fling Portas",
    Description = "As portas não vão mais te empurrar!",
    Default = false,
    Callback = function(Value)
        
        if Value then
            applyDoorNoclip(true)
            
            doorConnection = workspace.DescendantAdded:Connect(function(obj)
                if isDoor(obj) then
                    task.wait()
                    setDoorNoclip(obj, true)
                end
            end)
        else
            -- Desconecta o evento primeiro para não gerar conflitos
            if doorConnection then
                doorConnection:Disconnect()
                doorConnection = nil
            end

            -- Restaura o estado original de cada parte salva
            for part, originalCollide in pairs(doorParts) do
                if part and part.Parent then
                    part.CanCollide = originalCollide
                end
            end

            -- Limpa a tabela para a próxima vez
            table.clear(doorParts)
        end
    end
})

-- Variável para guardar o estado
local VoidConnection

local function ToggleVoidProtection(bool)
	if bool then
		game.Workspace.FallenPartsDestroyHeight = 0/0
	else
		game.Workspace.FallenPartsDestroyHeight = -500
	end
end

-- Toggle na RedzLib
Tab4:AddToggle({
	Name = "Anti Void",
	Description = "Não deixar você morrer para o void",
	Default = false,
	Callback = function(Value)
		ToggleVoidProtection(Value)
	end
})

local BananaConnection

Tab4:AddToggle({
    Name = "Anti Bananas",
    Default = false,
    Callback = function(Value)
        if Value then
            -- Remove as bananas que já existem
            for _, v in ipairs(workspace:GetChildren()) do
                if v.Name:match("^BananaPeel_") then
                    local touch = v:FindFirstChild("Touch")
                    if touch then
                        touch:Destroy()
                    end
                end
            end

            -- Detecta novas bananas
            BananaConnection = workspace.ChildAdded:Connect(function(v)
                if v.Name:match("^BananaPeel_") then
                    local touch = v:WaitForChild("Touch", 3)
                    if touch then
                        touch:Destroy()
                    end
                end
            end)

        else
            -- Para de detectar quando desligar
            if BananaConnection then
                BananaConnection:Disconnect()
                BananaConnection = nil
            end
        end
    end
})


----------------------------------------------------------------------------------------------------------------
-----------------------------------------Aba Avatar---------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
local Tab5= Window:MakeTab({ "| Avatar", "shirt" })

--==============================================================
-- 📦 SERVIÇOS E REFERÊNCIAS GLOBAIS
--==============================================================
local Players            = game:GetService("Players")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local HttpService        = game:GetService("HttpService")
local Remotes            = ReplicatedStorage:WaitForChild("Remotes")

local LocalPlayer        = Players.LocalPlayer

--==============================================================
-- 🧬 TABELA GLOBAL DE CORPOS
--==============================================================
local BODY_CODES = {
    ["Corpo Normal"]          = "BH-AE-b13ebf33569a4d909d1995f401511ba6",
    ["Corpo Normal Esticado"] = "BH-AE-00e12b1c7a95401398d1a0f8ffdc2eda",
    ["Corpo Alto Fino"]       = "BH-AE-a6dc40c61d634003b173e343aa5c880a"
}

local BODY_OPTIONS = { "Corpo Normal", "Corpo Normal Esticado", "Corpo Alto Fino" }

--==============================================================
-- 🛠️ FUNÇÕES UTILITÁRIAS GLOBAIS
--==============================================================

-- Vestir um item com delay anti rate-limit
local function SafeWear(assetId)
    if not assetId or assetId == 0 or assetId == "0" then return end
    pcall(function()
        Remotes.Wear:InvokeServer(tonumber(assetId))
    end)
    task.wait(0.35)
end

-- Adicionar ID à tabela de verificação
local function addId(tbl, id)
    if id and tonumber(id) and tonumber(id) ~= 0 then
        tbl[tonumber(id)] = true
    end
end

-- Coletar todos IDs de uma HumanoidDescription
local function collectDescriptionIds(desc)
    local ids = {}
    if not desc then return ids end
    addId(ids, desc.Shirt)
    addId(ids, desc.Pants)
    addId(ids, desc.Face)
    for _, acc in ipairs(desc:GetAccessories(true)) do
        addId(ids, acc.AssetId)
    end
    return ids
end

-- Extrair dados completos do avatar de uma HumanoidDescription
local function extractAvatarData(humanoid, character)
    if not humanoid then return nil end
    local Desc = humanoid:GetAppliedDescription()
    local data = {
        Body = {
            Torso    = Desc.Torso,
            RightArm = Desc.RightArm,
            LeftArm  = Desc.LeftArm,
            RightLeg = Desc.RightLeg,
            LeftLeg  = Desc.LeftLeg,
            Head     = Desc.Head
        },
        Clothing = {
            Shirt = Desc.Shirt,
            Pants = Desc.Pants,
            Face  = Desc.Face
        },
        Accessories = {},
        Animations = {
            Idle  = Desc.IdleAnimation,
            Walk  = Desc.WalkAnimation,
            Run   = Desc.RunAnimation,
            Jump  = Desc.JumpAnimation,
            Fall  = Desc.FallAnimation,
            Climb = Desc.ClimbAnimation,
            Swim  = Desc.SwimAnimation
        }
    }
    for _, acc in ipairs(Desc:GetAccessories(true)) do
        if acc.AssetId and tonumber(acc.AssetId) then
            table.insert(data.Accessories, tonumber(acc.AssetId))
        end
    end
    if character then
        local bc = character:FindFirstChild("Body Colors")
        if bc then data.BodyColor = tostring(bc.HeadColor) end
    end
    return data
end

-- Aplicar um body code no Brookhaven
local function loadBodyCode(chosenBody)
    local code = BODY_CODES[chosenBody] or BODY_CODES["Corpo Normal"]
    task.spawn(function()
        pcall(function()
            Remotes.AvatarEditorOutfitCodes:InvokeServer("Load", code)
        end)
    end)
end

--==============================================================
-- 🎯 SEÇÃO: DROPDOWNS (TAB5)
--==============================================================
local SelectedPlayerAvatar = nil

local DropdownJogadoresAvatar = Tab5:AddDropdownPlayer({
    Name = "Selecionar Jogador",
    Callback = function(Value)
        SelectedPlayerAvatar = Value
    end
})

-- Dropdown "Tipo de Corpo" usado pelos botões de Copiar Avatar
local CopyAvatarBodyType = Tab5:AddDropdown({
    Name = "Tipo de Corpo",
    Description = "Selecione o corpo base para carregar a skin",
    Options = BODY_OPTIONS,
    Default = "Corpo Normal",
    Flag = "body_type_dropdown",
    Callback = function(Value)
        _G.SelectedBodyType = Value
    end
})

--==============================================================
-- 🚀 SEÇÃO: BOTÃO COPIAR AVATAR (jogador do Brookhaven)
--==============================================================
local BtnCopiarAvatar = Tab5:AddButton({
    Name = "Copiar Avatar",
    Callback = function()
        if not SelectedPlayerAvatar then
            MyLibrary:Notify({ Title = "Aviso", Message = "Nenhum jogador selecionado", Duration = 4 })
            return
        end

        local LChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local TPlayer = Players:FindFirstChild(SelectedPlayerAvatar)
        if not TPlayer then
            MyLibrary:Notify({ Title = "Erro", Message = "Jogador não encontrado", Duration = 4 })
            return
        end

        local TChar = TPlayer.Character or TPlayer.CharacterAdded:Wait()
        if not TChar then
            MyLibrary:Notify({ Title = "Erro", Message = "Character do alvo não carregado", Duration = 4 })
            return
        end

        local LHumanoid = LChar:FindFirstChildOfClass("Humanoid")
        local THumanoid = TChar:FindFirstChildOfClass("Humanoid")
        if not LHumanoid or not THumanoid then
            MyLibrary:Notify({ Title = "Erro", Message = "Humanoid não encontrado", Duration = 4 })
            return
        end

        -- 1. Capturar dados do alvo
        local PDesc = THumanoid:GetAppliedDescription()
        local targetIDs = collectDescriptionIds(PDesc)
        local targetAccessories = PDesc:GetAccessories(true)

        -- 2. Resetar com corpo escolhido
        loadBodyCode(_G.SelectedBodyType or "Corpo Normal")
        task.wait(1)

        -- 3. Equipar corpo/roupas/acessórios
        pcall(function()
            Remotes.ChangeCharacterBody:InvokeServer({
                PDesc.Torso, PDesc.RightArm, PDesc.LeftArm,
                PDesc.RightLeg, PDesc.LeftLeg, PDesc.Head
            })
        end)
        task.wait(0.5)

        if targetIDs[tonumber(PDesc.Shirt)] then SafeWear(PDesc.Shirt) end
        if targetIDs[tonumber(PDesc.Pants)] then SafeWear(PDesc.Pants) end
        if targetIDs[tonumber(PDesc.Face)]  then SafeWear(PDesc.Face)  end

        for _, acc in ipairs(targetAccessories) do
            if acc.AssetId then SafeWear(acc.AssetId) end
        end

        local SkinColor = TChar:FindFirstChild("Body Colors")
        if SkinColor then
            pcall(function()
                Remotes.ChangeBodyColor:FireServer(tostring(SkinColor.HeadColor))
            end)
            task.wait(0.3)
        end

        -- Função de revisão (double-check com proteção de troca de skin do alvo)
        local function RunRevision(revisionNumber)
            local checkTChar = TPlayer.Character
            local checkTHumanoid = checkTChar and checkTChar:FindFirstChildOfClass("Humanoid")
            if not checkTHumanoid then return false end

            local NewPDesc = checkTHumanoid:GetAppliedDescription()
            local currentTargetIDs = collectDescriptionIds(NewPDesc)

            local totalOriginalItems, matchingItems = 0, 0
            for id in pairs(targetIDs) do
                totalOriginalItems = totalOriginalItems + 1
                if currentTargetIDs[id] then matchingItems = matchingItems + 1 end
            end

            local matchRatio = totalOriginalItems > 0 and (matchingItems / totalOriginalItems) or 1
            if matchRatio < 0.6 then return false end -- Alvo mudou de skin, aborta

            local LDesc = LHumanoid:GetAppliedDescription()
            local myEquipped = collectDescriptionIds(LDesc)

            for id in pairs(targetIDs) do
                if not myEquipped[id] then
                    SafeWear(id)
                end
            end
            return true
        end

        task.wait(1.5) RunRevision(2)
        task.wait(1.5) RunRevision(3)

        -- 4. Aplicar animações
        local Animations = {
            PDesc.IdleAnimation, PDesc.WalkAnimation, PDesc.RunAnimation,
            PDesc.JumpAnimation, PDesc.FallAnimation, PDesc.ClimbAnimation, PDesc.SwimAnimation
        }
        for _, anim in ipairs(Animations) do
            if tonumber(anim) and anim ~= 0 then SafeWear(anim) end
        end

        MyLibrary:Notify({
            Title = "Sucesso",
            Message = "Avatar de " .. SelectedPlayerAvatar .. " copiado com sucesso!",
            Duration = 4
        })
    end
})

--==============================================================
-- 🚀 SEÇÃO: BOTÃO COPIAR AVATAR ROBLOX (perfil original)
--==============================================================
local BtnCopiarAvatarRoblox = Tab5:AddButton({
    Name = "Copiar Avatar Roblox",
    Callback = function()
        if not SelectedPlayerAvatar then
            MyLibrary:Notify({ Title = "Aviso", Message = "Nenhum jogador selecionado", Duration = 4 })
            return
        end

        local LChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local TPlayer = Players:FindFirstChild(SelectedPlayerAvatar)
        if not TPlayer then
            MyLibrary:Notify({ Title = "Erro", Message = "Jogador não encontrado", Duration = 4 })
            return
        end

        local LHumanoid = LChar:FindFirstChildOfClass("Humanoid")
        if not LHumanoid then
            MyLibrary:Notify({ Title = "Erro", Message = "Seu Humanoid não foi encontrado", Duration = 4 })
            return
        end

        -- 1. Puxar descrição via API da Roblox
        local success, PDesc = pcall(function()
            return Players:GetHumanoidDescriptionFromUserId(TPlayer.UserId)
        end)
        if not success or not PDesc then
            MyLibrary:Notify({ Title = "Erro", Message = "Não foi possível carregar o avatar original", Duration = 4 })
            return
        end

        local targetIDs = collectDescriptionIds(PDesc)
        local targetAccessories = PDesc:GetAccessories(true)

        -- 2. Reset com corpo escolhido
        loadBodyCode(_G.SelectedBodyType or "Corpo Normal")
        task.wait(4)

        -- 3. Equipar
        pcall(function()
            Remotes.ChangeCharacterBody:InvokeServer({
                PDesc.Torso, PDesc.RightArm, PDesc.LeftArm,
                PDesc.RightLeg, PDesc.LeftLeg, PDesc.Head
            })
        end)
        task.wait(0.5)

        if targetIDs[tonumber(PDesc.Shirt)] then SafeWear(PDesc.Shirt) end
        if targetIDs[tonumber(PDesc.Pants)] then SafeWear(PDesc.Pants) end
        if targetIDs[tonumber(PDesc.Face)]  then SafeWear(PDesc.Face)  end

        for _, acc in ipairs(targetAccessories) do
            if acc.AssetId then SafeWear(acc.AssetId) end
        end

        pcall(function()
            local skinBrickColor = BrickColor.new(PDesc.HeadColor)
            Remotes.ChangeBodyColor:FireServer(tostring(skinBrickColor))
        end)
        task.wait(0.3)

        local function RunRevision(revisionNumber)
            local LDesc = LHumanoid:GetAppliedDescription()
            local myEquipped = collectDescriptionIds(LDesc)
            for id in pairs(targetIDs) do
                if not myEquipped[id] then
                    SafeWear(id)
                end
            end
            return true
        end

        task.wait(1.5) RunRevision(2)
        task.wait(1.5) RunRevision(3)

        -- 4. Animações
        local Animations = {
            PDesc.IdleAnimation, PDesc.WalkAnimation, PDesc.RunAnimation,
            PDesc.JumpAnimation, PDesc.FallAnimation, PDesc.ClimbAnimation, PDesc.SwimAnimation
        }
        for _, anim in ipairs(Animations) do
            if tonumber(anim) and anim ~= 0 then SafeWear(anim) end
        end

        MyLibrary:Notify({
            Title = "Sucesso",
            Message = "Avatar Roblox de " .. SelectedPlayerAvatar .. " copiado!",
            Duration = 4
        })
    end
})

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SavePath = "saved_skins.json"

-- Estrutura inicial do arquivo JSON
local function GetDefaultData()
    return {
        LastSlot = 25, -- O próximo slot gerado será 26
        Skins = {}
    }
end

-- Carregar dados do JSON
local function LoadSkinsData()
    if isfile and isfile(SavePath) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(SavePath))
        end)
        if success and type(result) == "table" and result.Skins then
            return result
        end
    end
    return GetDefaultData()
end

-- Salvar dados no JSON
local function SaveSkinsData(data)
    if writefile then
        writefile(SavePath, HttpService:JSONEncode(data))
    end
end

-- Tabela em memória
local SkinData = LoadSkinsData()

-- Obter lista de nomes das skins salvas
local function GetSkinNames()
    local names = {}
    for name, _ in pairs(SkinData.Skins) do
        table.insert(names, name)
    end
    return names
end

Tab5:AddSection({ "skins instataneas" })

-- 1. TextBox para o Nome da Skin
local SkinNameInput = ""
Tab5:AddTextBox({
    Name = "Nome da Skin",
    Default = "",
    PlaceholderText = "Digite o nome aqui...",
    ClearTextOnFocus = false,
    Callback = function(Value)
        SkinNameInput = Value
    end
})

-- Variáveis de controle do Dropdown
local SelectedSkinName = ""
local SkinDropdown

-- 2. Dropdown com as Skins Salvas
SkinDropdown = Tab5:AddDropdown({
    Name = "Skins Salvas",
    Options = GetSkinNames(),
    Default = "",
    Callback = function(Value)
        SelectedSkinName = Value
    end
})

-- Função auxiliar para atualizar a lista do Dropdown
local function RefreshDropdown()
    local currentNames = GetSkinNames()
    if SkinDropdown and SkinDropdown.Set then
        SkinDropdown:Set(currentNames)
    end
end

-- 3. Botão para Salvar Skin
Tab5:AddButton({
    Name = "Salvar Skin",
    Callback = function()
        if SkinNameInput == "" then
            MyLibrary:Notify({
                Title = "Erro",
                Message = "Digite um nome para a skin!",
                Duration = 3
            })
            return
        end

        -- Impede o salvamento com nome duplicado
        if SkinData.Skins[SkinNameInput] then
            MyLibrary:Notify({
                Title = "Aviso",
                Message = "Já existe uma skin com esse nome!",
                Duration = 3
            })
            return
        end

        -- Gera o próximo slot sequencial
        SkinData.LastSlot = SkinData.LastSlot + 1
        local currentSlot = SkinData.LastSlot

        -- Chamada do Remote
        local args = {
            [1] = currentSlot,
            [2] = SkinNameInput
        }
        ReplicatedStorage.Remotes.SaveOutfit:InvokeServer(unpack(args))

        -- Salva no JSON
        SkinData.Skins[SkinNameInput] = currentSlot
        SaveSkinsData(SkinData)

        -- Atualiza o Dropdown
        RefreshDropdown()

        MyLibrary:Notify({
            Title = "Sucesso",
            Message = "Skin '" .. SkinNameInput .. "' salva com sucesso!",
            Duration = 3
        })
    end
})

-- 4. Botão para Carregar Skin Selecionada
Tab5:AddButton({
    Name = "Carregar Skin",
    Callback = function()
        if SelectedSkinName == "" or not SkinData.Skins[SelectedSkinName] then
            MyLibrary:Notify({
                Title = "Aviso",
                Message = "Selecione uma skin válida no Dropdown!",
                Duration = 3
            })
            return
        end

        local SlotToLoad = SkinData.Skins[SelectedSkinName]

        local args = {
            [1] = SlotToLoad
        }
        ReplicatedStorage.Remotes.LoadOutfit:InvokeServer(unpack(args))

        MyLibrary:Notify({
            Title = "Sucesso",
            Message = "Skin '" .. SelectedSkinName .. "' carregada!",
            Duration = 3
        })
    end
})

-- 5. Botão para Deletar Skin Selecionada
Tab5:AddButton({
    Name = "Deletar Skin",
    Callback = function()
        if SelectedSkinName == "" or not SkinData.Skins[SelectedSkinName] then
            MyLibrary:Notify({
                Title = "Aviso",
                Message = "Selecione uma skin para deletar!",
                Duration = 3
            })
            return
        end

        local DeletedName = SelectedSkinName

        -- Remove a skin da tabela local
        SkinData.Skins[SelectedSkinName] = nil
        SaveSkinsData(SkinData)

        SelectedSkinName = ""

        -- Atualiza o Dropdown
        RefreshDropdown()

        MyLibrary:Notify({
            Title = "Removido",
            Message = "Skin '" .. DeletedName .. "' foi deletada!",
            Duration = 3
        })
    end
})

--==============================================================
-- 💾 SEÇÃO: SKIN MANAGER
--==============================================================
Tab5:AddSection({ "Salva Skins" })

local FILE_NAME = "SAGAZxAvataLoad.json"

local Skins = {} -- { [NomeSkin] = { Body=..., Clothing=..., Accessories=..., Animations=... } }

-- ---------------------------------------------
-- Persistência
-- ---------------------------------------------
local function LoadFiles()
    if isfile(FILE_NAME) then
        local ok, result = pcall(function() return HttpService:JSONDecode(readfile(FILE_NAME)) end)
        Skins = (ok and type(result) == "table") and result or {}
    else
        writefile(FILE_NAME, "{}")
    end
end

local function SaveSkinsFile()
    writefile(FILE_NAME, HttpService:JSONEncode(Skins))
end

LoadFiles()

-- ---------------------------------------------
-- Helpers do Skin Manager
-- ---------------------------------------------
local function GetCurrentAvatarData()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum  = char:FindFirstChildOfClass("Humanoid")
    return extractAvatarData(hum, char)
end

local function GetAvatarDataFromPlayer(targetPlayer)
    if not targetPlayer then return nil end
    local char = targetPlayer.Character or targetPlayer.CharacterAdded:Wait()
    local hum  = char:FindFirstChildOfClass("Humanoid")
    return extractAvatarData(hum, char)
end

-- Aplicar uma skin salva (com 3 revisões + animações)
local function AplicarSkin(data)
    if not data then return end

    local LChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local LHumanoid = LChar:FindFirstChildOfClass("Humanoid")
    if not LHumanoid then return end

    local targetIDs = {}
    if data.Clothing then
        addId(targetIDs, data.Clothing.Shirt)
        addId(targetIDs, data.Clothing.Pants)
        addId(targetIDs, data.Clothing.Face)
    end
    if data.Accessories then
        for _, id in ipairs(data.Accessories) do addId(targetIDs, id) end
    end

    -- Reset com o corpo escolhido no Skin Manager
    loadBodyCode(_G.SelectedBodyTypeSkinManager or "Corpo Normal")
    task.wait(4)

    -- Corpo
    if data.Body then
        pcall(function()
            Remotes.ChangeCharacterBody:InvokeServer({
                data.Body.Torso, data.Body.RightArm, data.Body.LeftArm,
                data.Body.RightLeg, data.Body.LeftLeg, data.Body.Head
            })
        end)
        task.wait(0.5)
    end

    -- Roupas
    if data.Clothing then
        if targetIDs[tonumber(data.Clothing.Shirt)] then SafeWear(data.Clothing.Shirt) end
        if targetIDs[tonumber(data.Clothing.Pants)] then SafeWear(data.Clothing.Pants) end
        if targetIDs[tonumber(data.Clothing.Face)]  then SafeWear(data.Clothing.Face)  end
    end

    -- Acessórios
    if data.Accessories then
        for _, id in ipairs(data.Accessories) do SafeWear(id) end
    end

    -- Cor da pele
    if data.BodyColor then
        pcall(function()
            Remotes.ChangeBodyColor:FireServer(tostring(data.BodyColor))
        end)
        task.wait(0.3)
    end

    -- Revisão de roupas/acessórios
    local function RunRevision()
        local LDesc = LHumanoid:GetAppliedDescription()
        local myEquipped = collectDescriptionIds(LDesc)
        for id in pairs(targetIDs) do
            if not myEquipped[id] then SafeWear(id) end
        end
    end

    task.wait(1.5) RunRevision()
    task.wait(1.5) RunRevision()

    -- Animações + revisão
    if data.Animations then
        local animKeys = {"Idle", "Walk", "Run", "Jump", "Fall", "Climb", "Swim"}

        local function RunAnimRevision()
            local LDesc = LHumanoid:GetAppliedDescription()
            local current = {
                Idle  = LDesc.IdleAnimation,  Walk  = LDesc.WalkAnimation,
                Run   = LDesc.RunAnimation,   Jump  = LDesc.JumpAnimation,
                Fall  = LDesc.FallAnimation,  Climb = LDesc.ClimbAnimation,
                Swim  = LDesc.SwimAnimation
            }
            for _, key in ipairs(animKeys) do
                local saved   = tonumber(data.Animations[key])
                local curr    = tonumber(current[key])
                if saved and saved ~= 0 and saved ~= curr then
                    SafeWear(saved)
                end
            end
        end

        for _, key in ipairs(animKeys) do
            local animId = data.Animations[key]
            if tonumber(animId) and tonumber(animId) ~= 0 then SafeWear(animId) end
        end

        task.wait(1.5) RunAnimRevision()
        task.wait(1.5) RunAnimRevision()
    end

    MyLibrary:Notify({ Title = "Sucesso", Message = "Skin aplicada com sucesso!", Duration = 4 })
end

-- ---------------------------------------------
-- Helpers de dropdown
-- ---------------------------------------------
local function GetSkinList()
    local list = {}
    for name in pairs(Skins) do table.insert(list, name) end
    table.sort(list)
    return list
end

-- ---------------------------------------------
-- Variáveis de UI do Skin Manager
-- ---------------------------------------------
local SkinName     = ""
local SelectedSkin = nil

-- ---------------------------------------------
-- UI: TextBox + Dropdowns
-- ---------------------------------------------
local SkinManagerNameBox = Tab5:AddTextBox({
    Name = "Nome da Skin",
    PlaceholderText = "Digite o nome...",
    Callback = function(value) SkinName = value end
})

local SkinManagerSkinDropdown = Tab5:AddDropdown({
    Name = "Skins Salvas",
    Options = GetSkinList(),
    Callback = function(option) SelectedSkin = option end
})

local SkinManagerBodyTypeDropdown = Tab5:AddDropdown({
    Name = "Tipo de Corpo (Skin Manager)",
    Description = "Selecione o corpo base para carregar a skin",
    Options = BODY_OPTIONS,
    Default = "Corpo Normal",
    Flag = "body_type_dropdown_sm",
    Callback = function(Value)
        _G.SelectedBodyTypeSkinManager = Value
    end
})

-- Refresh helper (usando variável nomeada)
local function RefreshSkinDropdown()
    local newList = GetSkinList()
    if SkinManagerSkinDropdown.Set then
        SkinManagerSkinDropdown:Set(newList)
    elseif SkinManagerSkinDropdown.Refresh then
        SkinManagerSkinDropdown:Refresh(newList, true)
    end
    SelectedSkin = nil
end

--==============================================================
-- 🚀 SEÇÃO: BOTÕES DO SKIN MANAGER
--==============================================================

local BtnSalvarSkinPlayer = Tab5:AddButton({
    Name = "Salvar Skin do Player Selecionado",
    Callback = function()
        if not SelectedPlayerAvatar then
            MyLibrary:Notify({ Title = "Aviso", Message = "Nenhum player selecionado.", Duration = 4 })
            return
        end

        local targetPlayer = Players:FindFirstChild(SelectedPlayerAvatar)
        if not targetPlayer then
            MyLibrary:Notify({ Title = "Erro", Message = "Player não encontrado.", Duration = 4 })
            return
        end

        local PlayerData = GetAvatarDataFromPlayer(targetPlayer)
        if not PlayerData then
            MyLibrary:Notify({ Title = "Erro", Message = "Erro ao extrair skin.", Duration = 4 })
            return
        end

        local nomeLimpo = tostring(SkinName):gsub("^%s*(.-)%s*$", "%1")
        if nomeLimpo == "" then nomeLimpo = SelectedPlayerAvatar end

        Skins[nomeLimpo] = PlayerData
        SaveSkinsFile()
        RefreshSkinDropdown()
        MyLibrary:Notify({ Title = "Sucesso", Message = "Skin salva como: " .. nomeLimpo, Duration = 4 })
    end
})

local BtnSalvarSkin = Tab5:AddButton({
    Name = "Salvar Skin",
    Callback = function()
        local nomeLimpo = tostring(SkinName):gsub("^%s*(.-)%s*$", "%1")
        if nomeLimpo == "" then
            MyLibrary:Notify({ Title = "Aviso", Message = "Digite um nome na TextBox.", Duration = 4 })
            return
        end

        local CurrentData = GetCurrentAvatarData()
        if not CurrentData then return end

        Skins[nomeLimpo] = CurrentData
        SaveSkinsFile()
        RefreshSkinDropdown()
        MyLibrary:Notify({ Title = "Sucesso", Message = "Skin salva: " .. nomeLimpo, Duration = 4 })
    end
})

local BtnCarregarSkin = Tab5:AddButton({
    Name = "Carregar Skin Selecionada",
    Callback = function()
        if SelectedSkin and Skins[SelectedSkin] then
            AplicarSkin(Skins[SelectedSkin])
        else
            MyLibrary:Notify({ Title = "Aviso", Message = "Selecione uma skin na lista.", Duration = 4 })
        end
    end
})

local BtnSalvarSkinAtualNaSelecionada = Tab5:AddButton({
    Name = "Salvar Skin Atual na Opção Selecionada",
    Callback = function()
        if not SelectedSkin then
            MyLibrary:Notify({ Title = "Aviso", Message = "Selecione uma skin na Dropdown primeiro!", Duration = 4 })
            return
        end

        local CurrentData = GetCurrentAvatarData()
        if not CurrentData then return end

        Skins[SelectedSkin] = CurrentData
        SaveSkinsFile()
        MyLibrary:Notify({ Title = "Sucesso", Message = "Skin " .. SelectedSkin .. " atualizada!", Duration = 4 })
    end
})

local BtnDeletarSkin = Tab5:AddButton({
    Name = "Deletar Skin Selecionada",
    Callback = function()
        if SelectedSkin and Skins[SelectedSkin] then
            Skins[SelectedSkin] = nil
            SaveSkinsFile()
            SelectedSkin = nil
            RefreshSkinDropdown()
            MyLibrary:Notify({ Title = "Sucesso", Message = "Skin deletada.", Duration = 4 })
        else
            MyLibrary:Notify({ Title = "Aviso", Message = "Selecione uma skin para deletar.", Duration = 4 })
        end
    end
})

Tab5:AddSection({ " Animações Secretas" })

Tab5:AddButton({
    Name = "Mr. Toilet Idle ",
    Description = "",
    Callback = function()
        -- INSIRA O ID DA ANIMAÇÃO NO LUGAR DO NUMERO ABAIXO:
        local animId = 4418326547
        
        -- Executa o envio seguro para o servidor do jogo (Brookhaven)
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("Wear") then 
                remotes.Wear:InvokeServer(tonumber(animId)) 
                print("Animacao enviada com sucesso! ID:", animId)
            else
                warn("Remotes de customizacao nao encontrados no jogo.")
            end
        end)
    end
})

Tab5:AddButton({
    Name = "Mr. Toilet Run ",
    Description = "",
    Callback = function()
        -- INSIRA O ID DA ANIMAÇÃO NO LUGAR DO NUMERO ABAIXO:
        local animId = 4418324223
        
        -- Executa o envio seguro para o servidor do jogo (Brookhaven)
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("Wear") then 
                remotes.Wear:InvokeServer(tonumber(animId)) 
                print("Animacao enviada com sucesso! ID:", animId)
            else
                warn("Remotes de customizacao nao encontrados no jogo.")
            end
        end)
    end
})

Tab5:AddButton({
    Name = "Borock idle ",
    Description = "",
    Callback = function()
        -- INSIRA O ID DA ANIMAÇÃO NO LUGAR DO NUMERO ABAIXO:
        local animId = 3710007708
        
        -- Executa o envio seguro para o servidor do jogo (Brookhaven)
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("Wear") then 
                remotes.Wear:InvokeServer(tonumber(animId)) 
                print("Animacao enviada com sucesso! ID:", animId)
            else
                warn("Remotes de customizacao nao encontrados no jogo.")
            end
        end)
    end
})

Tab5:AddButton({
    Name = "R15 idle ",
    Description = "",
    Callback = function()
        -- INSIRA O ID DA ANIMAÇÃO NO LUGAR DO NUMERO ABAIXO:
        local animId = 4211409027
        
        -- Executa o envio seguro para o servidor do jogo (Brookhaven)
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("Wear") then 
                remotes.Wear:InvokeServer(tonumber(animId)) 
                print("Animacao enviada com sucesso! ID:", animId)
            else
                warn("Remotes de customizacao nao encontrados no jogo.")
            end
        end)
    end
})

Tab5:AddButton({
    Name = "Ud'zal idle ",
    Description = "",
    Callback = function()
        -- INSIRA O ID DA ANIMAÇÃO NO LUGAR DO NUMERO ABAIXO:
        local animId = 3307605825
        
        -- Executa o envio seguro para o servidor do jogo (Brookhaven)
        pcall(function()
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes and remotes:FindFirstChild("Wear") then 
                remotes.Wear:InvokeServer(tonumber(animId)) 
                print("Animacao enviada com sucesso! ID:", animId)
            else
                warn("Remotes de customizacao nao encontrados no jogo.")
            end
        end)
    end
})

do
    ----------------------------------------------------------------------------------------------------------------
    ----------------------------------------- Aba RGB -----------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------
    local RbgTab = Window:MakeTab({ Title = "| RGB", Icon = "rbxassetid://10734910187" })

    -- =========================================================
    -- SERVIÇOS E CONFIGURAÇÕES INICIAIS
    -- =========================================================
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer

    -- Tabela de Cores Padrão (RGB/HSV)
    local colorMap = {
        ["Vermelho"] = Color3.fromRGB(255, 0, 0),
        ["Verde"]    = Color3.fromRGB(0, 255, 0),
        ["Azul"]     = Color3.fromRGB(0, 0, 255),
        ["Amarelo"]  = Color3.fromRGB(255, 255, 0),
        ["Roxo"]     = Color3.fromRGB(128, 0, 128),
        ["Ciano"]    = Color3.fromRGB(0, 255, 255),
        ["Laranja"]  = Color3.fromRGB(255, 165, 0),
        ["Rosa"]     = Color3.fromRGB(255, 192, 203),
        ["Branco"]   = Color3.fromRGB(255, 255, 255)
    }

    local colorList = {"RGB", "Vermelho", "Verde", "Azul", "Amarelo", "Roxo", "Ciano", "Laranja", "Rosa", "Branco"}

    local bodyColors = {
        "Pastel brown", "Pastel yellow", "Pastel blue", "Pastel green", "Pastel pink",
        "Really red", "Bright orange", "Bright blue", "Bright violet", "Bright green",
        "Bright yellow", "White", "Black", "Dark stone grey", "Medium stone grey",
        "Light stone grey", "Bright red", "Bright yellowish green", "Bright bluish green",
        "Bright purple", "Bright pink", "Reddish brown", "Earth green", "Sand red",
        "Sand blue", "Sand green", "Dark green", "Navy blue", "Toothpaste", "Cyan",
        "Hot pink", "Crimson", "Royal purple", "Neon orange", "Neon green", "Neon pink",
        "Neon blue", "Gold", "Bright gold", "New Yeller", "Dark orange", "Deep blue",
        "Maroon", "Bright maroon"
    }

    -- Controllers e Remotes
    local WearingController = require(ReplicatedStorage.Modules.Client.AvatarEditor.WearingController)
    local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
    local ChangeBodyColor = Remotes and Remotes:WaitForChild("ChangeBodyColor", 5)

    -- Estados Globais da Aba
    local effectSpeed = 5
    local selectedColor = "RGB"
    local selectedTarget = "Nome e Bio"
    local isEffectActive = false

    local pulseSpeed = 5
    local selectedPalette = "RGB"

    -- Estados dos Toggles
    local toolActive = false
    local houseActive = false
    local houseTextActive = false
    local vehicleActive = false
    local carActive = false
    local bodyActive = false
    local hairActive = false
    local accessoriesActive = false

    -- =========================================================
    -- FUNÇÕES DE SUPORTE
    -- =========================================================
    local function fireServer(eventName, args)
        local event = ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild(eventName)
        if event then
            pcall(function()
                event:FireServer(unpack(args))
            end)
        end
    end

    local function applyColor(color)
        if selectedTarget == "Nome" or selectedTarget == "Nome e Bio" then
            fireServer("1RPNam1eColo1r", { "PickingRPNameColor", color })
        end
        if selectedTarget == "Bio" or selectedTarget == "Nome e Bio" then
            fireServer("1RPNam1eColo1r", { "PickingRPBioColor", color })
        end
    end

    local function calculateDynamicColor(tickCounter)
        local brightness = 0.25 + (math.sin(tickCounter) + 1) * 0.375

        if selectedPalette == "RGB" then
            local hue = (tickCounter * 0.1) % 1
            return Color3.fromHSV(hue, 1, brightness)
        else
            local baseColor = colorMap[selectedPalette] or Color3.fromRGB(255, 255, 255)
            local h, s, _ = baseColor:ToHSV()
            return Color3.fromHSV(h, s, brightness)
        end
    end

    local function getCarColorRemote()
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if not playerGui then return nil end

        local mainGui = playerGui:FindFirstChild("MainGUIHandler")
        if not mainGui then return nil end

        local vehicleControl = mainGui:FindFirstChild("VehicleControl")
        if not vehicleControl then return nil end

        local colorPicker = vehicleControl:FindFirstChild("UIColorPicker")
        if not colorPicker then return nil end

        return colorPicker:FindFirstChild("SetColor")
    end

    local function MudarCorDoCabelo(novaCor)
        local character = LocalPlayer.Character
        if not character then return end

        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Accessory") and child.AccessoryType == Enum.AccessoryType.Hair then
                local assetId = child:GetAttribute("AssetId") or child:GetAttribute("AcessoryId")
                if assetId then
                    pcall(function()
                        WearingController.SetAccessoryColor(assetId, novaCor)
                    end)
                end
            end
        end
    end

    local function MudarCorDeTodosOsAcessorios(novaCor)
        local character = LocalPlayer.Character
        if not character then return end

        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Accessory") then
                local assetId = child:GetAttribute("AssetId") or child:GetAttribute("AcessoryId")
                if assetId then
                    pcall(function()
                        WearingController.SetAccessoryColor(assetId, novaCor)
                    end)
                end
            end
        end
    end

    local function getSetColorRemote()
        local toolGui = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("ToolGui")
        if not toolGui then return nil end

        local toolSettings = toolGui:FindFirstChild("ToolSettings")
        if not toolSettings then return nil end

        local settings = toolSettings:FindFirstChild("Settings")
        if not settings then return nil end

        local propsColor = settings:FindFirstChild("PropsColor")
        if not propsColor then return nil end

        return propsColor:FindFirstChild("SetColor")
    end

    local function updateHouseColor(targetColor)
        pcall(function()
            local userGui = LocalPlayer:FindFirstChild("PlayerGui")
            if userGui then
                local settingsModule = userGui:FindFirstChild("Player8Handler") and userGui.Player8Handler:FindFirstChild("Game8Settings")
                if settingsModule then
                    local settingsData = require(settingsModule)
                    local colorKey = settingsData.PickingHouseColor
                    local houseRemote = settingsData.PlayersHouse
                    if houseRemote and colorKey then
                        houseRemote:FireServer(colorKey, targetColor)
                    end
                end
            end
            
            local hasPackages, packageRemotes = pcall(function() 
                return require(ReplicatedStorage.Packages.Remotes) 
            end)
            if hasPackages and packageRemotes and packageRemotes.fireServer then
                packageRemotes.fireServer("Property:SetColor", targetColor)
            end
        end)
    end

    local function fireVehicleServer(eventName, args)
        local event = ReplicatedStorage:FindFirstChild("RE")
        if event and event:FindFirstChild(eventName) then
            pcall(function()
                event[eventName]:FireServer(unpack(args))
            end)
        end
    end

    -- =========================================================
    -- CONFIGURAÇÕES DO EFEITO LENTO (NOME E BIO)
    -- =========================================================
    RbgTab:AddSection({"Configurações do Efeito Lento"})

    RbgTab:AddSlider({
        Name = "Velocidade do Efeito",
        Min = 5,
        Max = 30,
        Increase = 1,
        Default = 5,
        Callback = function(value)
            effectSpeed = value
        end
    })

    RbgTab:AddDropdown({
        Name = "Cor",
        Options = colorList,
        Default = "RGB",
        Callback = function(option)
            selectedColor = option
        end
    })

    RbgTab:AddDropdown({
        Name = "Local",
        Options = {"Nome", "Bio", "Nome e Bio"},
        Default = "Nome e Bio",
        Callback = function(option)
            selectedTarget = option
        end
    })

    RbgTab:AddToggle({
        Name = "Nome/Bio RGB",
        Description = "",
        Default = false,
        Callback = function(state)
            isEffectActive = state
            if state then
                task.spawn(function()
                    local timeOffset = 0
                    local goingDark = true

                    while isEffectActive and LocalPlayer.Character do
                        local waitTime = math.clamp(0.25 - (effectSpeed * 0.02), 0.03, 0.25)
                        local step = 0.02 * (effectSpeed / 2)

                        if selectedColor == "RGB" then
                            local hue = (timeOffset % 1)
                            local brightness = goingDark and (1 - (timeOffset % 1)) or (timeOffset % 1)
                            brightness = math.clamp(brightness, 0.1, 1)

                            applyColor(Color3.fromHSV(hue, 1, brightness))
                            timeOffset = timeOffset + step

                            if timeOffset >= 1 then
                                timeOffset = 0
                                goingDark = not goingDark
                            end
                        else
                            local baseColor = colorMap[selectedColor] or Color3.fromRGB(255, 255, 255)
                            local h, s, _ = baseColor:ToHSV()

                            local brightness = goingDark and (1 - (timeOffset % 1)) or (timeOffset % 1)
                            brightness = math.clamp(brightness, 0.15, 1)

                            applyColor(Color3.fromHSV(h, s, brightness))
                            timeOffset = timeOffset + step

                            if timeOffset >= 1 then
                                timeOffset = 0
                                goingDark = not goingDark
                            end
                        end

                        task.wait(waitTime)
                    end
                end)
            end
        end
    })

    -- =========================================================
    -- CONFIGURAÇÕES GERAIS (PULSE SPEED & PALETA)
    -- =========================================================
    RbgTab:AddSection({"OUTROS"})

    RbgTab:AddSlider({
        Name = "Velocidade do Efeito",
        Min = 5,
        Max = 30,
        Increase = 1,
        Default = 5,
        Callback = function(val)
            pulseSpeed = val
        end
    })

    RbgTab:AddDropdown({
        Name = "Seleção de Cor",
        Options = colorList,
        Default = "RGB",
        Callback = function(choice)
            selectedPalette = choice
        end
    })

    -- =========================================================
    -- TOGGLES DE EFEITOS RGB
    -- =========================================================
    RbgTab:AddSection({"RGB Em Tools"})

    RbgTab:AddToggle({
        Name = "Tools RGB",
        Description = "Aplicar RGB Em Todos os Tools",
        Default = false,
        Callback = function(enabled)
            toolActive = enabled
            if enabled then
                task.spawn(function()
                    local tickCounter = 0
                    while toolActive do
                        local delayTime = math.clamp(0.12 - (pulseSpeed * 0.003), 0.015, 0.12)
                        local step = 0.04 * (pulseSpeed / 5)

                        tickCounter = tickCounter + step
                        local currentColor = calculateDynamicColor(tickCounter)
                        
                        local setColor = getSetColorRemote()
                        if setColor then
                            pcall(function()
                                setColor:FireServer(currentColor)
                            end)
                        end

                        task.wait(delayTime)
                    end
                end)
            end
        end
    })

    RbgTab:AddSection({"RGB Em Casas"})

    RbgTab:AddToggle({
        Name = "Casa RGB",
        Description = "",
        Default = false,
        Callback = function(enabled)
            houseActive = enabled
            if enabled then
                task.spawn(function()
                    local tickCounter = 0
                    while houseActive do
                        local delayTime = math.clamp(0.12 - (pulseSpeed * 0.003), 0.015, 0.12)
                        local step = 0.04 * (pulseSpeed / 5)
                        
                        tickCounter = tickCounter + step
                        updateHouseColor(calculateDynamicColor(tickCounter))
                        
                        task.wait(delayTime)
                    end
                end)
            end
        end
    })

    RbgTab:AddToggle({
        Name = "Texto Da Casa RGB",
        Description = "",
        Default = false,
        Callback = function(enabled)
            houseTextActive = enabled
            if enabled then
                task.spawn(function()
                    local tickCounter = 0
                    while houseTextActive do
                        local delayTime = math.clamp(0.12 - (pulseSpeed * 0.003), 0.015, 0.12)
                        local step = 0.04 * (pulseSpeed / 5)
                        
                        tickCounter = tickCounter + step
                        fireVehicleServer("1RPHous1eEven1tColo1r", {
                            "PickingBusinessNameColor",
                            calculateDynamicColor(tickCounter)
                        })
                        
                        task.wait(delayTime)
                    end
                end)
            end
        end
    })

    RbgTab:AddSection({"RGB Em Veículos"})

    RbgTab:AddToggle({
        Name = "Veículo Sem Motor RGB",
        Description = "",
        Default = false,
        Callback = function(enabled)
            vehicleActive = enabled
            if enabled then
                task.spawn(function()
                    local tickCounter = 0
                    while vehicleActive do
                        local delayTime = math.clamp(0.12 - (pulseSpeed * 0.003), 0.015, 0.12)
                        local step = 0.04 * (pulseSpeed / 5)
                        
                        tickCounter = tickCounter + step
                        fireVehicleServer("1Player1sCa1r", {
                            "NoMotorColor",
                            calculateDynamicColor(tickCounter)
                        })
                        
                        task.wait(delayTime)
                    end
                end)
            end
        end
    })

    RbgTab:AddToggle({
        Name = "Carro RGB",
        Description = "Tem Que Estar Sentado No Carro",
        Default = false,
        Callback = function(enabled)
            carActive = enabled
            if enabled then
                task.spawn(function()
                    local tickCounter = 0
                    while carActive do
                        local delayTime = math.clamp(0.12 - (pulseSpeed * 0.003), 0.015, 0.12)
                        local step = 0.04 * (pulseSpeed / 5)

                        tickCounter = tickCounter + step
                        local currentColor = calculateDynamicColor(tickCounter)
                        
                        local carRemote = getCarColorRemote()
                        if carRemote then
                            pcall(function()
                                carRemote:FireServer(currentColor)
                            end)
                        end

                        task.wait(delayTime)
                    end
                end)
            end
        end
    })
    
RbgTab:AddSection({"RGB Em Pets e Kids"})

local kidsActive = false
RbgTab:AddToggle({
    Name = "RGB Kids",
    Default = false,
    Callback = function(enabled)
        kidsActive = enabled
        if enabled then
            task.spawn(function()
                local player = game:GetService("Players").LocalPlayer
                
                -- Localiza a pasta/frame com os itens de cor
                local playerGui = player:FindFirstChild("PlayerGui")
                local noReset = playerGui and playerGui:FindFirstChild("NoResetGUIHandler")
                local petsMenu = noReset and noReset:FindFirstChild("PetsKidsMenu")
                local catalog = petsMenu and petsMenu:FindFirstChild("Catalog")
                local container = catalog and catalog:FindFirstChild("Container")
                local scrollingFrame = container and container:FindFirstChild("ScrollingFrameKid2")
                local frame = scrollingFrame and scrollingFrame:FindFirstChild("Frame")

                -- Tenta obter o Remote do Game8Settings
                local remote = nil
                pcall(function()
                    local StarterGui = game:GetService("StarterGui")
                    local gameSettings = StarterGui:FindFirstChild("Player8Handler") and StarterGui.Player8Handler:FindFirstChild("Game8Settings")
                    if gameSettings then
                        local settingsData = require(gameSettings)
                        remote = settingsData.RPNameColorRemote
                    end
                end)

                if frame and remote then
                    -- Coleta os objetos de cor válidos (filtrando "Institutional white")
                    local listaObjetosCor = {}
                    for _, item in ipairs(frame:GetChildren()) do
                        if item.Name == "FollowColor" then
                            local objetoCor = item:FindFirstChild("Color")
                            if objetoCor and objetoCor.Value ~= "Institutional white" and objetoCor.Name ~= "Institutional white" then
                                table.insert(listaObjetosCor, objetoCor)
                            end
                        end
                    end

                    -- Loop de execução
                    while kidsActive and #listaObjetosCor > 0 do
                        for _, objetoCor in ipairs(listaObjetosCor) do
                            if not kidsActive then break end
                            
                            pcall(function()
                                remote:FireServer("PickingRPFollowColor", objetoCor)
                            end)

                            -- Delay dinâmico baseado na velocidade do slider
                            local dynamicWait = math.clamp(0.5 / (pulseSpeed / 5), 0.05, 0.5)
                            task.wait(dynamicWait)
                        end
                    end
                end
            end)
        end
    end
})

local petsActive = false
RbgTab:AddToggle({
    Name = "RGB Pets",
    Default = false,
    Callback = function(enabled)
        petsActive = enabled
        if enabled then
            task.spawn(function()
                local player = game:GetService("Players").LocalPlayer
                
                -- Localiza a pasta/frame com os itens de cor dos pets
                local playerGui = player:FindFirstChild("PlayerGui")
                local noReset = playerGui and playerGui:FindFirstChild("NoResetGUIHandler")
                local petsMenu = noReset and noReset:FindFirstChild("PetsKidsMenu")
                local catalog = petsMenu and petsMenu:FindFirstChild("Catalog")
                local container = catalog and catalog:FindFirstChild("Container")
                local scrollingFrame = container and container:FindFirstChild("ScrollingFramePet2")
                local frame = scrollingFrame and scrollingFrame:FindFirstChild("Frame")

                -- Tenta carregar o módulo de Remotes
                local hasPackages, Remotes = pcall(function()
                    return require(ReplicatedStorage.Packages.Remotes)
                end)

                if frame and hasPackages and Remotes and Remotes.fireServer then
                    -- Coleta as cores válidas (filtrando "Institutional white")
                    local listaCores = {}
                    for _, item in ipairs(frame:GetChildren()) do
                        if item.Name == "FollowColor" then
                            local colorObj = item:FindFirstChild("Color")
                            if colorObj and colorObj:IsA("StringValue") and colorObj.Value ~= "Institutional white" then
                                table.insert(listaCores, colorObj.Value)
                            end
                        end
                    end

                    -- Loop de execução
                    while petsActive and #listaCores > 0 do
                        for _, nomeCor in ipairs(listaCores) do
                            if not petsActive then break end
                            
                            pcall(function()
                                Remotes.fireServer("Pet_SetNameColor", nomeCor)
                            end)

                            -- Delay dinâmico baseado na velocidade do slider
                            local dynamicWait = math.clamp(0.5 / (pulseSpeed / 5), 0.05, 0.5)
                            task.wait(dynamicWait)
                        end
                    end
                end
            end)
        end
    end
})

 RbgTab:AddSection({"RGB Em Você"})

    RbgTab:AddToggle({
        Name = "Corpo RGB",
        Description = "",
        Default = false,
        Callback = function(enabled)
            bodyActive = enabled
            if enabled and ChangeBodyColor then
                task.spawn(function()
                    while bodyActive do
                        for _, colorName in ipairs(bodyColors) do
                            if not bodyActive then break end
                            pcall(function()
                                ChangeBodyColor:FireServer(colorName)
                            end)
                            local dynamicWait = math.clamp(0.3 / (pulseSpeed / 5), 0.05, 0.5)
                            task.wait(dynamicWait)
                        end
                    end
                end)
            end
        end
    })

    RbgTab:AddToggle({
        Name = "Cabelo RGB",
        Description = "",
        Default = false,
        Callback = function(enabled)
            hairActive = enabled
            if enabled then
                task.spawn(function()
                    local tickCounter = 0
                    while hairActive do
                        local delayTime = math.clamp(0.12 - (pulseSpeed * 0.003), 0.015, 0.12)
                        local step = 0.04 * (pulseSpeed / 5)
                        
                        tickCounter = tickCounter + step
                        MudarCorDoCabelo(calculateDynamicColor(tickCounter))
                        
                        task.wait(delayTime)
                    end
                end)
            end
        end
    })

    RbgTab:AddToggle({
        Name = "Acessórios RGB",
        Description = "",
        Default = false,
        Callback = function(enabled)
            accessoriesActive = enabled
            if enabled then
                task.spawn(function()
                    local tickCounter = 0
                    while accessoriesActive do
                        local delayTime = math.clamp(0.12 - (pulseSpeed * 0.003), 0.015, 0.12)
                        local step = 0.04 * (pulseSpeed / 5)
                        
                        tickCounter = tickCounter + step
                        MudarCorDeTodosOsAcessorios(calculateDynamicColor(tickCounter))
                        
                        task.wait(delayTime)
                    end
                end)
            end
        end
    })
end

----------------------------------------------------------------------------------------------------------------
-----------------------------------------Aba Casas---------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
local Tab6= Window:MakeTab({ "| Casas", "home" })

Tab6:AddSection({ "Remover ban" })

--==============================================================
-- 🚫 SEÇÃO: BAN REMOVER
--==============================================================

local function RemoveAllBannedBlocks()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name:match("^BannedBlock") then
            pcall(function()
                obj:Destroy()
            end)
        end
    end
end

Tab6:AddButton({
    Name = "Remover Ban",
    Description = "Remove ban de todas as casas",
    Callback = function()
        RemoveAllBannedBlocks()
    end
})

Tab6:AddToggle({
    Name = "Auto Remove Ban",
    Description = "Remove ban automaticamente",
    Default = false,
    Callback = function(Value)
        getgenv().AutoRemoveBan = Value

        if Value then
            task.spawn(function()
                while getgenv().AutoRemoveBan do
                    RemoveAllBannedBlocks()
                    task.wait(1)
                end
            end)
        end
    end
})

Tab6:AddSection({ "Banir Jogadores da Sua Casa" })

do -- ESCOPO ISOLADO
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- Variáveis de controle totalmente privadas deste bloco
    local listaDisponiveis = {}
    local listaSalvos = {}

    local selecionadoDropdown1 = nil
    local selecionadoDropdown2 = nil
    local banirListaAtivo = false
    local banirTodosAtivo = false

    -- Coleta os players iniciais
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(listaDisponiveis, player.Name)
        end
    end

    -- Declaração local dos elementos
    local Dropdown1 = nil
    local Dropdown2 = nil

    -- Atualizado para usar o método :Refresh com a Opção 2
    local function atualizarInterfaces()
        if Dropdown1 then Dropdown1:Refresh(listaDisponiveis) end
        if Dropdown2 then Dropdown2:Refresh(listaSalvos) end
    end

    local function reiniciarListas()
        listaDisponiveis = {}
        listaSalvos = {}
        selecionadoDropdown1 = nil
        selecionadoDropdown2 = nil
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                table.insert(listaDisponiveis, player.Name)
            end
        end
        atualizarInterfaces()
    end

    -- 🎯 DROPDOWN 1: SELECIONAR JOGADORES
    Dropdown1 = Tab6:AddDropdownPlayer({
        Name = "Selecionar Jogador",
        Options = listaDisponiveis,
        AutoSelect = false,
        Default = "...",
        Callback = function(Value)
            if Value and Value ~= "..." and Value ~= "Selecionar Jogador" then
                selecionadoDropdown1 = Value
                
                for i, nome in ipairs(listaDisponiveis) do
                    if nome == selecionadoDropdown1 then
                        table.remove(listaDisponiveis, i)
                        break
                    end
                end
                
                table.insert(listaSalvos, selecionadoDropdown1)
                selecionadoDropdown1 = nil
                atualizarInterfaces()
            end
        end
    })

    -- 🎯 DROPDOWN 2: LISTA DE JOGADORES SALVOS
    Dropdown2 = Tab6:AddDropdownPlayer({
        Name = "Jogadores na Lista",
        Options = listaSalvos,
        Default = "...",
        AutoSelect = false,
        Callback = function(Value)
            if Value and Value ~= "..." and Value ~= "Jogadores na Lista" then
                selecionadoDropdown2 = Value
            end
        end
    })

    -- 🛑 BOTÃO: REMOVER PLAYER SELECIONADO DA LISTA
    Tab6:AddButton({
        Name = "Remover player selecionado da lista",
        Callback = function()
            if selecionadoDropdown2 and selecionadoDropdown2 ~= "..." then
                for i, nome in ipairs(listaSalvos) do
                    if nome == selecionadoDropdown2 then
                        table.remove(listaSalvos, i)
                        break
                    end
                end
                
                table.insert(listaDisponiveis, selecionadoDropdown2)
                selecionadoDropdown2 = nil
                atualizarInterfaces()
            end
        end
    })

    -- 🧹 BOTÃO: REMOVER TODOS OS PLAYERS DA LISTA
    Tab6:AddButton({
        Name = "Remover todos os players da lista",
        Callback = function()
            reiniciarListas()
        end
    })

    -- ⚡ TOGGLE: BANIR JOGADORES DA LISTA
    Tab6:AddToggle({
        Name = "Banir jogadores da lista",
        Description = "Bane da Casa Apenas Quem Estiver Adicionado na Lista",
        Default = false,
        Callback = function(state)
            banirListaAtivo = state

            task.spawn(function()
                while banirListaAtivo do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            local naLista = false
                            for _, nomeSalvo in ipairs(listaSalvos) do
                                if player.Name == nomeSalvo then
                                    naLista = true
                                    break
                                end
                            end
                            
                            if naLista then
                                local lots = workspace:FindFirstChild("001_Lots")
                                if lots then
                                    for _, casa in pairs(lots:GetChildren()) do
                                        local permissao = casa:FindFirstChild("HousePickedByPlayer")
                                            and casa.HousePickedByPlayer:FindFirstChild("HouseModel")
                                            and casa.HousePickedByPlayer.HouseModel:FindFirstChild("Permissions:Disallow")

                                        if permissao then
                                            permissao:FireServer(player)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    })

    -- ⚡ TOGGLE: BANIR TODOS OS JOGADORES DA CASA (Menos os da lista)
    Tab6:AddToggle({
        Name = "Banir Todos os Jogadores da Casa",
        Description = "Bane todos do servidor exceto quem estiver na lista",
        Default = false,
        Callback = function(state)
            banirTodosAtivo = state

            task.spawn(function()
                while banirTodosAtivo do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            local estaProtegido = false
                            for _, nomeSalvo in ipairs(listaSalvos) do
                                if player.Name == nomeSalvo then
                                    estaProtegido = true
                                    break
                                end
                            end
                            
                            if not estaProtegido then
                                local lots = workspace:FindFirstChild("001_Lots")
                                if lots then
                                    for _, casa in pairs(lots:GetChildren()) do
                                        local permissao = casa:FindFirstChild("HousePickedByPlayer")
                                            and casa.HousePickedByPlayer:FindFirstChild("HouseModel")
                                            and casa.HousePickedByPlayer.HouseModel:FindFirstChild("Permissions:Disallow")

                                        if permissao then
                                            permissao:FireServer(player)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    })

    -- 🛠️ EVENTOS DE CONEXÃO E LIMPEZA
    Players.PlayerAdded:Connect(function(player)
        task.wait(0.5)
        local jaExiste = false
        for _, nome in ipairs(listaSalvos) do
            if nome == player.Name then jaExiste = true break end
        end
        for _, nome in ipairs(listaDisponiveis) do
            if nome == player.Name then jaExiste = true break end
        end
        
        if not jaExiste and player ~= LocalPlayer then
            table.insert(listaDisponiveis, player.Name)
            atualizarInterfaces()
        end
    end)

    Players.PlayerRemoving:Connect(function(player)
        for i, nome in ipairs(listaDisponiveis) do
            if nome == player.Name then table.remove(listaDisponiveis, i) break end
        end
        for i, nome in ipairs(listaSalvos) do
            if nome == player.Name then table.remove(listaSalvos, i) break end
        end
        
        if selecionadoDropdown2 == player.Name then
            selecionadoDropdown2 = nil
        end
        atualizarInterfaces()
    end)
end


Tab6:AddSection({ "Casas" })

local SelectHouse = nil
local NoclipDoor  = nil
local HouseDropdown

local Lots = workspace:WaitForChild("001_Lots")

-- Função para pegar casas
local function getHouseList()
    local Tabela = {}
    for _, House in ipairs(Lots:GetChildren()) do
        if House:IsA("Model") and House.Name ~= "For Sale" then
            table.insert(Tabela, House.Name)
        end
    end
    return Tabela
end

-- Criar dropdown uma única vez
HouseDropdown = Tab6:AddDropdown({
    Name = "Selecione a Casa",
    Options = getHouseList(),
    Default = "...",
    Callback = function(Value)
        SelectHouse = Value
        if NoclipDoor then
            NoclipDoor:Set(false)
        end
    end
})

-- Função de update
local function UpdateHouseDropdown()
    if not HouseDropdown then return end
    local newList = getHouseList()
    if HouseDropdown.Refresh then
        HouseDropdown:Refresh(newList)
    elseif HouseDropdown.Set then
        HouseDropdown:Set(newList)
    end
end

-- AUTO UPDATE 🔁
Lots.ChildAdded:Connect(function()
    task.wait(0.3)
    UpdateHouseDropdown()
end)

Lots.ChildRemoved:Connect(function()
    task.wait(0.3)
    UpdateHouseDropdown()
end)

-- Botão para teleportar para casa
pcall(function()
    Tab6:AddButton({
        Name = "Teleportar para Casa",
        Callback = function()
            local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
            if House and game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(House.WorldPivot.Position)
            else
                print("Casa não encontrada: " .. tostring(SelectHouse))
            end
        end
    })
end)

-- Botão para teleportar para cofre
pcall(function()
    Tab6:AddButton({
        Name = "Teleportar para Cofre",
        Callback = function()
            local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
            if House and House:FindFirstChild("HousePickedByPlayer") and game.Players.LocalPlayer.Character then
                local safe = House.HousePickedByPlayer.HouseModel:FindFirstChild("001_Safe")
                if safe then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(safe.WorldPivot.Position)
                else
                    print("Cofre não encontrado na casa: " .. tostring(SelectHouse))
                end
            else
                print("Casa não encontrada: " .. tostring(SelectHouse))
            end
        end
    })
end)

-- Toggle para bater na porta
pcall(function()
    Tab6:AddToggle({
        Name = "Bater na Porta loop",
        Description = "Em algumas casas nao fuciona",
        Default = false,
        Callback = function(Value)
            getgenv().ChaosHubAutoSpawnDoorValue = Value
            spawn(function()
                while getgenv().ChaosHubAutoSpawnDoorValue do
                    local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
                    if House and House:FindFirstChild("HousePickedByPlayer") then
                        local doors = House.HousePickedByPlayer.HouseModel:FindFirstChild("001_HouseDoors")
                        if doors and doors:FindFirstChild("HouseDoorFront") and doors.HouseDoorFront:FindFirstChild("Knock") then
                            pcall(function()
                                fireclickdetector(doors.HouseDoorFront.Knock.TouchBell.ClickDetector)
                            end)
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    })
end)
---------------------------------------------------------------------------------------------------------------------------------
                                          -- === Tab7 Carros=== --
---------------------------------------------------------------------------------------------------------------------------------

local Tab7= Window:MakeTab({ "| Carros", "car" })

local carSpeed = 25
local turboValue = "25"

Tab7:AddTextBox({
    Name = "Velocidade do carro",
    Description = "Digite a Velocidade",
    PlaceholderText = "Digite o valor da Velocidade...",
    Callback = function(Value)
		carSpeed = tonumber(Value) or carSpeed
    end
})

Tab7:AddTextBox({
    Name = "Definir Turbo",
    Description = "Defina o Turbo",
    PlaceholderText = "Digite o valor do Turbo...",
    Callback = function(Value)
        turboValue = tostring(Value)
    end
})

Tab7:AddButton({
	Name = "Mudar Velocidade e Turbo",
	Callback = function()
			local vehicles = workspace:FindFirstChild("Vehicles")
		local car = vehicles and vehicles:FindFirstChild(LocalPlayer.Name .. "Car")
		local seatsFolder = car and car:FindFirstChild("Seats")
		local seatInSeats = seatsFolder and seatsFolder:FindFirstChild("VehicleSeat")
		if seatInSeats then
			local maxSpeed = seatInSeats:FindFirstChild("MaxSpeed")
			if maxSpeed and maxSpeed:IsA("NumberValue") then
				maxSpeed.Value = carSpeed
			end

			local turbo = seatInSeats:FindFirstChild("Turbo")
			if turbo and turbo:IsA("StringValue") then
				turbo.Value = turboValue
			end
		end

		local bodyFolder = car and car:FindFirstChild("Body")
		local seatInBody = bodyFolder and bodyFolder:FindFirstChild("VehicleSeat")
		if seatInBody then
			local topSpeed = seatInBody:FindFirstChild("TopSpeed")
			if topSpeed and topSpeed:IsA("NumberValue") then
				topSpeed.Value = carSpeed
			end

			local turbo = seatInBody:FindFirstChild("Turbo")
			if turbo and turbo:IsA("StringValue") then
				turbo.Value = turboValue
			end
		end
        
	end
})

Tab7:AddSection({ "Seleciona o Carrosl" })

local function updateVehicleList()
    local novaTabela = {}
    for _, v in pairs(game.Workspace.Vehicles:GetChildren()) do
        table.insert(novaTabela, v.Name)
    end
    return novaTabela
end

local selectedVehicle = nil

local CarrosTT = Tab7:AddDropdown({
    Name = "Selecionar Carro",
    Options = updateVehicleList(),
    Default = nil,
    Callback = function(Value)
        selectedVehicle = Value
    end
})

Tab7:AddButton({
    Name = "Atualiza Lista",
    Callback = function()
        CarrosTT:Set(updateVehicleList())
    end
})

Tab7:AddToggle({
    Name = "Ver Camera do Carro Selecionado",
    Description = "Foca a camera no carro selecionado",
    Default = false,
    Callback = function(state)
        local camera = workspace.CurrentCamera

        if state then
            if not selectedVehicle or selectedVehicle == "" then
                warn("Nenhum carro selecionado!")
                return
            end

            local vehiclesFolder = workspace:FindFirstChild("Vehicles")
            if not vehiclesFolder then
                warn("Pasta Vehicles não encontrada!")
                return
            end

            local vehicle = vehiclesFolder:FindFirstChild(selectedVehicle)
            if not vehicle then
                warn("Carro não encontrado!")
                return
            end

            local vehicleSeat = vehicle:FindFirstChildWhichIsA("VehicleSeat", true)
            if not vehicleSeat then
                warn("VehicleSeat não encontrado!")
                return
            end

            -- Salva estado original
            _G.OriginalCameraSubject = camera.CameraSubject
            _G.OriginalCameraType = camera.CameraType

            -- Ajusta câmera
            camera.CameraSubject = vehicleSeat
            camera.CameraType = Enum.CameraType.Follow

        else
            -- Restaura câmera
            if _G.OriginalCameraSubject then
                camera.CameraSubject = _G.OriginalCameraSubject
                camera.CameraType = _G.OriginalCameraType or Enum.CameraType.Custom

                _G.OriginalCameraSubject = nil
                _G.OriginalCameraType = nil
            end
        end
    end
})

Tab7:AddButton({
    Name = "Teleporta ao asento",
    Callback = function()
        local pl = game.Players.LocalPlayer
        local character = pl.Character or pl.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")

        if selectedVehicle then
            local vehicle = workspace.Vehicles:FindFirstChild(selectedVehicle)
            if vehicle and vehicle:FindFirstChild("Body") then
                local body = vehicle.Body
                local destino = nil
                if body:FindFirstChild("VehicleSeat") then
                    destino = body.VehicleSeat
                elseif body:FindFirstChild("CarSeatPosition") then
                    destino = body.CarSeatPosition
                elseif body:FindFirstChild("Passenger") then
                    destino = body.Passenger
                end
                if destino and destino:IsA("BasePart") then
                    root.CFrame = destino.CFrame + Vector3.new(0, 3, 0)
                end
            end
        end
    end
})

Tab7:AddToggle({
    Name = "Puxar Carro",
    Default = false,
    Callback = function(Value)
      	if not Value then return end

		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hrp then return end

		if selectedVehicle then
			local vehicle = workspace.Vehicles:FindFirstChild(selectedVehicle)
			if vehicle and vehicle:FindFirstChild("Body") then
				local body = vehicle.Body
				local seat = body:FindFirstChild("CarSeatPosition") or body:FindFirstChild("VehicleSeat") or body:FindFirstChild("Passenger")

				if seat and seat:IsA("BasePart") then
					local originalPosition = hrp.CFrame
					hrp.CFrame = seat.CFrame
					wait(0.8)

					if vehicle.PrimaryPart then
						vehicle:SetPrimaryPartCFrame(originalPosition)
					elseif seat then
						vehicle:MoveTo(originalPosition.Position)
					end

					hrp.CFrame = originalPosition
				end
			end
		end
    end
})

local function teleportAllCars()
    for _, vehicle in ipairs(game.Workspace.Vehicles:GetChildren()) do
        for _, part in ipairs(vehicle:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Massless = true
            end
        end
    end
    
    wait(0.3)

    for _, vehicle in ipairs(game.Workspace.Vehicles:GetChildren()) do
        local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        vehicle:SetPrimaryPartCFrame(playerPosition)
        for _, part in ipairs(vehicle:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                part.Massless = false
            end
        end
    end
end

Tab7:AddSection({ "Todos os Carros" })

Tab7:AddButton({
    Name = "Puxar Carros",
    Callback = function()
        teleportAllCars()
    end
})

Tab7:AddButton({
    Name = "Remover Carros",
    Callback = function()
        local ofnawufn = false

if ofnawufn == true then
    return
end
ofnawufn = true

local cawwfer = "MilitaryBoatFree" 
local oldcfffff = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1754, -2, 58) 
wait(0.3)

local args = {
    [1] = "PickingBoat",
    [2] = cawwfer
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
wait(1)

local wrinfjn
for _, errb in pairs(game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"]:GetDescendants()) do
    if errb:IsA("VehicleSeat") then
        wrinfjn = errb
    end
end

repeat
    if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
        if not game.Players.LocalPlayer.Character.Humanoid.SeatPart == wrinfjn then
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
    end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = wrinfjn.CFrame
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = wrinfjn.CFrame + Vector3.new(0,1,0)
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = wrinfjn.CFrame + Vector3.new(0,-1,0)
    task.wait()
until game.Players.LocalPlayer.Character.Humanoid.SeatPart == wrinfjn

for _, wifn in pairs(game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"]:GetDescendants()) do
    if wifn.Name == "PhysicalWheel" then
        wifn:Destroy()
    end
end

local FLINGED = Instance.new("BodyThrust", game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass) 
FLINGED.Force = Vector3.new(50000, 0, 50000) 
FLINGED.Name = "SUNTERIUM HUB FLING"
FLINGED.Location = game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.Position

for _, wvwvwasc in pairs(game.workspace.Vehicles:GetChildren()) do
    for _, ascegr in pairs(wvwvwasc:GetDescendants()) do
        if ascegr.Name == "VehicleSeat" then
            local targetcar = ascegr
            local tet = Instance.new("BodyVelocity", game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass)
            tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            tet.P = 1250
            tet.Velocity = Vector3.new(0,0,0)
            tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
            for m=1,25 do
                local pos = {x=0, y=0, z=0}
                pos.x = targetcar.Position.X
                pos.y = targetcar.Position.Y
                pos.z = targetcar.Position.Z
                pos.x = pos.x + targetcar.Velocity.X / 2
                pos.y = pos.y + targetcar.Velocity.Y / 2
                pos.z = pos.z + targetcar.Velocity.Z / 2
                if pos.y <= -200 then
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(0,1000,0)
                else
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z))
                    task.wait()
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) + Vector3.new(0,-2,0)
                    task.wait()
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) * CFrame.new(0,0,2)
                    task.wait()
                    game.workspace.Vehicles[
game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) * CFrame.new(2,0,0)
                    task.wait()
                end
                task.wait()
            end
        end
    end
end

task.wait()
local args = {
    [1] = "DeleteAllVehicles"
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
game.Players.LocalPlayer.Character.Humanoid.Sit = false
wait()
local tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
tet.P = 1250
tet.Velocity = Vector3.new(0,0,0)
tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
wait(0.1)
for m=1,2 do 
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcfffff
end
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcfffff
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"):Destroy()
wait(0.2)
ofnawufn = false
    end
})

Tab7:AddSection({ "ESP Carros" })

local ESPEnabled = false
local espConnections = {}

local function createESP(vehicle)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP"
    billboard.Adornee = vehicle
    billboard.Size = UDim2.new(0, 150, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(0, 1, 0)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = billboard

    billboard.Parent = vehicle
    return textLabel
end

local function toggleESP(state)
    ESPEnabled = state
    if ESPEnabled then
        for _, vehicle in pairs(workspace.Vehicles:GetChildren()) do
            if not vehicle:FindFirstChild("ESP") and vehicle:IsA("Model") and vehicle.PrimaryPart then
                local textLabel = createESP(vehicle)
                local connection = game:GetService("RunService").RenderStepped:Connect(function()
                    if ESPEnabled and vehicle and vehicle.PrimaryPart then
                        local player = game.Players.LocalPlayer
                        local distance = (player.Character.PrimaryPart.Position - vehicle.PrimaryPart.Position).Magnitude
                        textLabel.Text = vehicle.Name .. " | Distância: " .. math.floor(distance) .. " studs"
                    end
                end)
                table.insert(espConnections, connection)
            end
        end
    else
        for _, connection in pairs(espConnections) do
            connection:Disconnect()
        end
        espConnections = {}
        for _, vehicle in pairs(workspace.Vehicles:GetChildren()) do
            if vehicle:FindFirstChild("ESP") then
                vehicle.ESP:Destroy()
            end
        end
    end
end

local Toggle = Tab7:AddToggle({
    Name = "ESP Carros",
    Default = false,
    Callback = function(Value)
        toggleESP(Value)
    end
})
----------------------------------------------------------------------------------------------------------------
-----------------------------------------Aba Outros-----------------------------------------------------
----------------------------------------------------------------------------------------------------------------

-- Aba Child
local Tab8= Window:MakeTab({"| Outros", "rbxassetid://10723424505"})

local selectedPlayerOutros = nil

local DropdownJogadoresKid = Tab8:AddDropdownPlayer({
    Name = "Selecionar Jogador",
    Callback = function(Value)
        selectedPlayerOutros = Value
    end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Cam = workspace.CurrentCamera

local viewing = false

-- Restaura a câmera para o próprio personagem
local function ResetCamera()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            Cam.CameraSubject = hum
        end
    end
end

----------------------------------------------------
-- TOGGLE REDZ LIB
----------------------------------------------------

Tab8:AddToggle({
    Name = "Visualizar Jogador",
    Default = false,
    Callback = function(Value)
        viewing = Value

        if viewing then
            task.spawn(function()
                local shown = false

                while viewing do
                    -- Busca o jogador pelo nome selecionado no Dropdown
                    local target = Players:FindFirstChild(selectedPlayerOutros)

                    if target then
                        -- Envia a notificação apenas uma vez ao iniciar a visualização
                        if not shown then
                            local thumbUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. target.UserId .. "&width=150&height=150&format=png"
                            
                            MyLibrary:NotifyWithImage({
                                Name = "Visualizando:",
                                Sub = target.DisplayName,        -- Nome secundário / visual
                                Text = "@" .. target.Name,       -- Nome original / username
                                Icon = thumbUrl,
                                Time = 3
                            })
                            shown = true
                        end

                        -- Acompanha o Humanoid do alvo
                        local char = target.Character
                        if char then
                            local hum = char:FindFirstChildOfClass("Humanoid")
                            if hum then
                                Cam.CameraSubject = hum
                            end
                        end
                    else
                        -- Notificação quando o jogador selecionado não é encontrado ou sai
                        MyLibrary:NotifyWithImage({
                            Name = "Jogador Indisponível",
                            Sub = tostring(selectedPlayerOutros),
                            Text = "Jogador desconectado ou inválido",
                            Icon = "rbxassetid://86050226751861",
                            Time = 3
                        })

                        viewing = false
                        ResetCamera()
                        break
                    end
                    task.wait(0.1)
                end
            end)
        else
            ResetCamera()
        end
    end
})

--==============================================================
-- 🛠️ HELPERS DA CRIANÇA
--==============================================================
local RunService = game:GetService("RunService")

-- Aguarda a criança ter Torso com BodyPosition/BodyGyro prontos
local function WaitForChildPhysics(followCharacter, timeout)
    timeout = timeout or 3
    local startTime = tick()
    repeat
        task.wait(0.05)
        local torso = followCharacter:FindFirstChild("Torso")
        if torso and torso:FindFirstChild("BodyPosition") and torso:FindFirstChild("BodyGyro") then
            return torso
        end
    until tick() - startTime > timeout
    return nil
end

-- Garante que a criança exista e retorne ela + torso prontos
local function GetOrSpawnChild()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local playerFolder = workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    local followCharacter = playerFolder and playerFolder:FindFirstChild("FollowCharacter")

    -- Spawna se não existir
    if not followCharacter then
        pcall(function()
            ReplicatedStorage.RE:FindFirstChild("1Bab1yFollo1w"):FireServer("CharacterFollowSpawnPlayer", "BabyBoy")
        end)

        local timeout = 3
        local startTime = tick()
        repeat
            task.wait(0.1)
            playerFolder = workspace:FindFirstChild(game.Players.LocalPlayer.Name)
            followCharacter = playerFolder and playerFolder:FindFirstChild("FollowCharacter")
        until followCharacter or tick() - startTime > timeout

        if not followCharacter then
            warn("Criança não spawnou a tempo.")
            return nil, nil
        end
    end

    -- Ativar colisão
    if playerFolder then
        for _, v in pairs(playerFolder:GetChildren()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
    end

    -- Esperar física pronta (evita precisar de 2-3 cliques)
    local torso = WaitForChildPhysics(followCharacter, 3)
    if not torso then
        warn("Torso da criança não ficou pronto a tempo.")
        return followCharacter, nil
    end

    return followCharacter, torso
end

-- Desconecta loop anterior
local function DisconnectChildLoop()
    if getgenv().ChildFollowLoop then
        pcall(function() getgenv().ChildFollowLoop:Disconnect() end)
        getgenv().ChildFollowLoop = nil
    end
end



Tab8:AddSection({ Name = "Criança"})

--==============================================================
-- 👶 SEÇÃO: CRIANÇA - CONTROLE BÁSICO
--==============================================================

Tab8:AddButton({
    Name = "Enviar criança",
    Callback = function()
        if not selectedPlayerOutros then
            warn("Nenhum jogador selecionado!")
            return
        end

        local followCharacter, torso = GetOrSpawnChild()
        if not followCharacter then return end

        -- Reparent para o alvo
        local targetFolder = workspace:FindFirstChild(selectedPlayerOutros)
        if not (targetFolder and followCharacter) then return end

        followCharacter.Parent = targetFolder

        -- Se torso já pronto, conecta loop
        if torso then
            DisconnectChildLoop()
            getgenv().ChildFollowLoop = RunService.Heartbeat:Connect(function()
                local followNow = targetFolder:FindFirstChild("FollowCharacter")
                if not (followNow and followNow:FindFirstChild("Torso") and followNow.Torso:FindFirstChild("BodyPosition")) then
                    return
                end

                local hrp = targetFolder:FindFirstChild("HumanoidRootPart")
                if hrp then
                    followNow.Torso.BodyPosition.Position =
                        hrp.Position - (hrp.CFrame.LookVector * 3)

                    if followNow.Torso:FindFirstChild("BodyGyro") then
                        followNow.Torso.BodyGyro.CFrame = hrp.CFrame
                    end
                end
            end)
        end
    end
})

Tab8:AddButton({
    Title = "BANG NA o FRENTE DO ALVO",
    Description = "",
    Callback = function()
        if not selectedPlayerOutros then
            warn("Nenhum player selecionado!")
            return
        end

        local followCharacter, torso = GetOrSpawnChild()
        if not (followCharacter and torso) then return end

        local targetChar = workspace:FindFirstChild(selectedPlayerOutros)
        local hrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
        if not hrp then warn("Target não encontrada!") return end

        followCharacter.Parent = workspace
        DisconnectChildLoop()

        getgenv().ChildFollowLoop = RunService.Heartbeat:Connect(function()
            if not (targetChar and targetChar:FindFirstChild("HumanoidRootPart") and torso) then
                getgenv().ChildFollowLoop:Disconnect()
                return
            end

            local currentHrp = targetChar:FindFirstChild("HumanoidRootPart")
            if not currentHrp then return end

            -- Posição: 2.5 studs na FRENTE do alvo, na altura do HRP
            local frontPos = currentHrp.Position + currentHrp.CFrame.LookVector * 2.5

            torso.BodyPosition.Position = frontPos
            -- Criança vira para o alvo
            torso.BodyGyro.CFrame = CFrame.lookAt(torso.Position, currentHrp.Position)
        end)
    end
})

-- BANG FACE (frente do rosto)
Tab8:AddButton({
    Title = "BANG FACE",
    Description = "",
    Callback = function()
        if not selectedPlayerOutros then
            warn("Nenhum player selecionado!")
            return
        end

        local followCharacter, torso = GetOrSpawnChild()
        if not (followCharacter and torso) then return end

        local targetChar = workspace:FindFirstChild(selectedPlayerOutros)
        local hrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
        if not hrp then warn("Target não encontrada!") return end

        followCharacter.Parent = workspace
        DisconnectChildLoop()

        getgenv().ChildFollowLoop = RunService.Heartbeat:Connect(function()
            if not (targetChar and targetChar:FindFirstChild("HumanoidRootPart") and torso) then
                getgenv().ChildFollowLoop:Disconnect()
                return
            end

            local head = targetChar:FindFirstChild("Head")
            local facePos
            if head then
                facePos = head.Position + head.CFrame.LookVector * 0.1
            else
                facePos = hrp.Position + hrp.CFrame.LookVector * 0.1
            end

            local pos1 = facePos + hrp.CFrame.LookVector * -0.2
            local pos2 = facePos + hrp.CFrame.LookVector * 2.9

            local t = tick() % 1
            local progress = math.abs(math.sin(t * math.pi))
            local newPos = pos1:Lerp(pos2, progress)

            torso.BodyPosition.Position = newPos
            torso.BodyGyro.CFrame = CFrame.lookAt(torso.Position, facePos)
        end)
    end
})

Tab8:AddButton({
    Title = "BANG ATRÁS DO ALVO",
    Description = "",
    Callback = function()
        if not selectedPlayerOutros then
            warn("Nenhum player selecionado!")
            return
        end

        local followCharacter, torso = GetOrSpawnChild()
        if not (followCharacter and torso) then return end

        local targetChar = workspace:FindFirstChild(selectedPlayerOutros)
        local hrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
        if not hrp then warn("Target não encontrada!") return end

        followCharacter.Parent = workspace
        DisconnectChildLoop()

        getgenv().ChildFollowLoop = RunService.Heartbeat:Connect(function()
            if not (targetChar and targetChar:FindFirstChild("HumanoidRootPart") and torso) then
                getgenv().ChildFollowLoop:Disconnect()
                return
            end

            local currentHrp = targetChar:FindFirstChild("HumanoidRootPart")
            if not currentHrp then return end

            local backPos = currentHrp.Position - currentHrp.CFrame.LookVector * 0.1
            local pos1 = backPos - currentHrp.CFrame.LookVector * 2.8
            local pos2 = backPos - currentHrp.CFrame.LookVector * -0.2

            local t = tick() % 1
            local progress = math.abs(math.sin(t * math.pi))
            local newPos = pos1:Lerp(pos2, progress)

            torso.BodyPosition.Position = newPos
            torso.BodyGyro.CFrame = CFrame.lookAt(torso.Position, currentHrp.Position)
        end)
    end
})

Tab8:AddButton({
    Name = "Retornar criança",
    Callback = function()
        DisconnectChildLoop()

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        pcall(function()
            ReplicatedStorage.RE:FindFirstChild("1Bab1yFollo1w"):FireServer("DeleteFollowCharacter")
        end)
        pcall(function()
            ReplicatedStorage.RE:FindFirstChild("1Bab1yFollo1w"):FireServer("CharacterFollowSpawnPlayer", "BabyBoy")
        end)
    end
})

--==============================================================
-- 🎮 SEÇÃO: CONTROLAR CRIANÇA (câmera + botões direcionais)
--==============================================================

-- Estado
local controllingChild   = false
local controlGui         = nil
local controlLoop        = nil
local savedCameraSubject = nil
local heldDirection      = nil -- "forward" | "backward" | "left" | "right" | nil

-- Configurações
local CHILD_SPEED  = 60   -- studs/s (fixo)
local childHeight  = 3    -- offset Y acima do chão
local HEIGHT_STEP  = 0.5  -- quanto +/− altera por clique

-- Raycast params reaproveitados
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.IgnoreWater = true
-- ---------------------------------------------
-- Cria a UI de controle
-- ---------------------------------------------
local function CreateControlGUI()
    if controlGui then return controlGui end

    local CoreGui = game:GetService("CoreGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ChildControllerUI"
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 999
    screenGui.Parent = CoreGui

    -- Helper: cria um botão estilizado
    local function MakeButton(parent, name, symbol, size, position, color)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Size = size
        btn.Position = position
        btn.BackgroundColor3 = color or Color3.fromRGB(25, 25, 25)
        btn.BackgroundTransparency = 0.25
        btn.BorderSizePixel = 0
        btn.Text = symbol
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 26
        btn.AutoButtonColor = true
        btn.Parent = parent
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.Transparency = 0.5
        stroke.Thickness = 2

        return btn
    end

    --=========================================================
    -- 🎮 Cruz direcional (canto inferior ESQUERDO)
    --=========================================================
    local dpadContainer = Instance.new("Frame")
    dpadContainer.Name = "DpadContainer"
    dpadContainer.Size = UDim2.new(0, 200, 0, 200)
    dpadContainer.Position = UDim2.new(0, 30, 1, -230) -- canto inferior esquerdo
    dpadContainer.BackgroundTransparency = 1
    dpadContainer.Parent = screenGui

    -- Conexões de segurar/soltar para os 4 botões direcionais
    local function ConnectDirectional(btn, dirKey)
        btn.MouseButton1Down:Connect(function()
            heldDirection = dirKey
        end)
        btn.MouseButton1Up:Connect(function()
            if heldDirection == dirKey then heldDirection = nil end
        end)
        btn.MouseLeave:Connect(function()
            if heldDirection == dirKey then heldDirection = nil end
        end)

        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                heldDirection = dirKey
            end
        end)
        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseButton1 then
                if heldDirection == dirKey then heldDirection = nil end
            end
        end)
    end

    -- 4 botões na cruz (▲ ◀ ▶ ▼)
    local btnUp    = MakeButton(dpadContainer, "BtnUp",    "▲", UDim2.new(0, 60, 0, 60), UDim2.new(0.5, -30, 0, 0))
    local btnDown  = MakeButton(dpadContainer, "BtnDown",  "▼", UDim2.new(0, 60, 0, 60), UDim2.new(0.5, -30, 1, -60))
    local btnLeft  = MakeButton(dpadContainer, "BtnLeft",  "◀", UDim2.new(0, 60, 0, 60), UDim2.new(0, 0, 0.5, -30))
    local btnRight = MakeButton(dpadContainer, "BtnRight", "▶", UDim2.new(0, 60, 0, 60), UDim2.new(1, -60, 0.5, -30))

    ConnectDirectional(btnUp,    "forward")
    ConnectDirectional(btnDown,  "backward")
    ConnectDirectional(btnLeft,  "left")
    ConnectDirectional(btnRight, "right")

    --=========================================================
    -- ⬆⬇ Botões de altura (canto inferior DIREITO)
    --=========================================================
    local heightContainer = Instance.new("Frame")
    heightContainer.Name = "HeightContainer"
    heightContainer.Size = UDim2.new(0, 70, 0, 150)
    heightContainer.Position = UDim2.new(1, -100, 1, -180) -- canto inferior direito
    heightContainer.BackgroundTransparency = 1
    heightContainer.Parent = screenGui

    local btnHeightUp   = MakeButton(heightContainer, "BtnHeightUp",   "+", UDim2.new(0, 70, 0, 70), UDim2.new(0, 0, 0, 0),   Color3.fromRGB(30, 90, 30))
    local btnHeightDown = MakeButton(heightContainer, "BtnHeightDown", "−", UDim2.new(0, 70, 0, 70), UDim2.new(0, 0, 0, 80),  Color3.fromRGB(90, 30, 30))

    -- Ajuste em 1 clique = ±0.5 (com pequeno feedback visual)
    local function AdjustHeight(delta)
        childHeight = childHeight + delta
        if childHeight < 0 then childHeight = 0 end -- não deixa afundar abaixo do chão
    end

    btnHeightUp.MouseButton1Click:Connect(function()
        AdjustHeight(HEIGHT_STEP)
    end)
    btnHeightDown.MouseButton1Click:Connect(function()
        AdjustHeight(-HEIGHT_STEP)
    end)

    -- Suporte Touch
    btnHeightUp.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            AdjustHeight(HEIGHT_STEP)
        end
    end)
    btnHeightDown.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            AdjustHeight(-HEIGHT_STEP)
        end
    end)

    controlGui = screenGui
    return screenGui
end

local function DestroyControlGUI()
    if controlGui then
        controlGui:Destroy()
        controlGui = nil
    end
end

-- ---------------------------------------------
-- Loop de controle
-- ---------------------------------------------
local function StartControlLoop()
    if controlLoop then controlLoop:Disconnect() end

    controlLoop = RunService.Heartbeat:Connect(function(dt)
        if not controllingChild then return end

        -- Criança atual
        local folder = workspace:FindFirstChild(game.Players.LocalPlayer.Name)
        local child  = folder and folder:FindFirstChild("FollowCharacter")
        if not child then return end

        local torso = child:FindFirstChild("Torso")
        if not (torso and torso:FindFirstChild("BodyPosition") and torso:FindFirstChild("BodyGyro")) then
            return
        end

        local bp = torso.BodyPosition
        local bg = torso.BodyGyro

        local currentPos = torso.Position

        -- ============================================================
        -- Direção do movimento (se houver botão pressionado)
        -- ============================================================
        local moveDir = Vector3.zero

        if heldDirection then
            local camCF    = workspace.CurrentCamera.CFrame
            local camLook  = camCF.LookVector
            local camRight = camCF.RightVector

            local forward = Vector3.new(camLook.X, 0, camLook.Z)
            if forward.Magnitude < 0.01 then forward = Vector3.new(0, 0, -1) end
            forward = forward.Unit

            local right = Vector3.new(camRight.X, 0, camRight.Z)
            if right.Magnitude < 0.01 then right = Vector3.new(1, 0, 0) end
            right = right.Unit

            if heldDirection == "forward"        then moveDir = forward
            elseif heldDirection == "backward"   then moveDir = -forward
            elseif heldDirection == "left"       then moveDir = -right
            elseif heldDirection == "right"      then moveDir = right
            end
        end

        -- ============================================================
        -- Nova posição horizontal
        -- ============================================================
        local horizontalPos = currentPos + moveDir * CHILD_SPEED * dt

        -- ============================================================
        -- Raycast pro chão + altura
        -- ============================================================
        rayParams.FilterDescendantsInstances = { child }

        local origin = Vector3.new(horizontalPos.X, currentPos.Y + 100, horizontalPos.Z)
        local result = workspace:Raycast(origin, Vector3.new(0, -500, 0), rayParams)

        local groundY = result and result.Position.Y or currentPos.Y
        local finalY  = groundY + childHeight

        local newPos = Vector3.new(horizontalPos.X, finalY, horizontalPos.Z)

        bp.Position = newPos

        -- Vira a criança pra direção do movimento
        if moveDir.Magnitude > 0.05 then
            bg.CFrame = CFrame.lookAt(newPos, newPos + moveDir)
        end
    end)
end

local function StopControlLoop()
    if controlLoop then
        controlLoop:Disconnect()
        controlLoop = nil
    end
end

-- ---------------------------------------------
-- Toggle principal
-- ---------------------------------------------
Tab8:AddToggle({
    Name = "Controlar Criança",
    Description = "",
    Default = false,
    Callback = function(Value)
        if Value then
            local followCharacter = GetOrSpawnChild()
            if not followCharacter then
                warn("Não foi possível spawnar a criança.")
                return
            end

            DisconnectChildLoop()

            local localFolder = workspace:FindFirstChild(game.Players.LocalPlayer.Name)
            if localFolder and followCharacter.Parent ~= localFolder then
                followCharacter.Parent = localFolder
            end

            controllingChild = true
            heldDirection    = nil

            local cam = workspace.CurrentCamera
            savedCameraSubject = cam.CameraSubject

            local targetTorso = followCharacter:FindFirstChild("Torso")
            if targetTorso then
                cam.CameraSubject = targetTorso
            end
            game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic

            CreateControlGUI()
            StartControlLoop()
        else
            controllingChild = false
            heldDirection    = nil

            local cam = workspace.CurrentCamera
            local myChar = game.Players.LocalPlayer.Character
            local myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")

            if myHum then
                cam.CameraSubject = myHum
            elseif savedCameraSubject then
                cam.CameraSubject = savedCameraSubject
            end

            DestroyControlGUI()
            StopControlLoop()
        end
    end
})

Tab8:AddSection({ Name = "Spawn Bombas", Icon = "rbxassetid://" })

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WorkspaceService = game:GetService("Workspace")


local BombAmount = 5 
local ColetandoBombas = false -- Controla se o loop de coleta deve rodar ou parar


local BlowBombsServer = nil
pcall(function()
    local SettingsModule = require(Player:WaitForChild("PlayerGui"):WaitForChild("Player8Handler"):WaitForChild("Game8Settings"))
    BlowBombsServer = SettingsModule.BlowBombsServer
end)

local BombFolder = nil
pcall(function()
    BombFolder = WorkspaceService.WorkspaceCom["001_CriminalWeapons"].GiveTools
end)


Tab8:AddTextBox({
    Name = "Quantidade De Bombas",
    Default = "5",
    PlaceholderText = "Digite um numero...",
    ClearTextOnFocus = false,
    Callback = function(value)
        local num = tonumber(value)
        if num and num > 0 then
            BombAmount = num
        else
            BombAmount = 5 -- Valor padrao caso o texto digitado seja inválido
        end
    end
})


local function getBombCount()
    local cnt = 0
    if Player:FindFirstChild("Backpack") then
        for _, t in ipairs(Player.Backpack:GetChildren()) do
            if t:IsA("Tool") and t.Name:lower():find("bomb") then
                cnt = cnt + 1
            end
        end
    end
    if Player.Character then
        for _, t in ipairs(Player.Character:GetChildren()) do
            if t:IsA("Tool") and t.Name:lower():find("bomb") then
                cnt = cnt + 1
            end
        end
    end
    return cnt
end


Tab8:AddButton({
    Name = "Pega Bombas",
    Callback = function()
        if ColetandoBombas then 
            print("Já existe uma coleta em andamento!")
            return 
        end
        
        ColetandoBombas = true
        
        task.spawn(function()
            local Character = Player.Character
            if not Character then
                print("Character não encontrado!")
                ColetandoBombas = false
                return
            end
            
            local RootPart = Character:WaitForChild("HumanoidRootPart", 5)
            if not RootPart then
                print("HumanoidRootPart não encontrado!")
                ColetandoBombas = false
                return
            end
            
            local origin = RootPart.CFrame
            local attempts = 0
            local collected = getBombCount()

            MyLibrary:Notify({
                Title = "Coleta",
                Message = "Iniciando coleta automatizada...",
                Duration = 2
            })

            -- Loop de repetição principal
            while ColetandoBombas and collected < BombAmount and attempts < 150 do
                attempts = attempts + 1
                
                -- Busca a bomba dinamicamente a cada loop para evitar referências nulas (nil)
                local AlvoBomba = nil
                
                -- 1ª Tentativa: Procura na pasta oficial que você informou
                if BombFolder then
                    AlvoBomba = BombFolder:FindFirstChild("Bomb") or BombFolder:FindFirstChildWhichIsA("BasePart")
                end
                
                -- 2ª Tentativa: Se não achou na pasta, escaneia o workspace por ClickDetectors de bomba
                if not AlvoBomba then
                    for _, v in ipairs(workspace:GetDescendants()) do
                        if v:IsA("ClickDetector") and v.Parent and v.Parent.Name:lower():find("bomb") then
                            AlvoBomba = v.Parent
                            break
                        end
                    end
                end

                -- Se encontrou a bomba e o ClickDetector, executa a aproximação e clique
                if AlvoBomba and AlvoBomba:FindFirstChild("ClickDetector") and RootPart then
                    pcall(function()
                        -- Teleporta ligeiramente acima do item
                        RootPart.CFrame = AlvoBomba.CFrame * CFrame.new(0, 1.8, 0)
                        task.wait(0.02)
                        fireclickdetector(AlvoBomba.ClickDetector, 2)
                    end)
                else
                    -- Se não encontrou nenhuma bomba no mapa inteiro, avisa no console
                    print("Procurando bomba no mapa... Nenhuma encontrada nesta tentativa (" .. tostring(attempts) .. ")")
                end

                task.wait(0.05) -- Delay seguro para o Roblox registrar o clique
                collected = getBombCount()
            end
            
            -- Retorna à posição original de forma segura
            pcall(function() 
                RootPart.CFrame = origin 
            end)
            
            -- Verificação final de estoque
            if ColetandoBombas then
                if collected >= BombAmount then
                    MyLibrary:Notify({
                        Title = "Sucesso",
                        Message = "Total de " .. tostring(collected) .. " bombas coletadas!",
                        Duration = 3
                    })
                else
                    MyLibrary:Notify({
                        Title = "Aviso",
                        Message = "A coleta encerrou. Total obtido: " .. tostring(collected) .. "/" .. tostring(BombAmount),
                        Duration = 4
                    })
                end
            end
            
            ColetandoBombas = false
        end)
    end
})




Tab8:AddButton({
    Name = "Parar de Pega Bombas",
    Callback = function()
        if ColetandoBombas then
            ColetandoBombas = false -- Altera a flag para fechar o loop do botão acima imediatamente
            MyLibrary:Notify({
                Title = "Interrompido",
                Message = "Cancelando coleta e retornando à posição...",
                Duration = 3
            })
        else
            MyLibrary:Notify({
                Title = "Info",
                Message = "Você não está coletando bombas no momento.",
                Duration = 2
            })
        end
    end
})


Tab8:AddButton({
    Name = "Spawn Bombas",
    Callback = function()
        task.spawn(function()
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local RootPart = Character:WaitForChild("HumanoidRootPart")
            
            local ferramentas = {}
            
            if Player:FindFirstChild("Backpack") then
                for _, t in ipairs(Player.Backpack:GetChildren()) do
                    if t:IsA("Tool") and t.Name:lower():find("bomb") then
                        table.insert(ferramentas, t)
                    end
                end
            end

            for _, t in ipairs(Character:GetChildren()) do
                if t:IsA("Tool") and t.Name:lower():find("bomb") then
                    table.insert(ferramentas, t)
                end
            end

            if #ferramentas == 0 then
                MyLibrary:Notify({
                    Title = "Erro",
                    Message = "Nenhuma bomba encontrada no seu inventário!",
                    Duration = 3
                })
                return
            end

            for _, bomb in ipairs(ferramentas) do
                task.spawn(function()
                    pcall(function()
                        local mouseLoc = bomb:FindFirstChild("MouseLoc")
                        local mouseLocCone = bomb:FindFirstChild("MouseLocCone")

                        if mouseLoc then
                            mouseLoc.OnClientInvoke = function()
                                return RootPart.Position + Vector3.new(0, 4, 0)
                            end
                        end

                        if mouseLocCone then
                            mouseLocCone.OnClientInvoke = function()
                                return RootPart
                            end
                        end

                        if bomb.Parent ~= Character then
                            bomb.Parent = Character
                        end
                        bomb:Activate()
                    end)
                end)
            end
        end)
    end
})


Tab8:AddButton({
    Name = "Ativa Bombas",
    Callback = function()
        if BlowBombsServer and BlowBombsServer:IsA("RemoteEvent") then
            pcall(function()
                BlowBombsServer:FireServer("Bomb" .. Player.Name)
                MyLibrary:Notify({
                    Title = "Detonação",
                    Message = "Sinal enviado para explodir as bombas!",
                    Duration = 3
                })
            end)
        else
            pcall(function()
                ReplicatedStorage.RE["1Blo1wBomb1sServe1r"]:FireServer("Bomb" .. Player.Name)
                MyLibrary:Notify({
                    Title = "Detonação",
                    Message = "Sinal alternativo enviado!",
                    Duration = 3
                })
            end)
        end
    end
})


local LoopSpamBomba = false

Tab8:AddToggle({
    Name = "Auto Spawn e Ativar Bombas",
    Default = false,
    Callback = function(state)
        LoopSpamBomba = state
        
        if LoopSpamBomba then
            task.spawn(function()
                MyLibrary:Notify({
                    Title = "Auto Spam",
                    Message = "Loop de bombas ativado!",
                    Duration = 2
                })
                
                -- Loop principal enquanto o Toggle estiver ligado
                while LoopSpamBomba do
                    local Character = Player.Character
                    local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    
                    if Character and RootPart then
                        local ferramentas = {}
                        
                        -- 1. Coleta todas as bombas do inventário
                        if Player:FindFirstChild("Backpack") then
                            for _, t in ipairs(Player.Backpack:GetChildren()) do
                                if t:IsA("Tool") and t.Name:lower():find("bomb") then
                                    table.insert(ferramentas, t)
                                end
                            end
                        end
                        for _, t in ipairs(Character:GetChildren()) do
                            if t:IsA("Tool") and t.Name:lower():find("bomb") then
                                table.insert(ferramentas, t)
                            end
                        end

                        -- 2. Se houver bombas, inicia o processo de descarregar
                        if #ferramentas > 0 then
                            -- Move todas as bombas para o personagem imediatamente
                            for _, bomb in ipairs(ferramentas) do
                                pcall(function()
                                    local mouseLoc = bomb:FindFirstChild("MouseLoc")
                                    local mouseLocCone = bomb:FindFirstChild("MouseLocCone")

                                    if mouseLoc then
                                        mouseLoc.OnClientInvoke = function()
                                            return RootPart.Position + Vector3.new(0, 4, 0)
                                        end
                                    end
                                    if mouseLocCone then
                                        mouseLocCone.OnClientInvoke = function()
                                            return RootPart
                                        end
                                    end

                                    if bomb.Parent ~= Character then
                                        bomb.Parent = Character
                                    end
                                end)
                            end
                            
                            -- PAUSA CRÍTICA: Dá tempo (0.03s) para o Roblox reconhecer as bombas nas suas mãos
                            task.wait(0.03)

                            -- Ativa todas que foram equipadas
                            for _, bomb in ipairs(ferramentas) do
                                pcall(function()
                                    bomb:Activate()
                                end)
                            end

                            -- SEGUNDA PAUSA CRÍTICA: Dá tempo para as bombas irem para a cabeça antes do "Boom"
                            task.wait(0.05)
                            
                            -- 3. Detonação remota
                            if BlowBombsServer and BlowBombsServer:IsA("RemoteEvent") then
                                pcall(function()
                                    BlowBombsServer:FireServer("Bomb" .. Player.Name)
                                end)
                            else
                                pcall(function()
                                    ReplicatedStorage.RE["1Blo1wBomb1sServe1r"]:FireServer("Bomb" .. Player.Name)
                                end)
                            end
                        end
                    end
                    
                    -- Pequena espera de 0.1 segundos antes de repetir todo o ciclo novamente
                    task.wait(0.1) 
                end
                
                MyLibrary:Notify({
                    Title = "Auto Spam",
                    Message = "Loop de bombas desativado.",
                    Duration = 2
                })
            end)
        end
    end
})


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Variáveis de Configuração
local auraDistance = 6
local auraSpeed = 1
local auraHeight = -3
local auraEnabled = false -- Orbita Você
local auraTargetEnabled = false -- Orbita Alvo
local currentShape = "Circulo"
local currentMovement = "Em fila"

-- Nova Variável
local orbitStaticEnabled = false -- Órbita Posição Atual
local staticPosition = nil -- Guarda a posição capturada

-- Elementos da Interface (Tab8)
Tab8:AddSection({ Name = "Orbita Props", Icon = "rbxassetid://" })

Tab8:AddButton({
    Name = "Pega a Caixa de Props",
    Callback = function()
        local args = {
            [1] = "PickingTools",
            [2] = "PropMaker"
        }
        pcall(function()
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
        end)
    end
})

Tab8:AddDropdown({
    Name = "Formas",
    Default = "Circulo",
    Multi = false,
    Options = {"Circulo", "Quadrado", "Triangulo"},
    Callback = function(shape) currentShape = shape end
})

Tab8:AddDropdown({
    Name = "Movimentos",
    Default = "Em fila",
    Multi = false,
    Options = {
        "Em fila",
        "Para fora",
        "Para dentro",
        "De cabeça para baixo",
        "De cabeça para baixo para dentro",
        "De cabeça para baixo para fora",
        "Deitado",
        "Deitado para dentro",
        "Deitado para fora"
    },
    Callback = function(movement) currentMovement = movement end
})

Tab8:AddSlider({
    Name = "Distância",
    Min = 1,
    Max = 100,
    Default = 6,
    Increase = 0.5,
    Callback = function(v) auraDistance = v end
})

Tab8:AddSlider({
    Name = "Velocidade",
    Min = 1,
    Max = 20,
    Default = 4,
    Increase = 1,
    Callback = function(v) auraSpeed = v end
})

Tab8:AddSlider({
    Name = "Altura",
    Min = -3,
    Max = 100,
    Default = -3,
    Increase = 0.5,
    Callback = function(v) auraHeight = v end
})

Tab8:AddToggle({
    Name = "Órbita Posição Atual",
    Default = false,
    Callback = function(v)
        orbitStaticEnabled = v
        if v then
            -- Captura a posição APENAS UMA VEZ no momento do clique
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                staticPosition = hrp.Position
            else
                staticPosition = Vector3.new(0, 0, 0)
            end
        else
            staticPosition = nil
        end
    end
})

Tab8:AddToggle({
    Name = "Orbita Você",
    Default = false,
    Callback = function(v) auraEnabled = v end
})

Tab8:AddToggle({
    Name = "Orbita Alvo",
    Default = false,
    Callback = function(v) auraTargetEnabled = v end
})

-- Funções Matemáticas para Formas Geométricas
local function getSquareOffset(angle, distance)
    local c = math.cos(angle)
    local s = math.sin(angle)
    local maxCoord = math.max(math.abs(c), math.abs(s))
    if maxCoord == 0 then maxCoord = 1 end
    return (c / maxCoord) * distance, (s / maxCoord) * distance
end

local function getTriangleOffset(angle, distance)
    local outAngle = math.fmod(angle, math.pi * 2 / 3)
    if outAngle < 0 then outAngle = outAngle + (math.pi * 2 / 3) end
    local r = distance * math.cos(math.pi / 3) / math.cos(outAngle - math.pi / 3)
    return math.cos(angle) * r, math.sin(angle) * r
end

-- Loop Principal
task.spawn(function()
    local angle = 0

    RunService.RenderStepped:Connect(function(dt)
        if not auraEnabled and not auraTargetEnabled and not orbitStaticEnabled then return end
        
        local myChar = LocalPlayer.Character
        local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
        
        local targetPlayerObj = selectedPlayerOutros and Players:FindFirstChild(selectedPlayerOutros)
        local targetChar = targetPlayerObj and targetPlayerObj.Character
        local targetHrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

        local folder = workspace:FindFirstChild("WorkspaceCom")
        local propsFolder = folder and folder:FindFirstChild("001_TrafficCones")
        if not propsFolder then return end

        -- Sentido da rotação (sempre horário agora)
        angle = angle + (dt * auraSpeed)

        local myProps = {}
        for _, prop in ipairs(propsFolder:GetChildren()) do
            if prop.Name:find("Prop" .. LocalPlayer.Name) then
                table.insert(myProps, prop)
            end
        end

        local totalProps = #myProps
        if totalProps == 0 then return end

        local targetGroups = {}
        
        -- Prioridade 1: Se Órbita Estática estiver ligada, ignora os eixos móveis dos players
        if orbitStaticEnabled and staticPosition then
            for index, prop in ipairs(myProps) do
                table.insert(targetGroups, {prop = prop, isStatic = true, staticCenter = staticPosition, groupIndex = index, groupTotal = totalProps})
            end
        -- Prioridade 2: Divisão mútua entre você e o Alvo
        elseif auraEnabled and auraTargetEnabled and targetHrp then
            local half = math.ceil(totalProps / 2)
            for index, prop in ipairs(myProps) do
                if index <= half then
                    table.insert(targetGroups, {prop = prop, centerHrp = myHrp, groupIndex = index, groupTotal = half})
                else
                    table.insert(targetGroups, {prop = prop, centerHrp = targetHrp, groupIndex = index - half, groupTotal = totalProps - half})
                end
            end
        -- Prioridade 3: Apenas no Alvo
        elseif auraTargetEnabled and targetHrp then
            for index, prop in ipairs(myProps) do
                table.insert(targetGroups, {prop = prop, centerHrp = targetHrp, groupIndex = index, groupTotal = totalProps})
            end
        -- Prioridade 4: Apenas em Você
        else
            if myHrp then
                for index, prop in ipairs(myProps) do
                    table.insert(targetGroups, {prop = prop, centerHrp = myHrp, groupIndex = index, groupTotal = totalProps})
                end
            end
        end

        -- Lógica de cálculo posicional por prop
        for _, data in ipairs(targetGroups) do
            local prop = data.prop
            local index = data.groupIndex
            local groupTotal = data.groupTotal
            
            -- Define qual será o ponto central (Estático ou um Player HRP)
            local centerPosition = nil
            local referenceCFrame = nil
            
            if data.isStatic then
                centerPosition = data.staticCenter
                referenceCFrame = CFrame.new(centerPosition)
            elseif data.centerHrp then
                centerPosition = data.centerHrp.Position
                referenceCFrame = data.centerHrp.CFrame
            end

            if centerPosition then
                local offsetAngle = angle + ((index - 1) * (math.pi * 2 / groupTotal))

                -- 1. Calcula Posição X e Z
                local px, pz = 0, 0
                if currentShape == "Quadrado" then
                    px, pz = getSquareOffset(offsetAngle, auraDistance)
                elseif currentShape == "Triangulo" then
                    px, pz = getTriangleOffset(offsetAngle, auraDistance)
                else
                    px = math.cos(offsetAngle) * auraDistance
                    pz = math.sin(offsetAngle) * auraDistance
                end

                local targetPosition = centerPosition + Vector3.new(px, auraHeight, pz)

                -- 2. Rotação/Direção do CFrame
                local baseCFrame
                if currentMovement:find("para fora") or currentMovement:find("Para fora") then
                    baseCFrame = CFrame.lookAt(targetPosition, targetPosition + Vector3.new(px, 0, pz))
                elseif currentMovement:find("para dentro") or currentMovement:find("Para dentro") then
                    baseCFrame = CFrame.lookAt(targetPosition, Vector3.new(centerPosition.X, targetPosition.Y, centerPosition.Z))
                else
                    baseCFrame = CFrame.new(targetPosition) * (referenceCFrame - referenceCFrame.Position)
                end

                -- 3. Multiplicadores de Eixo Especiais
                local targetCFrame = baseCFrame
                if currentMovement:find("De cabeça para baixo") then
                    targetCFrame = baseCFrame * CFrame.Angles(0, 0, math.pi)
                elseif currentMovement:find("Deitado") then
                    targetCFrame = baseCFrame * CFrame.Angles(math.pi / 2, 0, 0)
                end

                local remote = prop:FindFirstChild("SetCurrentCFrame")
                if remote then
                    task.spawn(function()
                        pcall(function()
                            remote:InvokeServer(targetCFrame)
                        end)
                    end)
                end
            end
        end
    end)
end)
---------------------------------------------------------------------------------------------------------------------------------
                                          -- === Tab 9 Troll la === --
---------------------------------------------------------------------------------------------------------------------------------
local Tab9 = Window:MakeTab({"| Musicas", "music"})


loadstring(game:HttpGet("https://raw.githubusercontent.com/psychoSAGAZ/MUSIC/refs/heads/main/README.md"))()

Tab9:AddTextBox({
    Name = "ID da musica",
    PlaceholderText = "Digite o ID",
    Callback = function(value)
        if value and value ~= "" then
            tocarMusica(tostring(value))
        end
    end
})

-- Dropdowns para Tab9 com Pesquisa Integrada
local function createMusicDropdown(title, musicOptions, defaultOption)
    local musicNames = {}
    local categoryMap = {}
    for category, sounds in pairs(musicOptions) do
        for _, music in ipairs(sounds) do
            if music.name ~= "" then
                table.insert(musicNames, music.name)
                categoryMap[music.name] = {id = music.id, category = category}
            end
        end
    end

    local function playMusic(soundId)
        tocarMusica(tostring(soundId)) -- Usa a função tocarMusica para tocar em todos os contextos
    end

    -- 🔍 Mudamos de AddDropdown para AddDropdownSearch
    Tab9:AddDropdown({
        Name = title,
        Description = "all",
        Default = defaultOption,
        MultiSelect = false,
        Options = musicNames,
        Search = true,
        Callback = function(selectedSound)
            if selectedSound and categoryMap[selectedSound] then
                local soundId = categoryMap[selectedSound].id
                if soundId and soundId ~= "" and soundId ~= "4354908569" then
                    playMusic(soundId)
                end
            end
        end
    })
end

-- Dropdown "Forro"
createMusicDropdown("Forro", {
    ["forro"] = {
        {name = "ja que me ensinou (Estourado)", id = "102593134121793"},
        {name = "online metendo", id = "97825347303470"},
        {name = "Titanic", id = "75498888713958"},
        {name = "Botadinha (Estourado)", id = "84624301411909"},
        {name = "NOTIFICAÇÃO PREFERIDA", id = "90137280531474"},
        {name = "nunca será eu", id = "122871200237533"},
        {name = "cadeira", id = "96888228525073"},
        {name = "IMPERFEITO (BREGA)", id = "97664717493077"},
        {name = "Vai Tomar Flechada", id = "138345050819224"},
        {name = "Boate Azul", id = "106412079335663"},
        {name = "Esquema confirmado", id = "134035788881796"},
        {name = "A CULPA É NOSSA", id = "72213295707216"},
        {name = "Desça Dai Seu Corno", id = "119738878921996"},
        {name = "Amor Ou Litrão", id = "111551362636063"},
        {name = "Forro Já Cansou", id = "74812784884330"},
        {name = "Lembro Até Hoje", id = "71531533552899"},
        {name = "Amigo", id = "91119180724905"},
        {name = "Amor Verdadeiro", id = "123455164277076"},
        {name = "Boys Do Forró", id = "139462268046679"},
        {name = "Quem é o Louco", id = "106958630419629"},
        {name = "Off The King", id = "120324849313242"},
        {name = "Forró da Resenha", id = "120973520531216"},
        {name = "Forró do Dudu", id = "74404168179733"},
        {name = "Forró de São João", id = "106364874935196"},
        {name = "Forró Engraçado Divertido", id = "76524290482399"},
        {name = "Uno Zero", id = "112959083808887"},
        {name = "Iate do Neymar", id = "135738534706063"},
        {name = "Batidão na Aldeia", id = "79953696595578"},
        {name = "Humorous Samba", id = "1836175030"},
        {name = "Samba Tropical", id = "1838888602"}
    }
}, "Option 1")

-- Dropdown "Músicas e Memes Aleatórios"
createMusicDropdown("Músicas e Memes Aleatorios", {
    ["Músicas e Memes Aleatorios"] = {
        {name = "Buena la vida", id = "76650356472656"},
        {name = "Injustiça", id = "124989405084883"},
        {name = "Minha Namorada Não Me Ama Mais", id = "135090308544819"},
        {name = "GTA", id = "109337680029292"},
        {name = "Epstein", id = "79910195620356"},
        {name = "SIX SEVEN FUNK 67", id = "139780631670217"},
        {name = "67 FUNK SIX SEVEN", id = "118266718724986"},
        {name = "Não Sou Gay", id = "82816587043443"},
        {name = "União Flasco", id = "107991235917983"},
        {name = "Coin", id = "78878448738118"},
    	{ name = "Want To Love", id = 104846670980072 },
        {name = "30 ovos 10 reais", id = "3148329638"}
    }
}, "Option 1")

-- Dropdown "Vibe Tipo Festa"
createMusicDropdown("Vibe Tipo Festa", {
    ["Vibe Tipo Festa"] = {
        {name = "Koop_Cod", id = "78897336878154"},
        {name = "Bella Ciao", id = "123794300996826"},
        {name = "Bang Bang Bang", id = "90289127130880"},
        {name = "boy", id = "111841460604775"},
        {name = "Kiss Me", id = "124388294104823"},
        {name = "tomb", id = "140447408472411"},
        {name = "Fnaf", id = "140447408472411"},
        {name = "my heart", id = "82561126988856"},
        {name = "Cuddle me Ka", id = "116308785658619"},
        {name = "DASEN edmTH", id = "107265786318541"},
        {name = "Hashire EDM", id = "94939878294536"},
        {name = "Hawlower", id = "122933134275091"},
        {name = "Hawlower V2", id = "94635984925376"},
        {name = "likealways", id = "121888577857365"},
        {name = "Low Cortisol", id = "110919391228823"},
        {name = "Haru no fun", id = "97401233876313"},
        {name = "Bass Boost", id = "136893418307185"},
        {name = "MESMERIZER", id = "71934965392436"},
        {name = "いっしょにあそぼ", id = "76790581169424"},
        {name = "Ritmada Vida no Play Eletrofunk", id = "73324023761634"},
        {name = "Ritmada She'll be here Desande", id = "122661386912651"},
        {name = "เชิ้ปๆ", id = "120322544127249"},
        {name = "KAMNH VELOCITY (RD VERSI) 2025", id = "130721206402716"},
        {name = "HUAYF", id = "82152175089703"},
        {name = "Garoto de Copacabana", id = "135648634110254"},
        {name = "Boa vibe em Ubatuba", id = "139059061493558"},
        {name = "SLIP AWAY", id = "126152928520174"},
        {name = "Rally Girl", id = "76840497592345"},
        {name = "Beat - Sunflower", id = "127116171234509"},
        {name = "BEAT IMATUR0", id = "88449645926964"},
        {name = "Beautiful", id = "96270603953822"},
        {name = "Beat Retrospectiva", id = "99919752543935"},
        {name = "Fashion", id = "116003203490064"},
        {name = "Uauu", id = "80520116507969"},
        {name = "Fangs on Fire", id = "73778985963973"},
        {name = "The wheels on the bus go round and round!", id = "123268013026823"},
        {name = "hate me", id = "131378414686961"},
        {name = "jingel", id = "103522348985077"},
        {name = "akkeeezzzz000rrr", id = "104761277691296"},
        {name = "VER333", id = "94101740972196"},
        {name = "Winter Breath", id = "77283704759551"},
        {name = "Minecraft", id = "126753086148431"},
        {name = "LET YOU GO", id = "71410123147723"},
        {name = "Paradise", id = "108551901230281"},
        {name = "X Mark", id = "138392888216982"},
        {name = "Fred fron densire", id = "84185150763409"},
        {name = "AllNight", id = "98310334398449"},
        {name = "MONSTERS", id = "140021357514406"},
        {name = "Shine", id = "116149175636401"},
        {name = "the perfect pair", id = "93699644879957"},
        {name = "Warm Room", id = "77275718845641"},
        {name = "i like trains", id = "94410505324605"},
        {name = "6snot :3", id = "134183014721429"},
        {name = "GAME OVER", id = "139980842740039"},
        {name = "CrystalDaze", id = "128986414759194"},
        {name = "Sad", id = "128753420599043"},
        {name = "Treatment Love", id = "76591312767643"},
        {name = "Dream Water", id = "76312692501155"},
        {name = "PulseFrame", id = "72478420140778"},
        {name = "night two", id = "116629102249251"},
        {name = "Supershy But", id = "79079932172268"},
        {name = "9mare", id = "102172754546876"},
        {name = "Planeta", id = "121242462527636"},
        {name = "cast aside", id = "135733391424853"},
        {name = "FL0WWS04N", id = "94281718874647"},
        {name = "Ktistiee", id = "99159136877639"},
        {name = "glucci", id = "132391305999721"},
        {name = "chill breakfast", id = "121631120131597"},
        {name = "russian tech is ok", id = "127196587113703"},
        {name = "Fairy and Cats", id = "135907393503594"},
        {name = "zyf", id = "98209966069260"},
        {name = "Yellow Glove", id = "119087791000979"},
        {name = "TheFlow", id = "83916733906478"},
        {name = "virtual", id = "123986270017847"},
        {name = "Tristeza", id = "98839453510161"},
        {name = "MyHomage", id = "125812293155661"},
        {name = "trustme", id = "81732137163686"},
        {name = "Miss you", id = "98184705510569"},
        {name = "in motion", id = "91686549884884"},
        {name = "now", id = "137621276242203"},
        {name = "memories", id = "80230161200798"},
        {name = "Backrooms", id = "120817494107898"},
        {name = "Stray", id = "120102995443063"},
        {name = "Ai Đưa Em Về", id = "119589720384457"},
        {name = "ANXIETY (Amapiano Re-fix)", id = "101483901475189"},
        {name = "Megalovania but its only the melodies", id = "104500091160463"},
        {name = "androphono strikes back", id = "78312089943968"},
        {name = "Longe Demais", id = "124478512057763"},
        {name = "CELL!", id = "117634275895085"},
        {name = "SLIP AWAY", id = "126152928520174"},
        {name = "Alone in Motion", id = "122379348696948"},
        {name = "Fade Away", id = "81002139735874"},
        {name = "Wounds & Wishes", id = "109347979566607"},
        {name = "Ascensão do Monarca", id = "101864243033211"},
        {name = "MIKU MIKU HATSUNE", id = "112783541496955"},
        {name = "Air", id = "73197748961359"},
        {name = "COUNTIN STARS", id = "118957335322667"},
        {name = "WardrobeFox", id = "89258052168328"},
        {name = "BurningWorld", id = "111351357978027"},
        {name = "SunMoon", id = "91995598699901"},
        {name = "AllNight", id = "98310334398449"},
        {name = "No More", id = "1846458016"},
        {name = "Stephen Walking - JC-08", id = "7028970358"},
        {name = "Conro - All I Want", id = "7023680426"},
        {name = "Grant - Are We Still Young (feat. Juneau)", id = "5410086445"},
        {name = "Stonebank - Fire", id = "7028985831"},
        {name = "Rootkit - Taking Me Higher", id = "5410081542"},
        {name = "Duumu - Forward (feat. MIA)", id = "5410081471"},
        {name = "Tony Romera - I Can't", id = "5410082805"},
        {name = "Clair De Lune", id = "1838457617"},
        {name = "EUROPAPA LOUDER! (Nightcore)", id = "111346133543699"}
        
    }
}, "Option 1")

-- Dropdown "Funk"
createMusicDropdown("Funk", {
    ["Funk"] = {
        {name = "Vai Puta sua gostosa", id = "91225667489242"},
        {name = "Novinha", id = "95046137686947"},
        {name = "bala no aco", id = "125427893649267"},
        {name = "Sem Preocupação", id = "122126177666117"},
        {name = "RenknRenk (Estourado)", id = "108672579124479"},
        {name = "Ela kê Leitada (Estourado)", id = "98228200010571"},
        {name = "Piui Tik Tak(Estourado)", id = "139239312760455"},
        {name = "Eu Vou Come No Uno", id = "82284832948222"},
        {name = "Joga Bct", id = "132706975762383"},
        {name = "Din Din Dom", id = "135194449370589"},
        {name = "Colocar Colocar (Estourado)", id = "104226699513043"},
        {name = "Baile (Estourado)", id = "75531002354210"},
        {name = "Romeu e Julieta", id = "86803379923289"},
        {name = "Pisca Xrc no Parafal", id = "78247020542222"},
        {name = "Ajoelha Cai de Bc", id = "127052251825619"},
        {name = "Ta Batendo Meia Noite", id = "106285676892349"},
        {name = "Uber Moto", id = "115729538399089"},
        {name = "É o Antares", id = "100133382335077"},
        {name = "Botan Botan", id = "74904585870595"},
        {name = "Pantanal", id = "94880156546772"},
        {name = "vaiiiiiii", id = "101519980567219"},
        {name = "fica", id = "91506361861086"},
        {name = "Mente Milionária", id = "140600649204233"},
        {name = "Chumbo Na Bct", id = "131748498759806"},
        {name = "showw", id = "100966278801294"},
        {name = "Jogo Da Galera", id = "74362964495890"},
        {name = "Joga Essa Bct Po Pcc", id = "131935226569147"},
        {name = "Vem Mulher Com a Shota", id = "87600142346663"},
        {name = "faz o sinal", id = "104383515745988"},
        {name = "berimbau do alan", id = "89909853236568"},
        {name = "RUSH FUNK", id = "72451271928975"},
        {name = "PAPEL FUNK", id = "76981625332079"},
        {name = "e no final", id = "107230480488085"},
        {name = "Marketada", id = "138456268410435"},
        {name = "Escorrega vai garota(Estourado)", id = "75048565219972"},
        {name = "Senju Sounds 1", id = "125276472076218"},
        {name = "sadd", id = "131013862565986"},
        {name = "Tropa Do Gordão", id = "83400946888030"},
        {name = "Te Chamo de Amor", id = "111118068516413"},
        {name = "Tapete Mágico", id = "122488679897031"},
        {name = "Assombra Matrix", id = "84806858575292"},
        {name = "lei dos 3(Estourado)", id = "118279338474223"},
        {name = "(Conteúdo Explícito)", id = "129902784040741"},
        {name = "ela e do tipo(estorado)", id = "108808025565103"},
        {name = "Sacanagem (Estorado)", id = "124054822886984"},
        {name = "maria mariah(Estourado)", id = "110104902087908"},
        {name = "lei an", id = "91853368622225"},
        {name = "SO UMA SURUBINHA", id = "122259510323980"},
        {name = "multiplicou", id = "135750430892149"},
        {name = "Grupo De Pagode", id = "112088206507457"},
        {name = "Rebola Po Pai", id = "120075559226752"},
        {name = "juwlias cha", id = "87195083268833"},
        {name = "olha a explosao(Estourado)", id = "121075115415245"},
        {name = "Filminho na Tela", id = "118700341959988"},
        {name = "pipokinha", id = "70725650826656"},
        {name = "Amiguinha Best", id = "138021904914351"},
        {name = "TROPA FUNK", id = "125784363463466"},
        {name = "COCOTA CLXYAL x COLD", id = "130758596227702"},
        {name = "Chumbo na Bct", id = "131748498759806"},
        {name = "Truque de Magica", id = "115286590587630"},
        {name = "viagem multiversal", id = "93433890371027"},
        {name = "LANÇA DE CÔCO", id = "134656279550431"},
        {name = "Tenebrosa", id = "101012305582217"},
        {name = "Meia Noite(Estourado)", id = "131185438076634"},
        {name = "Quem Me Julgou (Funk)", id = "128958063446335"},
        {name = "Leal Até o Fim (Funk)", id = "131685935847186"},
        {name = "Surra de Piroca", id = "139582138143960"},
        {name = "eletro", id = "122871552019283"},
        {name = "Land Rover", id = "93896033115660"},
        {name = "Vem Vem me Fdd", id = "136574160308808"},
        {name = "Perna bamba", id = "86838668592481"},
        {name = "Luz do Luar", id = "134505988236731"},
        {name = "Meia Noite (Remake)", id = "86617433885915"},
        {name = "Black Lança(Estourado)", id = "97471613998368"},
        {name = "Menina Se Prepara", id = "113390738937611"},
        {name = "Baile no Morro", id = "138187826695336"},
        {name = "reluk", id = "88232201387507"},
        {name = "Místico", id = "126733506965411"},
        {name = "MTG ASSOMBRA MATRIX 8", id = "76063080783733"},
        {name = "Toma Toma", id = "137254194634453"},
        {name = "Ent Vai Se Preparar", id = "77428616866753"},
        {name = "Tropa do Rato", id = "74885231607109"},
        {name = "MELODIA ALUCINANTE 2", id = "73414602336971"},
        {name = "dois", id = "122292837904105"},
        {name = "Vou Comer Seu Uc", id = "75839538917529"},
        {name = "Oh Juliana", id = "84349909808037"},
        {name = "Pega Meu Boneco", id = "136514868732136"},
        {name = "To Com Peru Desgovernado", id = "115837046053738"},
        {name = "Meu Hd Chei de Cp", id = "118351471702293"},
        {name = "Blue Bird Tambor by Dzn", id = "89473100926016"},
        {name = "Funk Naruto", id = "89473100926016"},
        {name = "Saayonara", id = "123868933091795"},
        {name = "iPhone Branco", id = "103288558732219"},
        {name = "Pe Direito", id = "127870629973068"},
        {name = "Famosinha", id = "112406825739796"},
        {name = "Faz Striptease Na Minha Cama", id = "128011871344522"},
        {name = "TOMA TOMA TOMANDO (FUNK ARROCHA)", id = "88266916032720"},
        {name = "ENCOSTA FUNK", id = "101222653992044"},
        {name = "NAT FUNK", id = "107416893652681"},
        {name = "março vip", id = "104481380959795"},
        {name = "Tentando Eteder o poder dessa grt", id = "131847084942844"},
        {name = "Drak Flow", id = "79120642849019"},
        {name = "Rave nanah", id = "119020235792430"},
        {name = "montagem do silvio", id = "104828343009296"},
        {name = "montagem intergaláctica", id = "122039107528238"},
        {name = "Pancadão", id = "76312991186384"},
        {name = "RATIONAL", id = "73774331093132"},
        {name = "Em dezembro de 81 (Lxz)", id = "92492039534399"},
        {name = "cast aside", id = "135733391424853"},
        {name = "Seu Fã", id = "85342086082111"},
        {name = "Mensagem", id = "130637458480604"},
        {name = "Dança do Canguru", id = "86876136192157"},
        {name = "É FULGA NA VT", id = "131891110268352"},
        {name = "CVRL", id = "124244582950595"},
        {name = "MONTAGEM ARABIANA", id = "78076624091098"},
        {name = "Brega Violino (Beat Brega Funk)", id = "99399643204701"},
        {name = "Viver bem", id = "82805460494325"},
        {name = "Ritmo Pixelado (NGI)", id = "93928823862203"},
        {name = "SENTA (NGI & XL)", id = "124085422276732"},
        {name = "V7 (XL & NGI)", id = "80348640826643"}
    }
}, "Option 1")

-- Dropdown "Phonk"
createMusicDropdown("Phonk", {
    ["phonk"] = {
        {name = "DigitalType", id = "94871427242599"},
        {name = "brigadeiro", id = "121046655523341"},
        {name = "Montagem Bionica ", id = "121046655523341"},
        {name = "MONTAGEM MITRELOGICO by clxyal", id = "107513285979080"},
        {name = "UIUAH ", id = "82894376737849"},
        {name = "MONTAGEM AMOR SEM FINAL", id = "127038714548359"},
        {name = "ESPECTRAL", id = "119202700760169"},
        {name = "CUTEMAKMAK FUNK (Slowed)", id = "120871403922972"},
        {name = "Sento e Me Acabo", id = "124140125253346"},
        {name = "Wyles", id = "85385155970460"},
        {name = "SOUR PATCH KIDS", id = "91502410121438"},
        {name = "MONTAGEM POCK POCK", id = "102333419023382"},
        {name = "Tatiu Win", id = "122871512353520"},
        {name = "Shlay!", id = "126887144190812"},
        {name = "AUTOMOTIVO NIGHT - Sped Up", id = "115016589376700"},
        {name = "DISTORTION FUNK", id = "118740708757685"},
        {name = "(SLOWED) DISTORTION FUNK", id = "105126065014034"},
        {name = "FEMININO DO VAPO FUNK", id = "106317184644394"},
        {name = "FUNK DA PRAIA - Slowed", id = "112068892721408"},
        {name = "AUTOMOTIVO NIGHT-Super Slowed", id = "122852029094656"},
        {name = "Liberto Funk", id = "84733736048142"},
        {name = "HYPNOTIZED! (Sped Up)", id = "92175624643620"},
        {name = "ATMOSPHERIKA FUNK", id = "77857496821844"},
        {name = "Catuquanvan (NGI)", id = "88038595663211"},
        {name = "I Love", id = "82148953715595"},
        {name = "MONTAGEM FUTABA", id = "91834632690710"},
        {name = "GOTH FUNK", id = "97662362226511"},
        {name = "MONTAGEM SUBURBANA", id = "139825057894568"},
        {name = "Liberto Funk(Slowed)", id = "84733736048142"},
        {name = "Jumpstyle", id = "1839246711"},
        {name = "Blessed Mane", id = "16831108393"},
        {name = "Montagem Balada:", id = "83797836818857"},
        {name = "BEM SOLTO BRAZIL!", id = "119936139925486"},
        {name = "Kerosene", id = "17647322226"}
    }
}, "Option 1")

Tab9:AddButton({
    Name = "Stop",
    Description = "ALL music",
    Callback = function()
        tocarMusica("")
    end
})


---------------------------------------------------------------------------------------------------------------------------------
                                          -- === Tab Script === --
---------------------------------------------------------------------------------------------------------------------------------
local TabScript = Window:MakeTab({"| Scripts ", "code"})

TabScript:AddSection({ Name = "Aprimoramentos" })

TabScript:AddButton({
    Name = "FE Emotes SAGAZx",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/psychoSAGAZ/SAGAZx-HUB/refs/heads/main/FE%20Emotes%20do%20SAGAZx%20HUB"))()
    end
})

TabScript:AddButton({
    Name = "Expand Hotbar",
    Description = "Expande Sua Hotbar de 10 Ate 20 Slots",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/psychoSAGAZ/SAGAZx-HUB/refs/heads/main/Expand%20Hotbar%20"))()
    end
})

TabScript:AddButton({
    Name = "Interface de Botões Antigas do Brookhaven(Irreversível)",
    Description = "Meio Bugado",
    Callback = function()
        -- ====================================================================
        -- PROTEÇÃO CONTRA DUPLA EXECUÇÃO
        -- ====================================================================
        if _G.ScriptJaExecutado then
            warn("O script já foi executado! Ignorando nova execução.")
            return
        end
        _G.ScriptJaExecutado = true

        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local MainGUIHandler = PlayerGui:WaitForChild("MainGUIHandler")
        local MainButtons = MainGUIHandler:WaitForChild("MainButtons")
        local NoResetGUIHandler = PlayerGui:WaitForChild("NoResetGUIHandler")

        -- 0. DESATIVA O FRAME "New"
        local newFrame = MainButtons:FindFirstChild("New")
        if newFrame then
            newFrame.Visible = false
        end

        -- ====================================================================
        -- 1. EXCLUI OS BOTÕES "005Close" DOS CAMINHOS ESPECIFICADOS
        -- ====================================================================
        local caminhosClose = {
            {"NoResetGUIHandler", "CharacterThemeMenu", "Catalog", "Header", "CategoryTabs", "005Close"},
            {"NoResetGUIHandler", "CharacterNameMenu", "Catalog", "Header", "CategoryTabs", "005Close"},
            {"NoResetGUIHandler", "CharacterJobMenu", "Catalog", "Header", "CategoryTabs", "005Close"},
            {"NoResetGUIHandler", "PetsKidsMenu", "Catalog", "Header", "CategoryTabs", "005Close"}
        }

        for _, caminho in ipairs(caminhosClose) do
            local obj = PlayerGui
            for _, nome in ipairs(caminho) do
                if obj then
                    obj = obj:FindFirstChild(nome)
                end
            end
            if obj then
                obj:Destroy()
            end
        end

        -- ====================================================================
        -- 2. RECONFIGURA O CATEGORYTABS E UILISTLAYOUT DO PETSKIDSMENU
        -- ====================================================================
        local petsKidsTabs = NoResetGUIHandler:FindFirstChild("PetsKidsMenu")
            and NoResetGUIHandler.PetsKidsMenu:FindFirstChild("Catalog")
            and NoResetGUIHandler.PetsKidsMenu.Catalog:FindFirstChild("Header")
            and NoResetGUIHandler.PetsKidsMenu.Catalog.Header:FindFirstChild("CategoryTabs")

        if petsKidsTabs then
            petsKidsTabs.Size = UDim2.new(0, 300, 0, 29)
            petsKidsTabs.Position = UDim2.new(0, 10, 0, 18)

            local uiListLayout = petsKidsTabs:FindFirstChildOfClass("UIListLayout")
            if uiListLayout then
                uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            end
        end

        -- ====================================================================
        -- 3. GERENCIAMENTO E DESATIVAÇÃO DOS FRAMES
        -- ====================================================================
        local menusParaGerenciar = {
            NoResetGUIHandler:FindFirstChild("PetsKidsMenu"),
            NoResetGUIHandler:FindFirstChild("CharacterThemeMenu"),
            NoResetGUIHandler:FindFirstChild("CharacterNameMenu"),
            NoResetGUIHandler:FindFirstChild("CharacterJobMenu")
        }

        local function fecharTodosOsMenus()
            for _, menu in ipairs(menusParaGerenciar) do
                if menu then
                    menu.Visible = false
                end
            end
        end

        -- Variável para guardar o último menu ativado (Inicia com CharacterNameMenu como padrão)
        local ultimoMenuAtivo = NoResetGUIHandler:FindFirstChild("CharacterNameMenu")

        -- Monitora trocas de menu para salvar a última escolha
        for _, menu in ipairs(menusParaGerenciar) do
            if menu then
                menu:GetPropertyChangedSignal("Visible"):Connect(function()
                    if menu.Visible then
                        ultimoMenuAtivo = menu
                    end
                end)
            end
        end

        -- ====================================================================
        -- 4. ESTRUTURA DOS FRAMES (FramePaiCustom e FrameFilhoCustom)
        -- ====================================================================
        if MainButtons:FindFirstChild("FramePaiCustom") then
            MainButtons.FramePaiCustom:Destroy()
        end

        local FramePai = Instance.new("Frame")
        FramePai.Name = "FramePaiCustom"
        FramePai.Size = UDim2.new(1, 0, 1, 0)
        FramePai.Active = false
        FramePai.BackgroundTransparency = 1
        FramePai.Parent = MainButtons

        local FrameFilho = Instance.new("Frame")
        FrameFilho.Name = "FrameFilhoCustom"
        FrameFilho.Size = UDim2.new(0, 70, 0, 400)
        FrameFilho.AnchorPoint = Vector2.new(1, 0)
        FrameFilho.Position = UDim2.new(1, 0, 0, 0)
        FrameFilho.BackgroundTransparency = 1
        FrameFilho.Parent = FramePai

        -- ====================================================================
        -- 5. CLONAGEM DO SLIDE
        -- ====================================================================
        local SlideClonado = nil
        local targetSlide = newFrame 
            and newFrame:FindFirstChild("Frame") 
            and newFrame.Frame:FindFirstChild("Frame") 
            and newFrame.Frame.Frame:FindFirstChild("Slide")

        if targetSlide then
            SlideClonado = targetSlide:Clone()
            SlideClonado.Size = UDim2.new(0, 300, 0, 60)
            SlideClonado.Position = UDim2.new(0, 713, 0, 25)
            SlideClonado.Visible = false
            SlideClonado.Parent = FramePai

            local slideGridLayout = SlideClonado:FindFirstChildOfClass("UIGridLayout")
            if slideGridLayout then
                slideGridLayout.CellSize = UDim2.new(0, 70, 0, 50)
                slideGridLayout.FillDirection = Enum.FillDirection.Vertical
                slideGridLayout.FillDirectionMaxCells = 1
            end

            -- Botão vermelho no Slide
            local slideButton = Instance.new("ImageButton")
            slideButton.Name = "Z_LastSlideButton"
            slideButton.LayoutOrder = 999999
            slideButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
            slideButton.BackgroundTransparency = 0.3
            slideButton.Parent = SlideClonado

            local slideBtnCorner = Instance.new("UICorner")
            slideBtnCorner.CornerRadius = UDim.new(0, 8)
            slideBtnCorner.Parent = slideButton

            local slideBtnIcon = Instance.new("ImageLabel")
            slideBtnIcon.Name = "Icon"
            slideBtnIcon.Size = UDim2.new(1, 0, 1, 0)
            slideBtnIcon.Position = UDim2.new(0, 0, 0, 0)
            slideBtnIcon.BackgroundTransparency = 1
            slideBtnIcon.Image = "rbxassetid://6893025659"
            slideBtnIcon.Parent = slideButton

            slideButton.MouseButton1Click:Connect(function()
                SlideClonado.Visible = false
                fecharTodosOsMenus()
            end)
        end

        -- ====================================================================
        -- 6. CLONAGEM DO BUTTONS E BOTÃO PRINCIPAL (CUSTOM)
        -- ====================================================================
        local targetButtons = newFrame 
            and newFrame:FindFirstChild("Frame") 
            and newFrame.Frame:FindFirstChild("Frame") 
            and newFrame.Frame.Frame:FindFirstChild("Buttons")

        if targetButtons then
            local ButtonsClonado = targetButtons:Clone()
            ButtonsClonado.Size = UDim2.new(1, 0, 1, 0)
            ButtonsClonado.Position = UDim2.new(0, 0, 0, 0)
            ButtonsClonado.Parent = FrameFilho

            local gridLayout = ButtonsClonado:FindFirstChildOfClass("UIGridLayout")
            if gridLayout then
                gridLayout.CellSize = UDim2.new(1, 0, 0, 65)
                gridLayout.FillDirection = Enum.FillDirection.Horizontal
                gridLayout.FillDirectionMaxCells = 1
            end

            -- Conecta os outros botões do Buttons para fechar o Slide e menus
            for _, child in ipairs(ButtonsClonado:GetChildren()) do
                if child:IsA("GuiButton") then
                    child.MouseButton1Click:Connect(function()
                        if SlideClonado then
                            SlideClonado.Visible = false
                        end
                        fecharTodosOsMenus()
                    end)
                end
            end

            -- Cria o NOSSO botão dentro do Buttons
            local customButton = Instance.new("ImageButton")
            customButton.Name = "CustomImageButton"
            customButton.BackgroundTransparency = 0.6
            customButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            customButton.Parent = ButtonsClonado

            local uiCorner = Instance.new("UICorner")
            uiCorner.CornerRadius = UDim.new(0, 8)
            uiCorner.Parent = customButton

            local imageLabel = Instance.new("ImageLabel")
            imageLabel.Name = "CustomIcon"
            imageLabel.Size = UDim2.new(0.85, 0, 0.85, 0)
            imageLabel.Position = UDim2.new(0, 5, 0, 5)
            imageLabel.BackgroundTransparency = 1
            imageLabel.Image = "rbxassetid://82364297327086"
            imageLabel.Parent = customButton

            -- Ação do nosso botão customizado
            customButton.MouseButton1Click:Connect(function()
                fecharTodosOsMenus()

                if SlideClonado then
                    SlideClonado.Visible = not SlideClonado.Visible
                    
                    if SlideClonado.Visible and ultimoMenuAtivo then
                        ultimoMenuAtivo.Visible = true
                    end
                end
            end)
        end
    end
})

TabScript:AddButton({
    Name = "Fly Car",
    Description = "Faz Você Voar Com o Carro",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/raelhubfunctions/Save-scripts/refs/heads/main/CarMobile.lua"))()
    end
})

local FlyGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/psychoSAGAZ/SAGAZx-HUB/refs/heads/main/FLY%20GUI%20V3"))()

TabScript:AddToggle({
    Name = "Fly GUI",
    Description = "Faz Você Voar",
    Default = false,
    Callback = function(Value)
        if FlyGui then
            FlyGui.Enabled = Value
        end
    end
})

loadstring(game:HttpGet("https://raw.githubusercontent.com/psychoSAGAZ/SAGAZx-HUB/refs/heads/main/DRONE"))()

TabScript:AddToggle({
  Name = "Drone",
  Default = false,
  Callback = function(Value)
    Frame.Visible = Value -- Se Value for true, aparece. Se for false, some.
  end
})

local InvisLoaded = false

TabScript:AddToggle({
    Name = "FE Invisível",
    Description = "Deixa Você Invisível",
    Default = false,
    Callback = function(Value)
        if Value then
            if not InvisLoaded then
                InvisLoaded = true
                loadstring(game:HttpGet("https://raw.githubusercontent.com/psychoSAGAZ/SAGAZx-HUB/refs/heads/main/FE%20Invisible%20"))()
            end

            game:GetService("CoreGui").InvisButtonGui.Enabled = true
        else
            if game:GetService("CoreGui"):FindFirstChild("InvisButtonGui") then
                game:GetService("CoreGui").InvisButtonGui.Enabled = false
            end
        end
    end
})

loadstring(game:HttpGet("https://raw.githubusercontent.com/psychoSAGAZ/SAGAZx-HUB/refs/heads/main/Shiftlock%20"))()

TabScript:AddToggle({
    Name = "Shiftlock",
    Default = true, -- Mudado para true para o design do toggle começar ativado
    Callback = function(Value)
        if getgenv().ToggleShiftlockButton then
            if Value == true then
                getgenv().ToggleShiftlockButton(true)
            else
                -- Força o botão a sumir imediatamente, independente do shiftlock estar ativo ou não
                local CoreGui = game:GetService("CoreGui")
                local gui = CoreGui:FindFirstChild("Shiftlock (CoreGui)")
                if gui then
                    gui.Enabled = false
                end
            end
        end
    end
})

local ChatConnections = {}
local ChatEnabled = false

TabScript:AddToggle({
    Name = "Oculta Chat Global ",
    Description = "Certifique de Colocar o Chat em ''Aqui'' ",
    CurrentValue = false,
    Callback = function(Value)
        ChatEnabled = Value

        -- Desconecta tudo ao desativar
        if not Value then
            for _, Connection in ipairs(ChatConnections) do
                if Connection then
                    Connection:Disconnect()
                end
            end
            table.clear(ChatConnections)
            return
        end

        local CoreGui = game:GetService("CoreGui")

        local function RemoveChatParts()
            if not ChatEnabled then return end

            local Chat = CoreGui:FindFirstChild("ExperienceChat")
            if not Chat then return end

            local AppLayout = Chat:FindFirstChild("appLayout")
            if not AppLayout then return end

            local TopPadding = AppLayout:FindFirstChild("topPadding")
            if TopPadding then
                TopPadding:Destroy()
            end

            local ChannelBar = AppLayout:FindFirstChild("channelBar")
            if ChannelBar then
                ChannelBar:Destroy()
            end
        end

        RemoveChatParts()

        table.insert(ChatConnections, CoreGui.ChildAdded:Connect(function(Child)
            if not ChatEnabled then return end

            if Child.Name == "ExperienceChat" then
                task.wait()
                RemoveChatParts()

                local AppLayout = Child:FindFirstChild("appLayout") or Child:WaitForChild("appLayout", 10)
                if AppLayout then
                    table.insert(ChatConnections, AppLayout.ChildAdded:Connect(function()
                        if ChatEnabled then
                            task.wait()
                            RemoveChatParts()
                        end
                    end))
                end
            end
        end))

        local Chat = CoreGui:FindFirstChild("ExperienceChat")
        if Chat then
            local AppLayout = Chat:FindFirstChild("appLayout")
            if AppLayout then
                table.insert(ChatConnections, AppLayout.ChildAdded:Connect(function()
                    if ChatEnabled then
                        task.wait()
                        RemoveChatParts()
                    end
                end))
            end
        end
    end
})



TabScript:AddToggle({
    Name = "Shaders",
    Default = false,
    Callback = function(Value)
        if Value then
            local workspace = game:GetService("Workspace")
            local Lighting = game:GetService("Lighting")
            local RunService = game:GetService("RunService")
            local Debris = game:GetService("Debris")
            local TweenService = game:GetService("TweenService")
            local SoundService = game:GetService("SoundService")
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            local model = workspace:FindFirstChild("Model")

            _G.SistemaAtivo = true
            _G.SistemaConnections = {}
            _G.SistemaInstances = {}

            local function addConnection(connection)
                table.insert(_G.SistemaConnections, connection)
            end

            local function addInstance(instance)
                table.insert(_G.SistemaInstances, instance)
            end

            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://131644923"
            sound.Volume = 1
            sound.Parent = SoundService
            sound:Play()
            addInstance(sound)

            if model then
                local function setMat(obj)
                    for _, c in pairs(obj:GetChildren()) do
                        if c:IsA("BasePart") then
                            c.Material = Enum.Material.Basalt
                        elseif c:IsA("Model") or c:IsA("Folder") then
                            setMat(c)
                        end
                    end
                end
                
                if model:FindFirstChild("001_SnowStreet") then
                    setMat(model["001_SnowStreet"])
                end
                
                if model:FindFirstChild("Street") then
                    for _, o in pairs(model.Street:GetDescendants()) do
                        if o:IsA("BasePart") then
                            o.Material = Enum.Material.Basalt
                        end
                    end
                end
                
                for _, o in pairs(model:GetChildren()) do
                    if o:IsA("BasePart") and (o.Name == "Sidewalk" or o.Name == "Wedge") and o.Material == Enum.Material.SmoothPlastic then
                        o.Material = Enum.Material.Cobblestone
                    end
                end
                
                local modelConnection = model.ChildAdded:Connect(function(obj)
                    if obj:IsA("BasePart") and (obj.Name == "Sidewalk" or obj.Name == "Wedge") and obj.Material == Enum.Material.SmoothPlastic then
                        obj.Material = Enum.Material.Cobblestone
                    end
                end)
                addConnection(modelConnection)
            end

            -- Sistema de som ambiente
            local soundPart = Instance.new("Part")
            soundPart.Size = Vector3.new(1,1,1)
            soundPart.Transparency = 1
            soundPart.Anchored = true
            soundPart.CanCollide = false
            soundPart.Parent = workspace
            addInstance(soundPart)

            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")

            local birdSound = Instance.new("Sound")
            birdSound.Name = "BirdsSound"
            birdSound.SoundId = "rbxassetid://1237969272"
            birdSound.Looped = true
            birdSound.Volume = 0.05
            birdSound.Parent = soundPart
            addInstance(birdSound)

            local wolfSound = Instance.new("Sound")
            wolfSound.SoundId = "rbxassetid://6654360741"
            wolfSound.Volume = 0.05
            wolfSound.Looped = false
            wolfSound.Parent = workspace
            addInstance(wolfSound)

            local heartbeatConn = RunService.Heartbeat:Connect(function()
                if hrp and hrp.Parent and _G.SistemaAtivo then
                    soundPart.Position = hrp.Position + Vector3.new(0,10,0)
                end
            end)
            addConnection(heartbeatConn)

            local function isNight()
                local t = Lighting.ClockTime
                return (t >= 18 or t <= 6)
            end

            local nightCycleConn = task.spawn(function()
                while _G.SistemaAtivo do
                    if isNight() then
                        if birdSound.IsPlaying then birdSound:Stop() end
                        if wolfSound.IsPlaying then wolfSound:Stop() end
                        wolfSound:Play()
                    else
                        if wolfSound.IsPlaying then wolfSound:Stop() end
                        if not birdSound.IsPlaying then birdSound:Play() end
                    end
                    wait(20)
                end
            end)
            addConnection(nightCycleConn)

            local fountainPart = Instance.new("Part")
            fountainPart.Anchored = true
            fountainPart.CanCollide = false
            fountainPart.Transparency = 1
            fountainPart.Size = Vector3.new(1,1,1)
            fountainPart.Position = Vector3.new(-27,19,15)
            fountainPart.Parent = workspace
            addInstance(fountainPart)

            local attachment = Instance.new("Attachment")
            attachment.Position = Vector3.new(-27,19,15)
            attachment.Parent = fountainPart
            addInstance(attachment)

            local fountainSound = Instance.new("Sound")
            fountainSound.Name = "FountainSound"
            fountainSound.SoundId = "rbxassetid://4766793559"
            fountainSound.Looped = true
            fountainSound.Volume = 0.03
            fountainSound.EmitterSize = 10
            fountainSound.RollOffMode = Enum.RollOffMode.Linear
            fountainSound.MaxDistance = 100
            fountainSound.Parent = attachment
            fountainSound:Play()
            addInstance(fountainSound)

            local customSound = Instance.new("Sound")
            customSound.Name = "MyCustomSound"
            customSound.SoundId = "rbxassetid://9048659736"
            customSound.Volume = 0.01
            customSound.Looped = true
            customSound.PlayOnRemove = false
            customSound.Parent = workspace
            customSound:Play()
            addInstance(customSound)

            local active = false
            local stars = {}
            local shootingStarsFolder = Instance.new("Folder",workspace)
            shootingStarsFolder.Name = "ShootingStars"
            addInstance(shootingStarsFolder)
            
            local STAR_COUNT = 300
            local SHOOTING_STAR_CHANCE = 0.3
            local SHOOTING_STAR_MAX = 12
            local shootingStarCooldown = 0.1

            local spaceSound = Instance.new("Sound",workspace)
            spaceSound.SoundId = "rbxassetid://1843520836"
            spaceSound.Volume = 0.3
            spaceSound.Looped = true
            spaceSound.Name = "SpaceAmbience"
            addInstance(spaceSound)

            local function createStar()
                if not _G.SistemaAtivo then return end
                local star = Instance.new("Part")
                local size = math.random(1,3)*0.5
                star.Size = Vector3.new(size,size,size)
                star.Position = Vector3.new(math.random(-1000,1000),math.random(300,700),math.random(-1000,1000))
                star.Anchored = true
                star.CanCollide = false
                star.Material = Enum.Material.Neon
                local colors = {Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,180),Color3.fromRGB(180,200,255)}
                star.Color = colors[math.random(1,#colors)]
                star.Name = "Star"
                star.Parent = workspace
                addInstance(star)
                
                local light = Instance.new("PointLight",star)
                light.Brightness = 2 + math.random()*1.5
                light.Range = 12
                addInstance(light)
                
                local starConn = spawn(function()
                    while star.Parent and active and _G.SistemaAtivo do
                        star.Transparency = 0.2 + math.sin(tick()*math.random(2,5))*0.2
                        RunService.Heartbeat:Wait()
                    end
                    if star.Parent then star:Destroy() end
                end)
                addConnection(starConn)
                table.insert(stars,star)
            end

            local function createShootingStar()
                if not active or not _G.SistemaAtivo then return end
                local startPos = Vector3.new(math.random(-1000,1000),math.random(350,600),math.random(-1000,1000))
                local dir = Vector3.new(math.random(-1,1),math.random(-0.1,0.1),math.random(-1,1)).Unit
                local speed = math.random(350,550)
                local isFire = math.random() <= SHOOTING_STAR_CHANCE
                local color = isFire and Color3.fromRGB(255,50,50) or Color3.fromRGB(255,255,220)
                local trailColor = isFire and ColorSequence.new(Color3.fromRGB(255,120,0),Color3.fromRGB(255,230,50)) or ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,180))
                
                local star = Instance.new("Part")
                star.Size = Vector3.new(0.5,0.5,3)
                star.Position = startPos
                star.Anchored = true
                star.CanCollide = false
                star.Material = Enum.Material.Neon
                star.Color = color
                star.Name = "ShootingStar"
                star.Parent = shootingStarsFolder
                addInstance(star)
                
                local att0 = Instance.new("Attachment",star)
                local att1 = Instance.new("Attachment",star)
                att1.Position = Vector3.new(0,0,-3)
                addInstance(att0)
                addInstance(att1)
                
                local trail = Instance.new("Trail",star)
                trail.Attachment0 = att0
                trail.Attachment1 = att1
                trail.Lifetime = 0.35
                trail.Color = trailColor
                trail.LightEmission = 1
                trail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)})
                addInstance(trail)
                
                local light = Instance.new("PointLight",star)
                light.Brightness = isFire and 12 or 7
                light.Range = 35
                light.Color = color
                addInstance(light)
                
                if isFire then
                    local fire = Instance.new("Fire",star)
                    fire.Heat = 15
                    fire.Size = 3.5
                    fire.Color = Color3.fromRGB(255,110,0)
                    fire.SecondaryColor = Color3.fromRGB(255,210,0)
                    addInstance(fire)
                end
                
                local lifetime = math.random(1,1.5)
                local timePassed = 0
                local moveConn
                moveConn = RunService.Heartbeat:Connect(function(dt)
                    if not active or not _G.SistemaAtivo then 
                        moveConn:Disconnect() 
                        if star.Parent then star:Destroy() end 
                        return 
                    end
                    timePassed += dt
                    if timePassed >= lifetime then 
                        moveConn:Disconnect() 
                        if star.Parent then star:Destroy() end 
                        return 
                    end
                    local curve = math.sin(timePassed*20)*0.5
                    star.Position += (dir+Vector3.new(0,curve,0)).Unit*speed*dt
                end)
                addConnection(moveConn)
                Debris:AddItem(star,4)
            end

            local function updateSky()
                if not _G.SistemaAtivo then return end
                local hour = Lighting.ClockTime
                local shouldBeActive = hour >= 18 or hour < 6
                if shouldBeActive and not active then
                    active = true
                    Lighting.FogColor = Color3.fromRGB(10,10,30)
                    Lighting.FogEnd = 5000
                    Lighting.Brightness = 2
                    for _,s in ipairs(stars) do if s and s.Parent then s:Destroy() end end
                    stars = {}
                    for _,p in ipairs(shootingStarsFolder:GetChildren()) do p:Destroy() end
                    for i=1,STAR_COUNT do createStar() end
                    spaceSound:Play()
                elseif not shouldBeActive and active then
                    active = false
                    for _,s in ipairs(stars) do if s and s.Parent then s:Destroy() end end
                    stars = {}
                    for _,p in ipairs(shootingStarsFolder:GetChildren()) do p:Destroy() end
                    spaceSound:Stop()
                    Lighting.FogColor = Color3.fromRGB(192,192,192)
                    Lighting.FogEnd = 100000
                    Lighting.Brightness = 2
                end
            end

            local shootingStarConn = task.spawn(function()
                while _G.SistemaAtivo do
                    if active then
                        for i=1,SHOOTING_STAR_MAX do
                            createShootingStar()
                            task.wait(shootingStarCooldown)
                        end
                    else
                        task.wait(1)
                    end
                end
            end)
            addConnection(shootingStarConn)

            local skyUpdateConn = task.spawn(function()
                while _G.SistemaAtivo do
                    updateSky()
                    task.wait(1)
                end
            end)
            addConnection(skyUpdateConn)

            local rainFolder = Instance.new("Folder",workspace)
            rainFolder.Name = "FakeRain"
            addInstance(rainFolder)
            local isRaining = false

            local birds = Instance.new("Sound",SoundService)
            birds.SoundId = "rbxassetid://9111139882"
            birds.Volume = 0.2
            birds.Looped = true
            birds:Play()
            addInstance(birds)

            local rainSound = Instance.new("Sound",SoundService)
            rainSound.SoundId = "rbxassetid://9118823106"
            rainSound.Volume = 0.3
            rainSound.Looped = true
            rainSound:Play()
            addInstance(rainSound)

            local thunder = Instance.new("Sound",SoundService)
            thunder.SoundId = "rbxassetid://9120018695"
            thunder.Volume = 0.4
            addInstance(thunder)

            local function updateBirdSound()
                birds.Volume = isRaining and 0 or 0.2
            end

            local function spawnRain()
                if not _G.SistemaAtivo then return end
                isRaining = true
                updateBirdSound()
                for i=1,120 do
                    local drop = Instance.new("Part")
                    drop.Size = Vector3.new(0.1,2,0.1)
                    drop.Anchored = true
                    drop.CanCollide = false
                    drop.Material = Enum.Material.Glass
                    drop.Transparency = 0.5
                    drop.Color = Color3.fromRGB(160,160,255)
                    drop.Position = Vector3.new(math.random(-150,150),100,math.random(-150,150))
                    drop.Parent = rainFolder
                    addInstance(drop)
                    local tween = TweenService:Create(drop,TweenInfo.new(1),{Position=drop.Position-Vector3.new(0,60,0)})
                    tween:Play()
                    Debris:AddItem(drop,1.5)
                end
                wait(1.5)
                isRaining = false
                updateBirdSound()
            end

            local function lightningStrike()
                if not _G.SistemaAtivo then return end
                local flash = Instance.new("Part")
                flash.Size = Vector3.new(1,1000,1)
                flash.Anchored = true
                flash.CanCollide = false
                flash.Transparency = 0.4
                flash.Material = Enum.Material.Neon
                flash.Color = Color3.new(1,1,1)
                flash.Position = Vector3.new(math.random(-100,100),500,math.random(-100,100))
                flash.Parent = workspace
                addInstance(flash)
                Lighting.Brightness = Lighting.Brightness + 1.5
                thunder:Play()
                wait(0.1)
                Lighting.Brightness = Lighting.Brightness - 1.5
                flash:Destroy()
            end

            for _,part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Material == Enum.Material.SmoothPlastic then
                    part.Reflectance = 0.25
                end
            end

            local rainConn = task.spawn(function()
                while _G.SistemaAtivo do
                    spawnRain()
                    if math.random() < 0.2 then lightningStrike() end
                    wait(1)
                end
            end)
            addConnection(rainConn)

            Lighting.Brightness = 2
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            Lighting.FogColor = Color3.fromRGB(120, 130, 140)
            Lighting.FogStart = 80
            Lighting.FogEnd = 600
            Lighting.EnvironmentSpecularScale = 1
            Lighting.EnvironmentDiffuseScale = 0.5

            local sky = Instance.new("Sky")
            sky.SkyboxBk = "rbxassetid://159454299"
            sky.SkyboxDn = "rbxassetid://159454296"
            sky.SkyboxFt = "rbxassetid://159454293"
            sky.SkyboxLf = "rbxassetid://159454286"
            sky.SkyboxRt = "rbxassetid://159454300"
            sky.SkyboxUp = "rbxassetid://159454304"
            sky.Parent = Lighting
            addInstance(sky)

            local color = Instance.new("ColorCorrectionEffect", Lighting)
            color.Brightness = 0.03
            color.Contrast = 0.15
            color.Saturation = 0.05
            color.TintColor = Color3.fromRGB(255, 240, 220)
            addInstance(color)

            local bloom = Instance.new("BloomEffect", Lighting)
            bloom.Intensity = 0.8
            bloom.Size = 56
            bloom.Threshold = 0.9
            addInstance(bloom)

            local sunRays = Instance.new("SunRaysEffect", Lighting)
            sunRays.Intensity = 0.05
            sunRays.Spread = 0.8
            addInstance(sunRays)

            local blur = Instance.new("BlurEffect", Lighting)
            blur.Size = 0
            addInstance(blur)

        else
            _G.SistemaAtivo = false
            
            if _G.SistemaConnections then
                for _, connection in pairs(_G.SistemaConnections) do
                    if connection then
                        pcall(function() connection:Disconnect() end)
                    end
                end
                _G.SistemaConnections = {}
            end
            
            if _G.SistemaInstances then
                for _, instance in pairs(_G.SistemaInstances) do
                    if instance and instance.Parent then
                        pcall(function() instance:Destroy() end)
                    end
                end
                _G.SistemaInstances = {}
            end
            
            local Lighting = game:GetService("Lighting")
            Lighting.Brightness = 1
            Lighting.FogColor = Color3.fromRGB(191, 191, 191)
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            
            for _, effect in pairs(Lighting:GetChildren()) do
                if effect:IsA("BloomEffect") or effect:IsA("ColorCorrectionEffect") or 
                   effect:IsA("SunRaysEffect") or effect:IsA("BlurEffect") or effect:IsA("Sky") then
                    effect:Destroy()
                end
            end
            
            if workspace:FindFirstChild("ShootingStars") then
                workspace.ShootingStars:Destroy()
            end
            if workspace:FindFirstChild("FakeRain") then
                workspace.FakeRain:Destroy()
            end
            
            for _, sound in pairs(workspace:GetDescendants()) do
                if sound:IsA("Sound") and (sound.Name == "SpaceAmbience" or sound.Name == "FountainSound" or sound.Name == "MyCustomSound") then
                    sound:Stop()
                end
            end
            
            for _, sound in pairs(SoundService:GetDescendants()) do
                if sound:IsA("Sound") then
                    sound:Stop()
                end
            end
        end
    end
})
