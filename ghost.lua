local Ghost = {}
local Map = require("map")

function Ghost:load()
    self.x = 16 * Map.tileSize
    self.y = 13 * Map.tileSize
    self.speed = 150
    self.size = Map.tileSize
    self.direction = "left"
end

function Ghost:update(dt)
    self:move(dt)
end

function Ghost:move(dt)
    local moveX, moveY = 0, 0

    if self.direction == "left" then
        moveX = -self.speed * dt
    elseif self.direction == "right" then
        moveX = self.speed * dt
    elseif self.direction == "up" then
        moveY = -self.speed * dt
    elseif self.direction == "down" then
        moveY = self.speed * dt
    end

    if not Map:checkCollision(self.x + moveX, self.y + moveY) then
        self.x = self.x + moveX
        self.y = self.y + moveY
    else
        self.direction = self:randomDirection()
    end
end

function Ghost:randomDirection()
    local directions = { "left", "right", "up", "down" }
    return directions[love.math.random(#directions)]
end

function Ghost:draw()
    love.graphics.setColor(255, 0, 0) -- Red ghost
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

return Ghost
