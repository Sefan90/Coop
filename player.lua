local collision = require 'collision'
local func = require 'func'

local player = {
    _VERSION     = '0.0.1',
    _DESCRIPTION = 'Player library',
    _URL         = 'http://foobar.page.or.repo.com',
    _LICENSE     = [[license text, or name/url for long licenses)]]
}

function player.move(player,dt,objects,movingobjects,players)
    local moveplayer = func.shallowCopy(player)
    if player.moving == 1 then
        moveplayer.y = player.y - player.speed*dt
    elseif player.moving == 2 then
        moveplayer.x = player.x - player.speed*dt
    elseif player.moving == 3 then
        moveplayer.y = player.y + player.speed*dt
    elseif player.moving == 4 then
        moveplayer.x = player.x + player.speed*dt
    elseif love.keyboard.isDown(player.up) then
        moveplayer.moving = 1
    elseif love.keyboard.isDown(player.left) then
        moveplayer.moving = 2
    elseif love.keyboard.isDown(player.down) then
        moveplayer.moving = 3
    elseif love.keyboard.isDown(player.right) then
        moveplayer.moving = 4
    elseif love.keyboard.isDown('space') then
        moveplayer.mode = 'circle'--players[1].mode+1-math.floor(players[1].mode+1/2)*2
    end

    --FULFIX
    if player.moving ~= 0 then
    	player.moving = 0
    	moveplayer.moving = 0
    end


    local collisioncheckers = {}
    table.insert(collisioncheckers,collision.checkObjects(player,moveplayer,objects))
    table.insert(collisioncheckers,collision.checkObjects(player,moveplayer,movingobjects))
    table.insert(collisioncheckers,collision.checkObjects(player,moveplayer,players))

    if collisioncheckers[1][1] and collisioncheckers[2][1] and collisioncheckers[3][1] then
        return moveplayer
    else
    	if collisioncheckers[1][2] == false or collisioncheckers[2][2] == false or collisioncheckers[3][2] == false then
    		player.alive = false
    	end
        player.moving = 0
        return player
    end
end

function player.drawplayers(objects)
    for i = 1, #objects do
        if objects[i].mode == 'rect' then
            love.graphics.rectangle('fill', objects[i].x, objects[i].y, objects[i].w, objects[i].h)
            love.graphics.rectangle(objects[i].drawmode, objects[i].x, objects[i].y, objects[i].w, objects[i].h)
        elseif objects[i].mode == 'circle' then
            love.graphics.circle(objects[i].drawmode, objects[i].x+objects[i].r, objects[i].y+objects[i].r, objects[i].r,4)
        else
            love.graphics.circle(objects[i].drawmode, objects[i].x+objects[i].r, objects[i].y+objects[i].r, objects[i].r)
        end
    end
end

return player