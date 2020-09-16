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
    local success = globalTurtle and globalTurtle.back() or randomChoice()
    return success
end

function turtle:turnLeft()
    return globalTurtle and globalTurtle.turnLeft() or nil
end

function turtle:turnRight()
    return globalTurtle and globalTurtle.turnRight() or nil
end

function turtle:up()
    local success = globalTurtle and globalTurtle.up() or randomChoice()
    return success
end

function turtle:down()
    local success = globalTurtle and globalTurtle.down() or randomChoice()
    return success
end
