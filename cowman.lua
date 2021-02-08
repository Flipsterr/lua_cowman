local cowman = {}

rectangle = {
    ["X"] = 0,
    ["Y"] = 0,
    ["Width"] = 0,
    ["Height"] = 0,
}

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
        ["Width"] = 16,
        ["Height"] = 16,
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
    for x = tablelength(world.Level1.Tiles), 1, -1 
    do 
        for y = tablelength(world.Level1.Tiles[1]), 1, -1 
        do 
            if world.Level1.Tiles[x][y] == 1 then
                r = rectangle
                r.X = y * 8
                r.Y = x * 8
                r.Width = 8
                r.Height = 8
                ResolveCollision(r)
            end
        end
    end
end

function ResolveCollision(rect)
    col1 = {
        ["Left"] = cowman.Collider.X,
        ["Right"] = cowman.Collider.X + cowman.Collider.Width,
        ["Top"] = cowman.Collider.Y,
        ["Bottom"] = cowman.Collider.Y+ cowman.Collider.Height
    }
    col2 = {
        ["Left"] = rect.X,
        ["Right"] = rect.X + rect.Width,
        ["Top"] = rect.Y,
        ["Bottom"] = rect.Y + rect.Height
    }
    if IsTouchingLeft(rect) == true then
        cowman.Velocity.X = col2.Right - col1.Left;
    end
    if IsTouchingRight(rect) == true then
        cowman.Velocity.X = col2.Left - col1.Right;
    end
    if IsTouchingTop(rect) == true then
        cowman.Velocity.Y = col2.Bottom - col1.Top;
    end
    if IsTouchingBottom(rect) == true then
        cowman.OnGround = true;

        cowman.Velocity.Y = col2.Top - col1.Bottom
    end
end

function IsTouchingLeft(rect)
    col1 = {
        ["Left"] = cowman.Collider.X,
        ["Right"] = cowman.Collider.X + cowman.Collider.Width,
        ["Top"] = cowman.Collider.Y,
        ["Bottom"] = cowman.Collider.Y+ cowman.Collider.Height
    }
    col2 = {
        ["Left"] = rect.X,
        ["Right"] = rect.X + rect.Width,
        ["Top"] = rect.Y,
        ["Bottom"] = rect.Y + rect.Height
    }
    
    return col1.Left + cowman.Velocity.X < col2.Right and col1.Right > col2.Right and col1.Bottom > col2.Top and col1.Top < col2.Bottom
end

function IsTouchingRight(rect)
    col1 = {
        ["Left"] = cowman.Collider.X,
        ["Right"] = cowman.Collider.X + cowman.Collider.Width,
        ["Top"] = cowman.Collider.Y,
        ["Bottom"] = cowman.Collider.Y+ cowman.Collider.Height
    }
    col2 = {
        ["Left"] = rect.X,
        ["Right"] = rect.X + rect.Width,
        ["Top"] = rect.Y,
        ["Bottom"] = rect.Y + rect.Height
    }

    return col1.Right + cowman.Velocity.X > col2.Left and col1.Left < col2.Left and col1.Bottom > col2.Top and col1.Top < col2.Bottom
end

function IsTouchingTop(rect)
    col1 = {
        ["Left"] = cowman.Collider.X,
        ["Right"] = cowman.Collider.X + cowman.Collider.Width,
        ["Top"] = cowman.Collider.Y,
        ["Bottom"] = cowman.Collider.Y+ cowman.Collider.Height
    }
    col2 = {
        ["Left"] = rect.X,
        ["Right"] = rect.X + rect.Width,
        ["Top"] = rect.Y,
        ["Bottom"] = rect.Y + rect.Height
    }

    return col1.Top + cowman.Velocity.Y < col2.Bottom and col1.Bottom > col2.Bottom and col1.Right > col2.Left and col1.Left < col2.Right
end

function IsTouchingBottom(rect)
    col1 = {
        ["Left"] = cowman.Collider.X,
        ["Right"] = cowman.Collider.X + cowman.Collider.Width,
        ["Top"] = cowman.Collider.Y,
        ["Bottom"] = cowman.Collider.Y+ cowman.Collider.Height
    }
    col2 = {
        ["Left"] = rect.X,
        ["Right"] = rect.X + rect.Width,
        ["Top"] = rect.Y,
        ["Bottom"] = rect.Y + rect.Height
    }

    return col1.Bottom + cowman.Velocity.Y > col2.Top and col1.Top < col2.Top and col1.Right > col2.Left and col1.Left < col2.Right
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
