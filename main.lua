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

local Map = require("map")
local Player = require("player")
local Ghost = require("ghost")
local Point = require("point")

function love.load()
    Map:load()
    Player:load()
    Ghost:load()
    Point:load()
end

function love.update(dt)
    Player:update(dt)
    Ghost:update(dt)
    Point:update(dt)
end

function love.draw()
    Map:draw()
    Player:draw()
    Ghost:draw()
    Point:draw()
end
