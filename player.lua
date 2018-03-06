local func = require 'func'
local object = require 'object'

local player = {
    _VERSION     = '0.0.1',
    _DESCRIPTION = 'Player library',
    _URL         = 'http://foobar.page.or.repo.com',
    _LICENSE     = [[license text, or name/url for long licenses)]]
}

local function moveplayer(player,x,y,dt,world)
	local actualX, actualY, cols, len = world:check(player, player.x+x, player.y+y, playerFilter)
	for i=1,len do
    	local other = cols[i].other
    	if other.type == 'box' then
    		object.move(other,x,y,world)
    	end
    end
    local actualX, actualY, cols, len = world:move(player, player.x+x, player.y+y, playerFilter)
    player.x, player.y = actualX, actualY
    return player
end

function player.move(player,dt,world)
	--Fixa typ om man trycker upp och står på en 
    if love.keyboard.isDown(player.left) then
    	player = moveplayer(player,-player.speed*dt,0,dt,world)
    end
    if love.keyboard.isDown(player.right) then
    	player = moveplayer(player,player.speed*dt,0,dt,world)
    end
    if player.flying == true then
	    if love.keyboard.isDown(player.up) then
	    	player = moveplayer(player,0,-player.speed*dt,dt,world)
	    end
	    if love.keyboard.isDown(player.down) then
	    	player = moveplayer(player,0,player.speed*dt,dt,world)
	    end
	else
		if love.keyboard.isDown(player.up) and player.jump == false then
			player.jumptime = player.jumptime - player.speed
			player.jump = true
		end
	    if love.keyboard.isDown(player.down) then
	    	player.jumptime = player.jumptime + player.speed*2*dt
	    end
	    if player.jumptime <= -player.speed/2 then
	    	player.jumptime = player.jumptime + player.speed/1.6*dt
		else
			player.jumptime = player.jumptime + player.speed*2*dt
		end
		local actualX, actualY, cols, len = world:move(player, player.x, player.y + player.jumptime*dt, playerFilter)
		if actualY == player.y then
			player.jump = false
			player.jumptime = 0
		end
	  	player.x, player.y = actualX, actualY
	end

    return player
end

function player.drawplayers(objects)
    love.graphics.setColor(255, 255, 255)
    --love.graphics.rectangle('fill', objects.x, objects.y, objects.w, objects.h, objects.w/5, objects.h/5,objects.w)
    love.graphics.draw(atlas.img,atlas.player,objects.x, objects.y,0,tilesize/16,tilesize/16)
end

function player.checkmap(player,world)
	local actualX, actualY, cols, len = world:check(player, player.x + 1, player.y, playerFilter)
	for i=1,len do
    	local other = cols[i].other
    	if other.type == 'end1' or other.type == 'end2' then
    		return 'end'
    	elseif other.type == 'start1' or other.type == 'start2' then
    		return 'start'
    	end
    end
    return ''
end

function player.outsideofmap(player,mapsize,tilesize,world)
	local actualX, actualY, cols, len = world:check(player, player.x + 1, player.y, playerFilter)
	for i=1,len do
    	local other = cols[i].other
    	if other.type == 'outside' then
    		return true
    	end
    end
	if player.x < 0 or player.x > mapsize.x*tilesize or player.y < 0 or player.y > mapsize.y*tilesize then
		return true
	end
	return false
end

playerFilter = function(item, other)
	if other.type == 'box1trigger1' then return 'cross'
	elseif other.type == 'player1trigger1' then return 'cross'
	elseif other.type == 'box2trigger1' then return 'cross'
	elseif other.type == 'player2trigger1' then return 'cross'
	elseif other.type == 'box1trigger2' then return 'cross'
	elseif other.type == 'player1trigger2' then return 'cross'
	elseif other.type == 'box2trigger2' then return 'cross'
	elseif other.type == 'player2trigger2' then return 'cross'
	elseif other.type == 'box1door1' and other.active == true then return 'cross'
	elseif other.type == 'player1door1' and other.active == true then return 'cross'
	elseif other.type == 'box2door1' and other.active == true then return 'cross'
	elseif other.type == 'player2door1' and other.active == true then return 'cross'
	elseif other.type == 'box1door2' and other.active == true then return 'cross'
	elseif other.type == 'player1door2' and other.active == true then return 'cross'
	elseif other.type == 'box2door2' and other.active == true then return 'cross'
	elseif other.type == 'player2door2' and other.active == true then return 'cross'
  	elseif other.type == 'start1' then return 'cross'
 	elseif other.type == 'start2' then return 'cross'
  	elseif other.type == 'end1' then return 'cross'
 	elseif other.type == 'end2' then return 'cross'
 	elseif other.type == 'end1door' and other.active == true then return 'cross'
 	elseif other.type == 'end2door' and other.active == true then return 'cross'
  	else return 'touch'
  	end
end

return player
