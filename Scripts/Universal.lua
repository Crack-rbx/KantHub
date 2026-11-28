--[=[
 ██╗  ██╗ █████╗ ███╗   ██╗████████╗ ██╗  ██╗██╗   ██╗██████╗
 ██║ ██╔╝██╔══██╗████╗  ██║╚══██╔══╝ ██║  ██║██║   ██║██╔══██╗
 █████╔╝ ███████║██╔██╗ ██║   ██║    ███████║██║   ██║██████╔╝
 ██╔═██╗ ██╔══██║██║╚██╗██║   ██║    ██╔══██║██║   ██║██╔══██╗
 ██║  ██╗██║  ██║██║ ╚████║   ██║    ██║  ██║╚██████╔╝██████╔╝
 ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝
                    @TavssDev @Crack-RBX
--]=]
-- Instances: 12 | Scripts: 1 | Modules: 6 | Tags: 0
local G2L = {};

-- StarterGui.LoadingUI
G2L["1"] = Instance.new("ScreenGui", game:GetService("CoreGui"));
G2L["1"]["IgnoreGuiInset"] = true;
G2L["1"]["Enabled"] = false;
G2L["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
G2L["1"]["Name"] = [[LoadingUI]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

-- StarterGui.LoadingUI.Scripts
G2L["2"] = Instance.new("Folder", G2L["1"]);
G2L["2"]["Name"] = [[Scripts]];


-- StarterGui.LoadingUI.Scripts.Loader
G2L["3"] = Instance.new("LocalScript", G2L["2"]);
G2L["3"]["Name"] = [[Loader]];


-- StarterGui.LoadingUI.Modules
G2L["4"] = Instance.new("Folder", G2L["1"]);
G2L["4"]["Name"] = [[Modules]];


-- StarterGui.LoadingUI.Modules.UI Modules
G2L["5"] = Instance.new("Folder", G2L["4"]);
G2L["5"]["Name"] = [[UI Modules]];


-- StarterGui.LoadingUI.Modules.UI Modules.LoadUI
G2L["6"] = Instance.new("ModuleScript", G2L["5"]);
G2L["6"]["Name"] = [[LoadUI]];


-- StarterGui.LoadingUI.Modules.UI Modules.UIBuilder
G2L["7"] = Instance.new("ModuleScript", G2L["5"]);
G2L["7"]["Name"] = [[UIBuilder]];


-- StarterGui.LoadingUI.Modules.Functions Modules
G2L["8"] = Instance.new("Folder", G2L["4"]);
G2L["8"]["Name"] = [[Functions Modules]];


-- StarterGui.LoadingUI.Modules.Functions Modules.Others
G2L["9"] = Instance.new("ModuleScript", G2L["8"]);
G2L["9"]["Name"] = [[Others]];


-- StarterGui.LoadingUI.Modules.Functions Modules.Moviment
G2L["a"] = Instance.new("ModuleScript", G2L["8"]);
G2L["a"]["Name"] = [[Moviment]];


-- StarterGui.LoadingUI.Modules.Functions Modules.ESP
G2L["b"] = Instance.new("ModuleScript", G2L["8"]);
G2L["b"]["Name"] = [[ESP]];


-- StarterGui.LoadingUI.Modules.Functions Modules.Aimbot
G2L["c"] = Instance.new("ModuleScript", G2L["8"]);
G2L["c"]["Name"] = [[Aimbot]];


-- Require G2L wrapper
local G2L_REQUIRE = require;
local G2L_MODULES = {};
local function require(Module: ModuleScript)
	local s = G2L_MODULES[Module]
	if not s then return G2L_REQUIRE(Module) end
	if s.Status == "done" then return s.Value end
	if s.Status == "loading" then error("require cíclico: " .. Module.Name, 2) end
	if s.Status == "failed" then error(s.Error, 2) end

	s.Status = "loading"
	local ok, result = xpcall(s.Closure, debug.traceback)
	if not ok then
		s.Status, s.Error = "failed", result
		error(result, 2)
	end
	s.Status, s.Value = "done", result
	return result
end

G2L_MODULES[G2L["6"]] = {
Closure = function()
    local script = G2L["6"];local Loader = {}

local URL          = "https://kant-hub-auth.vercel.app/private/UIEngine.lua"
local RETRY_DELAY  = 0.75
local MAX_ATTEMPTS = 3

local Cache     = nil
local Loading   = false
local LastError = nil

local function fetchSource()
	local lastErr
	for attempt = 1, MAX_ATTEMPTS do
		local ok, body = pcall(game.HttpGet, game, URL, true)
		if ok and type(body) == "string" and #body > 0 then return body end
		lastErr = ok and "empty response" or tostring(body)
		if attempt < MAX_ATTEMPTS then task.wait(RETRY_DELAY * attempt)end end
	return nil,("Failed to download the file after %d attempts: %s"):format(MAX_ATTEMPTS,
		tostring(lastErr))
end

local function compileAndRun(source)
	local chunk, compileErr = loadstring(source, "=UIEngine")
	if not chunk then return nil, "Compilation error:" .. tostring(compileErr)end
	local ok, result = xpcall(chunk, function(err)return debug.traceback(tostring(err), 2)end)
	if not ok then return nil, "Error while running:" .. tostring(result)end
	if result == nil then return nil, "The file did not return a valid Engine"end
	return result
end

function Loader:Load(force)
	if Cache ~= nil and not force then return Cache end

	-- prevents duplicate downloads if Load() is called in parallel
	if Loading then while Loading do task.wait()
		end return Cache, (Cache == nil) and LastError or nil end

	Loading = true
	LastError = nil

	local engine, err
	local source, fetchErr = fetchSource()
	
	if source then engine, err = compileAndRun(source)
	else err = fetchErr end
	if engine ~= nil then Cache = engine
	else LastError = err end

	Loading = false
	return engine, err
end

return Loader
end;
};
G2L_MODULES[G2L["7"]] = {
Closure = function()
    local script = G2L["7"];---------------------------------------------------------------------
-- UIBuilder (corrigido)
---------------------------------------------------------------------
local UIBuilder = {}

local State = {
	Initializing = false,
	Initialized  = false,

	UI      = nil,
	Window  = nil,
	Config  = nil,
	Tabs    = nil,
	Context = nil, -- { GetMovement = function, Others = module }
}

---------------------------------------------------------------------
-- UTILITIES
---------------------------------------------------------------------
local function SafeCall(label, callback, ...)
	if type(callback) ~= "function" then
		return false, ("Invalid callback: %s"):format(tostring(label))
	end

	local results = table.pack(pcall(callback, ...))

	if not results[1] then
		local err = tostring(results[2])
		warn(("[UIBuilder] %s failed: %s"):format(label, err))
		return false, err
	end

	return true, table.unpack(results, 2, results.n)
end

local function ValidateTable(value, name)
	if type(value) ~= "table" then
		return false, ("%s must be a table"):format(name)
	end
	return true
end

local function GetOptionalMethod(object, methodName)
	if type(object) ~= "table" then
		return nil
	end

	local method = object[methodName]
	if type(method) == "function" then
		return method
	end

	return nil
end

-- Chama um método da instância de Movement (com self), se ela existir.
local function CallMovement(methodName, label, ...)
	local context = State.Context
	local movement = context and context.GetMovement and context.GetMovement()

	if not movement or type(movement[methodName]) ~= "function" then
		return false
	end

	return SafeCall(label, movement[methodName], movement, ...)
end

-- Chama um método do módulo Others (Fullbright / AntiAFK), com self.
local function CallOthers(methodName, label, ...)
	local context = State.Context
	local others = context and context.Others

	if not others or type(others[methodName]) ~= "function" then
		return false
	end

	return SafeCall(label, others[methodName], others, ...)
end

---------------------------------------------------------------------
-- VALIDATION
---------------------------------------------------------------------
local function ValidateDependencies(UI, window, Config)
	local valid, err

	valid, err = ValidateTable(UI, "UI")
	if not valid then return false, err end

	valid, err = ValidateTable(Config, "Config")
	if not valid then return false, err end

	if not window then
		return false, "Window is unavailable"
	end

	if type(window.CreateTab) ~= "function" then
		return false, "Window does not expose CreateTab"
	end

	return true
end

---------------------------------------------------------------------
-- ADAPTER: traduz as chamadas do UIBuilder para a API real da engine
-- (Tab:CreateToggle / CreateDropdown / CreateSlider / CreateColorpicker / CreateKeybind)
---------------------------------------------------------------------
local function BuildHelpers()
	local H = {}

	function H.Toggle(tab, label, config, key, onChange)
		return tab:CreateToggle(label, config[key] == true, function(value)
			config[key] = value
			if onChange then onChange(value) end
		end)
	end

	function H.Dropdown(tab, title, subtitle, options, config, key, onChange)
		return tab:CreateDropdown(title, subtitle, options, config[key], function(value)
			config[key] = value
			if onChange then onChange(value) end
		end)
	end

	function H.Slider(tab, title, subtitle, minVal, maxVal, config, key, step, onChange)
		return tab:CreateSlider(title, subtitle, minVal, maxVal, config[key], function(value)
			config[key] = value
			if onChange then onChange(value) end
		end, step)
	end

	function H.Color(tab, title, subtitle, config, key, onChange)
		return tab:CreateColorpicker(title, subtitle, config[key], function(value)
			config[key] = value
			if onChange then onChange(value) end
		end)
	end

	function H.Keybind(tab, title, subtitle, defaultKey, onChange)
		return tab:CreateKeybind(title, subtitle, defaultKey, onChange)
	end

	return H
end

---------------------------------------------------------------------
-- TABS
---------------------------------------------------------------------
local function CreateOverlayTab(UI, window, Config)
	local tab = window:CreateTab("ESP")
	local config = Config.ESP

	tab:CreateCard(
		"Wallhack & ESP",
		"ESP (Extra Sensory Perception) provides visual information about other players, including their positions, even when they are behind obstacles."
	)

	UI.Toggle(tab, "Enable ESP",            config, "ESPEnabled")
	UI.Toggle(tab, "Enable Bounding Boxes", config, "ESPBox")
	UI.Toggle(tab, "Enable Tracers",        config, "ESPTracer")

	UI.Dropdown(
		tab,
		"Tracer Origin",
		"Choose where tracers originate from on the screen.",
		{ "Top", "Center", "Bottom" },
		config,
		"TracerOrigin"
	)

	UI.Toggle(tab, "Show Player Names", config, "ESPName")
	UI.Toggle(tab, "Show Health",       config, "ESPHealth")
	UI.Toggle(tab, "Show Distance",     config, "ESPDistance")
	UI.Toggle(tab, "Enable Team Check", config, "TeamCheck")

	UI.Color(tab, "Bounding Box Color", "Set the color of player bounding boxes.", config, "BoxColor")
	UI.Color(tab, "Tracer Color",       "Set the color of player tracers.",       config, "TracerColor")

	return tab
end

local function CreateAimTab(UI, window, Config)
	local tab = window:CreateTab("Aimbot")
	local config = Config.Aimbot

	UI.Toggle(tab, "Enable Aimbot",    config, "AimbotEnabled")
	UI.Toggle(tab, "Visibility Check", config, "VisibleCheck")
	UI.Toggle(tab, "Enable Team Check", config, "TeamCheck")

	UI.Dropdown(
		tab,
		"Target Part",
		"Choose which body part to prioritize when selecting a target.",
		{ "Head", "Body" },
		config,
		"AimbotPart"
	)

	UI.Slider(
		tab,
		"Smoothness",
		"Adjust how smoothly aiming transitions toward the selected target.",
		1, 20,
		config,
		"SmoothAimbot",
		1
	)

	UI.Slider(
		tab,
		"FOV Radius",
		"Adjust the radius of the field-of-view detection area.",
		20, 400,
		config,
		"FOVRadius",
		1
	)

	UI.Toggle(tab, "Show FOV Indicator", config, "ShowFOV")

	UI.Color(
		tab,
		"FOV Indicator Color",
		"Set the color of the field-of-view indicator.",
		config,
		"FOVColor"
	)

	return tab
end

local function CreateMovementTab(UI, window, Config)
	local tab = window:CreateTab("Movement")
	local fly = Config.Fly

	UI.Toggle(tab, "Enable Flight", fly, "FLY_ENABLE", function(enabled)
		fly.FLY_ENABLE = enabled
		CallMovement("SetFlyEnabled", "Set fly enabled", enabled)
	end)

	UI.Keybind(
		tab,
		"Flight Toggle Key",
		"Set the key used to enable or disable flight.",
		fly.TOGGLE_KEY,
		function(key)
			fly.TOGGLE_KEY = key
			CallMovement("SetToggleKey", "Set fly toggle key", key)
		end
	)

	UI.Slider(
		tab,
		"Flight Speed",
		"Adjust the movement speed while flying.",
		10, 1500,
		fly,
		"FLY_SPEED",
		5,
		function(speed)
			fly.FLY_SPEED = speed
			CallMovement("SetFlySpeed", "Set fly speed", speed)
		end
	)

	UI.Toggle(tab, "Enable Noclip", Config.Noclip, "NoclipEnabled", function(enabled)
		Config.Noclip.NoclipEnabled = enabled
		CallMovement("SetNoclipEnabled", "Set noclip enabled", enabled)
	end)

	return tab
end

local function CreateSettingsTab(UI, window, Config)
	local tab = window:CreateTab("Settings")
	local config = Config.Settings

	UI.Toggle(tab, "Enable Fullbright", config, "Fullbright", function(enabled)
		config.Fullbright = enabled
		CallOthers("Fullbright", "Fullbright toggle", enabled)
	end)

	UI.Toggle(tab, "Enable Anti-AFK", config, "AntiAFK", function(enabled)
		config.AntiAFK = enabled
		CallOthers("AntiAFK", "Anti-AFK toggle", enabled)
	end)

	UI.Keybind(
		tab,
		"Menu Toggle Key",
		"Set the key used to open or close the interface.",
		config.MenuKey,
		function(key)
			config.MenuKey = key

			local windowReference = State.Window
			if not windowReference then
				return
			end

			local setMenuKey = GetOptionalMethod(windowReference, "SetMenuKey")

			if setMenuKey then
				SafeCall("Update menu key", setMenuKey, windowReference, key)
				return
			end

			-- A engine não expõe SetMenuKey: registra um atalho extra que
			-- alterna o menu. A tecla original (RightControl) continua válida.
			local register = GetOptionalMethod(windowReference, "RegisterHotkey")
			local unregister = GetOptionalMethod(windowReference, "UnregisterHotkey")

			if not register then
				warn("[KantHub] UI window does not expose SetMenuKey/RegisterHotkey.")
				return
			end

			if unregister then
				SafeCall("Remove old menu hotkey", unregister, windowReference, "KantHubMenuToggle")
			end

			SafeCall("Register menu hotkey", register, windowReference, {
				Name = "KantHubMenuToggle",
				Key = key,
				Callback = function()
					local toggle = GetOptionalMethod(windowReference, "ToggleMenu")
					if toggle then toggle(windowReference) end
				end,
			})
		end
	)

	return tab
end

local function CreateCreditsTab(window)
	local tab = window:CreateTab("Credits")

	tab:CreateCard(
		"Credits",
		"This hub was carefully crafted to deliver a smooth, reliable, and consistent user experience."
			.. "\n\nDeveloped by Crack-RBX and TavssDev."
			.. "\n• Crack-RBX: UI design and integration."
			.. "\n• TavssDev: Core development."
	)

	tab:CreateCard(
		"Official Sources",
		"Refer to the official project sources below to access the original code and verify the latest published versions."
			.. "\n\nScriptBlox Profile:"
			.. "\nhttps://scriptblox.com/u/Crack_rbx"
			.. "\n\nGitHub Repository:"
			.. "\nhttps://github.com/Crack-rbx/Scripts"
	)

	return tab
end

local function Build(UI, window, Config)
	return {
		ESP      = CreateOverlayTab(UI, window, Config),
		Aimbot   = CreateAimTab(UI, window, Config),
		Movement = CreateMovementTab(UI, window, Config),
		Settings = CreateSettingsTab(UI, window, Config),
		Credits  = CreateCreditsTab(window),
	}
end

---------------------------------------------------------------------
-- PUBLIC API
---------------------------------------------------------------------
-- Retorna (true, tabs) em caso de sucesso ou (false, mensagem) em caso de erro.
function UIBuilder.Init(UI, window, Config, Context)
	if State.Initialized then
		return true, State.Tabs
	end

	if State.Initializing then
		return false, "UIBuilder is already initializing"
	end

	State.Initializing = true

	local valid, err = ValidateDependencies(UI, window, Config)
	if not valid then
		State.Initializing = false
		return false, err
	end

	State.Context = Context or {}
	State.Window  = window

	local helpers = BuildHelpers()

	local success, tabs = SafeCall("Interface construction", Build, helpers, window, Config)

	State.Initializing = false

	if not success then
		State.Window = nil
		return false, tabs
	end

	State.UI          = helpers
	State.Config      = Config
	State.Tabs        = tabs
	State.Initialized = true

	return true, tabs
end

function UIBuilder.IsInitialized()
	return State.Initialized
end

function UIBuilder.GetTabs()
	return State.Tabs
end

function UIBuilder.Reset()
	State.Initialized  = false
	State.Initializing = false

	State.UI      = nil
	State.Window  = nil
	State.Config  = nil
	State.Tabs    = nil
	State.Context = nil

	return true
end

return UIBuilder
end;
};
G2L_MODULES[G2L["9"]] = {
Closure = function()
    local script = G2L["9"];-- Fullbright + AntiAFK Module
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local Module = {}

-- STATE
local destroyed = false

local antiAFKConnection = nil
local savedLighting = nil

-- FULLBRIGHT
function Module:Fullbright(state)
	if destroyed then return end

	if state then
		if not savedLighting then
			savedLighting = {
				Brightness = Lighting.Brightness,
				ClockTime = Lighting.ClockTime,
				FogEnd = Lighting.FogEnd,
				GlobalShadows = Lighting.GlobalShadows
			}
		end

		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
	else
		if not savedLighting then return end

		for property, value in pairs(savedLighting) do
			Lighting[property] = value
		end

		savedLighting = nil
	end
end

-- ANTI AFK
function Module:AntiAFK(state)
	if destroyed then return end

	if state then
		if antiAFKConnection then return end

		antiAFKConnection = LocalPlayer.Idled:Connect(function()
			local camera = workspace.CurrentCamera
			local cf = camera and camera.CFrame or CFrame.new()

			VirtualUser:Button2Down(Vector2.zero, cf)

			task.wait(1)

			if not destroyed then
				VirtualUser:Button2Up(Vector2.zero, cf)
			end
		end)
	else
		if antiAFKConnection then
			antiAFKConnection:Disconnect()
			antiAFKConnection = nil
		end
	end
end

-- DESTROY
function Module:Destroy()
	if destroyed then return end

	self:AntiAFK(false)
	self:Fullbright(false)

	destroyed = true
end

return Module
end;
};
G2L_MODULES[G2L["a"]] = {
Closure = function()
    local script = G2L["a"];local Movement = {}
Movement.__index = Movement

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local DEFAULT_CONFIG = {
	Fly = {
		Enabled = false,
		Speed = 50,
		SprintMultiplier = 2.5,

		ToggleKey = Enum.KeyCode.F,
		AscendKey = Enum.KeyCode.Space,
		DescendKey = Enum.KeyCode.LeftControl,
	},

	Noclip = {
		Enabled = false,
		RefreshInterval = 1,
	},
}

local Vector3zero = Vector3.zero
local Vector3yAxis = Vector3.yAxis

local IsKeyDown = UserInputService.IsKeyDown

local function cloneConfig(source)
	local result = {}

	for key, value in pairs(source) do
		if type(value) == "table" then
			result[key] = cloneConfig(value)
		else
			result[key] = value
		end
	end

	return result
end

function Movement.new(customConfig)
	if customConfig ~= nil and type(customConfig) ~= "table" then
		return nil
	end

	local self = setmetatable({}, Movement)

	self.Config = cloneConfig(DEFAULT_CONFIG)

	if customConfig then
		for section, values in pairs(customConfig) do
			if type(values) == "table"
				and type(self.Config[section]) == "table" then

				for key, value in pairs(values) do
					if self.Config[section][key] ~= nil
						and typeof(value) == typeof(self.Config[section][key]) then

						self.Config[section][key] = value
					end
				end
			end
		end
	end

	self.Destroyed = false
	self.IsFlying = false

	self.Connections = {}

	self.FlyConnection = nil
	self.NoclipConnection = nil

	self.FlyAttachment = nil
	self.FlyVelocity = nil
	self.FlyOrientation = nil

	self.NoclipParts = {}
	self.LastNoclipRefresh = 0

	self:_Initialize()

	return self
end


function Movement:_Connect(signal, callback)
	if self.Destroyed then
		return nil
	end

	if not signal or type(callback) ~= "function" then
		return nil
	end

	local success, connection = pcall(function()
		return signal:Connect(callback)
	end)

	if not success then
		warn("[Movement] Connection error: " .. tostring(connection))
		return nil
	end

	table.insert(self.Connections, connection)

	return connection
end

function Movement:_GetCharacter()
	if self.Destroyed then
		return nil
	end

	local character = LocalPlayer.Character

	if not character or character.Parent == nil then
		return nil
	end

	return character
end

function Movement:_GetRootPart()
	local character = self:_GetCharacter()

	if not character then
		return nil
	end

	local rootPart = character:FindFirstChild("HumanoidRootPart")

	if not rootPart or not rootPart:IsA("BasePart") then
		return nil
	end

	return rootPart
end

function Movement:_GetHumanoid()
	local character = self:_GetCharacter()

	if not character then
		return nil
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not humanoid or humanoid.Parent ~= character then
		return nil
	end

	return humanoid
end

function Movement:_GetCamera()
	return workspace.CurrentCamera
end

local function safeDestroy(object)
	if not object then
		return
	end

	pcall(function()
		object:Destroy()
	end)
end

local function safeDisconnect(connection)
	if not connection then
		return
	end

	pcall(function()
		connection:Disconnect()
	end)
end

function Movement:_CleanupFly()
	safeDisconnect(self.FlyConnection)
	self.FlyConnection = nil

	safeDestroy(self.FlyVelocity)
	safeDestroy(self.FlyOrientation)
	safeDestroy(self.FlyAttachment)

	self.FlyVelocity = nil
	self.FlyOrientation = nil
	self.FlyAttachment = nil

	local humanoid = self:_GetHumanoid()

	if humanoid then
		humanoid.PlatformStand = false
	end
end

function Movement:_StartFly()
	local rootPart = self:_GetRootPart()
	local humanoid = self:_GetHumanoid()

	if not rootPart or not humanoid then
		self.IsFlying = false
		return
	end

	self:_CleanupFly()

	humanoid.PlatformStand = true

	local attachment = Instance.new("Attachment")
	attachment.Name = "MovementAttachment"
	attachment.Parent = rootPart

	self.FlyAttachment = attachment

	local velocity = Instance.new("LinearVelocity")
	velocity.Name = "MovementVelocity"
	velocity.Attachment0 = attachment
	velocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
	velocity.MaxForce = math.huge
	velocity.VectorVelocity = Vector3zero
	velocity.Parent = rootPart

	self.FlyVelocity = velocity

	local orientation = Instance.new("AlignOrientation")
	orientation.Name = "MovementOrientation"
	orientation.Attachment0 = attachment
	orientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
	orientation.MaxTorque = math.huge
	orientation.Responsiveness = 50
	orientation.CFrame = rootPart.CFrame
	orientation.Parent = rootPart

	self.FlyOrientation = orientation

	self.FlyConnection = RunService.Heartbeat:Connect(function()
		if self.Destroyed or not self.IsFlying then
			return
		end

		local camera = self:_GetCamera()

		if not camera or not self.FlyVelocity then
			return
		end

		local config = self.Config.Fly
		local cameraCF = camera.CFrame

		local look = cameraCF.LookVector
		local right = cameraCF.RightVector

		local move = Vector3zero

		if IsKeyDown(UserInputService, Enum.KeyCode.W) then
			move += look
		end

		if IsKeyDown(UserInputService, Enum.KeyCode.S) then
			move -= look
		end

		if IsKeyDown(UserInputService, Enum.KeyCode.A) then
			move -= right
		end

		if IsKeyDown(UserInputService, Enum.KeyCode.D) then
			move += right
		end

		if IsKeyDown(UserInputService, config.AscendKey) then
			move += Vector3yAxis
		end

		if IsKeyDown(UserInputService, config.DescendKey) then
			move -= Vector3yAxis
		end

		local speed = config.Speed

		if IsKeyDown(UserInputService, Enum.KeyCode.LeftShift) then
			speed *= config.SprintMultiplier
		end

		if move.Magnitude > 0 then
			move = move.Unit
		end

		self.FlyVelocity.VectorVelocity = move * speed

		local flat = look * Vector3.new(1, 0, 1)

		if flat.Magnitude > 0 then
			self.FlyOrientation.CFrame = CFrame.lookAt(
				Vector3zero,
				flat.Unit
			)
		end
	end)
end

function Movement:SetFlying(state)
	if self.Destroyed then
		return
	end

	state = state == true

	if state == self.IsFlying then
		return
	end

	self.IsFlying = state

	if state then
		self:_StartFly()
	else
		self:_CleanupFly()
	end
end

function Movement:SetFlyEnabled(state)
	self.Config.Fly.Enabled = state == true

	if not self.Config.Fly.Enabled then
		self:SetFlying(false)
	end
end


function Movement:SetFlySpeed(speed)
	if self.Destroyed then
		return false
	end

	if type(speed) ~= "number"
		or speed ~= speed
		or speed == math.huge
		or speed == -math.huge then

		return false
	end

	self.Config.Fly.Speed = math.max(0, speed)

	return true
end

function Movement:SetSprintMultiplier(multiplier)
	if self.Destroyed then
		return false
	end

	if type(multiplier) ~= "number"
		or multiplier ~= multiplier
		or multiplier == math.huge
		or multiplier == -math.huge then

		return false
	end

	self.Config.Fly.SprintMultiplier = math.max(1, multiplier)

	return true
end

function Movement:SetToggleKey(key)
	if self.Destroyed then
		return false
	end

	if typeof(key) ~= "EnumItem"
		or key.EnumType ~= Enum.KeyCode then

		return false
	end

	self.Config.Fly.ToggleKey = key

	return true
end

function Movement:_RefreshNoclipParts()
	table.clear(self.NoclipParts)

	self.LastNoclipRefresh = os.clock()

	local character = self:_GetCharacter()

	if not character then
		return
	end

	for _, instance in ipairs(character:GetDescendants()) do
		if instance:IsA("BasePart") then
			table.insert(self.NoclipParts, instance)
		end
	end
end

function Movement:_StartNoclip()
	if self.NoclipConnection then
		return
	end

	self:_RefreshNoclipParts()

	self.NoclipConnection = RunService.Stepped:Connect(function()
		if self.Destroyed then
			return
		end

		local config = self.Config.Noclip

		if os.clock() - self.LastNoclipRefresh >= config.RefreshInterval then
			self:_RefreshNoclipParts()
		end

		for i = 1, #self.NoclipParts do
			local part = self.NoclipParts[i]

			if part.Parent and part.CanCollide then
				part.CanCollide = false
			end
		end
	end)
end

function Movement:_StopNoclip()
	if self.NoclipConnection then
		self.NoclipConnection:Disconnect()
		self.NoclipConnection = nil
	end

	table.clear(self.NoclipParts)
end

function Movement:SetNoclipEnabled(state)
	if self.Destroyed then
		return
	end

	self.Config.Noclip.Enabled = state == true

	if self.Config.Noclip.Enabled then
		self:_StartNoclip()
	else
		self:_StopNoclip()
	end
end

function Movement:_Initialize()
	self:_Connect(
		UserInputService.InputBegan,
		function(input, gameProcessed)
			if gameProcessed or self.Destroyed then
				return
			end

			local config = self.Config.Fly

			if not config.Enabled then
				return
			end

			if input.KeyCode == config.ToggleKey then
				self:SetFlying(not self.IsFlying)
			end
		end
	)

	self:_Connect(
		LocalPlayer.CharacterAdded,
		function()
			self:SetFlying(false)

			if self.Config.Noclip.Enabled then
				self:_RefreshNoclipParts()
			end
		end
	)

	if self.Config.Fly.Enabled then
		self:SetFlying(false)
	end

	if self.Config.Noclip.Enabled then
		self:_StartNoclip()
	end
end

function Movement:Destroy()
	if self.Destroyed then
		return
	end

	self.Destroyed = true
	self.IsFlying = false

	safeDisconnect(self.FlyConnection)
	safeDisconnect(self.NoclipConnection)

	self.FlyConnection = nil
	self.NoclipConnection = nil

	safeDestroy(self.FlyVelocity)
	safeDestroy(self.FlyOrientation)
	safeDestroy(self.FlyAttachment)

	self.FlyVelocity = nil
	self.FlyOrientation = nil
	self.FlyAttachment = nil

	for index = #self.Connections, 1, -1 do
		safeDisconnect(self.Connections[index])
		self.Connections[index] = nil
	end

	table.clear(self.Connections)
	table.clear(self.NoclipParts)
end

return Movement
end;
};
G2L_MODULES[G2L["b"]] = {
Closure = function()
    local script = G2L["b"];---------------------------------------------------------------------
-- SERVICES
---------------------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Environment = (getgenv and getgenv()) or _G
local DrawingLibrary = Drawing

---------------------------------------------------------------------
-- PREVENT DUPLICATE EXECUTION
---------------------------------------------------------------------
if Environment.KantHubESPDestroy then
	pcall(Environment.KantHubESPDestroy)
end

if not DrawingLibrary or type(DrawingLibrary.new) ~= "function" then
	warn("[KantHub ESP] The Drawing library is not available.")
	return nil
end

---------------------------------------------------------------------
-- LOCAL REFERENCES
---------------------------------------------------------------------
local Vector2new = Vector2.new
local Vector3new = Vector3.new
local Color3fromRGB = Color3.fromRGB
local Color3fromHSV = Color3.fromHSV

local mathFloor = math.floor
local mathMax = math.max
local mathClamp = math.clamp
local abs = math.abs
local format = string.format

local BLACK = Color3fromRGB(0, 0, 0)
local WHITE = Color3fromRGB(255, 255, 255)

---------------------------------------------------------------------
-- CONFIGURATION
---------------------------------------------------------------------
local ESP = {}

ESP.Config = {
	ESPEnabled = false,

	ESPBox = false,
	ESPTracer = false,
	ESPName = false,
	ESPHealth = false,
	ESPDistance = false,

	TeamCheck = false,
	TracerOrigin = "Bottom", -- "Top", "Center" or "Bottom"

	BoxColor = WHITE,
	TracerColor = WHITE,
}

local Config = ESP.Config

---------------------------------------------------------------------
-- STATE
---------------------------------------------------------------------
local destroyed = false
local connections = {}
local drawingsByPlayer = {}
local stateByPlayer = {}
local warned = {}

---------------------------------------------------------------------
-- CONNECTION MANAGEMENT
---------------------------------------------------------------------
local function connect(signal, callback)
	local connection = signal:Connect(callback)
	connections[#connections + 1] = connection
	return connection
end

local function warnOnce(label, message)
	if warned[label] then
		return
	end

	warned[label] = true
	warn(format("[KantHub ESP] %s: %s", label, tostring(message)))
end

local function safeCall(label, callback, ...)
	local ok, result = pcall(callback, ...)
	if not ok then
		warnOnce(label, result)
		return false, nil
	end

	return true, result
end

---------------------------------------------------------------------
-- DRAWING HELPERS
---------------------------------------------------------------------
local function newDrawing(className, properties)
	local ok, drawing = pcall(function()
		local object = DrawingLibrary.new(className)

		for property, value in pairs(properties) do
			object[property] = value
		end

		return object
	end)

	if not ok then
		return nil, drawing
	end

	return drawing
end


local function setVisible(drawing, visible)
	if not drawing then
		return false
	end

	local ok, err = pcall(function()
		drawing.Visible = visible == true
	end)

	if not ok then
		warnOnce("Drawing visibility", err)
		return false
	end

	return true
end

local function removeDrawing(drawing)
	if drawing then
		pcall(function()
			drawing:Remove()
		end)
	end
end

local function hideDrawings(drawings, state)
	if type(drawings) ~= "table" then
		return
	end

	for _, drawing in pairs(drawings) do
		setVisible(drawing, false)
	end

	if state then
		state.shown = false
	end
end


---------------------------------------------------------------------
-- DEFAULT PLAYER HELPERS
---------------------------------------------------------------------
local Defaults = {}

function Defaults.GetCharacter(player)
	return player and player.Character
end

function Defaults.GetHumanoid(character)
	return character and character:FindFirstChildOfClass("Humanoid")
end

function Defaults.IsAlive(character)
	local humanoid = Defaults.GetHumanoid(character)
	return humanoid ~= nil and humanoid.Health > 0
end

function Defaults.IsEnemy(player)
	if not Config.TeamCheck then
		return true
	end

	if not player or player == LocalPlayer then
		return false
	end

	if LocalPlayer.Neutral or player.Neutral then
		return true
	end

	local localTeam = LocalPlayer.Team
	local targetTeam = player.Team

	if not localTeam or not targetTeam then
		return true
	end

	return localTeam ~= targetTeam
end

function Defaults.GetRoot(character)
	return character and character:FindFirstChild("HumanoidRootPart")
end

function Defaults.GetHead(character)
	return character and character:FindFirstChild("Head")
end


function Defaults.GetHealthPercent(character)
	local humanoid = Defaults.GetHumanoid(character)

	if not humanoid then
		return 0
	end

	local maxHealth = humanoid.MaxHealth
	local health = humanoid.Health

	if maxHealth <= 0 then
		return 0
	end

	local percentage = (health / maxHealth) * 100

	return mathClamp(mathFloor(percentage), 0, 100)
end

function Defaults.GetDisplayName(player)
	return player.Name
end

function Defaults.GetBoxColor(_player)
	return Config.BoxColor
end

function Defaults.GetTracerColor(_player)
	return Config.TracerColor
end

local Hooks = table.clone(Defaults)

---------------------------------------------------------------------
-- HOOK MANAGEMENT
---------------------------------------------------------------------
local function setHook(name, callback)
	if not Defaults[name] or type(callback) ~= "function" then
		return false
	end

	Hooks[name] = callback
	return true
end


local function callHook(name, ...)
	local callback = Hooks[name]
	local defaultCallback = Defaults[name]

	if type(callback) ~= "function" then
		callback = defaultCallback
	end

	if type(callback) ~= "function" then
		warnOnce("Invalid hook", name)
		return nil
	end

	local ok, result = pcall(callback, ...)

	if ok then
		return result
	end

	warnOnce("Hook '" .. name .. "' failed", result)

	Hooks[name] = defaultCallback

	if type(defaultCallback) ~= "function" then
		return nil
	end

	local defaultOK, defaultResult = pcall(defaultCallback, ...)

	if defaultOK then
		return defaultResult
	end

	warnOnce("Default hook '" .. name .. "' failed", defaultResult)

	return nil
end

local function installHooks(hooks)
	if type(hooks) ~= "table" then
		return
	end

	for name, callback in pairs(hooks) do
		if not setHook(name, callback) then
			warnOnce("Unknown hook", name)
		end
	end
end

-- Defuse Division stores team information in PlayerStates.Team.
if game.PlaceId == 112757576021097 or game.GameId == 112757576021097 then
	installHooks({
		IsEnemy = function(player)
			if not Config.TeamCheck then
				return true
			end

			if not player or player == LocalPlayer then
				return false
			end

			local localStates = LocalPlayer:FindFirstChild("PlayerStates")
			local targetStates = player:FindFirstChild("PlayerStates")

			local localTeam = localStates and localStates:FindFirstChild("Team")
			local targetTeam = targetStates and targetStates:FindFirstChild("Team")

			if not localTeam or not targetTeam then
				return false
			end

			return localTeam.Value ~= targetTeam.Value
		end,
	})
end

---------------------------------------------------------------------
-- PLAYER DRAWING LIFECYCLE
---------------------------------------------------------------------
local function isValidInstance(instance)
	return typeof(instance) == "Instance"
		and instance.Parent ~= nil
end

local function removePlayerDrawings(player)
	local drawings = drawingsByPlayer[player]
	if not drawings then
		return
	end

	drawingsByPlayer[player] = nil
	stateByPlayer[player] = nil

	for _, drawing in pairs(drawings) do
		removeDrawing(drawing)
	end
end

local function createPlayerDrawings(player)
	if destroyed or not player or player == LocalPlayer then
		return false
	end

	if player.Parent ~= Players then
		return false
	end

	if drawingsByPlayer[player] then
		return true
	end

	local definitions = {
		Box = {
			"Square",
			{
				Thickness = 1.2,
				Filled = false,
				Transparency = 1,
				Visible = false,
			},
		},

		Tracer = {
			"Line",
			{
				Thickness = 1.2,
				Transparency = 1,
				Visible = false,
			},
		},

		Name = {
			"Text",
			{
				Size = 13,
				Center = true,
				Outline = true,
				OutlineColor = BLACK,
				Color = WHITE,
				Visible = false,
			},
		},

		Health = {
			"Text",
			{
				Size = 12,
				Center = false,
				Outline = true,
				OutlineColor = BLACK,
				Color = WHITE,
				Visible = false,
			},
		},

		Distance = {
			"Text",
			{
				Size = 12,
				Center = true,
				Outline = true,
				OutlineColor = BLACK,
				Color = WHITE,
				Visible = false,
			},
		},
	}

	local drawings = {}

	for name, definition in pairs(definitions) do
		local drawing, err = newDrawing(
			definition[1],
			definition[2]
		)

		if not drawing then
			for _, created in pairs(drawings) do
				removeDrawing(created)
			end

			warnOnce("Drawing creation", err)

			return false
		end

		drawings[name] = drawing
	end

	drawingsByPlayer[player] = drawings

	stateByPlayer[player] = {
		shown = false,
		health = nil,
		distance = nil,
	}

	return true
end

local function clearAllDrawings()
	for player in pairs(drawingsByPlayer) do
		removePlayerDrawings(player)
	end
end

---------------------------------------------------------------------
-- SCREEN POSITION HELPERS
---------------------------------------------------------------------
local function getTracerOrigin(viewport)
	local centerX = viewport.X * 0.5
	local origin = Config.TracerOrigin

	if origin == "Top" then
		return Vector2new(centerX, 0)
	elseif origin == "Center" then
		return Vector2new(centerX, viewport.Y * 0.5)
	end

	return Vector2new(centerX, viewport.Y)
end

---------------------------------------------------------------------
-- PLAYER UPDATE
---------------------------------------------------------------------

local function updatePlayer(player, drawings, state, camera, tracerOrigin, localPosition)
	if destroyed or not Config.ESPEnabled then
		hideDrawings(drawings, state)
		return
	end

	-- Validação dos argumentos
	if not player or not drawings or not state or not camera then
		if state and drawings then
			hideDrawings(drawings, state)
		end
		return
	end

	-- Validação do jogador
	local success, result = pcall(function()
		return player.Parent == Players
	end)

	if not success or not result then
		hideDrawings(drawings, state)
		return
	end

	-- Obtém o personagem
	local character = callHook("GetCharacter", player)

	if not character
		or character.Parent == nil
		or callHook("IsEnemy", player) ~= true
		or callHook("IsAlive", character) ~= true then

		hideDrawings(drawings, state)
		return
	end

	-- Obtém os componentes
	local root = callHook("GetRoot", character)
	local head = callHook("GetHead", character)
	local humanoid = callHook("GetHumanoid", character)

	if not root or not head or not humanoid then
		hideDrawings(drawings, state)
		return
	end

	-- Verifica a validade dos componentes
	local valid = pcall(function()
		assert(root:IsDescendantOf(character))
		assert(head:IsDescendantOf(character))
		assert(humanoid:IsDescendantOf(character))

		assert(root:IsA("BasePart"))
		assert(head:IsA("BasePart"))
		assert(humanoid:IsA("Humanoid"))
	end)

	if not valid then
		hideDrawings(drawings, state)
		return
	end

	-- Verifica a validade dos desenhos
	local box = drawings.Box
	local tracer = drawings.Tracer
	local name = drawings.Name
	local health = drawings.Health
	local distanceDrawing = drawings.Distance

	if not box or not tracer or not name
		or not health or not distanceDrawing then
		hideDrawings(drawings, state)
		return
	end

	local drawingsValid = pcall(function()
		local _ = box.Visible
		local _ = tracer.Visible
		local _ = name.Visible
		local _ = health.Visible
		local _ = distanceDrawing.Visible
	end)

	if not drawingsValid then
		hideDrawings(drawings, state)
		return
	end

	-- Projeção protegida
	local rootPosition
	local rootScreen
	local headScreen
	local legScreen

	local projectionValid = pcall(function()
		rootPosition = root.Position

		local rootOnScreen
		rootScreen, rootOnScreen = camera:WorldToViewportPoint(rootPosition)

		if not rootOnScreen or rootScreen.Z <= 0 then
			error("Root fora da tela")
		end

		headScreen = camera:WorldToViewportPoint(
			head.Position + Vector3new(0, 0.5, 0)
		)

		legScreen = camera:WorldToViewportPoint(
			rootPosition - Vector3new(0, 3, 0)
		)

		if headScreen.Z <= 0 or legScreen.Z <= 0 then
			error("Personagem parcialmente atrás da câmera")
		end
	end)

	if not projectionValid then
		hideDrawings(drawings, state)
		return
	end

	-- Validação das dimensões
	local height = abs(headScreen.Y - legScreen.Y)

	if height <= 0 or height ~= height then
		hideDrawings(drawings, state)
		return
	end

	local width = height * 0.65

	local boxX = rootScreen.X - width * 0.5
	local boxY = headScreen.Y

	-- Evita dimensões inconsistentes
	if width <= 0 or width ~= width then
		hideDrawings(drawings, state)
		return
	end

	state.shown = true

	-----------------------------------------------------------------
	-- BOX
	-----------------------------------------------------------------

	if Config.ESPBox then
		local success = pcall(function()
			box.Size = Vector2new(width, height)
			box.Position = Vector2new(boxX, boxY)
			box.Color = callHook("GetBoxColor", player) or Config.BoxColor
			setVisible(box, true)
		end)

		if not success then
			hideDrawings(drawings, state)
			return
		end
	else
		setVisible(box, false)
	end

	-----------------------------------------------------------------
	-- TRACER
	-----------------------------------------------------------------

	if Config.ESPTracer then
		local success = pcall(function()
			tracer.From = tracerOrigin
			tracer.To = Vector2new(rootScreen.X, legScreen.Y)
			tracer.Color = callHook("GetTracerColor", player) or Config.TracerColor
			setVisible(tracer, true)
		end)

		if not success then
			hideDrawings(drawings, state)
			return
		end
	else
		setVisible(tracer, false)
	end

	-----------------------------------------------------------------
	-- NAME
	-----------------------------------------------------------------

	if Config.ESPName then
		local success = pcall(function()
			local displayName = callHook("GetDisplayName", player)
				or player.Name

			if name.Text ~= displayName then
				name.Text = displayName
			end

			name.Position = Vector2new(rootScreen.X, headScreen.Y - 16)
			setVisible(name, true)
		end)

		if not success then
			hideDrawings(drawings, state)
			return
		end
	else
		setVisible(name, false)
	end

	-----------------------------------------------------------------
	-- HEALTH
	-----------------------------------------------------------------

	if Config.ESPHealth then
		local success = pcall(function()
			local healthPercent = callHook("GetHealthPercent", character)

			if type(healthPercent) ~= "number" then
				healthPercent = 0
			end

			healthPercent = mathClamp(healthPercent, 0, 100)

			if healthPercent ~= state.health then
				state.health = healthPercent
				health.Text = tostring(mathFloor(healthPercent)) .. "%"

				health.Color = Color3fromHSV(
					healthPercent / 100 * 0.33,
					0.9,
					1
				)
			end

			health.Position = Vector2new(boxX + width + 4, headScreen.Y)
			setVisible(health, true)
		end)

		if not success then
			hideDrawings(drawings, state)
			return
		end
	else
		setVisible(health, false)
		state.health = nil
	end

	-----------------------------------------------------------------
	-- DISTANCE
	-----------------------------------------------------------------

	if Config.ESPDistance then
		local success = pcall(function()
			local distance = 0

			if localPosition then
				distance = mathFloor((localPosition - rootPosition).Magnitude)
			end

			if distance ~= state.distance then
				state.distance = distance
				distanceDrawing.Text = "[" .. tostring(distance) .. " studs]"
			end

			distanceDrawing.Position = Vector2new(
				rootScreen.X,
				legScreen.Y + 2
			)

			setVisible(distanceDrawing, true)
		end)

		if not success then
			hideDrawings(drawings, state)
			return
		end
	else
		setVisible(distanceDrawing, false)
		state.distance = nil
	end
end

local function updateESP(camera)
	if destroyed or not Config.ESPEnabled then
		return
	end

	if not camera or typeof(camera) ~= "Instance" then
		return
	end

	if not camera:IsA("Camera") then
		return
	end

	local viewport = camera.ViewportSize

	if viewport.X <= 0 or viewport.Y <= 0 then
		return
	end

	local tracerOrigin = getTracerOrigin(viewport)

	local localCharacter = LocalPlayer.Character
	local localRoot = localCharacter
		and Defaults.GetRoot(localCharacter)

	local localPosition = localRoot
		and localRoot.Position

	for player, drawings in pairs(drawingsByPlayer) do
		if destroyed then
			break
		end

		local state = stateByPlayer[player]

		if not state then
			continue
		end

		if player.Parent ~= Players then
			removePlayerDrawings(player)
			continue
		end

		local ok, err = pcall(function()
			updatePlayer(
				player,
				drawings,
				state,
				camera,
				tracerOrigin,
				localPosition
			)
		end)

		if not ok then
			warnOnce(
				"Player update: " .. player.Name,
				err
			)

			hideDrawings(drawings, state)
		end
	end
end

local function hideAllVisible()
	for player, drawings in pairs(drawingsByPlayer) do
		local state = stateByPlayer[player]

		if state and state.shown then
			hideDrawings(drawings, state)
		end
	end
end

---------------------------------------------------------------------
-- CONFIGURATION API
---------------------------------------------------------------------
function ESP.SetConfig(newConfig)
	if destroyed or type(newConfig) ~= "table" then
		return false
	end

	local validOrigins = {
		Top = true,
		Center = true,
		Bottom = true,
	}

	for key, value in pairs(newConfig) do
		local currentValue = Config[key]

		if currentValue == nil then
			continue
		end

		if key == "TracerOrigin" then
			if type(value) == "string"
				and validOrigins[value] then

				Config[key] = value
			end

		elseif key == "BoxColor" or key == "TracerColor" then
			if typeof(value) == "Color3" then
				Config[key] = value
			end

		elseif typeof(value) == typeof(currentValue) then
			Config[key] = value
		end
	end

	if not Config.ESPEnabled then
		hideAllVisible()
	end

	return true
end

---------------------------------------------------------------------
-- PUBLIC API
---------------------------------------------------------------------
function ESP.SetEnabled(enabled)
	if destroyed then
		return false
	end

	Config.ESPEnabled = enabled == true

	if not Config.ESPEnabled then
		hideAllVisible()
	end

	return true
end

function ESP.SetHook(name, callback)
	return setHook(name, callback)
end

function ESP.ResetHook(name)
	if not Defaults[name] then
		return false
	end

	Hooks[name] = Defaults[name]
	return true
end

function ESP.ResetHooks()
	for name, callback in pairs(Defaults) do
		Hooks[name] = callback
	end
end

function ESP.RefreshPlayers()
	if destroyed then
		return false
	end

	local currentPlayers = Players:GetPlayers()
	local activePlayers = {}

	for _, player in ipairs(currentPlayers) do
		if player ~= LocalPlayer then
			activePlayers[player] = true
			createPlayerDrawings(player)
		end
	end

	for player in pairs(drawingsByPlayer) do
		if not activePlayers[player] then
			removePlayerDrawings(player)
		end
	end

	return true
end

function ESP.Destroy()
	if destroyed then
		return
	end

	destroyed = true
	Config.ESPEnabled = false

	for index = #connections, 1, -1 do
		local connection = connections[index]

		if connection then
			pcall(function()
				connection:Disconnect()
			end)
		end

		connections[index] = nil
	end

	clearAllDrawings()

	table.clear(connections)
	table.clear(warned)

	if Environment.KantHubESPDestroy == ESP.Destroy then
		Environment.KantHubESPDestroy = nil
	end
end

---------------------------------------------------------------------
-- INITIALIZATION
---------------------------------------------------------------------
ESP.RefreshPlayers()

connect(Players.PlayerAdded, createPlayerDrawings)
connect(Players.PlayerRemoving, removePlayerDrawings)

connect(RunService.RenderStepped, function()
	if destroyed or not Config.ESPEnabled then
		return
	end

	local camera = workspace.CurrentCamera
	if not camera then
		return
	end

	safeCall("Update", updateESP, camera)
end)

Environment.KantHubESPDestroy = ESP.Destroy

return ESP
end;
};
G2L_MODULES[G2L["c"]] = {
Closure = function()
    local script = G2L["c"];---------------------------------------------------------------------
-- SERVICES
---------------------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

---------------------------------------------------------------------
-- EXTERNAL FUNCTIONS
---------------------------------------------------------------------
local globalEnv  = (getgenv and getgenv()) or _G
local mouseMover = mousemoverel or mouse_move

if not (Drawing and Drawing.new) then
	warn("[Aim] Drawing library is not available.")
	return {Config = {},Destroy = function() end}
end

---------------------------------------------------------------------
-- MODULE
---------------------------------------------------------------------
local Aim = {}

Aim.Config = {
	AimbotEnabled = false,
	VisibleCheck = true,
	TeamCheck = false,
	AimbotPart = "Head", -- "Head" or "Body"
	SmoothAimbot = 2,
	FOVRadius = 60,
	FOVColor = Color3.fromRGB(255, 255, 255),
	ShowFOV = false,
	Prediction = 0,
	OffsetY = 0,
}

local Config = Aim.Config
local destroyed = false
local connections = {}
local playerList = {}

local Vector2new = Vector2.new
local Vector3new = Vector3.new
local mathmax = math.max
local mathclamp = math.clamp
local mathsqrt = math.sqrt

---------------------------------------------------------------------
-- CONNECTION MANAGEMENT
---------------------------------------------------------------------

local function connect(signal, callback)
	if destroyed then
		return nil
	end

	if not signal or type(callback) ~= "function" then
		return nil
	end

	local success, connection = pcall(function()
		return signal:Connect(callback)
	end)

	if not success then
		warn("[Aim] Connection error: " .. tostring(connection))
		return nil
	end

	connections[#connections + 1] = connection

	return connection
end


---------------------------------------------------------------------
-- PLAYER CACHE
---------------------------------------------------------------------

local function refreshPlayers(excluded)
	if destroyed then
		return false
	end

	table.clear(playerList)

	local success, players = pcall(function()
		return Players:GetPlayers()
	end)

	if not success then
		warn("[Aim] Player refresh error: " .. tostring(players))
		return false
	end

	for _, player in ipairs(players) do
		if player ~= LocalPlayer
			and player ~= excluded
			and player.Parent == Players then

			playerList[#playerList + 1] = player
		end
	end

	return true
end

---------------------------------------------------------------------
-- TEAM VALIDATION
---------------------------------------------------------------------
local function isEnemyByTeam(player)
	if not player or player == LocalPlayer then
		return false
	end

	if LocalPlayer.Neutral or player.Neutral then
		return true
	end

	local localTeam = LocalPlayer.Team
	local targetTeam = player.Team

	if not localTeam or not targetTeam then
		return true
	end

	return localTeam ~= targetTeam
end

---------------------------------------------------------------------
-- AIM HOOKS
---------------------------------------------------------------------
local AimDefaults = {}

function AimDefaults.GetCharacter(player)
	return player.Character
end

function AimDefaults.IsAlive(character)
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	return humanoid ~= nil and humanoid.Health > 0
end

function AimDefaults.IsEnemy(player)
	if not Config.TeamCheck then
		return true
	end

	return isEnemyByTeam(player)
end

function AimDefaults.GetAimPart(character)
	if Config.AimbotPart == "Head" then
		return character:FindFirstChild("Head")
	end

	return character:FindFirstChild("HumanoidRootPart")
		or character:FindFirstChild("Head")
end

function AimDefaults.GetAimPosition(part)
	local position = part.Position

	if Config.OffsetY ~= 0 then
		position += Vector3new(0, Config.OffsetY, 0)
	end

	if Config.Prediction > 0 then
		position += part.AssemblyLinearVelocity * Config.Prediction
	end

	return position
end

function AimDefaults.GetIgnoreList()
	return { LocalPlayer.Character }
end

local Hooks = table.clone(AimDefaults)

function Aim.SetHook(name, callback)
	if destroyed then
		return false
	end

	if type(name) ~= "string" then
		return false
	end

	if type(callback) ~= "function" then
		return false
	end

	if type(AimDefaults[name]) ~= "function" then
		warn("[Aim] Unknown hook: " .. name)
		return false
	end

	Hooks[name] = callback

	return true
end

function Aim.ResetHook(name)
	if destroyed then
		return false
	end

	if name then
		if type(name) ~= "string" or not AimDefaults[name] then
			return false
		end

		Hooks[name] = AimDefaults[name]
		return true
	end

	Hooks = table.clone(AimDefaults)

	return true
end

---------------------------------------------------------------------
-- OPTIONAL GAME-SPECIFIC TEAM HOOKS
---------------------------------------------------------------------
local function defuseIsEnemy(player)
	if not player then
		return false
	end

	local localStats = LocalPlayer:FindFirstChild("PlayerStates")
	local localTeam = localStats and localStats:FindFirstChild("Team")

	local targetStats = player:FindFirstChild("PlayerStates")
	local targetTeam = targetStats and targetStats:FindFirstChild("Team")

	return localTeam ~= nil
		and targetTeam ~= nil
		and localTeam.Value ~= targetTeam.Value
end

if game.PlaceId == 112757576021097 then
	Aim.SetHook("IsEnemy", function(player)
		return not Config.TeamCheck or defuseIsEnemy(player)
	end)
end

---------------------------------------------------------------------
-- FOV DRAWING
---------------------------------------------------------------------
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.2
FOVCircle.NumSides = 64
FOVCircle.Filled = false
FOVCircle.Transparency = 1
FOVCircle.Visible = false

---------------------------------------------------------------------
-- VISIBILITY CHECK
---------------------------------------------------------------------
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.IgnoreWater = true


local function updateRayFilter()
	if destroyed then
		return false
	end

	local success, ignoreList = pcall(Hooks.GetIgnoreList)

	if not success then
		warn("[Aim] Ignore list error: " .. tostring(ignoreList))
		return false
	end

	if type(ignoreList) ~= "table" then
		return false
	end

	local validInstances = {}

	for _, instance in ipairs(ignoreList) do
		if typeof(instance) == "Instance" then
			validInstances[#validInstances + 1] = instance
		end
	end

	local updated, err = pcall(function()
		rayParams.FilterDescendantsInstances = validInstances
	end)

	if not updated then
		warn("[Aim] Ray filter error: " .. tostring(err))
		return false
	end

	return true
end

local function isVisible(camera, aimPosition, character)
	local origin = camera.CFrame.Position
	local result = workspace:Raycast(origin, aimPosition - origin, rayParams)

	return result == nil or result.Instance:IsDescendantOf(character)
end

---------------------------------------------------------------------
-- TARGET SELECTION
---------------------------------------------------------------------
local function getClosestTarget(camera)
	local radius = Config.FOVRadius
	local bestDistanceSquared = radius * radius
	local bestDelta

	local center = camera.ViewportSize / 2
	local worldToViewport = camera.WorldToViewportPoint
	local visibleCheck = Config.VisibleCheck

	for index = 1, #playerList do
		local player = playerList[index]

		if Hooks.IsEnemy(player) == true then
			local character = Hooks.GetCharacter(player)

			if character and Hooks.IsAlive(character) then
				local part = Hooks.GetAimPart(character)

				if part then
					local aimPosition = Hooks.GetAimPosition(part)
					local screenPosition, onScreen =
						worldToViewport(camera, aimPosition)

					if onScreen and screenPosition.Z > 0 then
						local dx = screenPosition.X - center.X
						local dy = screenPosition.Y - center.Y
						local distanceSquared = dx * dx + dy * dy

						if distanceSquared <= bestDistanceSquared
							and (not visibleCheck
								or isVisible(camera, aimPosition, character)) then

							bestDistanceSquared = distanceSquared
							bestDelta = Vector2new(dx, dy)
						end
					end
				end
			end
		end
	end

	if not bestDelta then
		return nil
	end

	return bestDelta, mathsqrt(bestDistanceSquared)
end

---------------------------------------------------------------------
-- AIM UPDATE
---------------------------------------------------------------------
local function updateAim(camera)
	if not mouseMover then
		return
	end

	local delta, distance = getClosestTarget(camera)

	if not delta or distance <= 1.5 then
		return
	end

	local mouseDelta = UserInputService:GetMouseDelta()

	if mouseDelta.Magnitude > 1.2 and mouseDelta:Dot(delta) < 0 then
		return
	end

	local smooth = mathmax(1, Config.SmoothAimbot)

	mouseMover(
		mathclamp(delta.X / smooth, -500, 500),
		mathclamp(delta.Y / smooth, -500, 500)
	)
end

---------------------------------------------------------------------
-- PUBLIC API
---------------------------------------------------------------------
function Aim.GetClosestTarget()
	local camera = workspace.CurrentCamera
	if not camera then
		return nil
	end

	return getClosestTarget(camera)
end

function Aim.SetEnabled(state)
	Config.AimbotEnabled = state == true
end

function Aim.SetFOVVisible(state)
	Config.ShowFOV = state == true
end


function Aim.Destroy()
	if destroyed then
		return
	end

	destroyed = true

	Config.AimbotEnabled = false
	Config.ShowFOV = false

	for index = #connections, 1, -1 do
		local connection = connections[index]

		if connection then
			pcall(function()
				connection:Disconnect()
			end)
		end

		connections[index] = nil
	end

	table.clear(connections)
	table.clear(playerList)

	pcall(function()
		FOVCircle.Visible = false
		FOVCircle:Remove()
	end)

	Hooks = table.clone(AimDefaults)

	if globalEnv.KantHubAimDestroy == Aim.Destroy then
		globalEnv.KantHubAimDestroy = nil
	end
end

---------------------------------------------------------------------
-- INITIALIZATION (AUTOMATIC ON REQUIRE)
---------------------------------------------------------------------
if globalEnv.KantHubAimDestroy then
	pcall(globalEnv.KantHubAimDestroy)
end

refreshPlayers()
updateRayFilter()

connect(Players.PlayerAdded, function()
	refreshPlayers()
end)

connect(Players.PlayerRemoving, function(player)
	refreshPlayers(player)
end)

connect(LocalPlayer.CharacterAdded, function()
	updateRayFilter()
end)

connect(RunService.RenderStepped, function()
	if destroyed then
		return
	end

	local camera = workspace.CurrentCamera
	if not camera then
		return
	end

	if Config.ShowFOV then
		FOVCircle.Position = camera.ViewportSize / 2
		FOVCircle.Radius = Config.FOVRadius
		FOVCircle.Color = Config.FOVColor
		FOVCircle.Visible = true
	else
		FOVCircle.Visible = false
	end

	if Config.AimbotEnabled then
		local success, err = pcall(updateAim, camera)
		if not success then
			warn("[Aim] Update error: " .. tostring(err))
		end
	end
end)

globalEnv.KantHubAimDestroy = Aim.Destroy

return Aim
end;
};
-- StarterGui.LoadingUI.Scripts.Loader
local function C_3()
local script = G2L["3"];
	---------------------------------------------------------------------
	-- SERVICES
	---------------------------------------------------------------------
	local Players = game:GetService("Players")
	
	local LocalPlayer = Players.LocalPlayer
	local ScreenGui = script.Parent.Parent
	
	---------------------------------------------------------------------
	-- FOLDERS
	---------------------------------------------------------------------
	local ModulesFolder = ScreenGui:WaitForChild("Modules")
	local UIModules     = ModulesFolder:WaitForChild("UI Modules")
	local FuncModules   = ModulesFolder:WaitForChild("Functions Modules")
	
	---------------------------------------------------------------------
	-- CONFIGURATION
	---------------------------------------------------------------------
	local Config = {
		Settings = {
			Fullbright = false,
			AntiAFK = false,
			MenuKey = Enum.KeyCode.RightControl,
		},
	
		ESP = {
			ESPEnabled = false,
			ESPName = false,
			ESPBox = false,
			ESPTracer = false,
			ESPHealth = false,
			ESPDistance = false,
	
			TeamCheck = false,
			TracerOrigin = "Bottom",
	
			BoxColor = Color3.fromRGB(255, 255, 255),
			TracerColor = Color3.fromRGB(255, 255, 255),
		},
	
		Aimbot = {
			AimbotEnabled = false,
			VisibleCheck = true,
			TeamCheck = false,
			AimbotPart = "Head",
	
			SmoothAimbot = 2,
			FOVRadius = 60,
			FOVColor = Color3.fromRGB(255, 255, 255),
			ShowFOV = false,
	
			Prediction = 0,
			OffsetY = 0,
		},
	
		Fly = {
			FLY_ENABLE = false,
			FLY_SPEED = 50,
			SPRINT_MULTIPLIER = 2.5,
	
			ASCEND_KEY = Enum.KeyCode.Space,
			DESCEND_KEY = Enum.KeyCode.LeftControl,
			TOGGLE_KEY = Enum.KeyCode.F,
		},
	
		Noclip = {
			NoclipEnabled = false,
		},
	}
	
	---------------------------------------------------------------------
	-- RUNTIME STATE
	---------------------------------------------------------------------
	local State = {
		Initializing = false,
		Initialized = false,
		Destroyed = false,
	
		Engine = nil,
		Window = nil,
		Tabs = nil,
	
		Modules = {},
		Connections = {},
	}
	
	---------------------------------------------------------------------
	-- UTILITIES
	---------------------------------------------------------------------
	local function IsAlive()
		return not State.Destroyed
	end
	
	local function SafeCall(label, callback, ...)
		if type(callback) ~= "function" then
			return false, ("Invalid callback: %s"):format(tostring(label))
		end
	
		local results = table.pack(pcall(callback, ...))
	
		if not results[1] then
			local message = tostring(results[2])
			warn(("[KantHub] %s failed: %s"):format(tostring(label), message))
			return false, message
		end
	
		return true, table.unpack(results, 2, results.n)
	end
	
	local function Connect(signal, callback, label)
		if not IsAlive() then
			return nil
		end
	
		if not signal or type(signal.Connect) ~= "function" then
			warn(("[KantHub] Invalid signal: %s"):format(tostring(label or "unknown")))
			return nil
		end
	
		local success, connection = SafeCall(label or "Signal connection", signal.Connect, signal, callback)
	
		if not success or not connection then
			return nil
		end
	
		table.insert(State.Connections, connection)
	
		return connection
	end
	
	local function DisconnectAll()
		for index = #State.Connections, 1, -1 do
			local connection = State.Connections[index]
	
			SafeCall("Connection disconnection", function()
				if connection.Connected then
					connection:Disconnect()
				end
			end)
	
			State.Connections[index] = nil
		end
	end
	
	local function GetOptionalMethod(object, methodName)
		if type(object) ~= "table" and typeof(object) ~= "Instance" then
			return nil
		end
	
		local success, method = pcall(function()
			return object[methodName]
		end)
	
		if success and type(method) == "function" then
			return method
		end
	
		return nil
	end
	
	local function CallOptionalMethod(object, methodName, label, passSelf)
		local method = GetOptionalMethod(object, methodName)
	
		if not method then
			return true
		end
	
		if passSelf then
			return SafeCall(label or methodName, method, object)
		end
	
		return SafeCall(label or methodName, method)
	end
	
	local function ValidateInstance(instance, expectedClass, label)
		if not instance then
			error(("%s is unavailable."):format(label), 2)
		end
	
		if not instance:IsA(expectedClass) then
			error(("%s must be a %s."):format(label, expectedClass), 2)
		end
	
		return instance
	end
	
	---------------------------------------------------------------------
	-- MODULE LOADING
	---------------------------------------------------------------------
	-- optional = true: se o módulo falhar (ex.: executor sem Drawing),
	-- o hub continua funcionando sem ele.
	local function RequireModule(parent, moduleName, optional)
		local moduleScript = parent:FindFirstChild(moduleName)
	
		if not moduleScript then
			if optional then
				warn(("[KantHub] Optional module '%s' was not found."):format(moduleName))
				return nil
			end
			error(("Module '%s' was not found."):format(moduleName), 2)
		end
	
		ValidateInstance(moduleScript, "ModuleScript", moduleName)
	
		local success, result = SafeCall(("Require module '%s'"):format(moduleName), require, moduleScript)
	
		if not success then
			if optional then
				return nil
			end
			error(("Failed to load module '%s': %s"):format(moduleName, tostring(result)), 2)
		end
	
		if type(result) ~= "table" then
			if optional then
				warn(("[KantHub] Module '%s' is unavailable in this executor."):format(moduleName))
				return nil
			end
			error(("Module '%s' must return a table."):format(moduleName), 2)
		end
	
		return result
	end
	
	local function ValidateMethod(moduleTable, methodName, moduleName)
		if type(moduleTable[methodName]) ~= "function" then
			error(("Module '%s' is missing required method '%s'."):format(moduleName, methodName), 2)
		end
	end
	
	local function LoadModules()
		local modules = State.Modules
	
		-- Cada módulo é registrado imediatamente, para que Destroy()
		-- consiga limpar os já carregados se um posterior falhar.
		modules.Aim      = RequireModule(FuncModules, "Aimbot", true)
		modules.ESP      = RequireModule(FuncModules, "ESP", true)
		modules.Movement = RequireModule(FuncModules, "Moviment")
		modules.Others   = RequireModule(FuncModules, "Others")
	
		modules.UIBuilder = RequireModule(UIModules, "UIBuilder")
		modules.Loader    = RequireModule(UIModules, "LoadUI")
	
		ValidateMethod(modules.Movement, "new", "Moviment")
		ValidateMethod(modules.Others, "Fullbright", "Others")
		ValidateMethod(modules.Others, "AntiAFK", "Others")
	
		ValidateMethod(modules.UIBuilder, "Init", "UIBuilder")
		ValidateMethod(modules.Loader, "Load", "LoadUI")
	
		return modules
	end
	
	---------------------------------------------------------------------
	-- CONFIGURATION BINDING
	---------------------------------------------------------------------
	-- A UI escreve diretamente em Config.ESP / Config.Aimbot.
	-- Para os módulos enxergarem essas mudanças, a tabela de config do módulo
	-- passa a ser a fonte única: copiamos os valores padrão para ela e
	-- apontamos Config.ESP / Config.Aimbot para a mesma tabela.
	local function BindModuleConfig(moduleName, configKey)
		local module = State.Modules[moduleName]
	
		if not module then
			return true
		end
	
		if type(module.Config) ~= "table" then
			return false, ("%s does not expose a Config table."):format(moduleName)
		end
	
		for key, value in pairs(Config[configKey]) do
			module.Config[key] = value
		end
	
		Config[configKey] = module.Config
	
		return true
	end
	
	local function BindAllConfigs()
		local success, err = BindModuleConfig("Aim", "Aimbot")
		if not success then
			error(err, 2)
		end
	
		success, err = BindModuleConfig("ESP", "ESP")
		if not success then
			error(err, 2)
		end
	
		return true
	end
	
	---------------------------------------------------------------------
	-- MOVEMENT
	---------------------------------------------------------------------
	local function CreateMovement()
		local fly = Config.Fly
	
		local instance = State.Modules.Movement.new({
			Fly = {
				Enabled = fly.FLY_ENABLE,
				Speed = fly.FLY_SPEED,
				SprintMultiplier = fly.SPRINT_MULTIPLIER,
				ToggleKey = fly.TOGGLE_KEY,
				AscendKey = fly.ASCEND_KEY,
				DescendKey = fly.DESCEND_KEY,
			},
			Noclip = {
				Enabled = Config.Noclip.NoclipEnabled,
			},
		})
	
		if not instance then
			error("Movement.new returned nil.", 2)
		end
	
		State.Modules.MovementInstance = instance
	end
	
	---------------------------------------------------------------------
	-- HUB CREATION
	---------------------------------------------------------------------
	local function CreateHub()
		local modules = State.Modules
		local loaderModule = modules.Loader
	
		local called, engine, loadErr = SafeCall("UI Engine loading", function()
			return loaderModule:Load()
		end)
	
		if not called then
			error("Unable to load UI Engine: " .. tostring(engine), 2)
		end
	
		if not engine then
			error("UI Engine loader returned nil: " .. tostring(loadErr), 2)
		end
	
		if type(engine.Config) ~= "table" or type(engine.Config.Menuname) ~= "table" then
			error("UI Engine returned an invalid configuration structure.", 2)
		end
	
		if type(engine.CreateHub) ~= "function" then
			error("UI Engine is missing CreateHub().", 2)
		end
	
		State.Engine = engine
	
		engine.Config.Menuname.Title = "Kant Hub - Keyless | Universal"
		engine.Config.Menuname.Sub = "Kant Hub"
		engine.Config.MenuKey = Config.Settings.MenuKey
	
		local createSuccess, windowOrError = SafeCall("Hub window creation", engine.CreateHub, engine)
	
		if not createSuccess then
			error("Unable to create Hub window: " .. tostring(windowOrError), 2)
		end
	
		local window = windowOrError
	
		if not window then
			error("UI Engine failed to create the Hub window.", 2)
		end
	
		if type(window.CreateTab) ~= "function" then
			error("Hub window does not expose CreateTab().", 2)
		end
	
		State.Window = window
	
		-----------------------------------------------------------------
		-- UI BUILDER
		-----------------------------------------------------------------
		-- O UIBuilder cria seus próprios helpers em cima da API real da engine
		-- (Tab:CreateToggle, CreateSlider etc.); o primeiro argumento é mantido
		-- apenas por compatibilidade.
		local context = {
			Others = modules.Others,
			GetMovement = function()
				return State.Modules.MovementInstance
			end,
		}
	
		-- SafeCall devolve (pcall ok, retorno1, retorno2): aqui o retorno1 do
		-- UIBuilder.Init é o seu próprio sucesso e o retorno2 são as abas/erro.
		local called2, built, tabsOrError = SafeCall(
			"UIBuilder initialization",
			modules.UIBuilder.Init,
			engine,
			window,
			Config,
			context
		)
	
		if not called2 then
			error("Unable to initialize UIBuilder: " .. tostring(built), 2)
		end
	
		if not built then
			error("Unable to initialize UIBuilder: " .. tostring(tabsOrError), 2)
		end
	
		State.Tabs = tabsOrError
	
		return window
	end
	
	---------------------------------------------------------------------
	-- SHUTDOWN
	---------------------------------------------------------------------
	local function Destroy()
		if State.Destroyed then
			return true
		end
	
		State.Destroyed = true
		State.Initializing = false
	
		print("[KantHub] Shutting down...")
	
		Config.Settings.Fullbright = false
		Config.Settings.AntiAFK = false
	
		DisconnectAll()
	
		local modules = State.Modules
	
		-- Aim e ESP expõem Destroy como função de módulo (sem self).
		if modules.Aim then
			CallOptionalMethod(modules.Aim, "Destroy", "Aim controller destruction", false)
		end
	
		if modules.ESP then
			CallOptionalMethod(modules.ESP, "Destroy", "ESP module destruction", false)
		end
	
		-- Others e Movement usam método com ':' (precisam de self).
		if modules.Others then
			CallOptionalMethod(modules.Others, "Destroy", "Others destruction", true)
		end
	
		if modules.MovementInstance then
			CallOptionalMethod(modules.MovementInstance, "Destroy", "Movement instance destruction", true)
			modules.MovementInstance = nil
		end
	
		CallOptionalMethod(State.Window, "Destroy", "Window destruction", true)
		CallOptionalMethod(State.Engine, "Destroy", "Engine destruction", true)
	
		if modules.UIBuilder and type(modules.UIBuilder.Reset) == "function" then
			SafeCall("UIBuilder reset", modules.UIBuilder.Reset)
		end
	
		State.Window = nil
		State.Engine = nil
		State.Tabs = nil
		State.Modules = {}
	
		State.Initialized = false
	
		print("[KantHub] Shutdown completed.")
	
		return true
	end
	
	---------------------------------------------------------------------
	-- INITIALIZATION
	---------------------------------------------------------------------
	local function Initialize()
		if State.Destroyed then
			return false, "The controller has already been destroyed."
		end
	
		if State.Initialized then
			return true
		end
	
		if State.Initializing then
			return false, "Initialization is already in progress."
		end
	
		State.Initializing = true
	
		local success, result = SafeCall("Controller initialization", function()
			ValidateInstance(ScreenGui, "ScreenGui", "ScreenGui")
			ValidateInstance(ModulesFolder, "Folder", "Modules folder")
			ValidateInstance(UIModules, "Folder", "UI Modules folder")
			ValidateInstance(FuncModules, "Folder", "Functions Modules folder")
	
			LoadModules()
			BindAllConfigs()
			CreateMovement()
			CreateHub()
	
			return true
		end)
	
		State.Initializing = false
	
		if not success then
			Destroy()
			return false, result
		end
	
		State.Initialized = true
	
		-- O botão X da engine só destrói a janela. Aqui encerramos também
		-- ESP, Aimbot, Fly etc. quando a ScreenGui da engine for destruída.
		local window = State.Window
		if window and typeof(window.ScreenGui) == "Instance" then
			Connect(window.ScreenGui.Destroying, Destroy, "Window ScreenGui destroying")
		end
	
		print("[KantHub] KantHub initialized successfully.")
	
		return true
	end
	
	---------------------------------------------------------------------
	-- EXECUTION
	---------------------------------------------------------------------
	local initialized, initializationError = Initialize()
	
	if not initialized then
		warn("[KantHub] Initialization failed: " .. tostring(initializationError))
		return
	end
	
	---------------------------------------------------------------------
	-- LIFECYCLE
	---------------------------------------------------------------------
	Connect(script.Destroying, Destroy, "Loader destruction")
end;
task.spawn(C_3);

return G2L["1"], require;
