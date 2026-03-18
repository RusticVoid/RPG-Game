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

    self:makeBuilding(math.random(0, self.width-10), math.random(0, self.height-10), "store")

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


function town:makeBuilding(buildingX, buildingY, building)
    buildingData = json.loadFile("./src/buildings/"..building..".json")

    buildingWidth = #buildingData-1
    buildingHeight = #buildingData[1]-1

    if ((buildingX > 0)
    and (buildingY > 0)
    and (buildingX+buildingWidth < self.width)
    and (buildingY+buildingHeight < self.height)) then
        for y = buildingY, buildingY+buildingHeight do
            for x = buildingX, buildingX+buildingWidth do
                if (self.map[y][x].tile.type == Tiles.empty) then
                    self.map[y][x].tile.type = Tiles[buildingData[y-buildingY+1][x-buildingX+1]]
                end
            end
        end
        
        return true
    else
        return false
    end
end