local collision = require 'collision'
local object = {
    _VERSION     = '0.0.1',
    _DESCRIPTION = 'Object library',
    _URL         = 'http://foobar.page.or.repo.com',
    _LICENSE     = [[license text, or name/url for long licenses)]]
}

local function objectshape(object)
	if object.enemy == false then
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
	else
		love.graphics.setColor(127, 127, 127)
		love.graphics.circle('fill', object.x+object.w/2, object.y+object.w/2, object.w/2, 4)
		love.graphics.rectangle('fill', object.x+object.w/8, object.y+object.w/8, object.w*0.75, object.h*0.75)
		love.graphics.setColor(255, 255, 255)
	end
end

function object.position(i,j)
    local position = {false,false,false,false,false,false,false,false}
    if i ~= 1 and j ~= 1 then
        if map[i-1][j-1] ~= 1 then
            position[1] = true
        end
    end
    if i ~= 1 then
        if map[i-1][j] ~= 1 then
            position[2] = true
        end
    end
    if i ~= 1 and j ~= #map[i] then
        if map[i-1][j+1] ~= 1 then
            position[3] = true
        end
    end
    if j ~= 1 then
        if map[i][j-1] ~= 1 then
            position[4] = true
        end
    end
    if j ~= #map[i] then
        if map[i][j+1] ~= 1 then
            position[5] = true
        end
    end
    if i ~= #map and j ~= 1 then
        if map[i+1][j-1] ~= 1 then
            position[6] = true
        end
    end
    if i ~= #map  then
        if map[i+1][j] ~= 1 then
            position[7] = true
        end
    end
    if i ~= #map and j ~= #map[i] then
        if map[i+1][j+1] ~= 1 then
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

function object.move(object,dt)
	local moveobject = shallowCopy(object)
    moveobject.x = moveobject.x + moveobject.dx*dt
    moveobject.y = moveobject.y + moveobject.dy*dt
	if collision.checkObjects(object,moveobject,objects)[1] and collision.checkObjects(object,moveobject,players)[1] then
        return moveobject
    else
    	object.dx = -object.dx
    	object.dy = -object.dy
        return object
    end
end

return object