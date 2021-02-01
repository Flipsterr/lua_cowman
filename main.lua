cowman = require "cowman"

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    cowman.Load()
end

function love.update(dt)
    cowman.Update()
end

function love.draw ()
    love.graphics.scale(2,2)
    cowman.Draw()
end
