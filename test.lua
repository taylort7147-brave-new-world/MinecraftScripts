local Utils = {}

local stepsTaken = {}
function Refuel()
    print("Trying to refuel.")
    for i = 1, 16, 1 do
        local currentFuel = turtle.getFuelLevel()
        if (currentFuel > 0) then
            print("Have fuel.")
            return
        end
        turtle.refuel(i)
    end
    print("No fuel in inventory.")
end

function WalkToWall()
    while (true) do
        Refuel()
        if (not turtle.forward()) then
            print("Cannot move.")
            return
        end
        stepsTaken.insert("forward")
    end
end

WalkToWall()
