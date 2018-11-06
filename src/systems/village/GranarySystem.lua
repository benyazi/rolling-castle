local system = tiny.processingSystem()

system.filter = tiny.requireAll('granary')

function system:process(e)
    e.granary.current = e.granary.current + e.granary.harvest
    if e.granary.current > e.granary.calculatedMax then
        e.granary.current = e.granary.calculatedMax
    end
    world:notifyChange(e)
end

return system