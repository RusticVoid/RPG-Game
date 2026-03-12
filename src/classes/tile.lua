tile = {}
tile.__index = tile

function tile.new(settings)
    local self = setmetatable({}, tile)

    self.x = settings.x
    self.y = settings.y

    self.type = settings.type
    
    self.texture = settings.type.texture
    self.collision = settings.type.collision

    return self
end

function tile:update(dt)
end

function tile:draw()
    love.graphics.draw(self.texture, (self.x * tileSize)-Camera.offX, (self.y * tileSize)-Camera.offY)
end