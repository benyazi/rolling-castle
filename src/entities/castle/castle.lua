local Castle = {}

function Castle:new(x, y)
    p = {}
    p.type = 'Castle'
    p.castle = true
    --Transform component
    p.transform = {
        position = {
            x = x, y = y
        },
        size = {
            w = 32, h = 32
        }
    }
    --RESOURCES
    p.resources = {
        eat = {
            calculateMax = 1000,
            max = 1000,
            current = 0
        },
        prayers = {
            calculateMax = 1000,
            max = 1000,
            current = 0
        }
    }
    --Some components
    p.checkCollision = true
    p.hasCollider = true

    p.collider = {
        w = 20, h = 10,
        offset = { x = 0, y = 0 }
    }
    --
    p.spriteRender = components.SpriteRender:new()
    local g = anim8.newGrid(32, 32, assets.Willage_main:getWidth(), assets.Willage_main:getHeight())

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
    spriteBody.sprite.file = assets.Willage_main;
    spriteBody.sprite.states = {};
    spriteBody.sprite.states[STATE.IDLE] = {}
    spriteBody.sprite.states[STATE.MOVING] = {}
    spriteBody.sprite.states[STATE.IDLE][DIR.DOWN] = anim8.newAnimation(g('1-5',1),0.25)
    spriteBody.sprite.current = spriteBody.sprite.states[STATE.IDLE][DIR.DOWN]
    p.spriteRender:addSprite(spriteBody)

    p.isVisible = true

    return setmetatable(p, {__index=self})
end

return Castle