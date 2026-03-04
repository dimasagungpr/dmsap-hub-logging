local UI_SOURCE_URL = "https://raw.githubusercontent.com/dimasagungpr/dmsap-hub-ui/refs/heads/main/ui.lua"

local ok, Rayfield = pcall(function()
    return loadstring(game:HttpGet(UI_SOURCE_URL))()
end)

if not ok or not Rayfield then
    warn("[LoggingDemo] Failed to load UI library from source URL")
    return
end

local state = {
    AutoLog = false,
    RefreshRate = 5,
    Endpoint = "https://example.local/log",
    Channel = "General",
    Hotkey = "RightShift"
}

local Window = Rayfield:CreateWindow({
    Name = "DMSAP Logging Demo",
    LoadingTitle = "DMSAP HUB",
    LoadingSubtitle = "Logging project v1.0.0",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

local OverviewTab = Window:CreateTab("Overview", 4483362458)
OverviewTab:CreateSection("Status")
OverviewTab:CreateParagraph({
    Title = "Purpose",
    Content = "Demo UI untuk mengetes komponen yang tersedia dari ui.lua publik."
})

OverviewTab:CreateButton({
    Name = "Show Startup Notification",
    Callback = function()
        Rayfield:Notify({
            Title = "Logging Demo",
            Content = "UI berhasil dibuat dan siap diuji.",
            Duration = 4,
            Image = 4483362458
        })
    end
})

local LoggingTab = Window:CreateTab("Logging", 4483362458)
LoggingTab:CreateSection("Runtime Controls")

LoggingTab:CreateToggle({
    Name = "Auto Logging",
    CurrentValue = state.AutoLog,
    Flag = "Logging_Auto",
    Callback = function(value)
        state.AutoLog = value
        Rayfield:Notify({
            Title = "Auto Logging",
            Content = value and "Enabled" or "Disabled",
            Duration = 2,
            Image = 4483362458
        })
    end
})

LoggingTab:CreateSlider({
    Name = "Refresh Rate (seconds)",
    Range = {1, 60},
    Increment = 1,
    Suffix = "s",
    CurrentValue = state.RefreshRate,
    Flag = "Logging_RefreshRate",
    Callback = function(value)
        state.RefreshRate = value
    end
})

LoggingTab:CreateInput({
    Name = "Endpoint URL",
    PlaceholderText = "https://example.local/log",
    RemoveTextAfterFocusLost = false,
    CurrentValue = state.Endpoint,
    Flag = "Logging_Endpoint",
    Callback = function(value)
        if type(value) == "string" and #value > 0 then
            state.Endpoint = value
        end
    end
})

LoggingTab:CreateDropdown({
    Name = "Channel",
    Options = {"General", "Combat", "Currency", "Debug"},
    CurrentOption = {state.Channel},
    MultipleOptions = false,
    Flag = "Logging_Channel",
    Callback = function(option)
        if type(option) == "table" then
            state.Channel = tostring(option[1] or state.Channel)
        else
            state.Channel = tostring(option)
        end
    end
})

LoggingTab:CreateKeybind({
    Name = "Toggle Auto Logging",
    CurrentKeybind = state.Hotkey,
    HoldToInteract = false,
    Flag = "Logging_Hotkey",
    Callback = function()
        state.AutoLog = not state.AutoLog
        Rayfield:Notify({
            Title = "Hotkey Triggered",
            Content = "Auto Logging: " .. (state.AutoLog and "Enabled" or "Disabled"),
            Duration = 2,
            Image = 4483362458
        })
    end
})

local ToolsTab = Window:CreateTab("Tools", 4483362458)
ToolsTab:CreateSection("Utility")

ToolsTab:CreateButton({
    Name = "Print Current Config",
    Callback = function()
        print("[LoggingDemo] AutoLog:", state.AutoLog)
        print("[LoggingDemo] RefreshRate:", state.RefreshRate)
        print("[LoggingDemo] Endpoint:", state.Endpoint)
        print("[LoggingDemo] Channel:", state.Channel)
    end
})

ToolsTab:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        Rayfield:Destroy()
    end
})

Rayfield:Notify({
    Title = "Logging Demo v1.0.0",
    Content = "Overview, Logging, dan Tools tab aktif.",
    Duration = 4,
    Image = 4483362458
})

