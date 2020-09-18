require("Event")

Moved = Event:new("Moved")
MoveFailed = Event:new("MoveFailed")
Rotated = Event:new("Rotated")

BlockInspected = Event:new("BlockInspected")

ItemSelected = Event:new("ItemSelected")
ItemDropped = Event:new("ItemDropped")
ItemPickedUp = Event:new("ItemPickedUp")

InventoryChanged = Event:new("InventoryChanged")

return {
    Moved = Moved,
    MoveFailed = MoveFailed,
    Rotated = Rotated,
    BlockInspected = BlockInspected,

    ItemSelected = ItemSelected,
    ItemDropped = ItemDropped,
    ItemPickedUp = ItemPickedUp,

    InventoryChanged = InventoryChanged
}
