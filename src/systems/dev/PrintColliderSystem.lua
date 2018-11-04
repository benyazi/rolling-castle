local system = tiny.processingSystem()


system.filter = tiny.requireAll('hasCollider','pos')
system.isDrawSystem = true

function system:process(e, dt)
  love.graphics.setColor(0,255,0)
  local x, y = e.pos.x, e.pos.y
  local w,h = 0,0
  if e.size then
    w,h = e.size.w,e.size.h
  end
  if e.size and e.size.offset then
    if e.size.offset.x then
     x = x + e.size.offset.x
    end
    if e.size.offset.y then
     y = y + e.size.offset.y
    end
  end
  if e.collider then
    x = x - e.collider.w/2
    y = y - e.collider.h
    w,h = e.collider.w,e.collider.h
  end
  love.graphics.rectangle("line",x,y,w,h)
  love.graphics.setColor(255,255,255)
end

return system
