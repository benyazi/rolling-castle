local Player = {}

function Player:new(x, y)
    p = {}
    --Transform component
    p.transform = {
        position = {
            x = x, y = y
        },
        size = {
            w = 32, h = 32
        }
    }
    --Some components
    p.speed = 2
    p.keyboardControlled = true
    p.followingCamera = true
    p.checkCollision = true
    p.hasCollider = true

    --Radar component
    p.radar = {size = 5, type = "rect"}

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

    p.magicState = MAGIC_STATE.IDLE

    p.collider = {
        w = 20, h = 10,
        offset = { x = 0, y = 0 }
    }
    --
    p.spriteRender = components.SpriteRender:new()
    local g = anim8.newGrid(32, 32, assets.good1:getWidth(), assets.good1:getHeight())
    local spriteHead = {
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
    spriteHead.sprite.file = assets.good1
    spriteHead.sprite.states = {};
    spriteHead.sprite.states[STATE.IDLE] = {}
    spriteHead.sprite.states[STATE.IDLE][DIR.DOWN] = anim8.newAnimation(g('1-1',1),0.5)
    spriteHead.sprite.current = spriteHead.sprite.states[STATE.IDLE][DIR.DOWN]

    local spriteBody = {
        type = 'anim',
        state = "magicState",
        sprite = {},
        position = {
            x = 0, y = 0,
            offsetX = 0, offsetY = 0,
        },
        size = {
            w = 32, y = 32
        }
    }
    spriteBody.sprite.file = assets.good1;
    spriteBody.sprite.states = {};
    spriteBody.sprite.states[MAGIC_STATE.IDLE] = {}
    spriteBody.sprite.states[MAGIC_STATE.USING] = {}
    spriteBody.sprite.states[MAGIC_STATE.IDLE][DIR.DOWN] = anim8.newAnimation(g('2-2',1),0.5)
    spriteBody.sprite.states[MAGIC_STATE.USING][DIR.DOWN] = anim8.newAnimation(g('2-3',1),0.5)
    spriteBody.sprite.current = spriteBody.sprite.states[MAGIC_STATE.IDLE][DIR.DOWN]

    local spriteFoot = {
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
    spriteFoot.sprite.file = assets.good1;
    spriteFoot.sprite.states = {};
    spriteFoot.sprite.states[STATE.IDLE] = {}
    spriteFoot.sprite.states[STATE.MOVING] = {}
    spriteFoot.sprite.states[STATE.IDLE][DIR.DOWN] = anim8.newAnimation(g('1-1',2),0.25)
    spriteFoot.sprite.states[STATE.MOVING][DIR.DOWN] = anim8.newAnimation(g('1-3',2),0.25)
    spriteFoot.sprite.current = spriteFoot.sprite.states[STATE.IDLE][DIR.DOWN]
    p.spriteRender:addSprite(spriteFoot)
    p.spriteRender:addSprite(spriteBody)
    p.spriteRender:addSprite(spriteHead)

    p.isVisible = true

    return setmetatable(p, {__index=self})
end

return Player