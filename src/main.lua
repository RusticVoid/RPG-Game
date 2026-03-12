require "utils"
initClasses()

function love.load()
	-- Init Love2d
	initLove()
    font = love.graphics.getFont()
	
	-- Init Game
	initTextures()
	canvasWidth = 320
	canvasHeight = 240

	windowScale = 3
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
	}

	World = world.new({width = 100, height = 100})

	Player = player.new({x = World.spawnX, y = World.spawnY})

	Camera = camera.new()
	Camera.target = Player

	debug = false

	scale = math.min(windowWidth / canvasWidth, windowHeight / canvasHeight)
end

function love.update(dt)
    windowWidth, windowHeight = love.graphics.getDimensions()
	scale = math.min(windowWidth / canvasWidth, windowHeight / canvasHeight)

	Player:update(dt)
	Camera:update()
end

function love.draw()
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
		World:draw()
		Player:draw()
		love.graphics.print("FPS: "..love.timer.getFPS())
	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, scale, scale)

end
