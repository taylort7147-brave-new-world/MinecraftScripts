-- v5
package.path = package.path .. ";../?.lua"
require("turtle/Inventory")
require("turtle/Movement")
require("turtle/Events")
local inspect = require("inspect")

function listenForEvent(functionTbl)
    while true do
        tbl = {os.pullEvent()}
        if type(functionTbl[tbl[1]]) == "function" then
            functionTbl[tbl[1]](select(2, unpack(tbl)))
        end
    end
end

function watchOsEvents()

    listenForEvent({
        turtle_inventory = function()
            InventoryChanged:raise(turtle, null)
        end
    })
end

function handleFailedMove(movement, failedStep)
    if (failedStep.step == "forward") then
        digAll()
        movement:Forward()
        digAll()
    end
    if (failedStep.step == "up") then
        digAll()
        movement:Up()
        digAll()
    end
    if (failedStep.step == "down") then
        digAll()
        movement:Down()
        digAll()
    end
    if (failedStep.step == "backward") then
        movement:Right()
        movement:Right()
        digAll()
        movement:Left()
        movement:Left()
        movement:Backward()
        digAll()
    end
end

function handleMove()
    digAll()
end

function handleInventoryChange()
    print("handling inventory changed")
    for i = 0, 16, 1 do
        inventory:DropLowestPriorityItem()
    end
end

function main()
    print("starting up")
    local movement = Movement:new()
    local inventory = Inventory:new({
        ['iron'] = 100,
        ['diamond'] = 100,
        ['coal'] = 100,
        ['uranium'] = 100,
        ['emerald'] = 100
    })
    function digAll()
        while turtle.dig() do
            turtle.digUp()
            turtle.digDown()
        end
    end

    Moved:subscribe(handleMove)
    MoveFailed:subscribe(handleFailedMove)
    InventoryChanged:subscribe(handleInventoryChange)

    for _ = 0, 5, 1 do
        movement = Movement:new()
        for i = 0, 10, 1 do
            if (not movement:Forward()) then
                digAll()
            end
        end
        movement:BackToStart()
        movement:Right()
        movement:Forward()
        movement:Left()
    end
end

parallel.waitForAny(watchOsEvents, main)
