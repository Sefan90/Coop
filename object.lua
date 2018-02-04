local collision = require 'collision'
local func = require 'func'

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
	    if object.position[1] == true then
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
		-- if object.position[2] == true then
		-- 	love.graphics.line(object.x, object.y, object.x+tilesize*(1/6), object.y+tilesize*(1/6), object.x+tilesize*(1/6)*2, object.y, object.x+tilesize*(1/6)*3, object.y+tilesize*(1/6), object.x+tilesize*(1/6)*4, object.y, object.x+tilesize*(1/6)*5, object.y+tilesize*(1/6), object.x+tilesize, object.y)
		-- end
		-- if object.position[4] == true then
		-- 	love.graphics.line(object.x, object.y+object.h, object.x+tilesize*(1/6), object.y+object.h-tilesize*(1/6), object.x+tilesize*(1/6)*2, object.y+object.h, object.x+tilesize*(1/6)*3, object.y+object.h-tilesize*(1/6), object.x+tilesize*(1/6)*4, object.y+object.h, object.x+tilesize*(1/6)*5, object.y+object.h-tilesize*(1/6), object.x+tilesize, object.y+object.h)
		-- end
		-- if object.position[7] == true then
		-- 	love.graphics.line(object.x, object.y, object.x+tilesize*(1/6), object.y+tilesize*(1/6), object.x, object.y+tilesize*(1/6)*2, object.x+tilesize*(1/6), object.y+tilesize*(1/6)*3, object.x, object.y+tilesize*(1/6)*4, object.x+tilesize*(1/6), object.y+tilesize*(1/6)*5, object.x, object.y+tilesize)
		-- end
		-- if object.position[5] == true then
		-- 	love.graphics.line(object.x+object.w, object.y, object.x+object.w-tilesize*(1/6), object.y+tilesize*(1/6), object.x+object.w, object.y+tilesize*(1/6)*2, object.x+object.w-tilesize*(1/6), object.y+tilesize*(1/6)*3, object.x+object.w, object.y+tilesize*(1/6)*4, object.x+object.w-tilesize*(1/6), object.y+tilesize*(1/6)*5, object.x+object.w, object.y+tilesize)
		-- end
	end
end

function object.position(map,i,j)
	if map[i][j] == 1 then
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
	else
		 return {true,true,true,true,true,true,true,true}
	end
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

function object.createmovingobjects(map,tx,ty,tilesize)
	local objects = {}
	local movingobjects = {}
	for i = 1, #map do
        for j = 1, #map[i] do
            if map[i][j] == 1 then --Vägg/ stillastående block
                table.insert(objects, {x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, r = tilesize/2, mode = 'rect', drawmode = 'fill', position = object.position(map,i,j), enemy = false})
            elseif map[i][j] == 2 then --Vertikalt rörande block
                table.insert(movingobjects, {x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, dx = 0, dy = tilesize*2, position = object.position(map,i,j), enemy = false})
            elseif map[i][j] == 3 then --Horosentalt rörande block
                table.insert(movingobjects, {x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, dx = tilesize*2, dy = 0, position = object.position(map,i,j), enemy = false})
            elseif map[i][j] == 4 then --Vertikalt rörande fiende
                table.insert(movingobjects, {x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, dx = 0, dy = tilesize*2, position = object.position(map,i,j), enemy = true})
            elseif map[i][j] == 5 then --Horosentalt rörande fiende
                table.insert(movingobjects, {x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, dx = tilesize*2, dy = 0, position = object.position(map,i,j), enemy = true})
            elseif map[i][j] == 6 then --Stillastående fiende
                table.insert(objects, {x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, dx = 0, dy = 0, position = object.position(map,i,j), enemy = true})
                --Lägg till resterande från listan i levels.lua
            end
        end
    end
    return objects, movingobjects
end

function object.move(object,dt,objects,movingobjects,players)
	local moveobject = func.shallowCopy(object)
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