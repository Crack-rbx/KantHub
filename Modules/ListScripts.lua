--!strict
local PREFIX = "[KHZ_LISTER]"

local Lister = {}
local Registry: { [number]: string } = {
	-- [1234567890] = "https://exemplo.com/script.lua",
}

local UNIVERSAL_URL: string = ""

-- Utilities --

local function log(message: string)
	warn(string.format("%s %s", PREFIX, message))
end

local function isNonEmptyString(value: any): boolean
	return typeof(value) == "string" and value ~= ""
end

-- URL resolution --

local function resolveURL(placeId: number): string?
	local url = Registry[placeId] or UNIVERSAL_URL

	if not isNonEmptyString(url) then
		return nil
	end

	return url
end

-- Download --
local function fetch(url: string): string?
	local ok, response = pcall(game.HttpGet, game, url)

	if not ok then
		log("Failed to retrieve the script: " .. tostring(response))
		return nil
	end

	if not isNonEmptyString(response) then
		log("The received content is invalid.")
		return nil
	end

	return response
end

-- API Public --
function Lister.GetScript(placeId: number?): string?
	local id = if placeId == nil then game.PlaceId else placeId

	if typeof(id) ~= "number" then
		log("The value received is not a valid number.")
		return nil
	end

	local url = resolveURL(id)
	if not url then
		log("No valid URL was found for this game.")
		return nil
	end

	return fetch(url)
end

function Lister.Register(placeId: number, url: string)
	assert(typeof(placeId) == "number", "placeId must be a number")
	assert(isNonEmptyString(url), "url must be a non-empty string")
	Registry[placeId] = url
end

function Lister.SetUniversal(url: string)
	assert(isNonEmptyString(url), "url must be a non-empty string")
	UNIVERSAL_URL = url
end

return Lister
