-- v5
package.path = package.path .. ";../?.lua"
require("turtle/Inventory")
require("turtle/Movement")
require("turtle/Events")

local movement = Movement:new()

function digAll()
    while turtle.dig() do
        turtle.digUp()
        turtle.digDown()
    end
end

Moved:subscribe(function()
    digAll()
end)

InventoryChanged:subscribe(function() print("inventory changed!") end)

for _ = 0, 5, 1 do
    for i = 0, 50, 1 do
        if (not movement:Forward()) then
            digAll()
        end
    end
    movement:BackToStart()
    movement:Right()
    movement:Forward()
    movement:Left()
end
