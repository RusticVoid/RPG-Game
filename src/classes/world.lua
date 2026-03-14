world = {}
world.__index = world

function world.new(settings)
    local self = setmetatable({}, world)

    self.width = settings.width
    self.height = settings.height

    self.roomSize = 8

    self.map = {}
    for y = 0, self.height do
        self.map[y] = {}
        for x = 0, self.width do
            self.map[y][x] = {tile = tile.new({x = x, y = y, type = Tiles.empty}), location, height = math.random()}
        end
    end

    for i = 0, 14 do
        for y = 0, self.height do
            for x = 0, self.width do
                local values = {}
                if (x-1 >= 0) then
                    table.insert(values, self.map[y][x-1].height)
                end
                if (x+1 <= self.width) then
                    table.insert(values, self.map[y][x+1].height)
                end
                if (y-1 >= 0) then
                    table.insert(values, self.map[y-1][x].height)
                end
                if (y+1 <= self.height) then
                    table.insert(values, self.map[y+1][x].height)
                end

                local valueSum = 0
                for i = 1, #values do
                    valueSum = valueSum + values[i]
                end

                self.map[y][x].height = (valueSum)/#values
            end
        end
    end

    for y = 0, self.height do
        for x = 0, self.width do
            if (self.map[y][x].height > 0.5) then
                self.map[y][x].tile.type = Tiles.grass
            else
                self.map[y][x].tile.type = Tiles.water
            end
        end
    end

    for i = 0, 100 do
        local x = math.random(0, self.width)
        local y = math.random(0, self.height)
        if (self.map[y][x].tile.type == Tiles.grass) then
            self:addLocation(poi.new({x = x, y = y, type = poiTypes.dungeon, location = self}))
        end
    end

    while true do
        x = math.random(0, self.width)
        y = math.random(0, self.height)
        if (self.map[y][x].tile.type == Tiles.grass) then
            self.spawnX = x
            self.spawnY = y
            break
        end
    end


    return self
end

function world:update(dt)
end

function world:draw()
    for y = 0, self.width do
        for x = 0, self.height do
            self.map[y][x].tile:draw()
            if (not (self.map[y][x].location == nil)) then
                self.map[y][x].location:draw()
            end
        end
    end
end

function world:addLocation(location)
    self.map[location.y][location.x].location = location
end