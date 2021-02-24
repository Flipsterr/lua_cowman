local world = {}


function world:Load()
    imagedata = love.image.newImageData('Assets/Levels/level_01.png')
    image     = love.graphics.newImage(imagedata)
    
    world.Tiles = {}
    for i = 1,image:getWidth() do
            world.Tiles[i] = {}
        for j = 1,image:getHeight() do
            world.Tiles[i][j] = 0
        end
    end

    world.Texture = love.graphics.newImage("Assets/tile_map_sand.png")
    world.Quad = love.graphics.newQuad(0,0,8,8,world.Texture:getWidth(),world.Texture:getHeight())
    
    for x = image:getWidth() - 1, 1, -1 
    do 
        for y = image:getHeight() - 1, 1, -1 
        do 
            local r, g, b = imagedata:getPixel(x, y)
            if g > 0 then
                world.Tiles[y][x] = 1
            end
        end
    end
end

function world:Update()
    
end

function world:Draw()
    for x = tablelength(world.Tiles), 1, -1 
    do 
        for y = tablelength(world.Tiles[1]), 1, -1 
        do 
            if world.Tiles[x][y] == 1 then
                love.graphics.draw(world.Texture, world.Quad, y * 8 - 8, x * 8 - 8)
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