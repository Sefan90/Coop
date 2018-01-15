local collision = {
    _VERSION     = '0.0.1',
    _DESCRIPTION = 'Collision library',
    _URL         = 'http://foobar.page.or.repo.com',
    _LICENSE     = [[license text, or name/url for long licenses)]]
}

--Bygg egen collision kod. DONE
--Skapa egen fil för koden samt göra den snyggare

local function rectrectCollision(rect1, rect2)
    return rect1.x < rect2.x+rect2.w and rect2.x < rect1.x+rect1.w and rect1.y < rect2.y+rect2.h and rect2.y < rect1.y+rect1.h
end

local function circelcircelcollision(circle1, circle2)
    local dist = (circle1.x - circle2.x)^2 + (circle1.y - circle2.y)^2
    return dist <= (circle2.r + circle2.r)^2
end

local function circelrectcollision(circle, rect) 
    local circle_dx = math.abs(circle.x+circle.r - rect.x - rect.w/2)
    local circle_dy = math.abs(circle.y+circle.r - rect.y - rect.h/2)

    if circle_dx > (rect.w/2 + circle.r) or circle_dy > (rect.h/2 + circle.r) then
        return false
    elseif circle_dx <= (rect.w/2) or circle_dy <= (rect.h/2) then
        return true
    end

    return (math.pow(circle_dx - rect.w/2, 2) + math.pow(circle_dy - rect.h/2, 2)) <= math.pow(circle.r, 2)
end

function collision.check(A,B)
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

function collision.checkObjects(player,moveplayer,objects)
    local notCollided = true
    for i = 1, #objects do
        if collision.check(moveplayer,objects[i]) and objects[i] ~= player then
            notCollided = false
            break
        end
    end
    return notCollided
end

return collision