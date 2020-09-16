require("turtle/Events")
Inventory = {}

local itemPriority = {
    ['minecraft:bucket'] = 40
}

function Inventory:new(priority)
    o = {}
    setmetatable(o, self)
    self.__index = self
    self.priority = priority or itemPriority
    return o
end

function Inventory:GetItems()
    local items = {}
    for i = 1, 16, 1 do
        local item = turtle.getItemDetail(i)
        if (item) then
            item['priority'] = self.priority[item.name] or 0
            table.insert(items, item)
        end
    end
    return items
end

function Inventory:SelectByName(itemName)
    if (not itemName) then
        return nil
    end
    for i, v in pairs(self.GetItems()) do
        if (v.name:match(itemName)) then
            turtle.select(i)
            ItemSelected:raise(self, v)
            return v
        end
    end
end

function Inventory:SelectByIndex(index)
    if (not index) then
        return nil
    end

    for i, v in pairs(self.GetItems()) do
        if (i == index) then
            turtle.select(i)
            ItemSelected:raise(self, v)
            return v
        end
    end
end

return {
    Inventory = Inventory
}
