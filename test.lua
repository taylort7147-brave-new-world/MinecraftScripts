require("Event")

local e = Event:new("test")
e:subscribe(function(type, data)
    print("got some data", type, data)
end)

e:raise('tested', 'hi')