globalTurtle = turtle
turtle = globalTurtle or {}
math.randomseed(os.time())

function randomChoice(choices)
    local index = math.random(#choices)
    print(index)
    return choices[index]
end

function turtle:forward()
    if (globalTurtle) then
        return globalTurtle.forward()
    end
    return randomChoice({true, false})
end

function turtle:back()
    if (globalTurtle) then
        return globalTurtle.back()
    end
    return randomChoice({true, false})
end

function turtle:turnLeft()
    if (globalTurtle) then
        return globalTurtle.turnLeft()
    end
    return randomChoice({true, false})
end

function turtle:turnRight()
    if (globalTurtle) then
        return globalTurtle.turnRight()
    end
    return randomChoice({true, false})
end
