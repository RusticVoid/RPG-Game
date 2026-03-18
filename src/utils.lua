json = require("json")

function initLove()
    math.randomseed(os.clock())
    windowWidth, windowHeight = love.graphics.getDimensions()
	love.keyboard.setKeyRepeat(true)
end

function loadTextures(dir)
	OpSys = love.system.getOS()

	local textures = {}

	if (OpSys == "Windows") then
		files = io.popen([[dir ".\src\"]]..dir):lines()
	end
	if (OpSys == "Linux") then
		files = io.popen([[ls ./src/]]..dir):lines()
	end

	for file in files do
		textures[string.gsub(file, ".png", "")] = love.graphics.newImage(dir.."/"..file)
	end

	return textures
end

function loadClasses(dir)
	OpSys = love.system.getOS()

	if (OpSys == "Windows") then
		files = io.popen([[dir ".\src\"]]..dir):lines()
	end
	if (OpSys == "Linux") then
		files = io.popen([[ls ./src/]]..dir):lines()
	end

	for file in files do
		local classFile, count = string.gsub(file, ".lua", "")
		if (tonumber(count) > 0) then
			require (dir.."."..classFile)
		end
	end
end

function addPOI(location, poi)
    location.map[poi.y][poi.x].poi = poi
end

function addItem(location, item)
    location.map[item.y][item.x].item = item
end

function loadTiles(dir)
	OpSys = love.system.getOS()

	local tiles = {}

	if (OpSys == "Windows") then
		files = io.popen([[dir ".\src\"]]..dir):lines()
	end
	if (OpSys == "Linux") then
		files = io.popen([[ls ./src/]]..dir):lines()
	end

	for file in files do
		tiles[string.gsub(file, ".json", "")] = json.loadFile("./src/"..dir.."/"..file)
	end

	return tiles
end