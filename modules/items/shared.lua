local function useExport(resource, export)
	return function(...)
		return exports[resource][export](nil, ...)
	end
end

local ItemList = {}
local isServer = IsDuplicityVersion()

---@param data OxItem
local function newItem(data)
	data.weight = data.weight or 0

	if data.close == nil then
		data.close = true
	end

	if data.stack == nil then
		data.stack = true
	end

	local clientData, serverData = data.client, data.server
	---@cast clientData -nil
	---@cast serverData -nil

	if not data.consume and (clientData and (clientData.status or clientData.usetime or clientData.export) or serverData?.export) then
		data.consume = 1
	end

	if isServer then
		data.client = nil

		if serverData?.export then
			data.cb = useExport(string.strsplit('.', serverData.export))
		end

		if not data.durability then
			if data.degrade or (data.consume and data.consume ~= 0 and data.consume < 1) then
				data.durability = true
			end
		end
	else
		data.server = nil
		data.count = 0

		if clientData?.export then
			data.export = useExport(string.strsplit('.', clientData.export))
		end

		if clientData?.image then
			clientData.image = clientData.image:match('^[%w]+://') and clientData.image or ('%s/%s'):format(client.imagepath, clientData.image)
		end
	end

	ItemList[data.name] = data
end

for k, v in pairs(lib.load('data.items')) do
	v.name = k
	local success, response = pcall(newItem, v)

    if not success then
        warn(('An error occurred while creating item "%s" callback!\n^1SCRIPT ERROR: %s^0'):format(k, response))
    end
end

ItemList.cash = ItemList.money

return ItemList
