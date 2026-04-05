editMode = {}
editMode.__index = editMode

function editMode.new(settings)
    local self = setmetatable({}, editMode)

    self.enabled = false
    self.editTile = Tiles.dirt

    return self
end

function editMode:keypressed(key)
    if (key == "t") then
        self.enabled = not self.enabled
		if (self.enabled == true) then
			EditWorld.exitInfo = {location = currentLocation, x = Player.x, y = Player.y}
			currentLocation = EditWorld
			Player.x = currentLocation.spawnX
			Player.y = currentLocation.spawnY
		else
			currentLocation:exit(Player)
		end
    end
end

function editMode:draw()
	if (self.enabled == true) then
        love.graphics.print("EDIT MODE", 0,22)
        i = 0
        for var, value in pairs(Tiles) do
            love.graphics.draw(textures[value.texture], i*tileSize, 0)
            i = i + 1
        end
    end
end

function editMode:mousepressed(x, y, button)
    if (self.enabled == true) then
        mouseX = math.floor(x/scale)
        mouseY = math.floor(y/scale)

        i = 0
        for var, value in pairs(Tiles) do
            if ((mouseX > i*tileSize) and (mouseX < i*tileSize+textures[value.texture]:getWidth()) 
            and (mouseY > 0) and (mouseY < textures[value.texture]:getHeight())) then
                self.editTile = value
                goto continue
            end
            i = i + 1
        end

		tileX = math.floor((mouseX+Camera.offX)/tileSize)
		tileY = math.floor((mouseY+Camera.offY)/tileSize)
        if ((tileY > -1) and (tileY < #currentLocation.map+1)
        and (tileX > -1) and (tileX < #currentLocation.map[tileY]+1)) then
            currentLocation.map[tileY][tileX].tile.type = self.editTile
        end
        ::continue::
	end
end