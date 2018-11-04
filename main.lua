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
DIR = {DOWN=1, LEFT=2, UP=3, RIGHT=4}
CAM = gamera.new(0, 0, 2000, 2000)
ENV = 'prod'

entities = require.tree('src.entities')
components = require.tree('src.components')
local systems = require.tree('src.systems')

local TerrainManager = require 'src.terrain.TerrainManager'

world = world:new(
    bump.newWorld(32)
--systems.SpriteSystem,
)

local drawFilter = tiny.requireAll('isDrawSystem')
local updateFilter = tiny.rejectAny('isDrawSystem')

function love.load()
    assets.load()
    TerrainManager.createMap(32, 32)
    world:addEntity({soundManager=true})
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
        else
            ENV = 'dev'
        end
    elseif k == 'w' then
        beholder.trigger('MOVING_UP_PRESSED')
    elseif k == 's' then
        beholder.trigger('MOVING_DOWN_PRESSED')
    elseif k == 'a' then
        beholder.trigger('MOVING_LEFT_PRESSED')
    elseif k == 'd' then
        beholder.trigger('MOVING_RIGHT_PRESSED')
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
    end
end
