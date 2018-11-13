local system = tiny.processingSystem()


system.filter = tiny.requireAll('spriteRender', 'transform')
system.isDrawSystem = true

function system:process(e, dt)
   local pos = e.transform.position
   local correction = 32--need to think
   local x1,y1,x2,y2,x3,y3,x4,y4 = CAM:getVisibleCorners()
   if pos.x > x1-correction and pos.x < x2+correction and pos.y > y1-correction and pos.y < y4+correction then
      if e.isVisible == nil then
         e.isVisible = true
         world:notifyChange(e)
      end
   else
      if e.isVisible ~= nil then
         e.isVisible = nil
         world:notifyChange(e)
      end
   end
end


return system
