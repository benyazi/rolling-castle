local Prayer = {}

function Prayer:new(x, y)
    p = {}
    p.type = 'prayer'
    --Transform component
    p.transform = {
        position = {
            x = x, y = y
        },
        size = {
            w = 32, h = 32
        }
    }
    --motherland
    p.motherland = nil
    p.goToMotherLand = nil

    --Castle
    p.inCastle = nil

    --Faith components
    p.Faith = {
        current = 0,
        max = 100,
        calculateMax = 100
    }
    p.GoldenTaurus = nil
    p.faithState = FAITH_STATE.IDLE
    p.faithMinDistance = 100

    --hungry
    p.satiety = 100
    p.appetite = 0.1

    --Some components
    p.speed = math.random(1.25, 1.5)
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

    p.collider = {
        w = 20, h = 10,
        offset = { x = 0, y = 0 }
    }
    --
    p.spriteRender = components.SpriteRender:new()
    local g = anim8.newGrid(32, 32, assets.prayer1_main:getWidth(), assets.prayer1_main:getHeight())

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
    spriteBody.sprite.file = assets.prayer1_main;
    spriteBody.sprite.states = {};
    spriteBody.sprite.states[STATE.IDLE] = {}
    spriteBody.sprite.states[STATE.MOVING] = {}
    spriteBody.sprite.states[STATE.IDLE][DIR.DOWN] = anim8.newAnimation(g('1-1',1),0.5)
    spriteBody.sprite.states[STATE.MOVING][DIR.DOWN] = anim8.newAnimation(g('1-2',1),0.5)
    spriteBody.sprite.current = spriteBody.sprite.states[STATE.IDLE][DIR.DOWN]

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
    spriteFoot.sprite.file = assets.prayer1_main;
    spriteFoot.sprite.states = {};
    spriteFoot.sprite.states[STATE.IDLE] = {}
    spriteFoot.sprite.states[STATE.MOVING] = {}
    spriteFoot.sprite.states[STATE.IDLE][DIR.DOWN] = anim8.newAnimation(g('1-1',2),0.25)
    spriteFoot.sprite.states[STATE.MOVING][DIR.DOWN] = anim8.newAnimation(g('1-3',2),0.25)
    spriteFoot.sprite.current = spriteFoot.sprite.states[STATE.IDLE][DIR.DOWN]
    p.spriteRender:addSprite(spriteFoot)
    p.spriteRender:addSprite(spriteBody)

    p.isVisible = true

    return setmetatable(p, {__index=self})
end

return Prayer