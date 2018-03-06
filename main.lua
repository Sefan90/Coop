local func = require 'func'
STATE = require "game" --"menu" -- start with this state

function load_state(new_state)
    if STATE.exit then STATE.exit() end
    STATE = new_state
    if STATE.load then STATE.load() end
end

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    atlas = {}
    atlas.img = love.graphics.newImage("/maps/img/16bit.png")
    atlas.player = love.graphics.newQuad(64, 0, 16, 16, atlas.img:getDimensions())
    atlas.box = love.graphics.newQuad(64, 16, 16, 16, atlas.img:getDimensions())
    atlas.trigger = love.graphics.newQuad(80, 0, 16, 16, atlas.img:getDimensions())
    atlas.trigger_active = love.graphics.newQuad(96, 0, 16, 16, atlas.img:getDimensions())
    atlas.exit = love.graphics.newQuad(80, 16, 16, 16, atlas.img:getDimensions())
    atlas.door = love.graphics.newQuad(16, 16, 16, 16, atlas.img:getDimensions())
    atlas.draw = {}
    for i = 1, 100 do
        table.insert(atlas.draw,love.graphics.newQuad(math.floor((i - 1) % 10)*16, math.floor((i - 1) / 10)*16, 16, 16, atlas.img:getDimensions()))
    end

    myShader = love.graphics.newShader[[
      extern vec4 color1;
      extern vec4 color2;
      extern vec4 color3;
      extern vec4 color4;

      vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
        vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
        if (pixel.a == 0.0) { return vec4(0.0,0.0,0.0,0.0); }
        if (pixel.r < 0.25) { return vec4(color4.r/255,color4.g/255,color4.b/255,color4.a/255); }
        else if (pixel.r < 0.5) { return vec4(color3.r/255,color3.g/255,color3.b/255,color3.a/255); }
        else if (pixel.r < 0.75) { return vec4(color2.r/255,color2.g/255,color2.b/255,color2.a/255); }
        else { return vec4(color1.r/255,color1.g/255,color1.b/255,color1.a/255); }
        return pixel;
      }
    ]]

    if STATE.load then STATE.load() end
end

function love.update(dt)
    if STATE.update then STATE.update(dt) end
end

function love.draw()
    if STATE.draw then STATE.draw() end
end

function love.keypressed(...)
    if STATE.keypressed then STATE.keypressed(...) end
end

function love.keyreleased(...)
    if STATE.keyreleased then STATE.keyreleased(...) end
end