local system = tiny.processingSystem()

system.filter = tiny.requireAll('castle')

system.timer = 24;

function system:process(e)
    if system.timer < 0 then
        local posX, posY = e.transform.position.x-150,e.transform.position.y-150
        local items, len = world.physics:queryRect(
                posX, posY,
                300, 300,
                function(item) return item ~= e end)
        for index=1, #items do
            if items[index].type and items[index].type == 'prayer' and items[index].GoldenTaurus then
                items[index].goToMotherLand = nil
                items[index].inCastle = e
                items[index].GoldenTaurus = nil
                items[index].checkCollision = nil
                e.resources.prayers.current = e.resources.prayers.current + 1
                world:notifyChange(items[index])
                world:notifyChange(e)
            end
            if items[index].type and items[index].type == 'Wagon' and items[index].eat.current > 0 then
                e.resources.eat.current = e.resources.eat.current + items[index].eat.current
                items[index].eat.current = 0
                if e.resources.eat.current > e.resources.eat.calculateMax then
                    items[index].eat.current = e.resources.eat.current - e.resources.eat.calculateMax
                    e.resources.eat.current = e.resources.eat.calculateMax
                end
                world:notifyChange(items[index])
                world:notifyChange(e)
            end
        end
        system.timer = 24
    end
    system.timer = system.timer - 1
end

return system
