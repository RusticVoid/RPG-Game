town = {}
town.__index = town

function town.new(settings)
    local self = setmetatable({}, town)

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

    self:makeHouse(math.random(0, self.width), math.random(0, self.height), 5)

    self.spawnX = math.floor(self.width/2)
    self.spawnY = math.floor(self.height/2)

    self.map[self.spawnY][self.spawnX].tile.type = Tiles.exit

    return self
end

function town:exit(target)
    currentLocation = self.exitInfo.location
    target.x = self.exitInfo.x
    target.y = self.exitInfo.y
end

function town:draw()
    for y = 0, self.width do
        for x = 0, self.height do
            self.map[y][x].tile:draw()
            if (not (self.map[y][x].item == nil)) then
                self.map[y][x].item:draw()
            end
        end
    end
end


function town:makeHouse(houseX, houseY, houseSize)
    if ((houseX > 0) 
    and (houseY > 0) 
    and (houseX+houseSize < self.width) 
    and (houseY+houseSize < self.height)) then
        for y = houseY, houseY+houseSize do
            for x = houseX, houseX+houseSize do
                if ((x == houseX) or (x == houseX+houseSize) or (y == houseY) or (y == houseY+houseSize)) then
                    if (self.map[y][x].tile.type == Tiles.empty) then
                        self.map[y][x].tile.type = Tiles.wall
                    end
                else
                    self.map[y][x].tile.type = Tiles.dirt
                end
            end
        end
        
        return true
    else
        return false
    end
end