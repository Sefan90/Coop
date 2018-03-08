local func = require 'func'

local object = {
    _VERSION     = '0.0.1',
    _DESCRIPTION = 'Object library',
    _URL         = 'http://foobar.page.or.repo.com',
    _LICENSE     = [[license text, or name/url for long licenses)]]
}

local function objectshape(object)
	if object.id ~= 0 and object.id ~= 1 then
		local tileX = object.x
		local tileY = object.y
		local origx = object.x
		local origy = object.y
		local compx = 0
		local compy = 0
		-- Compensation for scale/rotation shift
		if object.sx < 0 then compx = tilesize end
		if object.sy < 0 then compy = tilesize end

		if object.r > 0 then
			tileX = tileX + tilesize - compy
			tileY = tileY + compx
		elseif object.r < 0 then
			tileX = tileX + compy
			tileY = tileY - compx + tilesize
		else
			tileX = tileX + compx
			tileY = tileY + compy
		end
		if object.id > 20 and object.id < 29 and object.active == true then
			love.graphics.draw(atlas.img,atlas.draw[30],tileX,tileY,object.r,tilesize/16*object.sx,tilesize/16*object.sy)
		elseif object.id > 30 and object.id < 40 and object.active == true then
			love.graphics.draw(atlas.img,atlas.draw[2],tileX,tileY,object.r,tilesize/16*object.sx,tilesize/16*object.sy)
		else
			love.graphics.draw(atlas.img,atlas.draw[object.id],tileX,tileY,object.r,tilesize/16*object.sx,tilesize/16*object.sy)
		end
	end
end

local function setFlippedID(id)
	local bit31   = 2147483648
	local bit30   = 1073741824
	local bit29   = 536870912
	local flipX   = false
	local flipY   = false
	local flipD   = false
	local realid = id

	if realid >= bit31 then
		realid = realid - bit31
		flipX   = not flipX
	end

	if realid >= bit30 then
		realid = realid - bit30
		flipY   = not flipY
	end

	if realid >= bit29 then
		realid = realid - bit29
		flipD   = not flipD
	end

	local data = {
		id = realid,
		r = math.rad(0),
		sx = 1,
		sy = 1
	}

	if flipX then
		if flipY and flipD then
			data.r  = math.rad(-90)
			data.sy = -1
		elseif flipY then
			data.sx = -1
			data.sy = -1
		elseif flipD then
			data.r = math.rad(90)
		else
			data.sx = -1
		end
	elseif flipY then
		if flipD then
			data.r = math.rad(-90)
		else
			data.sy = -1
		end
	elseif flipD then
		data.r  = math.rad(90)
		data.sy = -1
	end

	return data
end

local function subtiles(i,j,map,tx,ty,tilesize,data,world)
	if data.r == 0 then
	elseif data.r == math.rad(-90) then
	end
end

local function createobject(i,j,map,tx,ty,tilesize,data)
	return {
		name ='x'..i..'y'..j, 
		x = tx+(j-1)*tilesize, 
		y = ty+(i-1)*tilesize, 
		w = tilesize, 
		h = tilesize, 
		r = data.r, 
		sx = data.sx, 
		sy = data.sy, 
		id = data.id, 
		position = object.position(map,i,j),
		gravity = data.gravity,
		active = false
	}
end

function object.position(map,i,j)
    local position = {false,false,false,false}
    if i ~= 1 then
        if map[i-1][j] == 1 then
            position[1] = true
        end
    end
    if j ~= 1 then
        if map[i][j-1] == 1 then
            position[2] = true
        end
    end
    if j ~= #map[i] then 
        if map[i][j+1] == 1 then
            position[3] = true
        end
    end
    if i ~= #map  then
        if map[i+1][j] == 1 then
            position[4] = true
        end
    end
    return position
end

function object.drawobjects(objects)
    for i = 1, #objects do
        objectshape(objects[i])
    end
    for i = 1, #objects do --Så att boxar kommer över andra obejct i listan
    	if objects[i].id == 11 then
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
        	local data = setFlippedID(map[i][j])
        	data.gravity = gravity
			if data.id == 1 then
				table.insert(objects, createobject(i,j,map,tx,ty,tilesize,data))
				world:add(objects[#objects],objects[#objects].x,objects[#objects].y,objects[#objects].w,objects[#objects].h)
        	elseif data.id < 11 or (data.id > 11 and data.id < 21) then
        		table.insert(bgobjects, createobject(i,j,map,tx,ty,tilesize,data))
        		if ((data.id == 12 or data.id == 14) and nextmap == true) or ((data.id == 13 or data.id == 15) and nextmap == false) then
            		playerstart.x = tx+(j-1)*tilesize
            		playerstart.y = ty+(i-1)*tilesize
            	end
            	if data.id == 12 or data.id == 14 or data.id == 13 or data.id == 15 then
					table.insert(objects, createobject(i,j,map,tx,ty,tilesize,data))
					world:add(objects[#objects],objects[#objects].x,objects[#objects].y,objects[#objects].w,objects[#objects].h)
            	end
        	elseif data.id == 11 then
        		table.insert(movingobjects, createobject(i,j,map,tx,ty,tilesize,data))
        		world:add(movingobjects[#movingobjects],movingobjects[#movingobjects].x,movingobjects[#movingobjects].y,movingobjects[#movingobjects].w,movingobjects[#movingobjects].h)
        		data.id = 2
        		table.insert(bgobjects, createobject(i,j,map,tx,ty,tilesize,data))
        	elseif data.id > 20 then
        		table.insert(movingobjects, createobject(i,j,map,tx,ty,tilesize,data))
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
	if moveobject.gravity == true and moveobject.id == 11 then
		object.move(moveobject,0,tilesize*6*dt,world)
	end
end

function object.check(object, objects, world)
	if object.id == 21 or object.id == 22 or object.id == 23 or object.id == 24 or object.id == 25 or object.id == 26 or object.id == 27 or object.id == 28 then

		local active = false
		local actualX, actualY, cols, len = world:check(object, object.x, object.y,playerFilter)
		for i=1,len do
    		local other = cols[i].other
    		if ((object.id == 21 or object.id == 22 or object.id == 27 or object.id == 28) and other.id == 11) 
    		or ((object.id == 23 or object.id == 24) and other.name == 'p1') or ((object.id == 25 or object.id == 26) and other.name == 'p2') then
    			active = true
    		end
    	end
    	object.active = active
		for i = 1, #objects do 
    		for j = 1, #objects[i] do
    			if objects[i][j].id == object.id+10 then
    				objects[i][j].active = active
    			end
    		end
    	end
    end
end

return object