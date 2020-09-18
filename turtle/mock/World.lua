package.path = package.path .. ";../../../?.lua"
package.path = package.path .. ";../../?.lua"
package.path = package.path .. ";../?.lua"

local inspect = require("inspect")
local e = require("turtle.Events")

math.randomseed(os.time())
World = {}
Blocks = {{
    chance = 5,
    block = {
        name = "minecraft:stone"
    }
}, {
    block = nil,
    chance = 5
}, {
    block = {
        name = "minecraft:gold_ore"
    },
    chance = 5
}, {
    block = {
        name = "minecraft:copper_ore"
    },
    chance = 5
}, {
    block = {
        name = "minecraft:silver_ore"
    },
    chance = 5
}, {
    block = {
        name = "minecraft:coal"
    },
    chance = 5
}, {
    block = {
        name = "minecraft:wall_torch"
    },
    chance = 5
}, {
    block = {
        name = "minecraft:cobblestone"
    },
    chance = 100
}}

function World:new()
    o = {}
    setmetatable(o, self)
    self.__index = self
end

function generateWorld(length, width, height)
    local blocks = {}
    for i = 0, height, 1 do
        blocks[i] = {}
        for j = 0, width, 1 do
            blocks[i][j] = {}
            for k = 0, length, 1 do
                blocks[i][j][k] = getBlock()
            end
        end
    end

    return blocks
end

function getBlock()
    for _, value in pairs(Blocks) do
        local spawn = math.random(0, 100)
        if (spawn <= value.chance) then
            return value.block
        end
    end
end

local w = generateWorld(10, 10, 10)

for _, slice in pairs(w) do
    for _, row in pairs(slice) do
        for _, block in pairs(row) do
            print(block.name)
        end
    end
end
print(inspect(w[0][1]))
print(w[8][8][9])
