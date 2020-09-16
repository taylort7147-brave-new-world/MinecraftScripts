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
        table.insert(stepsTaken, {
            step = "forward",
            heading = heading
        })
        AdjustCoordinate()
    end
    return moved
end

function Backward()
    local moved = turtle.back()
    if (moved) then
        table.insert(stepsTaken, {
            step = "backward",
            heading = heading
        })
        AdjustCoordinate()
    end
    return moved
end

function AdjustCoordinate()
    local lastStep = stepsTaken[#stepsTaken]
    local multipiler = 1
    if (lastStep["step"] == "backward") then
        multiplier = -1
    end

    local magnitude = multipiler * lastStep["heading"]
    print(magnitude)
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
end

function Refuel()
    for i = 1, 16, 1 do
        local currentFuel = turtle.getFuelLevel()
        if (currentFuel > 0) then
            return
        end
        turtle.refuel(i)
    end
    print("No fuel in inventory.")
end

function WalkToWall()
    while (true) do
        Refuel()
        if (not Forward()) then
            return
        end
        print(x, y, z)
    end
end

function Dig()
    while (true) do
        if (not turtle.dig()) then
            turtle.digDown()
            turtle.digUp()
            break
        end
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

print(#stepsTaken)
for i = 1, #stepsTaken, 1 do
    print(x, y, z)
    Forward()
    Dig()
end

Left()
Left()
