-- v5
package.path = package.path .. ";../?.lua"
require("turtle/Inventory")
require("turtle/Movement")
require("turtle/Events")

local inventory = Inventory:new()
local movement = Movement:new()

for i = 0, 200, 1 do
    movement:Forward()
    print(movement.x, movement.y, movement.z, movement.heading)
    movement:BackWard()
    print(movement.x, movement.y, movement.z, movement.heading)
end
