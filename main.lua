cowman = require "cowman"
world = require "world"

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    sprites = {}

    table.insert(sprites, cowman)

    world.Load()
    for i,v in ipairs(sprites) do
        v.Load()
    end
end

function handleCollision()
    
end

function love.update(dt)
    if love.keyboard.isDown("r") then
        cowman.Position.X = 64
        cowman.Position.Y = -16
    end

    for i,v in ipairs(sprites) do
        v.Update(dt)
    end
    handleCollision()
end

function love.draw (dt)
    love.graphics.scale(2,2)

    world.Draw(dt)
    for i,v in ipairs(sprites) do
        v.Draw(dt)
    end
end


