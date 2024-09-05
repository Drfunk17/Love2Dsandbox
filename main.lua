if arg[2] == "debug" then
    require("lldebugger").start()
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end

-- Snake Game using Love2D
-- Define grid size
local gridSize = 20
local gridXCount = 40
local gridYCount = 30

-- Define snake variables
local snakeSegments
local snakeDir
local snakeTimer
local snakeSpeed = 0.1 -- How fast the snake moves
local nextDir

-- Food position
local foodX
local foodY

-- Score
local score

-- Game state variable
local gameOver

-- Function to reset the game
function reset()
    snakeSegments = {
        { x = 5, y = 5 },
        { x = 4, y = 5 },
        { x = 3, y = 5 }
    }
    snakeDir = "right"
    nextDir = snakeDir
    snakeTimer = 0
    score = 0
    gameOver = false

    -- Randomly place food
    foodX = love.math.random(0, gridXCount - 1)
    foodY = love.math.random(0, gridYCount - 1)
end

-- Load function
function love.load()
    love.window.setMode(gridSize * gridXCount, gridSize * gridYCount)
    reset()
end

-- Function to check if two positions overlap
function positionsAreEqual(x1, y1, x2, y2)
    return x1 == x2 and y1 == y2
end

-- Function to handle movement and collisions
function love.update(dt)
    if gameOver then
        return
    end

    snakeTimer = snakeTimer + dt
    if snakeTimer >= snakeSpeed then
        snakeTimer = snakeTimer - snakeSpeed

        -- Update direction if needed
        if (nextDir == "right" and snakeDir ~= "left") or
            (nextDir == "left" and snakeDir ~= "right") or
            (nextDir == "up" and snakeDir ~= "down") or
            (nextDir == "down" and snakeDir ~= "up") then
            snakeDir = nextDir
        end

        -- Move snake
        local nextX = snakeSegments[1].x
        local nextY = snakeSegments[1].y

        if snakeDir == "right" then
            nextX = nextX + 1
        elseif snakeDir == "left" then
            nextX = nextX - 1
        elseif snakeDir == "up" then
            nextY = nextY - 1
        elseif snakeDir == "down" then
            nextY = nextY + 1
        end

        -- Check for collisions with walls
        if nextX < 0 or nextY < 0 or nextX >= gridXCount or nextY >= gridYCount then
            gameOver = true -- Game over on wall collision
        end

        -- Check for collisions with self
        for _, segment in ipairs(snakeSegments) do
            if positionsAreEqual(nextX, nextY, segment.x, segment.y) then
                gameOver = true -- Game over on self-collision
            end
        end

        -- Move the snake by adding a new head
        table.insert(snakeSegments, 1, { x = nextX, y = nextY })

        -- Check for food
        if positionsAreEqual(snakeSegments[1].x, snakeSegments[1].y, foodX, foodY) then
            score = score + 1

            -- Move food to a new random position
            foodX = love.math.random(0, gridXCount - 1)
            foodY = love.math.random(0, gridYCount - 1)
        else
            -- Remove the tail (snake moves forward)
            table.remove(snakeSegments)
        end
    end
end

-- Function to handle keypresses
function love.keypressed(key)
    if key == "right" then
        nextDir = "right"
    elseif key == "left" then
        nextDir = "left"
    elseif key == "up" then
        nextDir = "up"
    elseif key == "down" then
        nextDir = "down"
    elseif key == "r" and gameOver then
        reset() -- Press 'r' to reset the game after a game over
    end
end

-- Function to draw everything on screen
function love.draw()
    -- Draw snake
    for _, segment in ipairs(snakeSegments) do
        love.graphics.rectangle("fill", segment.x * gridSize, segment.y * gridSize, gridSize - 1, gridSize - 1)
    end

    -- Draw food
    love.graphics.rectangle("fill", foodX * gridSize, foodY * gridSize, gridSize - 1, gridSize - 1)

    -- Draw score
    love.graphics.print("Score: " .. score, 10, 10)

    -- Display game over message
    if gameOver then
        love.graphics.print("Game Over! Press 'R' to restart", 200, 200)
    end
end
