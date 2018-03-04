STATE = require "game" --"menu" -- start with this state

function load_state(new_state)
    if STATE.exit then STATE.exit() end
    STATE = new_state
    if STATE.load then STATE.load() end
end

function love.load()
    myShader = love.graphics.newShader[[
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
      vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
      return pixel * color;
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