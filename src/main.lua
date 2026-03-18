require "utils"
loadClasses("classes")

function love.load()
	-- Init Love2d
	initLove()
	
	-- Init Game
	love.graphics.setDefaultFilter("nearest", "nearest")
	textures = loadTextures("assets")
	canvasWidth = 480 -- 320 / 480 / 1650
	canvasHeight = 320 -- 240 / 320 / 1650

	windowScale = 3 -- 3 / 0.6
	love.window.setMode(canvasWidth*windowScale, canvasHeight*windowScale, {
		vsync = 0,
		resizable = true
	})

	canvas = love.graphics.newCanvas(canvasWidth, canvasHeight)
	canvas:setFilter("nearest", "nearest")

	font = love.graphics.newFont(10, "mono")
	font:setFilter("nearest", "nearest")
	love.graphics.setFont(font)

	-- Global Variables
	tileSize = 16

	loadClasses("items")
	Tiles = loadTiles("tiles")
	--Tiles = {
	--	empty = {texture = textures["empty"], collision = false},
	--	exit =  {texture = textures["exit"],  collision = false},
	--	floor =  {texture = textures["floor"],  collision = false},
	--}

	loadClasses("POIS")
	poiTypes = {
		dungeon =  {texture = textures["dungeon"], class = dungeon},
		town =  {texture = textures["town"], class = town},
	}

	World = world.new({width = 100, height = 100})
	currentLocation = World

	Player = player.new({x = currentLocation.spawnX, y = currentLocation.spawnY})

	Camera = camera.new()
	Camera.target = Player

	debug = false

	scale = math.min(windowWidth / canvasWidth, windowHeight / canvasHeight)
end

function love.keypressed(key)
	Player:keypressed(key, currentLocation)
end

function love.update(dt)
    windowWidth, windowHeight = love.graphics.getDimensions()
	scale = math.min(windowWidth / canvasWidth, windowHeight / canvasHeight)

	Player:update(dt, currentLocation)
	Camera:update()
end

function love.draw()
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
		currentLocation:draw()
		Player:draw()
		love.graphics.print("FPS: "..love.timer.getFPS())
	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, scale, scale)

end
