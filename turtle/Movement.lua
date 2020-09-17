require("turtle/Events")

Movement = {}
function Movement:new()
    o = {}
    setmetatable(o, self)
    self.__index = self

    self.stepsTake = {}
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
        Moved:raise(self, step)
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
        Moved:raise(self, step)
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
        Moved:raise(self, step)
        self.z = self.z + 1
    end
    return moved
end

function Movement:Down()
    local moved = turtle.down()
    if (moved) then
        local self = {
            step = "down",
            heading = heading
        }
        table.insert(self.stepsTaken, self)
        Moved:raise(self, step)
        self.z = self.z - 1
    end
    return moved
end

Moved:subscribe(function(movement, step) 
    print("moved!")
    local lastStep = movement.stepsTaken[#movement.stepsTaken]
    local magnitude = 1
    if (lastStep["step"] == "backward") then
        magnitude = -1
    end

    if (lastStep["heading"] == 1) then
        x = x + magnitude
    end
    if (lastStep["heading"] == 3) then
        x = x - magnitude
    end
    if (lastStep["heading"] == 4) then
        y = y + magnitude
    end
    if (lastStep["heading"] == 2) then
        y = y - magnitude
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