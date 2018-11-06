local system = tiny.processingSystem()


system.filter = tiny.requireAll('granary')
system.isDrawSystem = true

function system:process(e, dt)
    love.graphics.setColor(155,0,155)
    local x,y = e.transform.position.x+5,e.transform.position.y-15
    love.graphics.print("EAT: "..math.floor(e.granary.current), x, y)
    love.graphics.setColor(255,255,255)
end

return system
