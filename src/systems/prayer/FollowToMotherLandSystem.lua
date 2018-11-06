local system = tiny.processingSystem()

system.filter = tiny.requireAll('goToMotherLand','motherland')

system.dirs = {}
system.dirs[DIR.UP] = false
system.dirs[DIR.DOWN] = false
system.dirs[DIR.LEFT] = false
system.dirs[DIR.RIGHT] = false

function system:process(e)
    if e.goToMotherLand then
        local taurusX,taurusY = e.motherland.transform.position.x,e.motherland.transform.position.y
        local new_x, new_y = e.transform.position.x,e.transform.position.y
        --local distance = math.abs((meX - taurusX)^2) + math.abs((meY - taurusY)^2)
        --distance = math.sqrt(distance)
        local old_x, old_y = new_x, new_y

        local dx = new_x - taurusX
        local dy = new_y - taurusY
        local distance = math.sqrt ( dx * dx + dy * dy )
        system.dirs[DIR.UP] = false
        system.dirs[DIR.DOWN] = false
        system.dirs[DIR.LEFT] = false
        system.dirs[DIR.RIGHT] = false
        if(distance > 50) then
            if dx > 10 then
                system.dirs[DIR.LEFT] = true
            elseif dx < 10 then
                system.dirs[DIR.RIGHT] = true
            end

            if dy > 10 then
                system.dirs[DIR.UP] = true
            elseif dy < 10 then
                system.dirs[DIR.DOWN] = true
            end
        end

        if system.dirs[DIR.UP] then
            new_y = new_y - e.speed
            --e.dir = DIR.UP
        end
        if system.dirs[DIR.DOWN] then
            new_y = new_y + e.speed
            --e.dir = DIR.DOWN
        end
        if system.dirs[DIR.LEFT] then
            new_x = new_x - e.speed
            --e.dir = DIR.LEFT
        end
        if system.dirs[DIR.RIGHT] then
            new_x = new_x + e.speed
            --e.dir = DIR.RIGHT
        end

        if new_x ~= old_x or new_y ~= old_y then
            e.state = STATE.MOVING
            if e.hasCollider ~= nil and e.checkCollision ~= nil then
                local act_x, act_y, cols, len = world.physics:move(
                        e, new_x, new_y,
                        function(me, other)
                            if other.hasCollider ~= nil and other.checkCollision ~= nil then return 'slide' end
                            return 'cross'
                        end)
                e.transform.position.x = act_x
                e.transform.position.y = act_y
            else
                e.transform.position.x = new_x
                e.transform.position.y = new_y
            end
            world:notifyChange(e)
        else
            e.state = STATE.IDLE
        end
    end
end

return system