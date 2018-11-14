local system = tiny.processingSystem()

system.filter = tiny.requireAll('velocity')


local ok_radius = 100
local flee_radius = 50
local time_to_target = 0.25


function system:process(e)
   -- TODO: add walls avoiding code
    local targets = world.physics:queryRect(
       e.transform.position.x - 50, e.transform.position.y - 50,
       100, 100,
       function(i) return i ~= e end)
    local nv = {x=0, y=0}
    for i=1, #targets do
       local t = targets[i]
       if t.transform then
          local dir = vector_diff(
             e.transform.position,
             t.transform.position)
          local dist = vector_len(dir)
          if dist < 20 then
             local strength = math.min(0.5 * dist * dist, e.speed)
             nv = vector_mul(vector_norm(vector_sum(nv, dir)), strength)
          end
          world:notifyChange(e)
       end
    end
    e.velocity = vector_sum(e.velocity, nv)
end

return system
