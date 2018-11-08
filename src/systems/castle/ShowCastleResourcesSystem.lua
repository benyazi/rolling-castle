local system = tiny.processingSystem()


system.filter = tiny.requireAll('castle')
system.isDrawSystem = true

function system:process(e, dt)
    local eat = e.resources.eat.current
    local prayers = e.resources.prayers.current
    love.graphics.setColor(1,0,0)
    local x,y = e.transform.position.x+170, e.transform.position.y
    love.graphics.print("Eat: "..math.floor(eat)..", Recruites: "..math.floor(prayers), x, y)
    love.graphics.setColor(255,255,255)
end

return system
