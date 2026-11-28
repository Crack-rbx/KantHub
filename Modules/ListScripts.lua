--[[
 ██╗  ██╗ █████╗ ███╗   ██╗████████╗ ██╗  ██╗██╗   ██╗██████╗
 ██║ ██╔╝██╔══██╗████╗  ██║╚══██╔══╝ ██║  ██║██║   ██║██╔══██╗
 █████╔╝ ███████║██╔██╗ ██║   ██║    ███████║██║   ██║██████╔╝
 ██╔═██╗ ██╔══██║██║╚██╗██║   ██║    ██╔══██║██║   ██║██╔══██╗
 ██║  ██╗██║  ██║██║ ╚████║   ██║    ██║  ██║╚██████╔╝██████╔╝
 ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝
                    @TavssDev @Crack-RBX
--]]
--!strict
-- Numeric key = PlaceId; Universal = fallback
type ScriptMap = { [number]: string, Universal: string }

export type ListScripts = {
	getscript: (placeId: number?) -> (string?, string?),
}

local Scripts: ScriptMap = {
	Universal = "https://raw.githubusercontent.com/Crack-rbx/KantHub/main/Scripts/Universal.lua",
	-- [7633926880] = "https://raw.githubusercontent.com/Crack-rbx/KantHub/main/Games/Exemplo.lua",
}

-- HttpGet is an executor-provided method and is not in Roblox's DataModel type,
-- so the cast is isolated here instead of being spread across the module.
local function httpGet(url: string): string
	return (game :: any):HttpGet(url)
end

-- Accepts finite, non-negative integers. 0 is allowed on purpose:
-- game.PlaceId is 0 in unpublished places, and those should fall back to Universal.
local function isValidPlaceId(value: any): boolean
	return type(value) == "number" and value == value and value >= 0 and value % 1 == 0
end

-- Returns the code (string) or nil + an error message.
local function getscript(placeId: number?): (string?, string?)
	local id: any = if placeId == nil then game.PlaceId else placeId

	if not isValidPlaceId(id) then
		return nil, "The value received is not a valid PlaceId."
	end

	local specific: string? = Scripts[id :: number]
	local target: string = if specific ~= nil and specific ~= "" then specific else Scripts.Universal

	if target == "" then
		return nil, "No valid URL was found for this game."
	end

	local ok, response = pcall(httpGet, target)

	if not ok then
		return nil, "Failed to retrieve the script: " .. tostring(response)
	end

	if response == "" then
		return nil, "The received content is empty."
	end

	return response, nil
end

local ListScripts: ListScripts = {
	getscript = getscript,
}

return ListScripts
