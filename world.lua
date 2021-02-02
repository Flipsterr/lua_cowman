local world = {}

function world:Load()
    world.Level1 = {
        ["Tiles"] = {
            {0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,1,1,0,0,0,0},
            {0,0,0,1,0,0,1,0,0,0},
            {0,0,1,0,0,0,0,1,0,0},
            {0,1,0,0,0,0,0,0,1,0},
            {0,0,1,0,0,0,0,1,0,0},
            {0,0,0,1,0,0,1,0,0,0},
            {0,0,0,0,1,1,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0}
        }
    }
    world.Texture = love.graphics.newImage("Assets/tile_map_sand.png")
    world.Quad = love.graphics.newQuad(0,0,8,8,world.Texture:getWidth(),world.Texture:getHeight())
end

function world:Draw()
    love.graphics.draw(world.Texture, world.Quad, world.Position.X, world.Position.Y)
end



return world