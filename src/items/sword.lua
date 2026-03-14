sword = {}
sword.__index = sword

function sword.new(settings)
    local self = setmetatable({}, sword)

    self.texture = textures["sword"]

    self.x = settings.x
    self.y = settings.y
    
    return self
end

function sword:pickup(taget, location)
    if (taget:giveItem(self)) then
        location.map[math.floor(self.y)][math.floor(self.x)].item = nil
    end
end

function sword:draw()
    love.graphics.draw(self.texture, (self.x * tileSize)-Camera.offX, (self.y * tileSize)-Camera.offY)
end