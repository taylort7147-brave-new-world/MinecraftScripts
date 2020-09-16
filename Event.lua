Event = {}
function Event:new(name)
    o = {}
    setmetatable(o, self)
    self.__index = self

    self.type = name
    self.__subscribers = {}
    return o
end

function Event:subscribe(handler)
    table.insert(self.__subscribers, handler)
    return #self.__subscribers
end

function Event:unsubscribe(index)
    table.remove(self.__subscribers, index)
    return #self.__subscribers
end

function Event:raise(caller, data)
    for _, v in pairs(self.__subscribers) do
        v(caller, data)
    end
end

return {
    Event = Event
}
