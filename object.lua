local object = {
    _VERSION     = '0.0.1',
    _DESCRIPTION = 'Object library',
    _URL         = 'http://foobar.page.or.repo.com',
    _LICENSE     = [[license text, or name/url for long licenses)]]
}

local function objectshape(object)
	love.graphics.setColor(127, 127, 127)
	love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
	love.graphics.setColor(255, 255, 255)
    if object.position == true then
        love.graphics.line(object.x, object.y, object.x, object.y)
    end
    if object.position[2] == true then
        love.graphics.line(object.x, object.y, object.x+object.w, object.y)
    end
    if object.position[3] == true then
        love.graphics.line(object.x, object.y, object.x, object.y)
    end
    if object.position[4] == true then
        love.graphics.line(object.x, object.y, object.x, object.y+object.h)
    end
    if object.position[5] == true then
        love.graphics.line(object.x+object.w, object.y, object.x+object.w, object.y+object.h)
    end
    if object.position[6] == true then
        love.graphics.line(object.x, object.y, object.x, object.y)
    end
    if object.position[7] == true then
        love.graphics.line(object.x, object.y+object.h, object.x+object.w, object.y+object.h)
    end
    if object.position[8] == true then
        love.graphics.line(object.x, object.y, object.x, object.y)
    end
end

function object.position(i,j)
    local position = {false,false,false,false,false,false,false,false}
    if i ~= 1 and j ~= 1 then
        if map[i-1][j-1] == 0 then
            position[1] = true
        end
    end
    if i ~= 1 then
        if map[i-1][j] == 0 then
            position[2] = true
        end
    end
    if i ~= 1 and j ~= #map[i] then
        if map[i-1][j+1] == 0 then
            position[3] = true
        end
    end
    if j ~= 1 then
        if map[i][j-1] == 0 then
            position[4] = true
        end
    end
    if j ~= #map[i] then
        if map[i][j+1] == 0 then
            position[5] = true
        end
    end
    if i ~= #map and j ~= 1 then
        if map[i+1][j-1] == 0 then
            position[6] = true
        end
    end
    if i ~= #map  then
        if map[i+1][j] == 0 then
            position[7] = true
        end
    end
    if i ~= #map and j ~= #map[i] then
        if map[i+1][j+1] == 0 then
            position[8] = true
        end
    end
    return position
end

function object.drawobjects(objects)
    for i = 1, #objects do
        objectshape(objects[i])
        --if objects[i].mode == 'rect' then
            --love.graphics.rectangle(objects[i].drawmode, objects[i].x, objects[i].y, objects[i].w, objects[i].h)
        --elseif objects[i].mode == 'circle' then
            --love.graphics.circle(objects[i].drawmode, objects[i].x+objects[i].r, objects[i].y+objects[i].r, objects[i].r,4)
        --else
            --love.graphics.circle(objects[i].drawmode, objects[i].x+objects[i].r, objects[i].y+objects[i].r, objects[i].r)
        --end
    end
end

return object