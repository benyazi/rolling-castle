local system = tiny.processingSystem()


system.filter = tiny.requireAll('eat')
system.isDrawSystem = true

function system:process(e, dt)
    love.graphics.setColor(255,155,0)
    local x,y = e.transform.position.x+5,e.transform.position.y-20
    love.graphics.print(math.floor(e.eat.current).."/"..math.floor(e.eat.calculateMax), x, y)
    love.graphics.setColor(255,255,255)
end

return system
