function initLove()
    math.randomseed(os.clock())
    windowWidth, windowHeight = love.graphics.getDimensions()
	love.keyboard.setKeyRepeat(true)
end

function initClasses()
	OpSys = love.system.getOS()

	if (OpSys == "Windows") then
		for file in io.popen([[dir ".\src\classes"]]):lines() do 
			require ("classes."..string.gsub(file, ".lua", "")) 
		end
	end
	if (OpSys == "Linux") then
		for file in io.popen([[ls ./src/classes]]):lines() do 
			require ("classes."..string.gsub(file, ".lua", "")) 
		end
	end
end

function initTextures()
	love.graphics.setDefaultFilter("nearest", "nearest")
	OpSys = love.system.getOS()

	textures = {}

	if (OpSys == "Windows") then
		for file in io.popen([[dir ".\src\assets"]]):lines() do
			textures[string.gsub(file, ".png", "")] = love.graphics.newImage("assets/"..file)
		end
	end
	if (OpSys == "Linux") then
		for file in io.popen([[ls ./src/assets]]):lines() do
			textures[string.gsub(file, ".png", "")] = love.graphics.newImage("assets/"..file)
		end
	end
end