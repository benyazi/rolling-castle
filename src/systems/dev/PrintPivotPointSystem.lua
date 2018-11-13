local system = tiny.processingSystem()


system.filter = tiny.requireAll('pivot', 'isVisible')
system.isDrawSystem = true

function system:process(e, dt)
   love.graphics.setColor(255,0,0)
   love.graphics.rectangle("fill",e.pivot.x,e.pivot.y,2,2)
   love.graphics.setColor(255,255,255)
end

return system
