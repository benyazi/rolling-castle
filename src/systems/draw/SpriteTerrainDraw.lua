local system = tiny.sortedProcessingSystem()

system.filter = tiny.requireAll('spriteDraw', 'pos', 'isVisible', 'terrain')
system.isDrawSystem = true

function system:compare(e1, e2)
    local e1y, e2y, e1z = e1.pos.y, e2.pos.y, e1.pos.z
    local e1x, e2x, e2z = e1.pos.x, e2.pos.x, e2.pos.z
    local result = e1z < e2z
    if e1z == e2z then
        result = e1y < e2y
        if e1y == e2y then
            result = e1x < e2x
        end
    end
    return result
end

function system:process(e, dt)
    love.graphics.draw(e.spriteDraw.sprite, e.pos.x, e.pos.y)
end

return system