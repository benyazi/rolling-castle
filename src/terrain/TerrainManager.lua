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
              pos = {x=j*TileW,y=i*TileH},
              hasCollider = true
          }
          if (i == 30 or i == 31) and (j < 50 or j > 106) then
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
          if (i==20 and j>=50 and j <=106)
                  or (i > 20 and i < 40 and (j ==50 or j == 106))
                  or (i == 40 and ((j>=50 and j < 70) or ( j>80 and j <=106)))
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
                  pos = {x=j*TileW,y=i*TileH},
                  hasCollider = true,
                  checkCollision = true
              }
              world:addEntity(terBlock2)
          end
      end
  end
end

return m