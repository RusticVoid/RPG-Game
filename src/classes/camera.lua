camera = {}
camera.__index = camera

function camera.new(settings)
    local self = setmetatable({}, camera)

    self.offX = 0
    self.offY = 0

    self.target = nil
    
    return self
end

function camera:update()
    if (self.target == nil) then
        print("test")
        return
    end

    self.offX = (self.target.x*tileSize)+(tileSize/2)-(canvasWidth/2)
    self.offY = (self.target.y*tileSize)+(tileSize/2)-(canvasHeight/2)
end

function camera:draw()
    love.graphics.draw(self.texture, self.x * tileSize, self.y * tileSize)
end