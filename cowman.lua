local cowman = {}
function cowman:load()
    Texture = love.graphics.newImage("Assets/cowman.png")
    Quad = love.graphics.newQuad(0,0,16,16,16,16)
end

function cowman:Draw()
    love.graphics.draw(Texture, Quad, 128, 128)
end
return cowman

