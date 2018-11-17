local system = tiny.processingSystem()

system.filter = tiny.requireAll('velocity')

function system:process(e)
   local vel = e.velocity

   if vel.x == 0 and vel.y == 0 then
      e.state = STATE.IDLE
   else
      e.state = STATE.MOVING
   end

   local new_x = e.transform.position.x + vel.x
   local new_y = e.transform.position.y + vel.y
   if e.hasCollider ~= nil and e.checkCollision ~= nil then
      local act_x, act_y, cols, len = world.physics:move(
         e, new_x, new_y,
         function(me, other)
            if other.hasCollider ~= nil and other.checkCollision ~= nil then return 'slide' end
            return 'cross'
        end)
        e.transform.position.x = act_x
        e.transform.position.y = act_y
    else
        e.transform.position.x = new_x
        e.transform.position.y = new_y
    end
    world:notifyChange(e)
end

return system
