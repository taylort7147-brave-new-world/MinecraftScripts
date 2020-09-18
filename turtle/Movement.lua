package.path = package.path .. ";../../../?.lua"
package.path = package.path .. ";../../?.lua"
package.path = package.path .. ";../?.lua"

local inspect = require("inspect")

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
    -- Rotated:raise(self, self.heading)
    return self.heading
end

function Movement:Right()
    turtle.turnRight()
    self.heading = self.heading + 1
    if self.heading > 4 then
        self.heading = self.heading - 4
    end
    -- Rotated:raise(self, self.heading)
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
            heading = self.heading
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

function Movement:BackToStart()
    local steps = {table.unpack(self.stepsTaken)}
    for i = #steps, 1, -1 do
        local step = steps[i]
        local stepHeading = step["heading"]
        print('need to move the opposite of ', step.step, step.heading)
        while not self.heading == stepHeading do
            self:Left()
        end

        if (step.step == "backward") then
            self:Forward()
        end

        if (step.step == "forward") then
            self:Backward()
        end

        if (step.step == "up") then
            self:Down()
        end

        if (step.step == "down") then
            self:Up()
        end
    end
end

Moved:subscribe(function(movement, lastStep)
    print(inspect(movement), inspect(lastStep))
    local magnitude = 1
    if (not lastStep or not lastStep["step"]) then
        return
    end
    if (lastStep["step"] == "backward") then
        magnitude = magnitude * -1
    end

    if (lastStep["heading"] == 1) then
        movement.x = movement.x + magnitude
    end
    if (lastStep["heading"] == 3) then
        movement.x = movement.x - magnitude
    end
    if (lastStep["heading"] == 4) then
        movement.y = movement.y + magnitude
    end
    if (lastStep["heading"] == 2) then
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
