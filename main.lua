local player = require 'player'
local object = require 'object'
local camera = require 'camera'
local func = require 'func'
local salg = require 'salg'
local bump = require 'bump'
local loadmap = require 'loadmap'
require 'autobatch'

local mapsize = {x=48,y=36}
local width, height = love.graphics.getDimensions()
local tilesize = func.getTileSize(width,height,mapsize)
local world = {bump.newWorld(tilesize), bump.newWorld(tilesize)}
local tx = (width-tilesize*mapsize.x)/2
local ty = (height-tilesize*mapsize.y)/2
local players = {
    {name = 'p1', x = 0, y = 0, w = tilesize*2, h = tilesize*2, speed = tilesize*5, jump = true, jumptime = 0, up = 'w', left = 'a', down = 's', right = 'd', nextlevel = 'q', nextlevelpressed = false, reload = 'r', reloadpressed = false, flying = true, alive = true, level = 1},
    {name = 'p2', x = 0, y = 0, w = tilesize*2, h = tilesize*2, speed = tilesize*5, jump = true, jumptime = 0, up = 'up', left = 'left', down = 'down', right = 'right', nextlevel = 'p', nextlevelpressed = false, reload = 'i', reloadpressed = false, flying = false, alive = true, level = 1}
}
world[1]:add(players[1],players[1].x,players[1].y,players[1].w,players[1].h)
world[2]:add(players[2],players[2].x,players[2].y,players[2].w,players[2].h)
--love.image.newImageData(1,1)
local imagedata = love.image.newImageData('/maps/img/pixel.png')
image = love.graphics.newImage(imagedata)

local bgobjects, objects, movingobjects, objectcavanas = {}, {}, {}, {}
for i = 1, #players do
    playerstart, bgobjects[i], objects[i], movingobjects[i] = loadmap.newmap(players[i],0,0,tilesize,world[i])   
    objectcavanas[i] = love.graphics.newCanvas(width,height)
    world[i]:update(players[i],playerstart.x,playerstart.y)
    players[i].x = playerstart.x
    players[i].y = playerstart.y
end

function love.load()
    --print(love.filesystem.load('maps/coopTest5.lua')layers[1].data)
    --Fixa så den byter bana och sparar banorna.
    camera1 = camera.new(tx,ty,tx,ty,width,height)--(width-2*tx),(height-2*ty)) --,width/4,height/4,width/4,height/4)
    for i = 1, #players do
        love.graphics.setCanvas(objectcavanas[i])
        object.drawobjects(bgobjects[i])
        object.drawobjects(objects[i])
        love.graphics.setCanvas()
    end
    salg:save(players)
end

function love.update(dt)
    for i = 1, #players do
        if players[i].nextlevelpressed and (player.checkmap(players[i],world[i]) == 'end' or (player.checkmap(players[i],world[i]) == 'start' and players[i].level ~= 1 and players[i].level ~= 2)) then
            players[i].nextlevelpressed = false
            if (i == 1 and player.checkmap(players[1],world[1]) == 'end' and players[1].level+1-players[2].level >= -1 and players[1].level+1-players[2].level <= 1)
            or (i == 1 and player.checkmap(players[1],world[1]) == 'start' and players[1].level-1-players[2].level >= -1 and players[1].level-1-players[2].level <= 1)
            or (i == 2 and player.checkmap(players[2],world[2]) == 'end' and players[2].level+1-players[1].level >= -1 and players[2].level+1-players[1].level <= 1)
            or (i == 2 and player.checkmap(players[2],world[2]) == 'start' and players[2].level-1-players[1].level >= -1 and players[2].level-1-players[1].level <= 1) then
                for j = 1, #movingobjects do --Öppnar dörr när en spelare byter bana
                    for k = 1, #movingobjects[j] do
                        if (i == 1 and movingobjects[j][k].type == 'end1door') or (i == 2 and movingobjects[j][k].type == 'end2door') then
                            movingobjects[j][k].active = true
                        end
                    end
                end
                if player.checkmap(players[i],world[i]) == 'end' then
                    playerstart, bgobjects[i], objects[i], movingobjects[i] = loadmap.nextmap(players[i],objects[i],movingobjects[i],0,0,tilesize,world[i])
                else
                    playerstart, bgobjects[i], objects[i], movingobjects[i] = loadmap.previousmap(players[i],objects[i],movingobjects[i],0,0,tilesize,world[i])
                end
                objectcavanas[i] = love.graphics.newCanvas(width,height)
                love.graphics.setCanvas(objectcavanas[i])
                object.drawobjects(bgobjects[i])
                object.drawobjects(objects[i])
                love.graphics.setCanvas()
                world[i]:update(players[i],playerstart.x,playerstart.y)
                players[i].jump = true --För att man inte ska kunna hopps om man spawnar i luften.
            end
        elseif players[i].reloadpressed or player.outsideofmap(players[i],mapsize,tilesize) then
            playerstart, bgobjects[i], objects[i], movingobjects[i] = loadmap.reloadmap(players[i],objects[i],movingobjects[i],0,0,tilesize,world[i])
            objectcavanas[i] = love.graphics.newCanvas(width,height)
            love.graphics.setCanvas(objectcavanas[i])
            object.drawobjects(bgobjects[i])
            object.drawobjects(objects[i])
            love.graphics.setCanvas()
            world[i]:update(players[i],playerstart.x,playerstart.y)
            players[i].x = playerstart.x
            players[i].y = playerstart.y
            players[i].jump = true --För att man inte ska kunna hopps om man spawnar i luften.
        end
    end
    for i = 1, #players do
        for j = 1, #movingobjects[i] do
            object.fall(movingobjects[i][j],tilesize,dt,world[i])
            object.check(movingobjects[i][j], movingobjects, world[i])
        end
        players[i] = player.move(players[i],dt,world[i])
    end
end

function love.draw()
    camera1:set()
    for i = 1, #players do
        love.graphics.draw(objectcavanas[i], 0, 0)
        object.drawobjects(movingobjects[i])
    end
    player.drawplayers(players)
    camera1:unset()
    love.graphics.print(love.timer.getFPS(),0,0)
    love.graphics.print(love.graphics.getStats().drawcalls,0,20)
    love.graphics.print(players[1].x..' '..players[1].y,0,40)
    love.graphics.print(players[2].x..' '..players[2].y,0,60)
end

--Bygg en bana att testa på.


function love.keypressed(key, scancode, isrepeat)
    for i = 1, #players do
        if key == players[i].nextlevel then
            players[i].nextlevelpressed = true
        end
        if key == players[i].reload then
            players[i].reloadpressed = true
        end
    end
end

function love.keyreleased(key, scancode)
    for i = 1, #players do
        if key == players[i].nextlevel then
            players[i].nextlevelpressed = false
        elseif key == players[i].reload then
            players[i].reloadpressed = false
        end
    end
end