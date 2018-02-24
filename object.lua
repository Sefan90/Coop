local func = require 'func'

local object = {
    _VERSION     = '0.0.1',
    _DESCRIPTION = 'Object library',
    _URL         = 'http://foobar.page.or.repo.com',
    _LICENSE     = [[license text, or name/url for long licenses)]]
}

local function objectshape(object)
	if object.type == 'bg' then
		love.graphics.setColor(127, 127, 127)
		love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
	elseif object.type == 'end1' or object.type == 'end2' or object.type == 'start1' or object.type == 'start2' then
		love.graphics.setColor(0, 127, 191)
		love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
	elseif object.type == 'end1door' or object.type == 'end2door' then
		if object.active == false then
			love.graphics.setColor(0, 127, 191)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
		else
			love.graphics.setColor(0, 127, 191)
			love.graphics.rectangle('line', object.x, object.y, object.w, object.h)
		end
	elseif object.type == 'blockplayer1' then
		love.graphics.setColor(127, 127, 0)
		love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
	elseif object.type == 'blockplayer2' then
		love.graphics.setColor(127, 0, 127)
		love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
	elseif object.type == 'box1trigger1' or object.type == 'box1trigger2' then
		if object.active == false then
			love.graphics.setColor(127, 127, 0)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x+object.w*0.1, object.y+object.h*0.1, object.w*0.8, object.h*0.8)
			love.graphics.setColor(127, 127, 0)
			love.graphics.rectangle('fill', object.x+object.w*0.2, object.y+object.h*0.2, object.w*0.6, object.h*0.6)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
			love.graphics.setColor(127, 127, 0)
			love.graphics.rectangle('fill', object.x+object.w*0.1, object.y+object.h*0.1, object.w*0.8, object.h*0.8)
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x+object.w*0.2, object.y+object.h*0.2, object.w*0.6, object.h*0.6)
		end
	elseif object.type == 'player1trigger1' or object.type == 'player1trigger2' then
		if object.active == false then
			love.graphics.setColor(0, 127, 0)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x+object.w*0.1, object.y+object.h*0.1, object.w*0.8, object.h*0.8)
			love.graphics.setColor(0, 127, 0)
			love.graphics.rectangle('fill', object.x+object.w*0.2, object.y+object.h*0.2, object.w*0.6, object.h*0.6)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
			love.graphics.setColor(0, 127, 0)
			love.graphics.rectangle('fill', object.x+object.w*0.1, object.y+object.h*0.1, object.w*0.8, object.h*0.8)
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x+object.w*0.2, object.y+object.h*0.2, object.w*0.6, object.h*0.6)
		end
	elseif object.type == 'box2trigger1' or object.type == 'box2trigger2' then
		if object.active == false then
			love.graphics.setColor(127, 0, 127)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x+object.w*0.1, object.y+object.h*0.1, object.w*0.8, object.h*0.8)
			love.graphics.setColor(127, 0, 127)
			love.graphics.rectangle('fill', object.x+object.w*0.2, object.y+object.h*0.2, object.w*0.6, object.h*0.6)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
			love.graphics.setColor(127, 0, 127)
			love.graphics.rectangle('fill', object.x+object.w*0.1, object.y+object.h*0.1, object.w*0.8, object.h*0.8)
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x+object.w*0.2, object.y+object.h*0.2, object.w*0.6, object.h*0.6)
		end
	elseif object.type == 'player2trigger1' or object.type == 'player2trigger2' then
		if object.active == false then
			love.graphics.setColor(0, 127, 127)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x+object.w*0.1, object.y+object.h*0.1, object.w*0.8, object.h*0.8)
			love.graphics.setColor(0, 127, 127)
			love.graphics.rectangle('fill', object.x+object.w*0.2, object.y+object.h*0.2, object.w*0.6, object.h*0.6)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
			love.graphics.setColor(0, 127, 127)
			love.graphics.rectangle('fill', object.x+object.w*0.1, object.y+object.h*0.1, object.w*0.8, object.h*0.8)
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle('fill', object.x+object.w*0.2, object.y+object.h*0.2, object.w*0.6, object.h*0.6)
		end
	elseif object.type == 'box1door1' or object.type == 'box1door2' then
		if object.active == false and object.gravity == false then
			love.graphics.setColor(127,127,0)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
		elseif object.active == true and object.gravity == false then
			love.graphics.setColor(127,127,0)
			love.graphics.rectangle('line', object.x, object.y, object.w, object.h)
		elseif object.active == false and object.gravity == true then
			love.graphics.setColor(127,127,0)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
		else
			love.graphics.setColor(127,127,0)
			love.graphics.rectangle('line', object.x, object.y, object.w, object.h)
		end
	elseif object.type == 'player1door1' or object.type == 'player1door2' then
		if object.active == false and object.gravity == false then
			love.graphics.setColor(0, 127, 0)
			love.graphics.rectangle('line', object.x, object.y, object.w, object.h)
		elseif object.active == true and object.gravity == false then
			love.graphics.setColor(127, 127, 127)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
			love.graphics.setColor(0, 127, 0)
			love.graphics.rectangle('line', object.x, object.y, object.w, object.h)
		elseif object.active == false and object.gravity == true then
			love.graphics.setColor(0, 127, 0)
			love.graphics.rectangle('line', object.x, object.y, object.w, object.h)
		else
			love.graphics.setColor(127, 127, 127)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
			love.graphics.setColor(0, 127, 0)
			love.graphics.rectangle('line', object.x, object.y, object.w, object.h)
		end
	elseif object.type == 'box2door1' or object.type == 'box2door2' then
		if object.active == false and object.gravity == false then
			love.graphics.setColor(127,0,127)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
		elseif object.active == true and object.gravity == false then
			love.graphics.setColor(127,0,127)
			love.graphics.rectangle('line', object.x, object.y, object.w, object.h)
		elseif object.active == false and object.gravity == true then
			love.graphics.setColor(127,0,127)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
		else
			love.graphics.setColor(127,0,127)
			love.graphics.rectangle('line', object.x, object.y, object.w, object.h)
		end
	elseif object.type == 'player2door1' or  object.type == 'player2door2' then
		if object.active == false and object.gravity == false then
			love.graphics.setColor(0, 127, 127)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
		elseif object.active == true and object.gravity == false then
			love.graphics.setColor(0, 127, 127)
			love.graphics.rectangle('line', object.x, object.y, object.w, object.h)
		elseif object.active == false and object.gravity == true then
			love.graphics.setColor(0, 127, 127)
			love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
		else
			love.graphics.setColor(0, 127, 127)
			love.graphics.rectangle('line', object.x, object.y, object.w, object.h)
		end
	else
		love.graphics.setColor(127, 0, 0)
		--love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
	end
	love.graphics.setColor(255, 255, 255)
end

function object.position(map,i,j)
	if map[i][j] == 0 then
	    local position = {false,false,false,false,false,false,false,false}
	    if i ~= 1 and j ~= 1 then
	        if map[i-1][j-1] ~= 0 then
	            position[1] = true
	        end
	    end
	    if i ~= 1 then
	        if map[i-1][j] ~= 0 then
	            position[2] = true
	        end
	    end
	    if i ~= 1 and j ~= #map[i] then
	        if map[i-1][j+1] ~= 0 then
	            position[3] = true
	        end
	    end
	    if j ~= 1 then
	        if map[i][j-1] ~= 0 then
	            position[4] = true
	        end
	    end
	    if j ~= #map[i] then 
	        if map[i][j+1] ~= 0 then
	            position[5] = true
	        end
	    end
	    if i ~= #map and j ~= 1 then
	        if map[i+1][j-1] ~= 0 then
	            position[6] = true
	        end
	    end
	    if i ~= #map  then
	        if map[i+1][j] ~= 0 then
	            position[7] = true
	        end
	    end
	    if i ~= #map and j ~= #map[i] then
	        if map[i+1][j+1] ~= 0 then
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
    end
    for i = 1, #objects do --Så att boxar kommer över andra obejct i listan
    	if objects[i].type == 'blockplayer1' or objects[i].type == 'blockplayer2' then
        	objectshape(objects[i])
        end
    end
end

function object.createmovingobjects(nextmap,map,gravity,tx,ty,tilesize,world)
	--Fixa så att det skapas object som kan skicka spelaren till en ny level
	local bgobjects = {}
	local objects = {}
	local movingobjects = {}
	local playerstart = {x = 0, y = 0}
	for i = 1, #map do
        for j = 1, #map[i] do
        	if map[i][j] == 2 then --Background
        		table.insert(bgobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, type = 'bg'})
        	elseif map[i][j] == 0 then
                table.insert(objects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, type = 'outside'})
                world:add(objects[#objects],objects[#objects].x,objects[#objects].y,objects[#objects].w,objects[#objects].h)
            elseif map[i][j] == 1 then --Vägg
                table.insert(objects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, type = 'wall'})
                world:add(objects[#objects],objects[#objects].x,objects[#objects].y,objects[#objects].w,objects[#objects].h)
            elseif map[i][j] == 8 then --Block spelare 1
            	table.insert(bgobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, type = 'bg'})
                table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize*2, h = tilesize*2, gravity = gravity, type = 'blockplayer1'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 13 then --Block spelar 2
            	table.insert(bgobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, type = 'bg'})
                table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize*2, h = tilesize*2, gravity = gravity, type = 'blockplayer2'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 9 then --Player1 spawn
            	table.insert(objects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize-tilesize/2, y = ty+(i-1)*tilesize-tilesize/2, w = tilesize*2, h = tilesize*2, type = 'start1'})
                world:add(objects[#objects],objects[#objects].x,objects[#objects].y,objects[#objects].w,objects[#objects].h)
            	table.insert(bgobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, type = 'bg'})
            	if nextmap == true then
            		playerstart.x = tx+(j-1)*tilesize
            		playerstart.y = ty+(i-1)*tilesize
            	end
            elseif map[i][j] == 11 then --Player2 spawn
            	table.insert(objects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize-tilesize/2, y = ty+(i-1)*tilesize-tilesize/2, w = tilesize*2, h = tilesize*2, type = 'start2'})
                world:add(objects[#objects],objects[#objects].x,objects[#objects].y,objects[#objects].w,objects[#objects].h)
            	table.insert(bgobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, type = 'bg'})
            	if nextmap == true then
            		playerstart.x = tx+(j-1)*tilesize
            		playerstart.y = ty+(i-1)*tilesize
            	end
            elseif map[i][j] == 10 then --Player1 end
            	table.insert(objects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize-tilesize/2, y = ty+(i-1)*tilesize-tilesize/2, w = tilesize*2, h = tilesize*2, type = 'end1'})
                world:add(objects[#objects],objects[#objects].x,objects[#objects].y,objects[#objects].w,objects[#objects].h)
                if nextmap == false then
            		playerstart.x = tx+(j-1)*tilesize
            		playerstart.y = ty+(i-1)*tilesize
            	end
            elseif map[i][j] == 12 then --Player2 end
            	table.insert(objects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize-tilesize/2, y = ty+(i-1)*tilesize-tilesize/2, w = tilesize*2, h = tilesize*2, type = 'end2'})
                world:add(objects[#objects],objects[#objects].x,objects[#objects].y,objects[#objects].w,objects[#objects].h)
            	if nextmap == false then
            		playerstart.x = tx+(j-1)*tilesize
            		playerstart.y = ty+(i-1)*tilesize
            	end
            elseif map[i][j] == 3 then --Trigger1 för block spelare 1
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, gravity = gravity, active = false, type = 'end1door'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 4 then --Trigger1 för spelare 1
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, gravity = gravity, active = false, type = 'end2door'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)

            elseif map[i][j] == 15 then --Trigger1 för block spelare 1
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize*2, h = tilesize*2, gravity = gravity, active = false, type = 'box1trigger1'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 16 then --Trigger1 för spelare 1
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize*2, h = tilesize*2, gravity = gravity, active = false, type = 'player1trigger1'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 20 then --Trigger1 för block spelare 2
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize*2, h = tilesize*2, gravity = gravity, active = false, type = 'box2trigger1'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 18 then --Trigger1 för spelare 2
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize*2, h = tilesize*2, gravity = gravity, active = false, type = 'player2trigger1'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)

            elseif map[i][j] == 22 then --Trigger2 för block spelare 1
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize*2, h = tilesize*2, gravity = gravity, active = false, type = 'box1trigger2'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 17 then --Trigger2 för spelare 1
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize*2, h = tilesize*2, gravity = gravity, active = false, type = 'player1trigger2'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 27 then --Trigger2 för block spelare 2
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize*2, h = tilesize*2, gravity = gravity, active = false, type = 'box2trigger2'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 19 then --Trigger2 för spelare 2
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize*2, h = tilesize*2, gravity = gravity, active = false, type = 'player2trigger2'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)

            elseif map[i][j] == 36 then --Door1 för block spelare 1
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, gravity = gravity, active = false, type = 'box1door1'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 24 then --Door1 för spelare 1
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, gravity = gravity, active = false, type = 'player1door1'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 41 then --Door1 för block spelare 2
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, gravity = gravity, active = false, type = 'box2door1'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 26 then --Door1 för spelare 2
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, gravity = gravity, active = false, type = 'player2door1'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)

            elseif map[i][j] == 43 then --Door2 för block spelare 1
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, gravity = gravity, active = false, type = 'box1door2'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 30 then --Door2 för spelare 1
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, gravity = gravity, active = false, type = 'player1door2'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 48 then --Door2 för block spelare 2
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, gravity = gravity, active = false, type = 'box2door2'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            elseif map[i][j] == 32 then --Door2 för spelare 2
            	table.insert(movingobjects, {name ='x'..i..'y'..j, x = tx+(j-1)*tilesize, y = ty+(i-1)*tilesize, w = tilesize, h = tilesize, gravity = gravity, active = false, type = 'player2door2'})
                world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
            end
        end
    end
    return playerstart, bgobjects, objects, movingobjects
end

function object.move(object,x,y,world)
	local actualX, actualY, cols, len = world:move(object, object.x + x, object.y + y,playerFilter)
  	object.x, object.y = actualX, actualY
end

function object.fall(moveobject,tilesize,dt,world)
	if moveobject.gravity == true and (moveobject.type == 'blockplayer1' or moveobject.type == 'blockplayer2') then
		object.move(moveobject,0,tilesize*6*dt,world)
	end
end

function object.check(object, objects, world)
	if object.type == 'box1trigger1' or object.type == 'player1trigger1' or object.type == 'box2trigger1' or object.type == 'player2trigger1'
	or object.type == 'box1trigger2' or object.type == 'player1trigger2' or object.type == 'box2trigger2' or object.type == 'player2trigger2' then
		local active = false
		local actualX, actualY, cols, len = world:check(object, object.x + 1, object.y+1,playerFilter)
		for i=1,len do
    		local other = cols[i].other
    		if ((object.type == 'box1trigger1' or object.type == 'box1trigger2') and other.type == 'blockplayer1') or ((object.type == 'player1trigger1' or object.type == 'player1trigger2') and other.name == 'p1') 
    		or ((object.type == 'box2trigger1' or object.type == 'box2trigger2') and other.type == 'blockplayer2') or ((object.type == 'player2trigger1' or object.type == 'player2trigger2') and other.name == 'p2') then
    			active = true
    		end
    	end
    	object.active = active
    -- 	local list = {}
  	-- 	for i = 1, #objects do 
    -- 		for j = 1, #objects[i] do
    -- 			if object.type == objects[i].type then
    -- 				table.insert(list,objects[i].active)
    -- 			end
    -- 		end
    -- 	end
    -- 	active = true
    -- 	for i = 1, #list do
    -- 		if list[i] == false then
    -- 			active = false
    -- 		end
    -- 	end
		for i = 1, #objects do 
    		for j = 1, #objects[i] do
    			if objects[i][j].type == string.gsub(object.type,'trigger','door') then
    				objects[i][j].active = active
    			end
    		end
    	end
    end
end

return object