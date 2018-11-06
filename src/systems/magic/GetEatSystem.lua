local system = tiny.processingSystem()

system.filter = tiny.requireAll('keyboardControlled','magicState', 'wagon')

system.using = 0
system.timer = 100;
system.events = {}

function system:process(e)
    if system.using == 1 then
        if system.timer < 0 then
            system.timer = 100
        end
        if system.timer >= 100 and e.wagon then
            print("Getting eat")
            if e.magicState == MAGIC_STATE.IDLE then
                e.magicState = MAGIC_STATE.USING
            end
            local posX, posY = e.transform.position.x-30,e.transform.position.y-30
            local items, len = world.physics:queryRect(
                    posX, posY,
                    60, 60,
                    function(item) return item ~= e end)
            for index=1, #items do
                if items[index].type and items[index].type == 'village' then
                    if items[index].granary.current > 100 then
                        items[index].granary.current = items[index].granary.current - 100
                        e.wagon.eat.current = e.wagon.eat.current + 100
                        if e.wagon.eat.current > e.wagon.eat.calculateMax then
                            e.wagon.eat.current = e.wagon.eat.calculateMax
                        end
                        world:notifyChange(items[index])
                        world:notifyChange(e.wagon)
                    end
                    print("Found village")
                end
            end
        end
        system.timer = system.timer - 1
    elseif e.magicState == MAGIC_STATE.USING then
        e.magicState = MAGIC_STATE.IDLE
    end
end

function system:onAddToWorld(world)
    system.events[#system.events + 1] = beholder.observe('GET_EAT_PRESSED', function()
        system.timer = 100
        system.using = 1
    end)
    system.events[#system.events + 1] = beholder.observe('GET_EAT_RELEASED', function() system.using = 0 end)
end

function system:onRemoveFromWorld(world)
    for i = 0, #system.events do
        beholder.stopObserving(system.events[i])
    end
end

return system
