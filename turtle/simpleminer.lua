-- version 0.3
local Utils = {}

local usefulBlocks = {
    ["minecraft:lava"] = "minecraft:lava"
}

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
    ExamineBlocks()
    return heading
end

function Right()
    turtle.turnRight()
    heading = heading + 1
    if heading > 4 then
        heading = heading - 4
    end
    ExamineBlocks()
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
        ExamineBlocks()
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
        ExamineBlocks()
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
        ExamineBlocks()
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
        ExamineBlocks()
    end
    return moved
end

function AdjustCoordinateXY()
    local lastStep = stepsTaken[#stepsTaken]
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
end

function SelectItem(name)
    print("trying to select", name)
    name = string.gsub(name, "%s+", "")
    for i = 1, 16, 1 do
        local item = turtle.getItemDetail(i)
        if (item and item.name) then
            if (string.gsub(item.name, "%s+", "") == name) then
                turtle.select(i)
                return true
            end
        end
    end
    print("failed to select ", name)
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

function HandleUsefulBlock(blockName)
    print("Handing useful block ", blockName)
    if (blockName == "minecraft:lava") then
        if (not SelectItem("minecraft:bucket")) then
            print("no empty bucket for lava :(")
            return
        end
        turtle.place()
        turtle.placeUp()
        turtle.placeDown()
    end
end

function ExamineBlocks()
    function useBlock(block)
        if (block and block.name) then
            local blockName = string.gsub(block.name, "%s+", "")
            print("checking if ", blockName, " is useful")
            if (usefulBlocks[blockName]) then
                print("Looks like it is!")
                HandleUsefulBlock(blockName)
            end
        end
    end

    local _, frontBlock = turtle.inspect()
    local _, upBlock = turtle.inspectUp()
    local _, downBlock = turtle.inspectDown()

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
    Forward()
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
