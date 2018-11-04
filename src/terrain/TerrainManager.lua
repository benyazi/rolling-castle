local Perlin = require 'src.terrain.perlin'
local m = {}

function m.createMap(TileW, TileH)
  Perlin:init(65,65)
  local perlinMap = Perlin:getMap()
  --local order = 1
  for i = 0, #perlinMap.n do
    for j = 0, #perlinMap.n[i] do
      --local vv = perlinMap.n[i][j]/order
      local terBlock = {
         type = "grass",
         terrain = true,
         isVisible = true,
         spriteDraw = {
           sprite = assets.terrain_grass,
           x = nil, y = nil,
           offset = { x = 0, y = 0 },
           w = TileW, h = TileH
         },
         collider = {
            w = TileW, h = TileH,
            offset = { x = 0, y = 0 }
         },
         pos = {x=j*TileW,y=i*TileH},
         hasCollider = true
      }
      if true then
         --terBlock.type = "water"
         --terBlock.spriteDraw.sprite = assets.terrain_water
         --terBlock.checkCollision = true
         world:addEntity(terBlock)
      end
    end
  end
end

return m