local cowman = {}

function cowman:Load()
    cowman.Speed = 1
    cowman.Sprint = 2
    cowman.Walk = 1
    cowman.JumpHeight = 4
    cowman.Gravity = 0.2
    cowman.OnGround = false

    cowman.Position = {["X"] = 64, ["Y"] = 64}
    cowman.Velocity = {["X"] = 0, ["Y"] = 0}
    cowman.Texture = love.graphics.newImage("Assets/cowman.png")
    cowman.Quad = love.graphics.newQuad(0,0,16,16,cowman.Texture:getWidth(),cowman.Texture:getHeight())
end

function cowman:Update()
    cowman.Velocity.X = 0;
    if love.keyboard.isDown("a") then
        cowman.Velocity.X = cowman.Velocity.X - cowman.Speed
    end
    if love.keyboard.isDown("d") then
        cowman.Velocity.X = cowman.Velocity.X + cowman.Speed
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

    cowman.Position.X = cowman.Position.X + cowman.Velocity.X
    cowman.Position.Y = cowman.Position.Y + cowman.Velocity.Y

    cowman.OnGround = false
    if cowman.Position.Y > 200 then
        cowman.Position.Y = 200
        cowman.Velocity.Y = 0
        cowman.OnGround = true
    end
end

function cowman:Draw()
    love.graphics.draw(cowman.Texture, cowman.Quad, cowman.Position.X, cowman.Position.Y)
end

return cowman
