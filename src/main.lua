require "utils"
initClasses()

function love.load()
	-- Init Love2d
	initLove()
    font = love.graphics.getFont()
	
	-- Init Game
	initTextures()
	initItemClasses()
	canvasWidth = 480 -- 320 / 480 / 1650
	canvasHeight = 320 -- 240 / 320 / 1650

	windowScale = 3 -- 3 / 0.6
	love.window.setMode(canvasWidth*windowScale, canvasHeight*windowScale)

	canvas = love.graphics.newCanvas(canvasWidth, canvasHeight)
	canvas:setFilter("nearest", "nearest")

	font = love.graphics.newFont(10, "mono")
	font:setFilter("nearest", "nearest")
	love.graphics.setFont(font)

	-- Global Variables
	tileSize = 16

	Tiles = {
		dirt =  {texture = textures["dirt"],  collision = false},
		wall =  {texture = textures["wall"],  collision = true},
		empty = {texture = textures["empty"], collision = false},
		exit =  {texture = textures["exit"],  collision = false},
		grass =  {texture = textures["grass"],  collision = false},
		water =  {texture = textures["water"],  collision = false},
	}

	poiTypes = {
		dungeon =  {texture = textures["dungeon"], class = dungeon},
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
