local player = require 'player'
local object = require 'object'
local camera = require 'camera'
local func = require 'func'
local salg = require 'salg'
local bump = require 'bump'
local loadmap = require 'loadmap'
--local sti = require 'sti'

local mapsize = {x=48,y=36}
local width, height = love.graphics.getDimensions()
local tilesize = func.getTileSize(width,height,mapsize)
local world = {bump.newWorld(tilesize), bump.newWorld(tilesize)}
local tx = (width-tilesize*mapsize.x)/2
local ty = (height-tilesize*mapsize.y)/2
local players = {
    {x = tx/2+tilesize*3, y = ty/2+tilesize*3, w = tilesize*2-1, h = tilesize*2-1, r = (tilesize-1)/2, speed = tilesize*6, jump = false, jumptime = 0, up = 'w', left = 'a', down = 's', right = 'd', flying = true, alive = true, level = 10},
    {x = tx/2+tilesize*5, y = height-ty/2-tilesize*5, w = tilesize*2-1, h = tilesize*2-1, r = (tilesize-1)/2, speed = tilesize*6, jump = false, jumptime = 0, up = 'up', left = 'left', down = 'down', right = 'right', flying = false, alive = true, level = 11}
}
world[1]:add(players[1],players[1].x,players[1].y,players[1].w,players[1].h)
world[2]:add(players[2],players[2].x,players[2].y,players[2].w,players[2].h)
--stimap = sti("maps/coopTest8.lua", { "bump" },tx,ty)

local bgobjects, objects, movingobjects, objectcavanas = {}, {}, {}, {}
for i = 1, #players do
    bgobjects[i], objects[i], movingobjects[i] = loadmap.newmap(players[i],0,0,tilesize,world[i])   
    objectcavanas[i] = love.graphics.newCanvas(width,height)
end

function love.load()
    --Fixa så den byter bana och sparar banorna.
    camera1 = camera.new(tx,ty,tx,ty,width,height)--(width-2*tx),(height-2*ty)) --,width/4,height/4,width/4,height/4)
    for i = 1, #players do
        love.graphics.setCanvas(objectcavanas[i])
        object.drawobjects(objects[i])
        love.graphics.setCanvas()
    end
    salg:save(camera1:getXY(),players)
end

function love.update(dt)
    --Fixa till så att man kan byta bana om man nuddar ett obeject och trycker nån knapp.
    --stimap:update(dt)
    if love.keyboard.isDown('r') then
        bgobjects[1], objects[1], movingobjects[1] = loadmap.nextmap(players[1],objects[1],movingobjects[1],0,0,tilesize,world[1])
        objectcavanas[1] = love.graphics.newCanvas(width,height)
        love.graphics.setCanvas(objectcavanas[1])
        object.drawobjects(objects[1])
        love.graphics.setCanvas()
    end
    --    local cameradata, playerdata = salg:load()
    --     camera1:setXY(cameradata.x,cameradata.y)
    --     players = playerdata
    --end
    for i = 1, #players do
        players[i] = player.move(players[i],dt,world[i])
    end
    for i = 1, #movingobjects do
        for j = 1, #movingobjects[i] do
            movingobjects[i][j] = object.move(movingobjects[i][j],dt,world[i])
        end
    end
    --if camera1:checkplayer(players[1]) then --Fixa så den endast sparar när man byter skärm.
    --    salg:save(camera1:getXY(),players)
    --end
end

function love.draw()
    camera1:set()
    for i = 1, #players do
        love.graphics.draw(objectcavanas[i], 0, 0)
    end
    player.drawplayers(players)
    love.graphics.print(tostring(players[1].alive), 400, 300)
    --love.graphics.print(levels[1][2][1], 400, 400)
    for i = 1, #players do
        object.drawobjects(movingobjects[i])
    end
    camera1:unset()
    love.graphics.print(players[1].x, 100, 100)
    --stimap:draw()
    --stimap:bump_draw()
end

--Bygg en bana att testa på.
