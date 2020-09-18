globalTurtle = turtle
turtle = globalTurtle or {}
math.randomseed(os.time())

function randomChoice(choices)
    choices = choices or {true, false}
    local index = math.random(#choices)
    print(index)
    return choices[index]
end

function turtle:forward()
    local success = globalTurtle and globalTurtle.forward() or randomChoice()
    return success
end

function turtle:back()
    if (globalTurtle) then
        return lobalTurtle.back()
    else
        return randomChoice()
    end
end

function turtle:turnLeft()
    if(globalTurtle) then
        return globalTurtle.turnLeft()
    end
    return nil
end

function turtle:turnRight()
    return globalTurtle and globalTurtle.turnRight() or nil
end

function turtle:up()
    if (globalTurtle) then
        return globalTurtle.up()
    else
        return randomChoice()
    end
end

function turtle:down()
    local success = globalTurtle and globalTurtle.down() or randomChoice()
    return success
end

function turtle:getItemDetail(index)
end




