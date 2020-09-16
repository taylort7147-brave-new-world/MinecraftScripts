require("Event")

Moved = Event:new("Moved")
Rotated = Event:new("Rotated")
BlockInspected = Event:new("BlockInspected")
ItemSelected = Event:new("ItemSelected")

return {
    Moved = Moved,
    Rotated = Rotated,
    BlockInspected = BlockInspected,
    ItemSelected = ItemSelected
}
