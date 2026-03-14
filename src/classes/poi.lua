poi = {}
poi.__index = poi

function poi.new(settings)
    local self = setmetatable({}, poi)

    self.x = settings.x
    self.y = settings.y

    self.type = settings.type

    self.info = self.type.class.new({width = 100, height = 100, exitInfo = {location = settings.location, x = self.x, y = self.y}})

    return self
end

function poi:enter(target)
    currentLocation = self.info
    target.x = currentLocation.spawnX
    target.y = currentLocation.spawnY
end

function poi:draw()
    love.graphics.draw(self.type.texture, (self.x * tileSize)-Camera.offX, (self.y * tileSize)-Camera.offY)
end