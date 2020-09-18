package.path = package.path .. ";../../../?.lua"
package.path = package.path .. ";../../?.lua"
package.path = package.path .. ";../?.lua"

local inspect = require("inspect")

require("turtle/Events")
Mine = {}
function Mine:new()
    o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Mine:Dig()
    if (turtle.dig()) then
    end
end

function Mine:DigAll()
end

return {
    Mine = Mine
}
