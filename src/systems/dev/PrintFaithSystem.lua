local system = tiny.processingSystem()


system.filter = tiny.requireAll('GoldenTaurus','faithState','Faith', 'isVisible')
system.isDrawSystem = true

function system:process(e, dt)
    love.graphics.setColor(255,255,0)
    local x,y = e.transform.position.x+5,e.transform.position.y-15
    love.graphics.print(math.floor(e.Faith.current).."/"..math.floor(e.Faith.calculateMax), x, y)
    love.graphics.setColor(255,255,255)
end

return system
