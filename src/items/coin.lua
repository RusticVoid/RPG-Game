coin = {}
coin.__index = coin

function coin.new(settings)
    local self = setmetatable({}, coin)

    self.texture = textures["gold"]

    self.x = settings.x
    self.y = settings.y
    
    return self
end

function coin:pickup(taget)
    taget.coins = taget.coins + math.random(1, 4)
    World.map[math.floor(self.y)][math.floor(self.x)].item = nil
end

function coin:draw()
    love.graphics.draw(self.texture, (self.x * tileSize)-Camera.offX, (self.y * tileSize)-Camera.offY)
end