local tiny = require 'lib.tiny'

local m = {}

function m:new(physics, ...)
   local world = tiny.world(unpack({...}))
   return setmetatable({entities={}, world=world, physics=physics}, {__index=self})
end

function m:add()
   error('Please use addEntity or addSystem instead')
end

function m:addEntity(e)
   if (e.size or e.collider) and e.pos and not self.physics:hasItem(e) then
     local x, y = e.pos.x, e.pos.y
     if e.size and e.size.offset then
       if e.size.offset.x then
        x = x + e.size.offset.x
       end
       if e.size.offset.y then
        y = y + e.size.offset.y
       end
      end
      if e.collider then
        local colliderX, colliderY = (e.pos.x - e.collider.w/2 + e.collider.offset.x),(e.pos.y-e.collider.h + e.collider.offset.y)
        self.physics:add(e, colliderX, colliderY, e.collider.w, e.collider.h)
        if e.spriteDraw.anim then
          print("HERO X:"..e.pos.x.." Y:"..e.pos.y.." COL_X:"..colliderX.." COL_Y:"..colliderY.." COL_W:"..e.collider.w.." COL_H:"..e.collider.h)
        end
      else
        self.physics:add(e, x, y, e.size.w, e.size.h)
      end
   end
   self.entities[e] = e
   return self.world:addEntity(e)
end

function m:removeEntity(e)
   self.physics:remove(e)
   self.entities[e] = nil
   return self.world:removeEntity(e)
end

function m:removeSystem(s)
   return self.world:removeSystem(s)
end

function m:addSystem(s)
   return self.world:addSystem(s)
end

function m:notifyChange(e)
   require('src.systems.SpriteSystem').modified = true
   return self:addEntity(e)
end

function m:update(dt, filter)
   return self.world:update(dt, filter)
end

return m
