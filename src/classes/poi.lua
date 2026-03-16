poi = {}
poi.__index = poi

function poi.new(settings)
    local self = setmetatable({}, poi)

    self.x = settings.x
    self.y = settings.y

    self.type = settings.type

    self.info = self.type.class.new({width = settings.width, height = settings.height, exitInfo = {location = settings.exitLocation, x = self.x, y = self.y}})

    return self
end

function poi:enter(target)
    currentLocation = self.info
    target.x = currentLocation.spawnX
    target.y = currentLocation.spawnY
end

function poi:draw()
    if (((self.x * tileSize)-Camera.offX > -tileSize) and 
        ((self.x * tileSize)-Camera.offX < canvasWidth) and
        ((self.y * tileSize)-Camera.offY > -tileSize) and 
        ((self.y * tileSize)-Camera.offY < canvasHeight)) then
        love.graphics.draw(self.type.texture, (self.x * tileSize)-Camera.offX, (self.y * tileSize)-Camera.offY)
    end
end