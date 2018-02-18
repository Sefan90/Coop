local player1levels = require 'player1levels'
local player2levels = require 'player2levels'
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
	if player.flying == true then
		map1d = love.filesystem.load('maps/coopTest'..player.level..'.lua')().layers[1].data --player1levels[player.level]
		gravity = false
	else
		map1d = love.filesystem.load('maps/coopTest'..player.level..'.lua')().layers[2].data--player2levels[player.level]
		gravity = true
	end
	local map2d = {}
	for i = 1, 48 do
		map2d[i] = {}
	end
	for i = 1, #map1d do
		map2d[math.floor((i - 1) / 48) + 1][math.floor((i - 1) % 48) + 1] = map1d[i]
	end
	return map2d, gravity
end

local function nextlevel(player)
	player.level = player.level + 1
	return player
end

local function createbumpobjects(player,x,y,tilesize,world)
	local level, gravity = loadlevel(player)
	return object.createmovingobjects(level,gravity,x,y,tilesize,world)
end

function loadmap.newmap(player,x,y,tilesize,world)
	return createbumpobjects(player,x,y,tilesize,world)
end

function loadmap.nextmap(player,objects,movingobjects,x,y,tilesize,world)
	removebumpobjects(objects,world)
	removebumpobjects(movingobjects,world)
	if player.flying == true then
		if player.level  == #player1levels then
			player.level = #player1levels-1
		end
	else
		if player.level  == #player2levels then
			player.level = #player2levels-1
		end
	end
	return createbumpobjects(nextlevel(player),x,y,tilesize,world)
end

return loadmap