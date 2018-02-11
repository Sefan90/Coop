local levels = require 'levels'
local object = require 'object'
local func = require 'func'
local loadmap = {}

local function removebumpobjects(objects,world)
	for i = #objects, 1, -1 do
		local obj = objects[i].name
		world:remove(obj)
		temp = world:getItems()
		table.remove(objects, i)

	end
end

local function loadlevel(player)
	if player.flying == true then
		return levels[player.level]
	else
		return levels[player.level]
	end
end

local function nextlevel(player)
	player.level = player.level + 1
	return player
end

local function createbumpobjects(player,x,y,tilesize,world)
	return object.createmovingobjects(loadlevel(player),x,y,tilesize,world)
end

function loadmap.newmap(player,x,y,tilesize,world)
	return createbumpobjects(player,x,y,tilesize,world)
end

function loadmap.nextmap(player,objects,movingobjects,x,y,tilesize,world)
	removebumpobjects(objects,world)
	removebumpobjects(movingobjects,world)
	if player.level  == #levels then
		player.level = #levels-1
	end
	return createbumpobjects(nextlevel(player),x,y,tilesize,world)
end

return loadmap