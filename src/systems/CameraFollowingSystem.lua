local system = tiny.processingSystem()

system.filter = tiny.requireAll('followingCamera', 'transform')

function system:process(e, dt)
   local targetX, targetY = e.transform.position.x, e.transform.position.y
   if targetX and targetY then CAM:setPosition(targetX, targetY) end
end

return system
