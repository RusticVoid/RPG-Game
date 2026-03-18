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

	windowScale = 2 -- 3 / 0.6
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

	editMode = false
	editTileIndex = 1
	EditWorld = editWorld.new({width = 10, height = 10, exitInfo = {location = currentLocation, x = Player.x, y = Player.Y}})
end

function love.keypressed(key)
	Player:keypressed(key, currentLocation)
	
	if (key == "t") then
        editMode = not editMode
		if (editMode == true) then
			EditWorld.exitInfo = {location = currentLocation, x = Player.x, y = Player.y}
			currentLocation = EditWorld
			Player.x = currentLocation.spawnX
			Player.y = currentLocation.spawnY
		else
			currentLocation:exit(Player)
		end
    end
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
		if (editMode == true) then
			love.graphics.print("EDIT MODE", 0,22)
			i = 0
			for var, value in pairs(Tiles) do
				love.graphics.draw(textures[value.texture], i*tileSize, 0)
				i = i + 1
			end
		end
	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, scale, scale)
end

function love.mousepressed(x, y, button)
	if (editMode == true) then
		tileX = math.floor(((x/scale)+Camera.offX)/tileSize)
		tileY = math.floor(((y/scale)+Camera.offY)/tileSize)
		i = 1
		for _, value in pairs(Tiles) do
			if (i == editTileIndex) then
				currentLocation.map[tileY][tileX].tile.type = value
			end
			i = i + 1
		end
	end
end
