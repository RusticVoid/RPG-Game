function initLove()
    math.randomseed(os.clock())
    windowWidth, windowHeight = love.graphics.getDimensions()
	love.keyboard.setKeyRepeat(true)
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

function initItemClasses()
	initClassesInDir("items")
end

function initClasses()
	initClassesInDir("classes")
end

function initClassesInDir(dir)
	OpSys = love.system.getOS()

	if (OpSys == "Windows") then
		for file in io.popen([[dir ".\src\"]]..dir):lines() do
			local classFile, count = string.gsub(file, ".lua", "")
			if (tonumber(count) > 0) then
				require (dir.."."..classFile)
			end
		end
	end
	if (OpSys == "Linux") then
		for file in io.popen([[ls ./src/]]..dir):lines() do
			local classFile, count = string.gsub(file, ".lua", "")
			if (tonumber(count) > 0) then
				require (dir.."."..classFile)
			end
		end
	end
end