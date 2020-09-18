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
    if (self.__subscribers[handler]) then
        print("already registered this handler")
        return
    end

    local currentlyRunning = false;
    self.__subscribers[handler] = function(context, data)
        if (currentlyRunning) then
            return
        end
        currentlyRunning = true
        handler(context, data)
        currentlyRunning = false
    end
    return #self.__subscribers
end

function Event:unsubscribe(handler)
    table.remove(self.__subscribers, handler)
    return #self.__subscribers
end

function Event:raise(context, data)
    print(self.type, " was triggered", context, data)
    if (not self.__subscribers or #self.__subscribers < 1) then
        return
    end
    for _, v in pairs(self.__subscribers) do
        v(context, data)
    end
end

return {
    Event = Event
}
