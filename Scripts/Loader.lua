--[=[
 ██╗  ██╗ █████╗ ███╗   ██╗████████╗ ██╗  ██╗██╗   ██╗██████╗
 ██║ ██╔╝██╔══██╗████╗  ██║╚══██╔══╝ ██║  ██║██║   ██║██╔══██╗
 █████╔╝ ███████║██╔██╗ ██║   ██║    ███████║██║   ██║██████╔╝
 ██╔═██╗ ██╔══██║██║╚██╗██║   ██║    ██╔══██║██║   ██║██╔══██╗
 ██║  ██╗██║  ██║██║ ╚████║   ██║    ██║  ██║╚██████╔╝██████╔╝
 ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝
                    @TavssDev @Crack-RBX
--]=]
repeat task.wait() until game:IsLoaded()
local AUTO_RUN = true
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
	task.wait()
	LocalPlayer = Players.LocalPlayer
end
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local G2L = {};

G2L["1"] = Instance.new("ScreenGui");
G2L["1"]["IgnoreGuiInset"] = true;
G2L["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
G2L["1"]["Name"] = [[Loader]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
G2L["1"]["ResetOnSpawn"] = false;
G2L["1"]["DisplayOrder"] = 999;
G2L["1"]:SetAttribute("KantHubLoader", true);


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


-- StarterGui.Loader.Scripts.Loader (placeholder desabilitado, sem codigo)
G2L["6"] = Instance.new("LocalScript", G2L["5"]);
G2L["6"]["Enabled"] = false;
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
-- Estados: loading / done / failed. Falhas e ciclos geram erro explicito,
-- nunca um nil silencioso.
local G2L_REQUIRE = require;
local G2L_MODULES = {};

local function require(Module: ModuleScript): any
	local s = G2L_MODULES[Module]
	if not s then
		return G2L_REQUIRE(Module)
	end

	if s.Status == "done" then
		return s.Value
	end
	if s.Status == "loading" then
		error("cyclic require: " .. Module.Name, 2)
	end
	if s.Status == "failed" then
		error(s.Error, 2)
	end

	s.Status = "loading"
	local ok, result = xpcall(s.Closure, debug.traceback)
	if not ok then
		s.Status, s.Error = "failed", result
		error(result, 2)
	end

	s.Status, s.Value = "done", result
	return result
end


---------------------------------------------------------------------
-- MODULE: LoadingAnimation
---------------------------------------------------------------------
G2L_MODULES[G2L["3"]] = {
	Closure = function()
		local TweenService = game:GetService("TweenService")

		local LoadingAnimation = {}

		-----------------------------------------------------------------
		-- CONFIGURATION
		-----------------------------------------------------------------
		local CONFIG = {
			EasingStyle     = Enum.EasingStyle.Quad,
			EasingDirection = Enum.EasingDirection.Out,

			FadeDuration    = 1,
			DisplayDuration = 2,

			BackgroundTransparency = 0.65,

			InitTimeout = 10,
			FadeGrace   = 2, -- folga alem de FadeDuration antes de forcar o valor final
		}

		-----------------------------------------------------------------
		-- STATE
		-----------------------------------------------------------------
		local State = {
			Loaded    = false, -- animacao concluida com sucesso
			Playing   = false,
			Cancelled = false,
		}

		-----------------------------------------------------------------
		-- REFERENCES
		-----------------------------------------------------------------
		local ScreenGui
		local Background
		local CanvasGroup
		local ActiveTweens

		-----------------------------------------------------------------
		-- HELPERS
		-----------------------------------------------------------------
		local function isAlive(): boolean
			return not State.Cancelled
				and ScreenGui ~= nil
				and Background ~= nil
				and CanvasGroup ~= nil
				and ScreenGui:IsDescendantOf(game)
		end

		local function cancelTweens()
			local tweens = ActiveTweens
			ActiveTweens = nil
			if tweens then
				for _, tween in ipairs(tweens) do
					pcall(function()
						tween:Cancel()
					end)
				end
			end
		end

		local function createTween(instance, properties, duration)
			local tweenInfo = TweenInfo.new(duration, CONFIG.EasingStyle, CONFIG.EasingDirection)
			return TweenService:Create(instance, tweenInfo, properties)
		end

		-- Espera `seconds`, abortando cedo se a animacao for cancelada ou a GUI sumir.
		local function waitAlive(seconds: number): boolean
			local deadline = os.clock() + seconds
			while os.clock() < deadline do
				if not isAlive() then
					return false
				end
				task.wait()
			end
			return isAlive()
		end

		-- Retorna false se foi cancelado / a GUI foi destruida durante o fade.
		local function fade(canvasTarget: number, backgroundTarget: number): boolean
			if not isAlive() then
				return false
			end

			local canvas, background = CanvasGroup, Background
			local canvasTween = createTween(canvas, { GroupTransparency = canvasTarget }, CONFIG.FadeDuration)
			local backgroundTween = createTween(background, { BackgroundTransparency = backgroundTarget }, CONFIG.FadeDuration)

			ActiveTweens = { canvasTween, backgroundTween }

			local finished = false
			local connection = canvasTween.Completed:Connect(function()
				finished = true
			end)

			canvasTween:Play()
			backgroundTween:Play()

			local deadline = os.clock() + CONFIG.FadeDuration + CONFIG.FadeGrace
			while not finished and os.clock() < deadline and isAlive() do
				task.wait()
			end

			connection:Disconnect()
			cancelTweens()

			if not isAlive() then
				return false
			end

			if not finished then
				-- tween atrasado: forca o valor final em vez de abortar o fluxo
				canvas.GroupTransparency = canvasTarget
				background.BackgroundTransparency = backgroundTarget
			end

			return true
		end

		-----------------------------------------------------------------
		-- PUBLIC METHODS
		-----------------------------------------------------------------
		function LoadingAnimation:Init(screenGui)
			if State.Playing then
				warn("[KantHub] LoadingAnimation:Init ignored while playing.")
				return self
			end

			assert(typeof(screenGui) == "Instance" and screenGui:IsA("ScreenGui"), "LoadingAnimation:Init expects a ScreenGui")

			local uiFolder = screenGui:WaitForChild("UI", CONFIG.InitTimeout)
			assert(uiFolder, "LoadingAnimation: 'UI' folder was not found")

			local background = uiFolder:FindFirstChild("Background")
			local canvasGroup = uiFolder:FindFirstChild("CanvasGroup")
			assert(background and background:IsA("Frame"), "LoadingAnimation: 'Background' Frame was not found")
			assert(canvasGroup and canvasGroup:IsA("CanvasGroup"), "LoadingAnimation: 'CanvasGroup' was not found")

			ScreenGui = screenGui
			Background = background
			CanvasGroup = canvasGroup
			State.Cancelled = false

			return self
		end

		function LoadingAnimation:Play()
			if State.Playing or State.Loaded or State.Cancelled then
				return false
			end
			assert(CanvasGroup and Background, "LoadingAnimation is not initialized!")

			local canvas, background = CanvasGroup, Background
			State.Playing = true

			local ok, result = pcall(function()
				canvas.GroupTransparency = 1
				background.BackgroundTransparency = 1
				canvas.Visible = true
				background.Visible = true

				if not fade(0, CONFIG.BackgroundTransparency) then
					return false
				end
				if not waitAlive(CONFIG.DisplayDuration) then
					return false
				end
				if not fade(1, 1) then
					return false
				end
				return true
			end)

			-- sempre libera o estado e esconde os objetos, mesmo em falha/cancelamento
			State.Playing = false
			cancelTweens()
			canvas.Visible = false
			background.Visible = false

			if not ok then
				warn("[KantHub] LoadingAnimation failed: " .. tostring(result))
				return false
			end
			if result ~= true then
				return false
			end

			State.Loaded = true
			return true
		end

		-- Interrompe a animacao em andamento (usar no Destroy do controlador).
		function LoadingAnimation:Cancel()
			State.Cancelled = true
			cancelTweens()
			return true
		end

		-- Cancela e solta as referencias as instancias.
		function LoadingAnimation:Destroy()
			self:Cancel()
			ScreenGui = nil
			Background = nil
			CanvasGroup = nil
			State.Loaded = false
			return true
		end

		function LoadingAnimation:IsLoaded()
			return State.Loaded
		end

		function LoadingAnimation:IsPlaying()
			return State.Playing
		end

		function LoadingAnimation:Reset()
			if State.Playing then
				return false
			end
			State.Loaded = false
			return true
		end

		return LoadingAnimation
	end;
};


---------------------------------------------------------------------
-- MODULE: ListScripts
---------------------------------------------------------------------
G2L_MODULES[G2L["4"]] = {
	Closure = function()
		-- Para travar a versao do lister, troque "main" por um SHA de commit.
		-- (Confirme tambem que o arquivo remoto e o lister de fato, e nao uma copia deste modulo.)
		local REF = "main"
		local URL = "https://raw.githubusercontent.com/Crack-rbx/KantHub/" .. REF .. "/Modules/ListScripts.lua"
		local CHUNK_NAME = "=KantHub/Lister"
		local MAX_SOURCE_BYTES = 262144 -- 256 KB

		local module = {}

		local lister: any = nil
		local inflight = false

		-- Baixa, compila, executa e valida o lister. Nunca lanca erro: retorna (lister | nil, erro?).
		local function fetchLister(): (any, string?)
			local ok: boolean, source: any = pcall(function()
				return game:HttpGet(URL)
			end)
			if not ok then
				return nil, "Failed to download the lister: " .. tostring(source)
			end

			if type(source) ~= "string" or source == "" then
				return nil, "The lister content is invalid."
			end
			if #source > MAX_SOURCE_BYTES then
				return nil, "The lister content is unexpectedly large."
			end

			local loadOk: boolean, chunk: any, compileError: any = pcall(loadstring, source, CHUNK_NAME)
			if not loadOk then
				return nil, "loadstring is unavailable: " .. tostring(chunk)
			end
			if type(chunk) ~= "function" then
				return nil, "Failed to compile the lister: " .. tostring(compileError)
			end

			local runOk: boolean, result: any = pcall(chunk)
			if not runOk then
				return nil, "Failed to run the lister: " .. tostring(result)
			end

			if type(result) ~= "table" or type(result.getscript) ~= "function" then
				return nil, "The lister does not expose a valid getscript function."
			end

			return result, nil
		end

		local function loadLister(): (any, string?)
			if lister then
				return lister, nil
			end

			-- evita downloads simultaneos: quem chega durante um download espera por ele
			while inflight do
				task.wait()
				if lister then
					return lister, nil
				end
			end

			inflight = true
			local ok, result, err = pcall(fetchLister)
			inflight = false

			if not ok then
				return nil, "Unexpected failure while loading the lister: " .. tostring(result)
			end
			if not result then
				return nil, err
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

		-- Compila o codigo obtido em getscript e devolve a funcao pronta para executar.
		-- Nao executa nada; nunca lanca erro: retorna (funcao | nil, erro?).
		-- (Ponto certo para uma futura verificacao de assinatura/integridade do codigo.)
		function module.compile(code: string, chunkName: string?): (any, string?)
			if type(code) ~= "string" or code == "" then
				return nil, "There is no code to compile."
			end

			local ok: boolean, chunk: any, compileError: any = pcall(loadstring, code, chunkName or "=KantHub/Script")
			if not ok then
				return nil, "loadstring is unavailable: " .. tostring(chunk)
			end
			if type(chunk) ~= "function" then
				return nil, "Failed to compile the script: " .. tostring(compileError)
			end

			return chunk, nil
		end

		return module
	end;
};


---------------------------------------------------------------------
-- CONTROLLER
---------------------------------------------------------------------
local Controller = (function()
	local MODULE_WAIT_TIMEOUT = 10
	local FETCH_TIMEOUT = 30

	local State = {
		Initializing = false,
		Initialized  = false,
		Running      = false,
		Destroyed    = false,
		Connections  = {},
		ScriptCode   = nil,
	}

	local LoadingAnimation
	local ListScripts

	-----------------------------------------------------------------
	-- LIFECYCLE
	-----------------------------------------------------------------
	local function IsAlive(): boolean
		return not State.Destroyed
	end

	local function Connect(signal, callback, label)
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
				connection:Disconnect()
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
		State.Running = false
		State.ScriptCode = nil

		DisconnectAll()

		if LoadingAnimation then
			pcall(function()
				LoadingAnimation:Destroy()
			end)
			LoadingAnimation = nil
		end
		ListScripts = nil

		-- a conexao Destroying ja foi desfeita acima, entao nao ha reentrada
		pcall(function()
			G2L["1"]:Destroy()
		end)

		print("[KantHub] Loader controller shut down.")
	end

	-----------------------------------------------------------------
	-- VALIDATION / LOADING
	-----------------------------------------------------------------
	local function GetScreenGui()
		local screenGui = G2L["1"]
		if not screenGui or not screenGui:IsA("ScreenGui") then
			error("ScreenGui is unavailable.", 0)
		end
		return screenGui
	end

	local function GetModulesFolder(screenGui)
		local modulesFolder = screenGui:WaitForChild("Modules", MODULE_WAIT_TIMEOUT)
		if not modulesFolder then
			error("Modules folder is unavailable.", 0)
		end
		if not modulesFolder:IsA("Folder") then
			error("Modules must be a Folder.", 0)
		end
		return modulesFolder
	end

	local function LoadModule(modulesFolder, name: string, requiredFunctions: { string })
		local moduleScript = modulesFolder:FindFirstChild(name)
		if not moduleScript then
			error(("Module '%s' was not found."):format(name), 0)
		end
		if not moduleScript:IsA("ModuleScript") then
			error(("'%s' must be a ModuleScript."):format(name), 0)
		end

		local success, result = pcall(require, moduleScript)
		if not success then
			error(("Failed to load module '%s': %s"):format(name, tostring(result)), 0)
		end
		if type(result) ~= "table" then
			error(("Module '%s' must return a table."):format(name), 0)
		end

		for _, functionName in ipairs(requiredFunctions) do
			if type(result[functionName]) ~= "function" then
				error(("Module '%s' is missing required function '%s'."):format(name, functionName), 0)
			end
		end

		return result
	end

	local function Initialize(): boolean
		if State.Destroyed then
			return false
		end
		if State.Initialized then
			return true
		end
		if State.Initializing then
			return false
		end

		State.Initializing = true

		local animation, lister
		local ok, err = pcall(function()
			local screenGui = GetScreenGui()
			local modulesFolder = GetModulesFolder(screenGui)

			animation = LoadModule(modulesFolder, "LoadingAnimation", { "Init", "Play" })
			lister = LoadModule(modulesFolder, "ListScripts", { "getscript", "compile" })

			if not IsAlive() then
				return
			end
			animation:Init(screenGui)
		end)

		-- pode ter sido destruido durante os yields acima
		if not IsAlive() then
			if animation then
				pcall(function()
					animation:Destroy()
				end)
			end
			return false
		end

		State.Initializing = false

		if not ok then
			warn("[KantHub] Initialization failed: " .. tostring(err))
			Destroy()
			return false
		end

		LoadingAnimation = animation
		ListScripts = lister
		State.Initialized = true

		Connect(G2L["1"].Destroying, function()
			Destroy()
		end, "ScreenGui.Destroying")

		return true
	end

	-----------------------------------------------------------------
	-- RUN
	-----------------------------------------------------------------
	local function Run(): boolean
		if not Initialize() then
			return false
		end
		if State.Running then
			return false
		end
		State.Running = true

		local animation, lister = LoadingAnimation, ListScripts

		-- 1) baixa o script em paralelo com a animacao
		local fetched = { Done = false, Code = nil, Error = nil }
		task.spawn(function()
			local ok, code, err = pcall(lister.getscript, game.PlaceId)
			if not ok then
				fetched.Error = tostring(code)
			else
				fetched.Code, fetched.Error = code, err
			end
			fetched.Done = true
		end)

		-- 2) anima a tela de carregamento (falha na animacao nao impede o carregamento)
		local animOk, animErr = pcall(function()
			animation:Play()
		end)
		if not animOk then
			warn("[KantHub] Loading animation failed: " .. tostring(animErr))
		end
		if not IsAlive() then
			return false
		end

		-- 3) aguarda o download terminar (com limite de tempo)
		local deadline = os.clock() + FETCH_TIMEOUT
		while not fetched.Done and IsAlive() and os.clock() < deadline do
			task.wait()
		end
		if not IsAlive() then
			return false
		end
		if not fetched.Done then
			warn("[KantHub] Timed out while downloading the script.")
			Destroy()
			return false
		end
		if type(fetched.Code) ~= "string" then
			warn("[KantHub] No script available: " .. tostring(fetched.Error or "unknown error"))
			Destroy()
			return false
		end

		-- 4) compila
		State.ScriptCode = fetched.Code
		local chunk, compileError = lister.compile(fetched.Code)
		State.ScriptCode = nil
		if not chunk then
			warn("[KantHub] " .. tostring(compileError))
			Destroy()
			return false
		end

		-- 5) executa em uma thread propria e protegida: scripts que yieldam ou falham
		--    nao afetam o controlador
		task.spawn(function()
			local ok, runError = xpcall(chunk, debug.traceback)
			if not ok then
				warn("[KantHub] Script error: " .. tostring(runError))
			end
		end)

		-- 6) fim do loader: limpa a GUI e as conexoes
		Destroy()
		return true
	end

	return {
		Initialize = Initialize,
		Run        = Run,
		Destroy    = Destroy,
		IsAlive    = IsAlive,
	}
end)()


---------------------------------------------------------------------
-- FINALIZE
---------------------------------------------------------------------
-- Remove somente Loaders antigos deste projeto (marcados por atributo),
-- sem tocar em GUIs do jogo que tenham o mesmo nome.
for _, child in ipairs(PlayerGui:GetChildren()) do
	if child:IsA("ScreenGui") and child:GetAttribute("KantHubLoader") == true then
		child:Destroy()
	end
end

G2L["1"].Parent = PlayerGui

if AUTO_RUN then
	task.spawn(Controller.Run)
end

return G2L["1"], require, Controller;
