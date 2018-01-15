local collision = require 'collision'
local player = {
    _VERSION     = '0.0.1',
    _DESCRIPTION = 'Player library',
    _URL         = 'http://foobar.page.or.repo.com',
    _LICENSE     = [[license text, or name/url for long licenses)]]
}

function player.move(player,dt)
    local moveplayer = shallowCopy(player)
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

    if collision.checkObjects(player,moveplayer,objects) and collision.checkObjects(player,moveplayer,players) then
        return moveplayer
    else
        player.moving = 0
        return player
    end
end

function player.drawplayers(objects)
    for i = 1, #objects do
        if objects[i].mode == 'rect' then
            love.graphics.rectangle(objects[i].drawmode, objects[i].x, objects[i].y, objects[i].w, objects[i].h)
        elseif objects[i].mode == 'circle' then
            love.graphics.circle(objects[i].drawmode, objects[i].x+objects[i].r, objects[i].y+objects[i].r, objects[i].r,4)
        else
            love.graphics.circle(objects[i].drawmode, objects[i].x+objects[i].r, objects[i].y+objects[i].r, objects[i].r)
        end
    end
end

return player