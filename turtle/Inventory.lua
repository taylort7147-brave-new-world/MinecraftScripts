require("turtle/Events")
Inventory = {}

local itemPriority = {
    ['minecraft:bucket'] = 100,
    ['minecraft:diamond'] = 100
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

function Inventory:GetIndexByName(itemName)
    if (not itemName) then
        return nil
    end
    for i, v in pairs(self:GetItems()) do
        if (v.name:match(itemName)) then
            turtle.select(i)
            ItemSelected:raise(self, v)
            return i
        end
    end
end

function Inventory:SelectByName(itemName)
    if (not itemName) then
        return nil
    end
    for i, v in pairs(self:GetItems()) do
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

    for i, v in pairs(self:GetItems()) do
        if (i == index) then
            turtle.select(i)
            ItemSelected:raise(self, v)
            return v
        end
    end
end

function Inventory:DropSlot(slot, amount)
    print("dropping ", slot)
    if (not slot) then
        return nil
    end
    local selectedItem = self:SelectByIndex(slot)
    if (selectedItem) then
        turtle.drop(amount)
    end
    return selectedItem
end

function Inventory:ChangeSlot(fromIndex, toIndex)
    if (not fromIndex or not toIndex) then
        return nil
    end
    self:SelectByIndex(fromIndex)
    turtle.transferTo(toIndex)
end

function Inventory:DropAllOf(name)
    if (not name) then
        return
    end
    for i, v in pairs(self:GetItems()) do
        if (v.name:match(name)) then
            self:DropSlot(i)
        end
    end
end

function Inventory:DropLowestPriorityItem()
    local lowestPriority
    for i, v in pairs(self:GetItems()) do
        if (not lowestPriority or v.priority < lowestPriority.priority and v.priority < 100) then
            lowestPriority = v
        end
    end
    print(lowestPriority.name)
    self:DropAllOf(lowestPriority.name)
    print("dropped ", lowestPriority.name, " to save space")
end

function Inventory:GetEmptySlots()
    local emptySlots = {}
    for i = 1, 16, 1 do
        if (not turtle.getItemDetail(i)) then
            emptySlots[i] = i
        end
    end
    return emptySlots
end

return {
    Inventory = Inventory
}
