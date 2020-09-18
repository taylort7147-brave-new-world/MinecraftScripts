-- v5
package.path = package.path .. ";../?.lua"
require("turtle/Inventory")
require("turtle/Movement")
require("turtle/Events")

local inventory = Inventory:new()
local movement = Movement:new()

function digAll()
    while turtle.dig() do
        turtle.digUp()
        turtle.digDow()
    end
end

Moved:subscribe(function()
    digAll()
end)

for i=0, 50, 1 do
    if(not movement:Forward()) then digAll() end
end

movement:BackToStart()