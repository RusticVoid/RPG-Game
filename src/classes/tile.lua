tile = {}
tile.__index = tile

function tile.new(settings)
    local self = setmetatable({}, tile)

    self.x = settings.x
    self.y = settings.y

    self.type = settings.type

    return self
end

function tile:update(dt)
end

function tile:draw()
    love.graphics.draw(self.type.texture, (self.x * tileSize)-Camera.offX, (self.y * tileSize)-Camera.offY)
end