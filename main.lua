local collision = require 'collision'
local levels = require 'levels'
local player = require 'player'
local object = require 'object'
local camera = require 'camera'
local func = require 'func'
local salg = require 'salg'

local width, height = love.graphics.getDimensions()
local map = levels[8]
local tilesize = func.getTileSize(width,height)
local tx = (width-tilesize*64)/2 --16
local ty = (height-tilesize*36)/2 --12
local players = {
    {x = tx/2+tilesize*3, y = ty/2+tilesize*3, w = tilesize*2-1, h = tilesize*2-1, r = (tilesize-1)/2, speed = tilesize*6, mode = 'rect', drawmode = 'line', up = 'w', left = 'a', down = 's', right = 'd', moving = 0, flying = false, alive = true},
    {x = width-tx/2-tilesize*3, y = height-ty/2-tilesize*3, w = tilesize*2-1, h = tilesize*2-1, r = (tilesize-1)/2, speed = tilesize*6, mode = 'rect', drawmode = 'line', up = 'up', left = 'left', down = 'down', right = 'right', moving = 0, flying = false, alive = true}
        --{x = 512, y = 256, w = 30, h = 30, r = 15, speed = 128, mode = 'rect', drawmode = 'line', up = 'up', left = 'left', down = 'down', right = 'right', moving = 0, flying = false}
    }
local objects, movingobjects = object.createmovingobjects(map,0,0,tilesize)
local objectcavanas = love.graphics.newCanvas(width*3,height*3)

function love.load()
    --Fixa så den byter bana och sparar banorna.
    camera1 = camera.new(tx,ty,tx,ty,width,height)--(width-2*tx),(height-2*ty)) --,width/4,height/4,width/4,height/4)
    --camera2 = camera.new(0,height/4,width/4,height/4,width/4,height/4)
    love.graphics.setCanvas(objectcavanas)
    object.drawobjects(objects)
    love.graphics.setCanvas()
    salg:save(camera1:getXY(),players)
end

function love.update(dt)
    if love.keyboard.isDown('r') then
        local cameradata, playerdata = salg:load()
         camera1:setXY(cameradata.x,cameradata.y)
         players = playerdata
    end
    for i = 1, #players do
        players[i] = player.move(players[i],dt,objects,movingobjects,players)
    end
    for i = 1, #movingobjects do
        movingobjects[i] = object.move(movingobjects[i],dt,objects,movingobjects,players)
    end
    --if camera1:checkplayer(players[1]) then --Fixa så den endast sparar när man byter skärm.
    --    salg:save(camera1:getXY(),players)
    --end
    --camera2:checkplayer(players[2])
end

function love.draw()
    camera1:set()
    love.graphics.draw(objectcavanas, 0, 0)
    player.drawplayers(players)
    love.graphics.print(tostring(players[1].alive), 400, 300)
    love.graphics.print(levels[1][2][1], 400, 400)
    object.drawobjects(movingobjects)
    camera1:unset()
    love.graphics.print(players[1].x, 100, 100)

    -- camera2:set()
    -- love.graphics.draw(objectcavanas, 0, 0)
    -- player.drawplayers(players)
    -- love.graphics.print(tostring(players[1].alive), 400, 300)
    -- love.graphics.print(levels[1][2][1], 400, 400)
    -- object.drawobjects(movingobjects)
    -- camera2:unset()
end

--Bygg en bana att testa på.
