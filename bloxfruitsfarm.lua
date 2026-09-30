-- Simple Roblox Executor

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Function to fetch and execute a script from a URL
local function executeScript(url)
    local success, response = pcall(function()
        return HttpService:RequestAsync(url, Enum.HttpRequestType.Get, nil, false, nil, false, false, false, Enum.TransportType.All)
    end)

    if success and response.Success then
        local scriptContent = response.Body
        loadstring(scriptContent)()
    else
        warn("Failed to fetch or execute script: " .. (response and response.StatusMessage or "Unknown error"))
    end
end

-- Function to set up a UI for the executor
local function setupUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    ScreenGui.Name = "ExecutorUI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 300, 0, 150)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0

    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Roblox Executor"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18

    local ScriptUrl = Instance.new("TextBox")
    ScriptUrl.Parent = MainFrame
    ScriptUrl.Size = UDim2.new(1, -20, 0, 30)
    ScriptUrl.Position = UDim2.new(0, 10, 0, 40)
    ScriptUrl.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    ScriptUrl.BorderSizePixel = 0
    ScriptUrl.Text = "Enter script URL"
    ScriptUrl.TextColor3 = Color3.fromRGB(200, 200, 200)
    ScriptUrl.Font = Enum.Font.SourceSans
    ScriptUrl.TextSize = 14
    ScriptUrl.PlaceholderText = "https://example.com/script.lua"

    local ExecuteButton = Instance.new("TextButton")
    ExecuteButton.Parent = MainFrame
    ExecuteButton.Size = UDim2.new(0, 100, 0, 30)
    ExecuteButton.Position = UDim2.new(0.5, -50, 0, 85)
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
    ExecuteButton.BorderSizePixel = 0
    ExecuteButton.Text = "Execute"
    ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteButton.Font = Enum.Font.SourceSansBold
    ExecuteButton.TextSize = 14

    ExecuteButton.MouseButton1Click:Connect(function()
        local url = ScriptUrl.Text
        if url and url:match("^https?://") then
            executeScript(url)
        else
            warn("Please enter a valid URL")
        end
    end)
end

-- Set up the executor UI
setupUI()
