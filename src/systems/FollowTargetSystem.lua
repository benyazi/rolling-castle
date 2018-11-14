local system = tiny.processingSystem()

system.filter = tiny.requireAll('target')



local ok_radius = 100
local flee_radius = 50
local time_to_target = 0.25


function system:process(e)
   local t = e.target.transform.position
   local velocity = vector_diff(
      e.target.transform.position,
      e.transform.position)
   if vector_len(velocity) <= flee_radius then
      velocity = vector_diff(
         e.transform.position,
         e.target.transform.position)
   elseif vector_len(velocity) >= ok_radius then
      velocity = vector_div(velocity, time_to_target)
   else
      velocity = {x = 0, y = 0}
   end
   if vector_len(velocity) > e.speed then
      velocity = vector_mul(vector_norm(velocity), e.speed)
   end
   e.velocity = velocity
   world:notifyChange(e)
end

return system
