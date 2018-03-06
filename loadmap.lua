local object = require 'object'
local func = require 'func'
local loadmap = {}

local function removebumpobjects(objects,world)
	for i = #objects, 1, -1 do
		local obj = objects[i]
		world:remove(obj)
		temp = world:getItems()
		table.remove(objects, i)

	end
end

local function loadlevel(player)
	local gravity = false
	local map1d = nil 
	print(player.level)
	if player.flying == true then
		map1d = love.filesystem.load('maps/level'..player.level..'.lua')().layers[1].data
		gravity = false
	else
		map1d = love.filesystem.load('maps/level'..player.level..'.lua')().layers[2].data
		gravity = true
	end
	local map2d = {}
	for i = 1, mapsize.x do
		map2d[i] = {}
	end
	for i = 1, #map1d do
		map2d[math.floor((i - 1) / mapsize.x) + 1][math.floor((i - 1) % mapsize.x) + 1] = map1d[i]
	end
	return map2d, gravity
end

local function nextlevel(player)
	player.level = player.level + 1
	return player
end

local function previouslevel(player)
	player.level = player.level - 1
	return player
end

local function createbumpobjects(nextlevel,player,x,y,tilesize,world)
	local level, gravity = loadlevel(player)
	return object.createmovingobjects(nextlevel,level,gravity,x,y,tilesize,world)
end

function loadmap.newmap(player,x,y,tilesize,world)
	return createbumpobjects(true,player,x,y,tilesize,world)
end

function loadmap.nextmap(player,objects,movingobjects,x,y,tilesize,world)
	removebumpobjects(objects,world)
	removebumpobjects(movingobjects,world)
	if player.level == 10 then
		player.level = 9
		print("player.level är för stor")
	end
	return createbumpobjects(true,nextlevel(player),x,y,tilesize,world)
end

function loadmap.previousmap(player,objects,movingobjects,x,y,tilesize,world)
	removebumpobjects(objects,world)
	removebumpobjects(movingobjects,world)
	if player.level == 1 then
		player.level = 2
		print("player.level är för liten")
	end
	return createbumpobjects(false,previouslevel(player),x,y,tilesize,world)
end

function loadmap.reloadmap(player,objects,movingobjects,x,y,tilesize,world)
	removebumpobjects(objects,world)
	removebumpobjects(movingobjects,world)
	return createbumpobjects(true,player,x,y,tilesize,world)
end

return loadmap