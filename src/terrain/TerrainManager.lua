local Perlin = require 'src.terrain.perlin'
local m = {}

function m.createMap(TileW, TileH)
  Perlin:init(156,156)
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
              pos = {x=j*TileW,y=i*TileH, z = 1},
              hasCollider = true
          }
          if (j < 3) or (j > 152) then
              terBlock.type = 'water'
              terBlock.spriteDraw.sprite = assets.terrain_water
              terBlock.checkCollision = true
          end
          if true then
              --terBlock.type = "water"
              --terBlock.spriteDraw.sprite = assets.terrain_water
              --terBlock.checkCollision = true
              world:addEntity(terBlock)
          end
          if ( j > 2 and j < 153 and i > 20 and i < 23)
          then
              local terBlock2 = {
                  type = "wall",
                  terrain = true,
                  isVisible = true,
                  spriteDraw = {
                      sprite = assets.terrain_wall,
                      x = nil, y = nil,
                      offset = { x = 0, y = 0 },
                      w = TileW, h = TileH
                  },
                  collider = {
                      w = TileW, h = TileH,
                      offset = { x = 0, y = 0 }
                  },
                  pos = {x=j*TileW,y=i*TileH, z = 10},
                  hasCollider = true,
                  checkCollision = true
              }
              world:addEntity(terBlock2)
          end
      end
  end
end

return m