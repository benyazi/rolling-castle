local Perlin = require 'src.terrain.perlin'

local m = {}
local inventoryCount = {
  axe = 3,
  picker = 2,
  elixir = 10
}
local isHeroCreated = false
local isHorseCreated = false

function m.createMap(TileW, TileH)
  Perlin:init(65,65)
  local perlinMap = Perlin:getMap()
  local order = 1

  for i = 0, #perlinMap.n do
    for j = 0, #perlinMap.n[i] do
      local vv = perlinMap.n[i][j]/order
      local terBlock = {
         type = "grass",
         terrain = true,
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
      if i < 2 or j < 2 or i > 62 or j > 62 then
         terBlock.type = "water"
         terBlock.spriteDraw.sprite = assets.terrain_water
         terBlock.checkCollision = true
         world:addEntity(terBlock)
      elseif vv < 120 then
         world:addEntity(terBlock)
         if vv > 115 then
         local tree = entities.Tree.new(j*TileW + math.random(0, 10), i*TileH + math.random(0, 10));
           world:addEntity(tree)
         end
      elseif vv < 140 then
         world:addEntity(terBlock)
          if isHeroCreated == false and math.random(0, 30) > 28 and i > 5 and j > 5 then
            local hero = entities.Link.new(j*TileW, i*TileH+10)
            hero.keyboardControlled = true
            world:addEntity(hero)
            isHeroCreated = true
          end
           if isHorseCreated == false and math.random(0, 30) > 28 and i > 6 and j > 6 then
             local horse = entities.Horse.new(j*TileW, i*TileH+10)
             world:addEntity(horse)
             isHorseCreated = true
           end
           if math.random(0, 30) > 28 and inventoryCount.axe > 0 then
              world:addEntity(entities.inventory.Axe:new(j*TileW, i*TileH))
              inventoryCount.axe = inventoryCount.axe-1
           end
            if math.random(0, 30) > 28 and inventoryCount.picker > 0 then
               world:addEntity(entities.inventory.Picker:new(j*TileW, i*TileH))
               inventoryCount.picker = inventoryCount.picker-1
            end
             if math.random(0, 30) > 28 and inventoryCount.elixir > 0 then
                world:addEntity(entities.inventory.Elixir:new(j*TileW, i*TileH))
                inventoryCount.elixir = inventoryCount.elixir-1
             end

         -- TODO: find a better way to seed the flowers
         local flowerSeed = math.random(1, 4)
         if flowerSeed == 1 or flowerSeed == 3 then
         world:addEntity({
               type = "flower",
               spriteDraw = {
                 sprite = assets.terrain_flower,
                 x = nil, y = nil,
                 offset = { x = 0, y = 0 },
                 w = 7, h = 12
               },
               pos = {x=j*TileW -16, y=i*TileH-2},
               -- hasCollider = true
         })
         end
         if flowerSeed == 2 or flowerSeed == 3 then
         world:addEntity({
               type = "flower",
               spriteDraw = {
                 sprite = assets.terrain_flower,
                 x = nil, y = nil,
                 offset = { x = 0, y = 0 },
                 w = 7, h = 12
               },
               pos = {x=j*TileW -16 + 8, y=i*TileH - 4},
               -- hasCollider = true
         })
         end
         if flowerSeed == 1 or flowerSeed == 4 then
         world:addEntity({
               type = "flower",
               spriteDraw = {
                 sprite = assets.terrain_flower,
                 x = nil, y = nil,
                 offset = { x = 0, y = 0 },
                 w = 7, h = 12
               },
               pos = {x=j*TileW -16 + 16, y=i*TileH-4},
               -- hasCollider = true
         })
         end
         if flowerSeed == 1 or flowerSeed == 2 then
         world:addEntity({
               type = "flower",
               spriteDraw = {
                 sprite = assets.terrain_flower,
                 x = nil, y = nil,
                 offset = { x = 0, y = 0 },
                 w = 7, h = 12
               },
               pos = {x=j*TileW -16 + 25, y=i*TileH - 2}
         })
         end

         if flowerSeed == 3 then
         world:addEntity({
               type = "flower",
               spriteDraw = {
                 sprite = assets.terrain_flower,
                 x = nil, y = nil,
                 offset = { x = 0, y = 0 },
                 w = 7, h = 12
               },
               pos = {x=j*TileW -16, y=i*TileH - 13}
         })
         end

         if flowerSeed == 1 or flowerSeed == 5 then
         world:addEntity({
               type = "flower",
               spriteDraw = {
                 sprite = assets.terrain_flower,
                 x = nil, y = nil,
                 offset = { x = 0, y = 0 },
                 w = 7, h = 12
               },
               pos = {x=j*TileW -16 + 8, y=i*TileH - 13 - 2}
         })
         end

         if flowerSeed == 4 or flowerSeed == 5 then
         world:addEntity({
               type = "flower",
               spriteDraw = {
                 sprite = assets.terrain_flower,
                 x = nil, y = nil,
                 offset = { x = 0, y = 0 },
                 w = 7, h = 12
               },
               pos = {x=j*TileW -16 + 16, y=i*TileH - 13 - 4}
         })
         end

         if flowerSeed == 2 or flowerSeed == 3 then
         world:addEntity({
               type = "flower",
               spriteDraw = {
                 sprite = assets.terrain_flower,
                 x = nil, y = nil,
                 offset = { x = 0, y = 0 },
                 w = 7, h = 12
               },
               pos = {x=j*TileW -16 + 25, y=i*TileH - 13 - 2}
         })
         end
      elseif vv <= 255 then
         terBlock.type = "water"
         terBlock.spriteDraw.sprite = assets.terrain_water
         terBlock.checkCollision = true
         world:addEntity(terBlock)
      end
    end
  end
end

return m
