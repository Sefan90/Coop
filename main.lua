local collision = require 'collision'
local levels = require 'levels'
local player = require 'player'
local object = require 'object'

function love.load()
    --Fixa så den byter bana och sparar banorna.
    width, height = love.graphics.getDimensions()
    map = levels[1]
    tilesize = getTileSize()
    players = {
        {x = (width-tilesize*16)/2+tilesize*3, y = (height-tilesize*12)/2+tilesize*3, w = tilesize-1, h = tilesize-1, r = (tilesize-1)/2, speed = 128, mode = 'rect', drawmode = 'line', up = 'w', left = 'a', down = 's', right = 'd', moving = 0, flying = false}
        --{x = 512, y = 256, w = 30, h = 30, r = 15, speed = 128, mode = 'rect', drawmode = 'line', up = 'up', left = 'left', down = 'down', right = 'right', moving = 0, flying = false}
    }
    objects = {}
    for i = 1, #map do
        for j = 1, #map[i] do
            if map[i][j] ~= 0 then
                table.insert(objects, {x = (width-tilesize*16)/2+(j-1)*tilesize, y = (height-tilesize*12)/2+(i-1)*tilesize, w = tilesize, h = tilesize, r = tilesize/2, mode = 'rect', drawmode = 'fill', position = object.position(i,j)})
            end
        end
    end
    objectcavanas = love.graphics.newCanvas()
    love.graphics.setCanvas(objectcavanas)
    object.drawobjects(objects)
    love.graphics.setCanvas()
end

function love.update(dt)
    for i = 1, #players do
        players[i] = player.move(players[i],dt)
    end
end

function love.draw()
    love.graphics.setScissor((width-tilesize*16)/2,(height-tilesize*12)/2,width-(width-tilesize*16)/2,height-(height-tilesize*12)/2)
    love.graphics.draw(objectcavanas, 0, 0)
    player.drawplayers(players)
    love.graphics.print(players[1].moving, 400, 300)
    love.graphics.print(levels[1][2][1], 400, 400)
    love.graphics.setScissor()
end

function shallowCopy(original)
    local copy = {}
    for key, value in pairs(original) do
        copy[key] = value
    end
    return copy
end

function getTileSize()
    local width, height = love.graphics.getDimensions()
    if width/16 < height/12 then
        return width/16
    else
        return height/12
    end
end

--Bygg en bana att testa på.
