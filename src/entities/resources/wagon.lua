local Wagon = {}

function Wagon:new(x, y)
    p = {}
    p.type = 'Wagon'
    --Transform component
    p.transform = {
        position = {
            x = x, y = y
        },
        size = {
            w = 32, h = 32
        }
    }
    --EAT
    p.eat = {
        calculateMax = 1000,
        max = 1000,
        current = 1000
    }
    --Some components
    p.speed = math.random(1.25, 1.5)
    p.checkCollision = true
    p.hasCollider = true

    p.GoldenTaurus = nil
    p.faithState = FAITH_STATE.IDLE
    p.faithMinDistance = 50
    --Health component
    p.health = {
        originMax = 100,
        calculateMax = 100,
        current = 20
    }
    p.showHealthBar = true
    p.showMainHealthBar = true

    p.dir = DIR.DOWN
    p.state = STATE.IDLE

    p.collider = {
        w = 20, h = 10,
        offset = { x = 0, y = 0 }
    }
    --
    p.spriteRender = components.SpriteRender:new()
    local g = anim8.newGrid(32, 32, assets.Wagon1_main:getWidth(), assets.Wagon1_main:getHeight())

    local spriteBody = {
        type = 'anim',
        state = "state",
        sprite = {},
        position = {
            x = 0, y = 0,
            offsetX = 0, offsetY = 0,
        },
        size = {
            w = 32, y = 32
        }
    }
    spriteBody.sprite.file = assets.Wagon1_main;
    spriteBody.sprite.states = {};
    spriteBody.sprite.states[STATE.IDLE] = {}
    spriteBody.sprite.states[STATE.MOVING] = {}
    spriteBody.sprite.states[STATE.IDLE][DIR.DOWN] = anim8.newAnimation(g('1-1',1),0.5)
    spriteBody.sprite.states[STATE.MOVING][DIR.DOWN] = anim8.newAnimation(g('1-2',1),0.5)
    spriteBody.sprite.current = spriteBody.sprite.states[STATE.IDLE][DIR.DOWN]

    p.spriteRender:addSprite(spriteBody)

    p.isVisible = true

    return setmetatable(p, {__index=self})
end

return Wagon