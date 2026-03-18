editWorld = {}
editWorld.__index = editWorld

function editWorld.new(settings)
    local self = setmetatable({}, editWorld)

    self.width = settings.width
    self.height = settings.height
    self.exitInfo = settings.exitInfo
    
    self.map = {}
    for y = 0, self.height do
        self.map[y] = {}
        for x = 0, self.width do
            self.map[y][x] = {tile = tile.new({x = x, y = y, type = Tiles.empty}), item}
        end
    end
    
    self.spawnX = math.floor(self.width/2)
    self.spawnY = math.floor(self.height/2)

    return self
end

function editWorld:exit(target)
    currentLocation = self.exitInfo.location
    target.x = self.exitInfo.x
    target.y = self.exitInfo.y
end

function editWorld:draw()
    for y = 0, self.width do
        for x = 0, self.height do
            self.map[y][x].tile:draw()
            if (not (self.map[y][x].item == nil)) then
                self.map[y][x].item:draw()
            end
        end
    end
end