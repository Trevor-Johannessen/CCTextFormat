-- function for creating new file
function create(args)
	
	-- Check args
	if not args then
		error("Please instantiate with a table. create({}) or create{}")
	
	elseif not args["fileName"] then
		error("Please give file name using create{fileName=\"\"}")
	end
	
	newFile = {}
	dateCode	= "i1I1I1I1I1I1"
	
	-- HEADERS
	newFile["year"] = tonumber(os.date("%Y")) - 2000
	newFile["month"] = tonumber(os.date("%m"))
	newFile["day"] = tonumber(os.date("%d"))
	newFile["hour"] = tonumber(os.date("%H"))
	newFile["minute"] = tonumber(os.date("%M"))
	newFile["second"] = tonumber(os.date("%S"))
	newFile["origin"] = os.getComputerID()
	newFile["version"] = 1
	newFile["size"] = 28 -- header size

	
	
	function saveFile()
		local file = io.open(args["fileName"], "wb")
		file:write(packHeaders())
		-- Write Body Here
		file:close()
	end
	
	function packHeaders()
		local dates = string.pack(dateCode,
			newFile["year"],
			newFile["month"],
			newFile["day"],
			newFile["hour"],
			newFile["minute"],
			newFile["second"]
		)
		return dates .. dates .. dates .. string.pack("I2I1I3I4", 
			newFile["origin"],
			newFile["version"],
			0,
			newFile["size"]
		)
	end
	
	saveFile()
	return open(args)
end




-- function for opening existing file
function open(args)
	-- Check args
	if not args then
		error("Please instantiate with a table. create({}) or create{}")
	
	elseif not args["fileName"] then
		error("Please give file name using create{fileName=\"\"}")
	end
	
	
	-- Constants
	file = {}
	dateCode	= "i1I1I1I1I1I1"
	
	-- Open File
	openedFile = io.open(args["fileName"], "rb")
	fileBinary = openedFile:read("a")	
	io.close(openedFile)
	
	-- Parse Headers
	lastAccessed = {string.unpack(dateCode, fileBinary)}
	lastModified = {string.unpack(dateCode, fileBinary, lastAccessed[#lastAccessed])}
	dateCreated = {string.unpack(dateCode, fileBinary, lastModified[#lastModified])}
	origin = {string.unpack("I2", fileBinary, dateCreated[#dateCreated])}
	version = {string.unpack("I1", fileBinary, origin[#origin])}
	size = {string.unpack("I4", fileBinary, version[#version]+3)}
	
	-- Get new last accessed
	currentDate = {}
	currentDate[1] = tonumber(os.date("%Y")) - 2000
	currentDate[2] = tonumber(os.date("%m"))
	currentDate[3] = tonumber(os.date("%d"))
	currentDate[4] = tonumber(os.date("%H"))
	currentDate[5] = tonumber(os.date("%M"))
	currentDate[6] = tonumber(os.date("%S"))
	
	-- get body data
	body = {}
	local i = 29
	while i < size[1] do
		local colors, character, nextIndex = string.unpack("I1B", fileBinary, i)
		body[#body+1] = {color=bit.band(3, colors), background=bit.blshift(colors, -2), character=character}
		i=nextIndex
	end
	-- Pack headers into binary string
	function packHeaders()
	
		function packDate(inDate)
			return string.pack(dateCode,
				inDate[1],
				inDate[2],
				inDate[3],
				inDate[4],
				inDate[5],
				inDate[6]
			)
		end
	
		accessed =  packDate(currentDate)
		modified = accessed
		created = packDate(dateCreated)
		return accessed .. modified .. created .. string.pack("I2I1I3I4", 
			origin[1],
			version[1],
			0,
			(#body*2+28) -- size of file
		)
	end
	
	-- Convert data to binary string and write to file
	function file:save()
		-- TODO: create copy and restore on error while saving
		local openedFile = io.open(args["fileName"], "wb")
		openedFile:write(packHeaders())
		for k, pixel in pairs(body) do
			local colors = pixel["color"] + bit.blshift(pixel["background"], 2)
			openedFile:write(string.pack("I1B", colors, pixel["character"]))
		end
		openedFile:close()
	end
	
	-- append character to file
	function file:append(appendArgs)
		-- TODO: add checks to keep values in  bounds
		body[#body+1] = {color=appendArgs.color, background=appendArgs.background, character=appendArgs.character}
	end
	
	-- print body (for testing purposes)
	function file:dumpBody()
		local counter=0
		local str = ""
		for k, v in pairs(body) do
			if counter < 8 then
				str = str .. v["character"] .. " "
				counter = counter + 1
			else
				str = ""
				counter = 0
				print(str)
			end
		end
		if counter ~= 0 then print(str) end
		print("Size: ", #body)
	end
	
	-- print headers (for testing purposes)
	function file:dumpHeaders()
		function printDate(inDate)
			local str = ""
			for i=1, 6 do
				str = str .. inDate[i] .. " "
			end
			return str
		end
		print("Last Accessed:\t" .. printDate(lastAccessed))
		print("Last Modified:\t" .. printDate(lastModified))
		print("Date Created:\t" .. printDate(dateCreated))
		print("origin:\t" .. origin[1])
		print("version:\t" .. version[1])
		print("size:\t" .. size[1])
	end
	
	-- retrieves n characters from given starting point
	function file:retrieve(n, start)
		local start = start or 1
		if n == nil then
			error("Retrieve requires the # of characters to retrieve")
		elseif start > #body then
			error("Start cannot be larger than the size of the string.")
		elseif n > #body-start+1 then
			error("N cannot be greater than the remaning length of the string")
		end
	
		
		local charString = ""
		local colorString = ""
		local bgString = ""
		
		for i = start, start+n-1 do		
			charString = charString .. string.char(body[i].character)
			colorString = colorString .. string.char(body[i].color + 97)
			bgString = bgString .. string.char(body[i].background + 97)
		end
		
		return charString, colorString, bgString
	end
	
	file:save() -- save new last accessed date
	
	return file
end
