require 'lib.require'

tiny = require 'lib.tiny'
anim8 = require 'lib.anim8'
gamera = require 'lib.gamera'
bump = require 'lib.bump'
inspect = require 'lib.inspect'
binser = require 'lib.binser'
beholder = require 'lib.beholder'

world = require 'src.world'
assets = require 'src.assets'

STATE = {MOVING=1, IDLE=2}
FAITH_STATE = {IDLE=1,ATTACK=2,DEFENSE=3}
MAGIC_STATE = {IDLE=1,USING=2}
WAGON_STATE = {FULL=1,MIDDLE=2,EMPTY=3}
DIR = {DOWN=1, LEFT=2, UP=3, RIGHT=4}
CAM = gamera.new(0, 0, 2000, 2000)
ENV = 'prod'

entities = require.tree('src.entities')
components = require.tree('src.components')
local systems = require.tree('src.systems')

local TerrainManager = require 'src.terrain.TerrainManager'

world = world:new(
    bump.newWorld(32),
    systems.CheckVisibleSystem,
    systems.AnimationStateTrackingSystem,
    systems.draw.SpriteTerrainDraw,
    systems.draw.SpriteRenderDraw,
    systems.castle.ShowCastleResourcesSystem,
    systems.KeyboardMovingSystem,
    systems.magic.UseMagicSystem,
    systems.magic.GetEatSystem,
    systems.prayer.CheckFaithLevelSystem,
    systems.prayer.EatingSystem,
    systems.FollowTargetSystem,
    systems.VelocityToMove,
    systems.village.GranarySystem,
    systems.CameraFollowingSystem,
    systems.castle.CheckResourceSystem
--systems.SpriteSystem,
)

local drawFilter = tiny.requireAll('isDrawSystem')
local updateFilter = tiny.rejectAny('isDrawSystem')

function love.load()
    assets.load()
    TerrainManager.createMap(32, 32)
    world:addEntity({soundManager=true})

    local player = entities.players.player:new(100,400)
    local wagon = entities.resources.wagon:new(120,420)
    local castle = entities.castle.castle:new(448,224)
    world:addEntity(castle)
    wagon.target = player
    world:addEntity(player)
    player.wagon = wagon
    world:addEntity(wagon)

    for i=0,10 do
        local vX,vY = i*10 + math.random(50, 1700),i*10 + math.random(300, 1700)
        local village = entities.prayers.village:new(
                vX,vY
        )
        world:addEntity(village)
        for i=0,10 do
            local pX = vX + math.random(-150, 150)
            local pY = vY + math.random(-150, 150)
            local prayer = entities.prayers.prayer:new(pX,pY)
            prayer.motherland = village
            world:addEntity(prayer)
        end
    end
end

function love.draw()
    CAM:draw(function()
        world:update(love.timer.getDelta(), drawFilter)
    end)
end

function love.update(dt)
    world:update(dt, updateFilter)
end

function love.keypressed(k)
    if k == 'o' then
        if ENV == 'dev' then
            ENV = 'prod'
            world:removeSystem(systems.dev.PrintPivotPointSystem)
            world:removeSystem(systems.dev.PrintLinkLogSystem)
            world:removeSystem(systems.dev.PrintColliderSystem)
            world:removeSystem(systems.dev.PrintFaithSystem)
            world:removeSystem(systems.dev.PrintEatSystem)
            world:removeSystem(systems.dev.PrintWagonStatSystem)
            world:removeSystem(systems.dev.PrintGranarySystem)
        else
            ENV = 'dev'
            world:addSystem(systems.dev.PrintPivotPointSystem)
            world:addSystem(systems.dev.PrintLinkLogSystem)
            world:addSystem(systems.dev.PrintColliderSystem)
            world:addSystem(systems.dev.PrintFaithSystem)
            world:addSystem(systems.dev.PrintEatSystem)
            world:addSystem(systems.dev.PrintWagonStatSystem)
            world:addSystem(systems.dev.PrintGranarySystem)
        end
    elseif k == 'w' then
        beholder.trigger('MOVING_UP_PRESSED')
    elseif k == 's' then
        beholder.trigger('MOVING_DOWN_PRESSED')
    elseif k == 'a' then
        beholder.trigger('MOVING_LEFT_PRESSED')
    elseif k == 'd' then
        beholder.trigger('MOVING_RIGHT_PRESSED')
    elseif k == 'e' then
        beholder.trigger('GET_EAT_PRESSED')
    elseif k == 'space' then
        beholder.trigger('SPACE_PRESSED')
    end
end

function love.keyreleased(k)
    if k == 'w' then
        beholder.trigger('MOVING_UP_RELEASED')
    elseif k == 's' then
        beholder.trigger('MOVING_DOWN_RELEASED')
    elseif k == 'a' then
        beholder.trigger('MOVING_LEFT_RELEASED')
    elseif k == 'd' then
        beholder.trigger('MOVING_RIGHT_RELEASED')
    elseif k == 'e' then
        beholder.trigger('GET_EAT_RELEASED')
    elseif k == 'space' then
        beholder.trigger('SPACE_RELEASED')
    end
end
