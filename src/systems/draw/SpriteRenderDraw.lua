local system = tiny.sortedProcessingSystem()

system.filter = tiny.requireAll('spriteRender', 'transform', 'isVisible')
system.isDrawSystem = true

function system:compare(e1, e2)
    local e1y, e2y = e1.transform.position.y, e2.transform.position.y
    local e1x, e2x = e1.transform.position.x, e2.transform.position.x
    local result = e1y < e2y
    if e1y == e2y then
        result = e1x < e2x
    end
    return result
end

function system:process(e, dt)
    local position, spriteRender = e.transform.position, e.spriteRender
    for i = 1, #spriteRender.sprites do
        local sprite = spriteRender.sprites[i]
        local x, y = position.x, position.y
        x = x + sprite.position.x
        y = y + sprite.position.y
        if sprite.type == 'anim' then
            sprite.sprite.current:update(dt)
            sprite.sprite.current:draw(sprite.sprite.file, x, y)
        else
            love.graphics.draw(sprite.sprite.file, x, y)
        end
    end
    -- love.graphics.setColor(0,0,255)
    -- love.graphics.rectangle("line",pos.x,pos.y,2,2)
    -- love.graphics.setColor(255,255,255)
end

return system