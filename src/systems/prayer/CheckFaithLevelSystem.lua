local system = tiny.processingSystem()

system.filter = tiny.requireAll('GoldenTaurus','faithState','Faith')

function system:process(e)
    local taurusX,taurusY = e.GoldenTaurus.transform.position.x,e.GoldenTaurus.transform.position.y
    local x, y = e.transform.position.x,e.transform.position.y
    local dx = x - taurusX
    local dy = y - taurusY
    local distance = math.sqrt ( dx * dx + dy * dy )
    if distance < 110 then
        if e.Faith.current < e.Faith.calculateMax then
            e.Faith.current = e.Faith.current + 0.1
        end
    elseif distance < 150 then
        if e.Faith.current > 0 then
            e.Faith.current = e.Faith.current - 0.1
        end
    elseif distance < 200 then
        if e.Faith.current > 0 then
            e.Faith.current = e.Faith.current - 0.2
        end
    else
        if e.Faith.current > 0 then
            e.Faith.current = e.Faith.current - 0.3
        end
    end
    if e.Faith.current <= 0 then
        e.Faith.current = 0
        e.GoldenTaurus = nil
    end
    world:notifyChange(e)
end

return system