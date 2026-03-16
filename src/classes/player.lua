player = {}
player.__index = player

function player.new(settings)
    local self = setmetatable({}, player)

    self.playerSheet = textures["playerSheet"]
    self.currentFrame = 0

    self.x = settings.x
    self.y = settings.y

    self.pastX = self.x
    self.pastY = self.y
    self.dir = 1
    self.moving = false
    self.speed = 3

    self.isItem = false
    self.floorItem = nil

    self.inventory = {}
    self.maxInvSlots = 12
    self.inventoryOpen = false
    self.coins = 0

    return self
end

function player:giveItem(item)
    if (#self.inventory >= self.maxInvSlots) then
        return false
    else
        table.insert(self.inventory, item)
        return true
    end
end
function player:removeItemFromSlot(slot)
    table.remove(taget.inventory, slot)
end

function player:keypressed(key, location)
    if (key == "q") then
        self.inventoryOpen = not self.inventoryOpen
    end

    if (self.moving == false) then
        if (love.keyboard.isDown("e")) then
            if (not (location.map[math.floor(self.y)][math.floor(self.x)].item == nil)) then
                location.map[math.floor(self.y)][math.floor(self.x)].item:pickup(self, location)
            end

            if (not (location.map[math.floor(self.y)][math.floor(self.x)].poi == nil)) then
                location.map[math.floor(self.y)][math.floor(self.x)].poi:enter(self)
            end

            if (not (location.map[math.floor(self.y)][math.floor(self.x)].tile == nil)) then
                if (location.map[math.floor(self.y)][math.floor(self.x)].tile.type == Tiles.exit) then
                    location:exit(self)
                end
            end
        end
    end
end

function player:update(dt, location)
    if (self.moving == false) then
        self.pastX = self.x
        self.pastY = self.y

        if (love.keyboard.isDown("s")) then
            if ((self.y+1 <= location.height) and (location.map[self.y+1][self.x].tile.type.collision == false)) then
                self.dir = 1
                self.moving = true
                self.currentFrame = 1
            end
        elseif (love.keyboard.isDown("w")) then
            if ((self.y-1 >= 0) and (location.map[self.y-1][self.x].tile.type.collision == false)) then
                self.dir = 2
                self.moving = true
                self.currentFrame = 1
            end
        elseif (love.keyboard.isDown("d")) then
            if ((self.x+1 <= location.width) and (location.map[self.y][self.x+1].tile.type.collision == false)) then
                self.dir = 3
                self.moving = true
                self.currentFrame = 1
            end
        elseif (love.keyboard.isDown("a")) then
            if ((self.x-1 >= 0) and location.map[self.y][self.x-1].tile.type.collision == false) then
                self.dir = 4
                self.moving = true
                self.currentFrame = 1
            end
        else
            self.currentFrame = 0
        end
    else
        if (self.dir == 1) then
            self.y = self.y + self.speed * dt
            if (self.y-self.pastY > 1) then
                self.y = self.pastY+1
                self.moving = false
            end
        elseif (self.dir == 2) then
            self.y = self.y - self.speed * dt
            if (self.pastY-self.y > 1) then
                self.y = self.pastY-1
                self.moving = false
            end
        elseif (self.dir == 3) then
            self.x = self.x + self.speed * dt
            if (self.x-self.pastX > 1) then
                self.x = self.pastX+1
                self.moving = false
            end
        elseif (self.dir == 4) then
            self.x = self.x - self.speed * dt
            if (self.pastX-self.x > 1) then
                self.x = self.pastX-1
                self.moving = false
            end
        end

        self.currentFrame = self.currentFrame + dt*5
        if (math.floor(self.currentFrame) > 2) then
            self.currentFrame = 1
        end
    end
end

function player:draw()
    love.graphics.draw(self.playerSheet, love.graphics.newQuad(math.floor(self.currentFrame)*tileSize, (self.dir-1)*tileSize, tileSize, tileSize, self.playerSheet:getWidth(), self.playerSheet:getHeight()),
                       (self.x * tileSize)-Camera.offX, (self.y * tileSize)-Camera.offY)

    love.graphics.setColor(0.8, 0.5, 0.1)
	love.graphics.print("Coins: "..self.coins, 0, font:getHeight())
    love.graphics.setColor(1,1,1,1)

    if (self.inventoryOpen) then
        local invPos = {x = 0, y = canvasHeight-textures["inventory"]:getHeight()}
        
        love.graphics.draw(textures["inventory"], invPos.x, invPos.y)
        for i = 1, #self.inventory do
            love.graphics.draw(self.inventory[i].texture, ((i - 1) % 4) * (tileSize + 1) + 3, invPos.y + 3 + math.floor((i - 1) / 4) * (tileSize + 1))
        end
    end
end