-- v1
package.path = package.path .. ";../?.lua"
require("turtle/Inventory")
require("turtle/Events")
local inspect = require('inspect')
ItemSelected:subscribe(function(sender, data)
    print('item was selected!!!', inspect(data), sender)
end)

local inventory = Inventory:new()
local items = inventory:GetItems()
print(inspect (inventory))
print(inspect (items))
inventory:SelectByName("bucket")