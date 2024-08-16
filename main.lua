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

print("Hello World")

function love.load()
    rectangleXPos = 100
    rectangleYPos = 50
    circleXPos = 300
    circleYPos = 300
    moveSpeed = 100
    circlemovespeed = 200
end

function love.update(deltaTime)
    -- print(deltaTime)

    if love.keyboard.isDown("right") then
        rectangleXPos = rectangleXPos + moveSpeed * deltaTime
    elseif love.keyboard.isDown("left") then
        rectangleXPos = rectangleXPos - moveSpeed * deltaTime
    end

    if love.keyboard.isDown("up") then
        rectangleYPos = rectangleYPos - moveSpeed * deltaTime
    elseif love.keyboard.isDown("down") then
        rectangleYPos = rectangleYPos + moveSpeed * deltaTime
    end



    if love.keyboard.isDown("w") then
        circleYPos = circleYPos - circlemovespeed * deltaTime
    elseif love.keyboard.isDown("s") then
        circleYPos = circleYPos + circlemovespeed * deltaTime
    end
end

function love.draw()
    love.graphics.rectangle("line", rectangleXPos, rectangleYPos, 200, 150)
    love.graphics.circle("line", circleXPos, circleYPos, 50)
end
