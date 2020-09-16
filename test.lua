local Utils = {}

local heading = 1
local x = 0
local y = 0
local z = 0

local stepsTaken = {}

function Left()
    turtle.turnLeft()
    heading = heading - 1
    if heading < 1 then
        heading = heading + 4
    end
    return heading
end

function Right()
    turtle.turnRight()
    heading = heading + 1
    if heading > 4 then
        heading = heading - 4
    end
    return heading
end

function Forward()
    local moved = turtle.forward()
    if (moved) then
        stepsTaken.insert({
            step = "forward",
            heading = heading
        })
        AdjustCoordinate()
    end
end

function Backward()
    local moved = turtle.back()
    if (moved) then
        stepsTaken.insert({
            step = "backward",
            heading = heading
        })
        AdjustCoordinate()
    end
end

function AdjustCoordinate()
    local lastStep = stepsTaken[#stepsTaken]
    local multipiler = 1
    if (lastStep.step == "backward") then
        multiplier = -1
    end

    local magnitude = multipiler * lastStep.heading
    if(lastStep.heading == 1) then x = x + magnitude end
    if(lastStep.heading == 3) then x = x - magnitude end
    if(lastStep.heading == 4) then y = y + magnitude end
    if(lastStep.heading == 2) then y = y - magnitude end
end
function Refuel()
    print("Trying to refuel.")
    for i = 1, 16, 1 do
        local currentFuel = turtle.getFuelLevel()
        if (currentFuel > 0) then
            print("Have fuel.")
            return
        end
        turtle.refuel(i)
    end
    print("No fuel in inventory.")
end

function WalkToWall()
    while (true) do
        Refuel()
        if (not turtle.forward()) then
            print("Cannot move.")
            return
        end
    end
end

function Dig()
    while (turtle.dig()) do
        print(turtle.inspect())
    end
end

function DigNByK(n, k)
    for i = 0, n, 1 do
        for j = 0, k, 1 do
        end
    end
end

for i = 1, 16, 1 do
    WalkToWall()
    Dig()
end

Right()
Right()

for i = 1, 16, 1 do
    WalkToWall()
    Dig()
end

Left()
Left()

print(x, y, z)
for k, v in pairs(stepsTaken) do
    print(k, v[1], v[2])
end
