local func = require 'func'

local player = {
    _VERSION     = '0.0.1',
    _DESCRIPTION = 'Player library',
    _URL         = 'http://foobar.page.or.repo.com',
    _LICENSE     = [[license text, or name/url for long licenses)]]
}

function player.move(player,dt,world)
    if love.keyboard.isDown(player.left) then
  		local actualX, actualY, cols, len = world:move(player, player.x - player.speed*dt, player.y, playerFilter)
  		player.x, player.y = actualX, actualY
    end
    if love.keyboard.isDown(player.right) then
  		local actualX, actualY, cols, len = world:move(player, player.x + player.speed*dt, player.y, playerFilter)
  		player.x, player.y = actualX, actualY
    end
    if player.flying == true then
	    if love.keyboard.isDown(player.up) then
	        local actualX, actualY, cols, len = world:move(player, player.x, player.y - player.speed*dt, playerFilter)
  			player.x, player.y = actualX, actualY
	    end
	    if love.keyboard.isDown(player.down) then
	        local actualX, actualY, cols, len = world:move(player, player.x, player.y + player.speed*dt, playerFilter)
  			player.x, player.y = actualX, actualY
	    end
	else
		if love.keyboard.isDown(player.up) and player.jump == false then
			player.jumptime = player.jumptime + 1
			player.jump = true
		end
	    if love.keyboard.isDown(player.down) and player.jump == true then
	    	player.jumptime = player.jumptime - 0.1
	    end
	    if player.jump == true then
	    	player.jumptime = player.jumptime - 0.0006
	    	if player.jumptime < 0 then
	    		player.jumptime = 0
	    	end
	    end
		local actualX, actualY, cols, len = world:move(player, player.x, player.y + player.speed*dt*(-player.jumptime+1) - player.speed*dt*(player.jumptime), playerFilter)
		if actualY == player.y and player.jumptime == 0 then
			player.jump = false
		end
	  	player.x, player.y = actualX, actualY
	end

    return player
end

function player.drawplayers(objects)
    for i = 1, #objects do
        love.graphics.rectangle('fill', objects[i].x, objects[i].y, objects[i].w, objects[i].h)
    end
end

return player

