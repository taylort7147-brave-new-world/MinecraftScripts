Inventory = {}

function Inventory:new()
    o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Inventory:SelectByName(itemName)
end

return {
    Inventory = Inventory
}
