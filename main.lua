
function love.load()
    map = {{1,1,1,1,1,1,1,1,1,1,1,1},{1,1,0,0,0,0,0,0,0,0,1,1},{1,0,0,1,1,0,0,1,1,0,0,1},{1,0,0,0,0,0,0,0,0,0,0,1},{1,1,1,0,0,0,0,0,0,1,1,1},{1,0,0,0,0,0,0,0,0,0,0,1},{1,0,0,1,1,0,0,1,1,0,0,1},{1,1,0,0,0,0,0,0,0,0,1,1},{1,1,1,1,1,1,1,1,1,1,1,1}}
    players = {
        {x = 128, y = 128, w = 32, h = 32, r = 16, speed = 128, mode = 'rect'}
    }
    objects = {}
    for i = 1, #map do
        for j = 1, #map[i] do
            if map[i][j] == 1 then
                table.insert(objects, {x = j*32, y = i*32, w = 32, h = 32, r = 16, mode = 'rect'})
            end
        end
    end
end

function love.update(dt)

    local moveplayer = shallowCopy(players[1])
    if love.keyboard.isDown('w') then
        moveplayer.y = players[1].y - players[1].speed*dt
    elseif love.keyboard.isDown('a') then
        moveplayer.x = players[1].x - players[1].speed*dt
    elseif love.keyboard.isDown('s') then
        moveplayer.y = players[1].y + players[1].speed*dt
    elseif love.keyboard.isDown('d') then
        moveplayer.x = players[1].x + players[1].speed*dt
    elseif love.keyboard.isDown('space') then
        moveplayer.mode = 'circle'--players[1].mode+1-math.floor(players[1].mode+1/2)*2
    end
    
    local collision = false
    for i = 1, #objects do
        if checkcollision(moveplayer,objects[i]) then
            collision = true
            break
        end
    end
    if collision == false then
        players[1] = moveplayer
    end
end

function love.draw()
    for i = 1, #map do
        for j = 1, #map[i] do
            if map[i][j] == 1 then
                love.graphics.rectangle('fill', j*32, i*32, 32, 32)
            end
        end
    end
    for i = 1, #players do
        if players[i].mode == 'rect' then
            love.graphics.rectangle('line', players[i].x, players[i].y, players[i].w, players[i].h)
        elseif players[i].mode == 'circle' then
            love.graphics.circle('line', players[i].x+players[i].r, players[i].y+players[i].r, players[i].r,4)
        else
            love.graphics.circle('line', players[i].x+players[i].r, players[i].y+players[i].r, players[i].r)
        end
    end
end

function shallowCopy(original)
    local copy = {}
    for key, value in pairs(original) do
        copy[key] = value
    end
    return copy
end

--Bygg en bana att testa på.

--Bygg egen collision kod. DONE
--Skapa egen fil för koden samt göra den snyggare
function checkcollision(A,B)
    if A.mode == 'rect' or A.mode == nil then
        if B.mode == 'rect' or B.mode == nil then
            return rectrectCollision(A,B)
        else
            return circelrectcollision(B,A)
        end
    else
        if B.mode == 'rect' or B.mode == nil then
            return circelrectcollision(A,B)
        else
            return circelcircelcollision(A, B)
        end
    end
end

function rectrectCollision(rect1, rect2)
    return rect1.x < rect2.x+rect2.w and rect2.x < rect1.x+rect1.w and rect1.y < rect2.y+rect2.h and rect2.y < rect1.y+rect1.h
end

function circelcircelcollision(circle1, circle2)
    local dist = (circle1.x - circle2.x)^2 + (circle1.y - circle2.y)^2
    return dist <= (circle2.r + circle2.r)^2
end

function circelrectcollision(circle, rect) 
    local circle_dx = math.abs(circle.x+circle.r - rect.x - rect.w/2)
    local circle_dy = math.abs(circle.y+circle.r - rect.y - rect.h/2)

    if circle_dx > (rect.w/2 + circle.r) or circle_dy > (rect.h/2 + circle.r) then
        return false
    elseif circle_dx <= (rect.w/2) or circle_dy <= (rect.h/2) then
        return true
    end

    return (math.pow(circle_dx - rect.w/2, 2) + math.pow(circle_dy - rect.h/2, 2)) <= math.pow(circle.r, 2)
end
