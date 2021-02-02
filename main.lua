cowman = require "cowman"
world = require "world"
local world = require "world"

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    cowman.Load()
    world.Load()
end

function love.update(dt)
    cowman.Update()
end

function love.draw ()
    love.graphics.scale(2,2)
    cowman.Draw()
    world.Draw()
end

