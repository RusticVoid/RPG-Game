dungeon = {}
dungeon.__index = dungeon

function dungeon.new(settings)
    local self = setmetatable({}, dungeon)

    self.width = settings.width
    self.height = settings.height
    self.exitInfo = settings.exitInfo

    self.roomSize = 8

    self.map = {}
    for y = 0, self.height do
        self.map[y] = {}
        for x = 0, self.width do
            self.map[y][x] = {tile = tile.new({x = x, y = y, type = Tiles.empty}), item}
        end
    end

    self.spawnX = math.floor(self.width/2)
    self.spawnY = math.floor(self.height/2)

    local x = self.spawnX-(self.roomSize/2)
    local y = self.spawnY-(self.roomSize/2)
    self:makeRoom(x, y)
    local lastX = x
    local lastY = y

    local dis = math.sqrt((self.spawnX-x)^2+(self.spawnY-y)^2)
    local lastDis = dis
    local farthestX = x
    local farthestY = y
    
    local roomAmount = math.random(5, 20)
    for i = 0, roomAmount do
        local dir = math.random(1, 4)
        lastX = x
        lastY = y

        if (dir == 1) then
            y = y-self.roomSize
        elseif (dir == 2) then
            x = x+self.roomSize
        elseif (dir == 3) then
            y = y+self.roomSize
        elseif (dir == 4) then
            x = x-self.roomSize
        end

        success = self:makeRoom(x, y)

        if (success) then
            if (dir == 1) then
                self.map[y+self.roomSize][x+math.floor(self.roomSize/2)].tile = tile.new({x = x+math.floor(self.roomSize/2), y = y+self.roomSize, type = Tiles.dirt})
            elseif (dir == 2) then
                self.map[y+math.floor(self.roomSize/2)][x].tile = tile.new({x = x, y = y+math.floor(self.roomSize/2), type = Tiles.dirt})
            elseif (dir == 3) then
                self.map[y][x+math.floor(self.roomSize/2)].tile = tile.new({x = x+math.floor(self.roomSize/2), y = y, type = Tiles.dirt})
            elseif (dir == 4) then
                self.map[y+math.floor(self.roomSize/2)][x+self.roomSize].tile = tile.new({x = x+self.roomSize, y = y+math.floor(self.roomSize/2), type = Tiles.dirt})
            end

            local itemAmount = math.random(0, 3)
            for i = 0, itemAmount do
                local itemX = math.random(x, x+self.roomSize)
                local itemY = math.random(y, y+self.roomSize)
                if (self.map[itemY][itemX].tile.type == Tiles.dirt) then
                    if (math.random(0, 1) == 0) then
                        addItem(self, coin.new({x = itemX, y = itemY}))
                    else
                        addItem(self, sword.new({x = itemX, y = itemY}))
                    end
                end
            end
        else
            x = lastX
            y = lastY
        end

        dis = math.sqrt((self.spawnX-x)^2+(self.spawnY-y)^2)
        if (dis > lastDis) then
            lastDis = dis
            farthestX = x
            farthestY = y
        end
    end

    x = farthestX+math.floor(self.roomSize/2)
    y = farthestY+math.floor(self.roomSize/2)

    self.map[y][x].tile.type = Tiles.exit

    return self
end

function dungeon:exit(target)
    currentLocation = self.exitInfo.location
    target.x = self.exitInfo.x
    target.y = self.exitInfo.y
end

function dungeon:draw()
    for y = 0, self.width do
        for x = 0, self.height do
            self.map[y][x].tile:draw()
            if (not (self.map[y][x].item == nil)) then
                self.map[y][x].item:draw()
            end
        end
    end
end

function dungeon:makeRoom(roomX, roomY)
    if ((roomX > 0) and (roomY > 0) 
    and (roomX+self.roomSize < self.width) and (roomY+self.roomSize < self.height)) then
        for y = roomY, roomY+self.roomSize do
            for x = roomX, roomX+self.roomSize do
                if ((x == roomX) or (x == roomX+self.roomSize) or (y == roomY) or (y == roomY+self.roomSize)) then
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