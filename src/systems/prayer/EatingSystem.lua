local system = tiny.processingSystem()

system.filter = tiny.requireAll('GoldenTaurus','faithState','Faith')

function system:process(e)
    if e.GoldenTaurus then
        local wagon = e.GoldenTaurus.wagon
        if wagon == nil or e.satiety >= 100 then
            e.satiety = e.satiety - e.appetite/2
        else
            local wagonX,wagonY = wagon.transform.position.x,wagon.transform.position.y
            local x, y = e.transform.position.x,e.transform.position.y
            local dx = x - wagonX
            local dy = y - wagonY
            local distance = math.sqrt ( dx * dx + dy * dy )
            if distance < 150 and wagon.eat.current > e.appetite then
                wagon.eat.current = wagon.eat.current - e.appetite
                e.satiety = e.satiety + e.appetite
                world:notifyChange(wagon)
            else
                e.satiety = e.satiety - e.appetite/2
            end
        end
        if e.satiety <= 0 then
            e.satiety = 0
            e.GoldenTaurus = nil
            e.goToMotherLand = true
        end
        world:notifyChange(e)
    end
end

return system