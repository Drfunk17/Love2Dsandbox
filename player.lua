local Player = {}
local Map = require("map")
local Point = require("point")

function Player:load()
    self.x = 2 * Map.tileSize
    self.y = 2 * Map.tileSize
    self.speed = 200
    self.size = Map.tileSize
end

function Player:update(dt)
    local moveX, moveY = 0, 0

    if love.keyboard.isDown("left") then
        moveX = -self.speed * dt
    elseif love.keyboard.isDown("right") then
        moveX = self.speed * dt
    end

    if love.keyboard.isDown("up") then
        moveY = -self.speed * dt
    elseif love.keyboard.isDown("down") then
        moveY = self.speed * dt
    end

    self:move(moveX, moveY)
    self:checkPointCollision()
end

function Player:move(dx, dy)
    local newX = self.x + dx
    local newY = self.y + dy

    if not Map:checkCollision(newX, self.y) then
        self.x = newX
    end

    if not Map:checkCollision(self.x, newY) then
        self.y = newY
    end
end

function Player:checkPointCollision()
    for i, point in ipairs(Point.points) do
        if math.abs(self.x - point.x) < self.size / 2 and math.abs(self.y - point.y) < self.size / 2 then
            table.remove(Point.points, i)
            break
        end
    end
end

function Player:draw()
    love.graphics.setColor(255, 255, 0) -- Yellow Pac-Man
    love.graphics.circle("fill", self.x, self.y, self.size / 2)
end

return Player
