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
    local currentlyRunning = false;
    table.insert(self.__subscribers, function(context, data, publisher)
        if (currentlyRunning) then
            return
        end
        currentlyRunning = true
        handler(context, data, publisher)
        currentlyRunning = false
    end)
    return #self.__subscribers
end

function Event:unsubscribe(index)
    table.remove(self.__subscribers, index)
    return #self.__subscribers
end

function Event:raise(context, data, publisher)
    for _, v in pairs(self.__subscribers) do
        v(context, data, publisher)
    end
end

return {
    Event = Event
}
