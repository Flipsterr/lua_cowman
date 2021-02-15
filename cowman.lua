local cowman = {}

rectangle = {
    ["X"] = 0,
    ["Y"] = 0,
    ["Width"] = 0,
    ["Height"] = 0,
}
function Left(rect)
    return rect.X
end
function Right(rect)
    return rect.X + rect.Width
end
function Top(rect)
    return rect.Y
end
function Bottom(rect)
    return rect.Y + rect.Height
end

function cowman:Load()
    cowman.Speed = 1
    cowman.Sprint = 2
    cowman.Walk = 1
    cowman.JumpHeight = 4
    cowman.Gravity = 0.2
    cowman.OnGround = false
    cowman.Xflip = 1
    cowman.Width = 16
    cowman.Height = 16

    cowman.Position = {["X"] = 64, ["Y"] = -16}
    cowman.Velocity = {["X"] = 0, ["Y"] = 0}
    cowman.Texture = love.graphics.newImage("Assets/cowman.png")
    cowman.Quad = love.graphics.newQuad(0,0,cowman.Width,cowman.Height,cowman.Texture:getWidth(),cowman.Texture:getHeight())

    cowman.Collider = {
        ["X"] = 0,
        ["Y"] = 0,
        ["Width"] = 8,
        ["Height"] = 8,
    }
end

function cowman:Update()
    cowman.Velocity.X = 0;
    if love.keyboard.isDown("a") then
        cowman.Velocity.X = cowman.Velocity.X - cowman.Speed
        cowman.Xflip = -1
    end
    if love.keyboard.isDown("d") then
        cowman.Velocity.X = cowman.Velocity.X + cowman.Speed
        cowman.Xflip = 1
    end
    if love.keyboard.isDown("w") and cowman.OnGround == true then
        cowman.Velocity.Y = cowman.Velocity.Y - cowman.JumpHeight
    end
    if love.keyboard.isDown("lshift") then
        cowman.Speed = cowman.Sprint
    else
        cowman.Speed = cowman.Walk
    end

    cowman.Velocity.Y = cowman.Velocity.Y + cowman.Gravity

    cowman.OnGround = false;

    cowman.Collider.X = cowman.Position.X
    cowman.Collider.Y = cowman.Position.Y
    CollideWithWorld()

    cowman.Position.X = cowman.Position.X + cowman.Velocity.X
    cowman.Position.Y = cowman.Position.Y + cowman.Velocity.Y
end

function CollideWithWorld()
    for x = tablelength(world.Tiles), 1, -1 
    do 
        for y = tablelength(world.Tiles[1]), 1, -1 
        do 
            if world.Tiles[x][y] == 1 then
                r = rectangle
                r.X = y * 8 - 4
                r.Y = x * 8 - 8
                r.Width = 8
                r.Height = 8
                ResolveCollision(r)
            end
        end
    end
end

function ResolveCollision(rect)

    if IsTouchingLeft(rect) == true then
        cowman.Velocity.X = Right(rect) - Left(cowman.Collider)
    end
    if IsTouchingRight(rect) == true then
        cowman.Velocity.X = Left(rect) - Right(cowman.Collider)
    end
    if IsTouchingTop(rect) == true then
        cowman.Velocity.Y = Bottom(rect) - Top(cowman.Collider)
    end
    if IsTouchingBottom(rect) == true then
        cowman.Velocity.Y = Top(rect) - Bottom(cowman.Collider)

        cowman.OnGround = true;
    end
end

function IsTouchingLeft(rect)
    return Left(cowman.Collider) + cowman.Velocity.X < Right(rect) and 
    Right(cowman.Collider) > Right(rect) and 
    Bottom(cowman.Collider) > Top(rect) and 
    Top(cowman.Collider) < Bottom(rect)
end

function IsTouchingRight(rect)
    return Right(cowman.Collider) + cowman.Velocity.X > Left(rect) and 
    Left(cowman.Collider) < Left(rect) and 
    Bottom(cowman.Collider) > Top(rect) and 
    Top(cowman.Collider) < Bottom(rect)
end

function IsTouchingTop(rect)
    return Top(cowman.Collider) + cowman.Velocity.Y < Bottom(rect) and 
    Bottom(cowman.Collider) > Bottom(rect) and 
    Right(cowman.Collider) > Left(rect) and 
    Left(cowman.Collider) < Right(rect)
end

function IsTouchingBottom(rect)
    return Bottom(cowman.Collider) + cowman.Velocity.Y > Top(rect) and 
    Top(cowman.Collider) < Top(rect) and 
    Right(cowman.Collider) > Left(rect) and 
    Left(cowman.Collider) < Right(rect)
end

function cowman:Draw()
    love.graphics.draw(
        cowman.Texture, 
        cowman.Quad, 
        cowman.Position.X, 
        cowman.Position.Y, 
        0, 
        cowman.Xflip, 
        1, 
        cowman.Width / 2, 
        cowman.Height / 2)
end

function tablelength(T)
    local count = 0
    for _ in ipairs(T) do count = count + 1 end
    return count
end

return cowman
