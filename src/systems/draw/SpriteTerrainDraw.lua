local system = tiny.processingSystem()

system.filter = tiny.requireAll('spriteDraw', 'pos', 'isVisible', 'terrain')
system.isDrawSystem = true

function system:process(e, dt)
    love.graphics.draw(e.spriteDraw.sprite, e.pos.x, e.pos.y)
end

return system