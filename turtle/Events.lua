require("Event")

Moved = Event:new("Moved")
Rotated = Event:new("Rotated")
BlockInspected = Event:new("BlockInspected")

ItemSelected = Event:new("ItemSelected")
ItemDropped = Event:new("ItemDropped")
ItemPickedUp = Event:new("ItemPickedUp")

return {
    Moved = Moved,
    Rotated = Rotated,
    BlockInspected = BlockInspected,
    ItemSelected = ItemSelected,
    ItemDropped = ItemDropped,
    ItemPickedUp = ItemPickedUp
}
