local containers = {}

---@class ItemContainerProperties
---@field slots number
---@field maxWeight number
---@field whitelist? table<string, true> | string[]
---@field blacklist? table<string, true> | string[]

local function arrayToSet(tbl)
	local size = #tbl
	local set = table.create(0, size)

	for i = 1, size do
		set[tbl[i]] = true
	end

	return set
end

---Registers items with itemName as containers (i.e. backpacks, wallets).
---@param itemName string
---@param properties ItemContainerProperties
---@todo Rework containers for flexibility, improved data structure; then export this method.
local function setContainerProperties(itemName, properties)
	local blacklist, whitelist = properties.blacklist, properties.whitelist

	if blacklist then
		local tableType = table.type(blacklist)

		if tableType == 'array' then
			blacklist = arrayToSet(blacklist)
		elseif tableType ~= 'hash' then
			TypeError('blacklist', 'table', type(blacklist))
		end
	end

	if whitelist then
		local tableType = table.type(whitelist)

		if tableType == 'array' then
			whitelist = arrayToSet(whitelist)
		elseif tableType ~= 'hash' then
			TypeError('whitelist', 'table', type(whitelist))
		end
	end

	containers[itemName] = {
		size = { properties.slots, properties.maxWeight },
		blacklist = blacklist,
		whitelist = whitelist,
	}
end

setContainerProperties('paperbag', {
	slots = 5,
	maxWeight = 1000,
	blacklist = { 'testburger' }
})

setContainerProperties('pizzabox', {
	slots = 5,
	maxWeight = 1000,
	whitelist = { 'pizza' }
})

setContainerProperties('wallet', {
	slots = 5,
	maxWeight = 3000,
	whitelist = { 'idcard' }
})

setContainerProperties('box_small', {
	slots = 5,
	maxWeight = 7500,
})

setContainerProperties('giftbox_red', {
	slots = 5,
	maxWeight = 3000,
})

setContainerProperties('giftbox_white', {
	slots = 5,
	maxWeight = 3000,
})

setContainerProperties('lscardbook_black', {
	slots = 90,
	maxWeight = 1000,
	whitelist = { 'lstradingcard' }
})

setContainerProperties('lscardbook_blue', {
	slots = 90,
	maxWeight = 1000,
	whitelist = { 'lstradingcard' }
})

setContainerProperties('lscardbook_green', {
	slots = 90,
	maxWeight = 1000,
	whitelist = { 'lstradingcard' }
})

setContainerProperties('lscardbook_yellow', {
	slots = 90,
	maxWeight = 1000,
	whitelist = { 'lstradingcard' }
})


return containers
