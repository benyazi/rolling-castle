local system = tiny.processingSystem()


system.filter = tiny.requireAll('log')
system.isDrawSystem = true


function system:process(e, dt)
   local x1, y1, x2, y2, x3, y3, x4, y4 = CAM:getVisibleCorners()
   local x, y = x1 + 20, y1 + 100
   for i=1, #e.log do
      print(("log %d %d %s"):format(x, y, e.log[i]))
      love.graphics.print(e.log[i], x, y)
      y = y + 20
   end
   e.log = {}
end

return system
