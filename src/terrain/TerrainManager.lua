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
          if (i == 6 or i == 7) and (j < 10 or j > 25) then
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
          if (i==4 and j>=10 and j <=25)
                  or (i > 4 and i < 10 and (j ==10 or j == 25))
                  or (i == 10 and ((j>=10 and j < 13) or ( j>17 and j <=25)))
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