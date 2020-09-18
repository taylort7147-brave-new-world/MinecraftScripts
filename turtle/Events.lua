require("Event")

Moved = Event:new("Moved")
Rotated = Event:new("Rotated")
BlockInspected = Event:new("BlockInspected")

ItemSelected = Event:new("ItemSelected")
ItemDropped = Event:new("ItemDropped")
ItemPickedUp = Event:new("ItemPickedUp")

InventoryChanged = Event:new("InventoryChanged")

function listenForEvent(functionTbl)
    while true do
        tbl = {os.pullEvent()}
        if type(functionTbl[tbl[1]]) == "function" then
            functionTbl[tbl[1]](select(2, unpack(tbl)))
        end
    end
end

listenForEvent({
    turtle_inventory = function(stuff, stuff2, stuff3)
        print(stuff, stuff2, stuff3)
        InventoryChanged:raise(turtle, null)
    end
})

return {
    Moved = Moved,
    Rotated = Rotated,
    BlockInspected = BlockInspected,

    ItemSelected = ItemSelected,
    ItemDropped = ItemDropped,
    ItemPickedUp = ItemPickedUp,

    InventoryChanged = InventoryChanged
}
