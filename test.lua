-- v5
package.path = package.path .. ";../?.lua"
require("turtle/Inventory")
require("turtle/Movement")
require("turtle/Events")
local inspect = require('inspect')
ItemSelected:subscribe(function(sender, data)
    print('item was selected!!!', inspect(data), sender)
end)

local inventory = Inventory:new()
local movement = Movement:new()
local items = inventory:GetItems()
print(inspect(inventory))
print(inspect(items))

inventory:SelectByName("bucket")
print(inventory:ChangeSlot(1, 15))
movement:Forward()