require("turtle/Events")
Movement = {}
function Movement:new()
    o = {}
    setmetatable(o, self)
    self.__index = self

    self.stepsTaken = {}
    self.x = 0
    self.y = 0
    self.z = 0
    self.heading = 1

    return o
end

function Movement:Left()
    turtle.turnLeft()
    self.heading = self.heading - 1
    if self.heading < 1 then
        self.heading = self.heading + 4
    end
    Rotated:raise(self, self.heading)
    return self.heading
end

function Movement:Right()
    turtle.turnRight()
    self.heading = self.heading + 1
    if self.heading > 4 then
        self.heading = self.heading - 4
    end
    Rotated:raise(self, self.heading)
    return self.heading
end

function Movement:Forward()
    local moved = turtle.forward()
    if (moved) then
        local step = {
            step = "forward",
            heading = self.heading
        }
        table.insert(self.stepsTaken, step)
        self:__adjustCoordinateXY()
    end
    return moved
end

function Movement:Backward()
    local moved = turtle.back()
    if (moved) then
        local step = {
            step = "backward",
            heading = heading
        }
        table.insert(self.stepsTaken, step)
        self:__adjustCoordinateXY()
    end
    return moved
end

function Movement:Up()
    local moved = turtle.up()
    if (moved) then
        local step = {
            step = "up",
            heading = heading
        }
        table.insert(self.stepsTaken, step)
        self.z = self.z + 1
        Moved(self, step)
    end
    return moved
end

function Movement:Down()
    local moved = turtle.down()
    if (moved) then
        local step = {
            step = "down",
            heading = heading
        }
        table.insert(self.stepsTaken, step)
        self.z = self.z - 1
        Moved(self, step)
    end
    return moved
end

function Movement:__adjustCoordinateXY()
    local lastStep = self.stepsTaken[#self.stepsTaken]
    local magnitude = 1
    if (lastStep["step"] == "backward") then
        magnitude = -1
    end

    if (lastStep["heading"] == 1) then
        self.x = self.x + magnitude
    end
    if (lastStep["heading"] == 3) then
        self.x = self.x - magnitude
    end
    if (lastStep["heading"] == 4) then
        self.y = self.y + magnitude
    end
    if (lastStep["heading"] == 2) then
        self.y = self.y - magnitude
    end
    Moved:raise(self, lastStep)
end

Moved:subscribe(function(movement, step) 
    local magnitude = 1
    if (step.step == "backward") then
        magnitude = -1
    end

    if (step.heading == 1) then
        movement.x = movement.x + magnitude
    end
    if (step.heading == 3) then
        movement.x = movement.x - magnitude
    end
    if (step.heading == 4) then
        movement.y = movement.y + magnitude
    end
    if (step.heading == 2) then
        movement.y = movement.y - magnitude
    end
end)

Moved:subscribe(function(movement, step) 
    for i = 1, 16, 1 do
        local currentFuel = turtle.getFuelLevel()
        if (currentFuel > 0) then
            return
        end
        local item = turtle.getItemDetail(i)
        if (item) then
            turtle.select(i)
            turtle.refuel(i)
        end
    end
    print("No fuel in inventory.")
end)

return {
    Movement = Movement
}