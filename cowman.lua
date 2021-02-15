local cowman = {}

rectangle = {
    X = 0,
    Y = 0,
    Width = 0,
    Height = 0,
    Left = function rectangle(self)
        return self.X
    end
    Right = function rectangle(self)
        return self.X
    end
    Top = function rectangle(self)
        return self.Y + Width
    end
    Bottom = function rectangle(self)
        return self.Y + Height
    end
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
                print(r.Left())
                ResolveCollision(r)
            end
        end
    end
end

function ResolveCollision(rect)
    col1 = rectangle
    col1.X = cowman.Collider.X
    col1.Y = cowman.Collider.Y
    col1.Width = cowman.Collider.Width
    col1.Height = cowman.Collider.Height

    print(col1.Left())

    if IsTouchingLeft(rect) == true then
        cowman.Velocity.X = rect.Right() - col1.Left()
    end
    if IsTouchingRight(rect) == true then
        cowman.Velocity.X = rect.Left() - col1.Right()
    end
    if IsTouchingTop(rect) == true then
        cowman.Velocity.Y = rect.Bottom() - col1.Top()
    end
    if IsTouchingBottom(rect) == true then
        cowman.Velocity.Y = rect.Top() - col1.Bottom()

        cowman.OnGround = true;
    end
end

function IsTouchingLeft(rect)
    col1 = rectangle
    col1.X = cowman.Collider.X
    col1.Y = cowman.Collider.Y
    col1.Width = cowman.Collider.Width
    col1.Height = cowman.Collider.Height
    
    return col1.Left() + cowman.Velocity.X < rect.Right() and col1.Right() > rect.Right() and col1.Bottom() > rect.Top() and col1.Top() < rect.Bottom()
end

function IsTouchingRight(rect)
    col1 = rectangle
    col1.X = cowman.Collider.X
    col1.Y = cowman.Collider.Y
    col1.Width = cowman.Collider.Width
    col1.Height = cowman.Collider.Height

    return col1.Right() + cowman.Velocity.X > rect.Left() and col1.Left() < rect.Left() and col1.Bottom() > rect.Top() and col1.Top() < rect.Bottom()
end

function IsTouchingTop(rect)
    col1 = rectangle
    col1.X = cowman.Collider.X
    col1.Y = cowman.Collider.Y
    col1.Width = cowman.Collider.Width
    col1.Height = cowman.Collider.Height

    return col1.Top() + cowman.Velocity.Y < rect.Bottom() and col1.Bottom() > rect.Bottom() and col1.Right() > rect.Left() and col1.Left() < rect.Right()
end

function IsTouchingBottom(rect)
    col1 = rectangle
    col1.X = cowman.Collider.X
    col1.Y = cowman.Collider.Y
    col1.Width = cowman.Collider.Width
    col1.Height = cowman.Collider.Height

    return col1.Bottom() + cowman.Velocity.Y > rect.Top() and col1.Top() < rect.Top() and col1.Right() > rect.Left() and col1.Left() < rect.Right()
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
