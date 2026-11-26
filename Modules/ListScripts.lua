--!strict

local url = "https://raw.githubusercontent.com/Crack-rbx/KantHub/main/Modules/ListScripts.lua"

-- Numeric key = PlaceId; Universal = fallback
local Scripts: { [any]: any } = {
	Universal = "",
	-- [7633926880] = "https://raw.githubusercontent.com/Crack-rbx/KantHub/main/Games/Exemplo.lua",
}

local module = {}
module.source = url

-- Returns the code (string) or nil + an error message.
function module.getscript(placeId: number?): (string?, string?)
	local id: any = if placeId == nil then game.PlaceId else placeId

	if type(id) ~= "number" then
		return nil, "The value received is not a valid number."
	end

	local target: any = Scripts[id] or Scripts.Universal
	if type(target) ~= "string" or target == "" then
		return nil, "No valid URL was found for this game."
	end

	local ok: boolean, response: any = pcall(function()
		return game:HttpGet(target)
	end)

	if not ok then
		return nil, "Failed to retrieve the script: " .. tostring(response)
	end

	if type(response) ~= "string" or response == "" then
		return nil, "The received content is invalid."
	end

	return response, nil
end

return module
