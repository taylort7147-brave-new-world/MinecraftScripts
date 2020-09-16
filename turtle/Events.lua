require("../Event")

Moved = Event:new("Moved")
Rotated = Event:new("Rotated")
BlockInspected = Event:new("BlockInspected")

return {
    Moved = Moved,
    Rotated = Rotated,
    BlockInspected = BlockInspected
}
