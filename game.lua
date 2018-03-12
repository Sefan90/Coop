local player = require 'player'
local object = require 'object'
local camera = require 'camera'
local func = require 'func'
local salg = require 'salg'
local bump = require 'bump'
local loadmap = require 'loadmap'
local ingamemenu = require 'ingamemenu'
--require 'autobatch' -- Kolla om den hjälper eller inte

local game = {}

function game.load()
    mapsize = {x=24,y=18}
    width, height = love.graphics.getDimensions()
    tilesize = func.getTileSize(width,height,mapsize)
    world = {bump.newWorld(tilesize), bump.newWorld(tilesize)}
    tx = (width-tilesize*mapsize.x)/2
    ty = (height-tilesize*mapsize.y)/2
    players = {
        {name = 'p1', x = 0, y = 0, w = tilesize, h = tilesize, speed = tilesize*3, jump = true, jumptime = 0, up = 'w', left = 'a', down = 's', right = 'd', nextlevel = 'q', nextlevelpressed = false, reload = 'r', reloadpressed = false, flying = true, alive = true, level = -1},
        {name = 'p2', x = 0, y = 0, w = tilesize, h = tilesize, speed = tilesize*3, jump = true, jumptime = 0, up = 'up', left = 'left', down = 'down', right = 'right', nextlevel = 'p', nextlevelpressed = false, reload = 'i', reloadpressed = false, flying = false, alive = true, level = -1}
    }
    esc = {button = 'escape', active = false}
    world[1]:add(players[1],players[1].x,players[1].y,players[1].w,players[1].h)
    world[2]:add(players[2],players[2].x,players[2].y,players[2].w,players[2].h)

    bgobjects, objects, movingobjects, objectcavanas = {}, {}, {}, {}
    for i = 1, #players do
        playerstart, bgobjects[i], objects[i], movingobjects[i] = loadmap.newmap(players[i],0,0,tilesize,world[i])   
        objectcavanas[i] = love.graphics.newCanvas(width,height)
        world[i]:update(players[i],playerstart.x,playerstart.y)
        players[i].x = playerstart.x
        players[i].y = playerstart.y
    end
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

function game.update(dt)
    if esc.active == false then
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
            elseif players[i].reloadpressed or player.outsideofmap(players[i],mapsize,tilesize,world[i]) then
                 players[i].reloadpressed = false
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
    else
        ingamemenu.update(players,esc)
    end
end

function game.draw()
    camera1:set()
    for i = 1, #players do
        if i == 1 then
            myShader:send('color1', {147,100,209,255})
            myShader:send('color2', {108,70,158,255})
            myShader:send('color3', {77,47,117,255})
            myShader:send('color4', {48,28,76,255})
        else
            myShader:send('color1', {233,172,91,255})
            myShader:send('color2', {172,124,60,255})
            myShader:send('color3', {112,79,35,255})
            myShader:send('color4', {51,35,14,255})
        end
        love.graphics.setShader(myShader)
        love.graphics.draw(objectcavanas[i], 0, 0)
        object.drawobjects(movingobjects[i])
        player.drawplayers(players[i])
        love.graphics.setShader()
        
    end
    camera1:unset()
    love.graphics.print(love.timer.getFPS(),0,0)
    love.graphics.print(love.graphics.getStats().drawcalls,0,20)
    love.graphics.print(players[1].x..' '..players[1].y,0,40)
    love.graphics.print(players[2].x..' '..players[2].y,0,60)
     love.graphics.print(tostring(not esc.active),0,80)
    if esc.active == true then
        ingamemenu.draw()
    end
end

--Bygg en bana att testa på.


function game.keypressed(key)
    for i = 1, #players do
        if key == players[i].nextlevel then
            players[i].nextlevelpressed = true
        elseif key == players[i].reload then
            players[i].reloadpressed = true
        end
    end
    if key == esc.button then
        esc.active = not esc.active
    end
    if esc.active == true then
        if (love.keyboard.isDown(players[1].up) or love.keyboard.isDown(players[2].up)) and ingamemenu.selected ~= 0 then
            ingamemenu.selected = ingamemenu.selected-1
        elseif (love.keyboard.isDown(players[1].down) or love.keyboard.isDown(players[2].down)) and ingamemenu.selected ~= 3 then
            ingamemenu.selected = ingamemenu.selected+1
        end
    end
end

function game.keyreleased(key)
    for i = 1, #players do
        if key == players[i].nextlevel then
            players[i].nextlevelpressed = false
        elseif key == players[i].reload then
            players[i].reloadpressed = false
        end
    end
end

return game