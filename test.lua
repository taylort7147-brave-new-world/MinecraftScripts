local Utils = {}

local usefulBlocks = {'Lava'}

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
        AdjustCoordinateXY()
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
        AdjustCoordinateXY()
    end
    return moved
end

function Up()
    local moved = turtle.up()
    if (moved) then
        table.insert(stepsTaken, {
            step = "up",
            heading = heading
        })
        z = z + 1
    end
    return moved
end

function Down()
    local moved = turtle.down()
    if (moved) then
        table.insert(stepsTaken, {
            step = "down",
            heading = heading
        })
        z = z - 1
    end
    return moved
end

function AdjustCoordinateXY()
    local lastStep = stepsTaken[#stepsTaken]
    local magnitude = 1
    if (lastStep["step"] == "backward") then
        magnitude = -1
    end

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

function SelectItem(name)
    for i = 1, 16, 1 do
        local item = turtle.getItemDetail(i)
        if (item and item.name == name) then
            turtle.select(i)
            return true
        end
    end
    return false
end

function Refuel()
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
end

function HandleUsefulBlock(block)
    if (not block or not usefulBlocks[block.name]) then
        return
    end

    print("Handing useful block ", block.name)
    if (block.name == "Lava") then
        if (not SelectItem("Bucket")) then
            print("no empty bucket for laval :(")
            return
        end
        turtle.place()
        turtle.placeUp()
        turtle.placeDown()
    end
end

function ExamineBlocks()
    function useBlock(block)
        if (block) then
            print("checking if ", block.name, " is useful")
            if (usefulBlocks[block.name]) then
                HandleUsefulBlock(block)
            end
        end
    end

    local frontBlock = turtle.inspect()
    local upBlock = turtle.inspectUp()
    local downBlock = turtle.inspectDown()

    useBlock(frontBlock)
    useBlock(upBlock)
    useBlock(downBlock)
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
