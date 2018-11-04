local system = tiny.processingSystem()

system.filter = tiny.requireAll('state', 'spriteRender', 'dir')
system.isDrawSystem = true

function system:process(e)
    local position, spriteRender = e.transform.position, e.spriteRender
    for i = 1, #spriteRender.sprites do
        local sprite = spriteRender.sprites[i]
        local x, y = position.x, position.y
        x = x + sprite.position.x
        y = y + sprite.position.y
        if e[sprite.state] then
            local state = e[sprite.state]
            if sprite.type == 'anim' and sprite.sprite.states[state] and sprite.sprite.states[state][DIR.DOWN] then
                sprite.sprite.current = sprite.sprite.states[state][DIR.DOWN]
            end
        end
    end
end

return system
