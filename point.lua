local Point = {}
local Map = require("map")

function Point:load()
    self.points = {}
    self.size = 8 -- Half the size of the tile to fit nicely in the center

    for y = 1, Map.height do
        for x = 1, Map.width do
            if Map.grid[y][x] == 0 then -- Check if the tile is not a wall
                table.insert(self.points, { x = (x - 0.5) * Map.tileSize, y = (y - 0.5) * Map.tileSize })
            end
        end
    end
end

function Point:update(dt)
    -- Collision detection with the player is handled in player.lua
end

function Point:draw()
    love.graphics.setColor(255, 255, 255) -- White points
    for _, point in ipairs(self.points) do
        love.graphics.circle("fill", point.x, point.y, self.size / 2)
    end
end

return Point
