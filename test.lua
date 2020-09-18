-- v5
package.path = package.path .. ";../?.lua"
require("turtle/Inventory")
require("turtle/Movement")
require("turtle/Events")

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
        turtle_inventory = function(stuff, stuff2, stuff3)
            print(stuff, stuff2, stuff3)
            InventoryChanged:raise(turtle, null)
        end
    })
end

function main()
    local movement = Movement:new()
    local inventory = Inventory:new({
        ['iron'] = 100,
        ['diamond'] = 100,
        ['coal'] = 100,
        ['uranium'] = 100
    })
    function digAll()
        while turtle.dig() do
            turtle.digUp()
            turtle.digDown()
        end
    end

    Moved:subscribe(function()
        digAll()
    end)

    InventoryChanged:subscribe(function()
        local emptySlots = inventory:GetEmptySlots()
        if (#emptySlots == 0) then
            inventory:DropLowestPriorityItem()
        end

    end)

    for _ = 0, 5, 1 do
        movement = Movement:new()
        for i = 0, 50, 1 do
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

parallel.waitForAll(watchOsEvents, main)
