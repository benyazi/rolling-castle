local system = tiny.processingSystem()


system.filter = tiny.requireAll('transform', 'keyboardControlled', 'speed')

system.dirs = {}
system.dirs[DIR.UP] = false
system.dirs[DIR.DOWN] = false
system.dirs[DIR.LEFT] = false
system.dirs[DIR.RIGHT] = false
system.isRun = 0

system.events = {}

function system:process(e)
   local old_x, old_y = e.transform.position.x, e.transform.position.y
   local new_x, new_y = e.transform.position.x, e.transform.position.y
   local speed = e.speed + (system.isRun * 0.5)
   if system.dirs[DIR.UP] then
      new_y = new_y - speed
      e.dir = DIR.UP
   end
   if system.dirs[DIR.DOWN] then
      new_y = new_y + speed
      e.dir = DIR.DOWN
   end
   if system.dirs[DIR.LEFT] then
      new_x = new_x - speed
      e.dir = DIR.LEFT
   end
   if system.dirs[DIR.RIGHT] then
      new_x = new_x + speed
      e.dir = DIR.RIGHT
   end

   if new_x ~= old_x or new_y ~= old_y then
      e.state = STATE.MOVING
      if e.hasCollider ~= nil and e.checkCollision ~= nil then
        local new_col_x,new_col_y = new_x,new_y
        if e.collider then
          new_col_x,new_col_y = new_x-e.collider.w/2+e.collider.offset.x,new_y-e.collider.h+e.collider.offset.y
        end
        local act_x, act_y, cols, len = world.physics:move(
           e, new_col_x, new_col_y,
           function(me, other)
              if other.hasCollider ~= nil and other.checkCollision ~= nil then return 'slide' end
              return 'cross'
        end)
        if e.collider then
          act_x,act_y = act_x+e.collider.w/2-e.collider.offset.x,act_y+e.collider.h-e.collider.offset.y
        end
        e.transform.position.x = act_x
        e.transform.position.y = act_y
      else
        e.transform.position.x = new_x
        e.transform.position.y = new_y
      end
      if e.owner then
        local owner = e.owner
        owner.pos.x = e.pos.x
        owner.pos.y = e.pos.y
        world:notifyChange(owner)
      end
      world:notifyChange(e)
   else
      e.state = STATE.IDLE
   end
end

function system:onAddToWorld(world)
  system.events[#system.events + 1] = beholder.observe('MOVING_UP_PRESSED', function() system.dirs[DIR.UP] = true end)
  system.events[#system.events + 1] = beholder.observe('MOVING_UP_RELEASED', function() system.dirs[DIR.UP] = false end)
  system.events[#system.events + 1] = beholder.observe('MOVING_DOWN_PRESSED', function() system.dirs[DIR.DOWN] = true end)
  system.events[#system.events + 1] = beholder.observe('MOVING_DOWN_RELEASED', function() system.dirs[DIR.DOWN] = false end)
  system.events[#system.events + 1] = beholder.observe('MOVING_LEFT_PRESSED', function() system.dirs[DIR.LEFT] = true end)
  system.events[#system.events + 1] = beholder.observe('MOVING_LEFT_RELEASED', function() system.dirs[DIR.LEFT] = false end)
  system.events[#system.events + 1] = beholder.observe('MOVING_RIGHT_PRESSED', function() system.dirs[DIR.RIGHT] = true end)
  system.events[#system.events + 1] = beholder.observe('MOVING_RIGHT_RELEASED', function() system.dirs[DIR.RIGHT] = false end)
  system.events[#system.events + 1] = beholder.observe('RUN_PRESSED', function() system.isRun = 1 end)
  system.events[#system.events + 1] = beholder.observe('RUN_RELEASED', function() system.isRun = 0 end)
end


function system:onRemoveFromWorld(world)
  for i = 0, #system.events do
    beholder.stopObserving(system.events[i])
  end
end

return system
