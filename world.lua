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
            {0,0,0,0,1,1,0,1,0,0},
            {0,0,0,0,0,0,0,0,1,0},
            {0,0,0,0,0,0,0,0,0,0}
        }
    }
    world.Texture = love.graphics.newImage("Assets/tile_map_sand.png")
    world.Quad = love.graphics.newQuad(0,0,8,8,world.Texture:getWidth(),world.Texture:getHeight())
end

function world:Update()
    
end

function world:Draw()
    for x = tablelength(world.Level1.Tiles), 1, -1 
    do 
        for y = tablelength(world.Level1.Tiles[1]), 1, -1 
        do 
            if world.Level1.Tiles[x][y] == 1 then
                love.graphics.draw(world.Texture, world.Quad, y * 8, x * 8)
            end
        end
    end
end

function tablelength(T)
    local count = 0
    for _ in ipairs(T) do count = count + 1 end
    return count
end

return world