--[=[
 ██╗  ██╗ █████╗ ███╗   ██╗████████╗ ██╗  ██╗██╗   ██╗██████╗
 ██║ ██╔╝██╔══██╗████╗  ██║╚══██╔══╝ ██║  ██║██║   ██║██╔══██╗
 █████╔╝ ███████║██╔██╗ ██║   ██║    ███████║██║   ██║██████╔╝
 ██╔═██╗ ██╔══██║██║╚██╗██║   ██║    ██╔══██║██║   ██║██╔══██╗
 ██║  ██╗██║  ██║██║ ╚████║   ██║    ██║  ██║╚██████╔╝██████╔╝
 ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝
                    @TavssDev @Crack-RBX
--]=]
-- Instances: 15 | Scripts: 1 | Modules: 2 | Tags: 0
local G2L = {};

-- StarterGui.Loader
G2L["1"] = Instance.new("ScreenGui", game:GetService("CoreGui"));
G2L["1"]["IgnoreGuiInset"] = true;
G2L["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
G2L["1"]["Name"] = [[Loader]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.Loader.Modules
G2L["2"] = Instance.new("Folder", G2L["1"]);
G2L["2"]["Name"] = [[Modules]];


-- StarterGui.Loader.Modules.LoadingAnimation
G2L["3"] = Instance.new("ModuleScript", G2L["2"]);
G2L["3"]["Name"] = [[LoadingAnimation]];


-- StarterGui.Loader.Modules.ListScripts
G2L["4"] = Instance.new("ModuleScript", G2L["2"]);
G2L["4"]["Name"] = [[ListScripts]];


-- StarterGui.Loader.Scripts
G2L["5"] = Instance.new("Folder", G2L["1"]);
G2L["5"]["Name"] = [[Scripts]];


-- StarterGui.Loader.Scripts.Loader
G2L["6"] = Instance.new("LocalScript", G2L["5"]);
G2L["6"]["Name"] = [[Loader]];


-- StarterGui.Loader.UI
G2L["7"] = Instance.new("Folder", G2L["1"]);
G2L["7"]["Name"] = [[UI]];


-- StarterGui.Loader.UI.Background
G2L["8"] = Instance.new("Frame", G2L["7"]);
G2L["8"]["Visible"] = false;
G2L["8"]["BorderSizePixel"] = 0;
G2L["8"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8"]["Name"] = [[Background]];
G2L["8"]["BackgroundTransparency"] = 0.65;


-- StarterGui.Loader.UI.CanvasGroup
G2L["9"] = Instance.new("CanvasGroup", G2L["7"]);
G2L["9"]["Visible"] = false;
G2L["9"]["ZIndex"] = 2;
G2L["9"]["BorderSizePixel"] = 0;
G2L["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9"]["BackgroundTransparency"] = 1;


-- StarterGui.Loader.UI.CanvasGroup.UI
G2L["a"] = Instance.new("Frame", G2L["9"]);
G2L["a"]["BorderSizePixel"] = 0;
G2L["a"]["BackgroundColor3"] = Color3.fromRGB(10, 10, 12);
G2L["a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["a"]["Size"] = UDim2.new(0.2981, 0, 0.10202, 0);
G2L["a"]["Position"] = UDim2.new(0.49968, 0, 0.49937, 0);
G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a"]["Name"] = [[UI]];


-- StarterGui.Loader.UI.CanvasGroup.UI.UICorner
G2L["b"] = Instance.new("UICorner", G2L["a"]);
G2L["b"]["CornerRadius"] = UDim.new(0.1, 0);


-- StarterGui.Loader.UI.CanvasGroup.UI.UIStroke
G2L["c"] = Instance.new("UIStroke", G2L["a"]);
G2L["c"]["Thickness"] = 1.8;
G2L["c"]["Color"] = Color3.fromRGB(40, 40, 43);


-- StarterGui.Loader.UI.CanvasGroup.UI.Credit
G2L["d"] = Instance.new("TextLabel", G2L["a"]);
G2L["d"]["BorderSizePixel"] = 0;
G2L["d"]["TextSize"] = 14;
G2L["d"]["TextYAlignment"] = Enum.TextYAlignment.Bottom;
G2L["d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["d"]["TextColor3"] = Color3.fromRGB(162, 162, 171);
G2L["d"]["BackgroundTransparency"] = 1;
G2L["d"]["Size"] = UDim2.new(0.27953, 0, 0.15436, 0);
G2L["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d"]["Text"] = [[Created by TavssDev]];
G2L["d"]["Name"] = [[Credit]];
G2L["d"]["Position"] = UDim2.new(0.72047, 0, 0.84564, 0);


-- StarterGui.Loader.UI.CanvasGroup.UI.Title
G2L["e"] = Instance.new("TextLabel", G2L["a"]);
G2L["e"]["TextWrapped"] = true;
G2L["e"]["ZIndex"] = 2;
G2L["e"]["BorderSizePixel"] = 0;
G2L["e"]["TextSize"] = 14;
G2L["e"]["TextScaled"] = true;
G2L["e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic);
G2L["e"]["TextColor3"] = Color3.fromRGB(251, 251, 251);
G2L["e"]["BackgroundTransparency"] = 1;
G2L["e"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e"]["Text"] = [[Kant-Hub]];
G2L["e"]["Name"] = [[Title]];
G2L["e"]["Position"] = UDim2.new(-0, 0, 0, 0);


-- StarterGui.Loader.UI.CanvasGroup.UI.Title.UIStroke
G2L["f"] = Instance.new("UIStroke", G2L["e"]);
G2L["f"]["Thickness"] = 1.5;
G2L["f"]["Color"] = Color3.fromRGB(40, 40, 43);


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

G2L_MODULES[G2L["3"]] = {
Closure = function()
    local script = G2L["3"];---------------------------------------------------------------------
-- SERVICES
---------------------------------------------------------------------
local TweenService = game:GetService("TweenService")

local LoadingAnimation = {}
---------------------------------------------------------------------
-- CONFIGURATION
---------------------------------------------------------------------
local CONFIG = {
	EasingStyle     = Enum.EasingStyle.Quad,
	EasingDirection = Enum.EasingDirection.Out,

	FadeDuration    = 1,
	DisplayDuration = 2,

	BackgroundTransparency = 0.65
}

---------------------------------------------------------------------
-- STATE
---------------------------------------------------------------------
local State = {
	Loaded  = false,
	Playing = false
}

---------------------------------------------------------------------
-- REFERENCES
---------------------------------------------------------------------
local ScreenGui
local Background
local CanvasGroup

---------------------------------------------------------------------
-- TWEEN
---------------------------------------------------------------------
local function createTween(instance, properties, duration)
	local tweenInfo=TweenInfo.new(duration,CONFIG.EasingStyle,CONFIG.EasingDirection)
	return TweenService:Create(instance, tweenInfo, properties)
end

---------------------------------------------------------------------
-- ANIMATION
---------------------------------------------------------------------
local function fadeIn()
	local canvasTween=createTween(CanvasGroup,{GroupTransparency=0},CONFIG.FadeDuration)
	local backgroundTween=createTween(
		Background,{BackgroundTransparency=CONFIG.BackgroundTransparency},CONFIG.FadeDuration)
	canvasTween:Play()
	backgroundTween:Play()
	canvasTween.Completed:Wait()
end

local function fadeOut()
	local canvasTween=createTween(CanvasGroup,{GroupTransparency=1},CONFIG.FadeDuration)
	local backgroundTween=createTween(Background,{BackgroundTransparency=1},CONFIG.FadeDuration)
	canvasTween:Play()
	backgroundTween:Play()
	canvasTween.Completed:Wait()
end

---------------------------------------------------------------------
-- PUBLIC METHODS
---------------------------------------------------------------------
function LoadingAnimation:Init(screenGui)
	ScreenGui=screenGui Background=ScreenGui:WaitForChild("UI").Background
	CanvasGroup=ScreenGui:WaitForChild("UI").CanvasGroup return self end
function LoadingAnimation:Play()
	if State.Playing or State.Loaded then return false end
	assert(CanvasGroup and Background,"LoadingAnimation is not initialized!")State.Playing=true
	CanvasGroup.GroupTransparency=1 Background.BackgroundTransparency=1
	CanvasGroup.Visible=true Background.Visible=true fadeIn()
	task.wait(CONFIG.DisplayDuration)fadeOut()
	State.Loaded=true State.Playing=false return true end
function LoadingAnimation:IsLoaded()return State.Loaded end
function LoadingAnimation:IsPlaying()return State.Playing end
function LoadingAnimation:Reset()if State.Playing then return false end 
	State.Loaded=false return true end

return LoadingAnimation
end;
};
G2L_MODULES[G2L["4"]] = {
Closure = function()
    local script = G2L["4"];--!strict
local url = "https://raw.githubusercontent.com/Crack-rbx/KantHub/main/Modules/ListScripts.lua"

local module = {}

local lister: any = nil
local function loadLister(): (any, string?)
	if lister then
		return lister, nil
	end

	local ok: boolean, source: any = pcall(function()
		return game:HttpGet(url)
	end)
	if not ok then
		return nil, "Failed to download the lister: " .. tostring(source)
	end

	if type(source) ~= "string" or source == "" then
		return nil, "The lister content is invalid."
	end

	local chunk: any, compileError: any = loadstring(source)
	if not chunk then
		return nil, "Failed to compile the lister: " .. tostring(compileError)
	end

	local runOk: boolean, result: any = pcall(chunk)
	if not runOk then
		return nil, "Failed to run the lister: " .. tostring(result)
	end

	if type(result) ~= "table" or type(result.getscript) ~= "function" then
		return nil, "The lister does not expose a valid getscript function."
	end

	lister = result
	return lister, nil
end

function module.getscript(placeId: number?): (string?, string?)
	local list: any, loadError: string? = loadLister()
	if not list then
		return nil, loadError
	end

	local callOk: boolean, code: any, err: any = pcall(list.getscript, placeId)
	if not callOk then
		return nil, "The lister errored: " .. tostring(code)
	end

	if type(code) ~= "string" or code == "" then
		return nil, if type(err) == "string" then err else "The lister returned no code."
	end

	return code, nil
end

return module
end;
};
-- StarterGui.Loader.Scripts.Loader
local function C_6()
local script = G2L["6"];
	--!strict
	---------------------------------------------------------------------
	-- STATE
	---------------------------------------------------------------------
	local MODULE_WAIT_TIMEOUT = 10
	
	local State = {
		Initializing = false,
		Initialized = false,
		Destroyed = false,
		Connections = {} :: { RBXScriptConnection },
		ScriptCode = nil :: string?,
	}
	
	---------------------------------------------------------------------
	-- LIFECYCLE
	---------------------------------------------------------------------
	local function IsAlive(): boolean
		return not State.Destroyed
	end
	
	local function Connect(signal: RBXScriptSignal, callback: () -> (), label: string): RBXScriptConnection?
		if not IsAlive() then
			return nil
		end
	
		local success, connection = pcall(function()
			return signal:Connect(callback)
		end)
	
		if not success then
			warn(("[KantHub] %s failed: %s"):format(label, tostring(connection)))
			return nil
		end
	
		table.insert(State.Connections, connection)
	
		return connection
	end
	
	local function DisconnectAll()
		for index = #State.Connections, 1, -1 do
			local connection = State.Connections[index]
	
			pcall(function()
				if connection.Connected then
					connection:Disconnect()
				end
			end)
	
			State.Connections[index] = nil
		end
	end
	
	local function Destroy()
		if State.Destroyed then
			return
		end
	
		State.Destroyed = true
		State.Initializing = false
		State.Initialized = false
		State.ScriptCode = nil
	
		DisconnectAll()
	
		print("[KantHub] Loading animation controller shut down.")
	end
	
	---------------------------------------------------------------------
	-- VALIDATION / LOADING
	---------------------------------------------------------------------
	type LoadingAnimationModule = {
		Init: (self: LoadingAnimationModule, screenGui: ScreenGui) -> any,
		Play: (self: LoadingAnimationModule) -> boolean,
	}
	
	type ListScriptsModule = {
	    getscript: (placeId: number?) -> (string?, string?),
    }
	
	type ListScriptsResult = {
		Code: string?,
		Error: string?,
	}
	
	local function GetScreenGui(): ScreenGui
		local parent = script.Parent
		local screenGui = if parent then parent.Parent else nil
	
		if not screenGui then
			error("ScreenGui is unavailable.", 0)
		end
	
		if not screenGui:IsA("ScreenGui") then
			error("ScreenGui must be a ScreenGui.", 0)
		end
	
		return screenGui
	end
	
	local function GetModulesFolder(screenGui: ScreenGui): Folder
		local modulesFolder = screenGui:WaitForChild("Modules", MODULE_WAIT_TIMEOUT)
	
		if not modulesFolder then
			error("Modules folder is unavailable.", 0)
		end
	
		if not modulesFolder:IsA("Folder") then
			error("Modules must be a Folder.", 0)
		end
	
		return modulesFolder
	end
	
	local function LoadLoadingAnimation(modulesFolder: Folder): LoadingAnimationModule
		local moduleScript = modulesFolder:FindFirstChild("LoadingAnimation")
	
		if not moduleScript then
			error("Module 'LoadingAnimation' was not found.", 0)
		end
	
		if not moduleScript:IsA("ModuleScript") then
			error("'LoadingAnimation' must be a ModuleScript.", 0)
		end
	
		local success, result = pcall(function()
			return require(moduleScript) :: any
		end)
	
		if not success then
			error(("Failed to load module 'LoadingAnimation': %s"):format(tostring(result)), 0)
		end
	
		if type(result) ~= "table" then
			error("Module 'LoadingAnimation' must return a table.", 0)
		end
	
		if type(result.Init) ~= "function" then
			error("Module 'LoadingAnimation' is missing required function 'Init'.", 0)
		end
	
		if type(result.Play) ~= "function" then
			error("Module 'LoadingAnimation' is missing required function 'Play'.", 0)
		end
	
		return result :: LoadingAnimationModule
	end
	
	local function execute(code: string, chunkName: string?): (boolean, string?)
		if type(code) ~= "string" or code == "" then
			return false, "Nenhum código para executar."
		end
	
		local chunk: any, compileError: any = loadstring(code, chunkName or "=KantHubScript")
		if not chunk then
			return false, "Falha ao compilar o script: " .. tostring(compileError)
		end
	
		-- runs in a separate thread: it doesn’t block the Loader, and a script error doesn’t crash the controller
		task.spawn(function()
			local ok, err = xpcall(chunk, debug.traceback)
			if not ok then
				warn("[KantHub] O script falhou ao executar:\n" .. tostring(err))
			end
		end)
	
		return true, nil
	end
	
	local function LoadListScripts(modulesFolder: Folder): ListScriptsModule
		local moduleScript = modulesFolder:FindFirstChild("ListScripts")
	
		if not moduleScript then
			error("[KantHub] Module 'ListScripts' was not found.", 0)
		end
	
		if not moduleScript:IsA("ModuleScript") then
			error("[KantHub] 'ListScripts' must be a ModuleScript.", 0)
		end
	
		local success, result = pcall(function()
			return require(moduleScript) :: any
		end)
	
		if not success then
			error(("[KantHub] Failed to load module 'ListScripts': %s"):format(tostring(result)), 0)
		end
	
		if type(result) ~= "table" then
			error("[KantHub] Module 'ListScripts' must return a table.", 0)
		end
	
		if type(result.getscript) ~= "function" then
			error("[KantHub] Module 'ListScripts' is missing required function 'getscript'.", 0)
		end
	
		return result :: ListScriptsModule
	end
	
	local function FetchScriptCode(listScripts: ListScriptsModule, placeId: number): string
		local success, result = pcall(function(): ListScriptsResult
			local code, err = listScripts.getscript(placeId)
	
			return { Code = code, Error = err }
		end)
	
		if not success then
			error("[KantHub] 'ListScripts.getscript' errored: " .. tostring(result), 0)
		end
	
		local code = result.Code
		local err = result.Error
	
		if code == nil or code == "" then
			local reason = if err ~= nil and err ~= "" then err else "no code was returned"
			error("[KantHub] No script available for PlaceId " .. tostring(placeId) .. ": " .. reason, 0)
		end
	
		return code
	end
	
	---------------------------------------------------------------------
	-- INITIALIZATION
	---------------------------------------------------------------------
	local function Run()
		local screenGui = GetScreenGui()
		local modulesFolder = GetModulesFolder(screenGui)
		local loadingAnimation = LoadLoadingAnimation(modulesFolder)
		local listScripts = LoadListScripts(modulesFolder)
		Connect(screenGui.Destroying, Destroy, "ScreenGui destroying")
	
		-- getscript may yield, so the controller can be destroyed meanwhile.
		local scriptCode = FetchScriptCode(listScripts, game.PlaceId)
	
		if not IsAlive() then
			return
		end
	
		-- Only stored and validated here; executing it is intentionally out of scope.
		State.ScriptCode = scriptCode
	
		loadingAnimation:Init(screenGui)
		loadingAnimation:Play()          -- yielda ~4s
	
		if not IsAlive() then
			return
		end
	
		local code = State.ScriptCode
		State.ScriptCode = nil
	
		if code then
	        local ok, err = execute(code, "=KantHub/" .. tostring(game.PlaceId))
	        if not ok then
		        error("[KantHub] " .. tostring(err), 0)
	        end
	    end
    end
	
	local function Initialize(): (boolean, string?)
		if State.Destroyed then
			return false, "The controller has already been destroyed."
		end
	
		if State.Initialized then
			return true, nil
		end
	
		if State.Initializing then
			return false, "Initialization is already in progress."
		end
	
		State.Initializing = true
	
		local success, err = pcall(function(): any
			Run()
	
			return nil
		end)
	
		if not success then
			Destroy()
			return false, tostring(err)
		end
	
		State.Initializing = false
	
		if State.Destroyed then
			return false, "The controller was destroyed during initialization."
		end
	
		State.Initialized = true
	
		return true, nil
	end
	
	---------------------------------------------------------------------
	-- EXECUTION
	---------------------------------------------------------------------
	local initialized, initializationError = Initialize()
	
	if not initialized then
		warn("[KantHub] Initialization failed: " .. tostring(initializationError))
		return
	end
	
	Connect(script.Destroying, Destroy, "Loader destruction")
end;
task.spawn(C_6);

return G2L["1"], require;
